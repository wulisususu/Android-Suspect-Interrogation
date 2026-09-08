"""Filesystem spool; checkpoint replacement is the window commit point.

One runtime writer owns a job. Revision metadata is fixed at creation; callers
provide actual runtime versions, parameters and creation time. Source audio is
only opened for reading. Window IDs are SHA256 encoded for portable filenames.
DONE and FAILED attempts retain immutable checkpoints and raw diagnostics.
Retries after FAILED must receive a fresh window ID, even for the same interval;
an interrupted attempt without a terminal checkpoint may reuse its window ID.
"""
import hashlib
import json
import os
from pathlib import Path
import re
import tempfile
from dataclasses import asdict
from uuid import uuid4

from .types import JobSnapshot, JobState, NormalizedSegment, WindowResult, WindowState
from .windowing import WindowSpec


def _sync_directory(path):
    if os.name != 'nt':
        fd = os.open(path, os.O_RDONLY | os.O_DIRECTORY)
        try:
            os.fsync(fd)
        finally:
            os.close(fd)


def _atomic_write(path, text):
    path = Path(path)
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8', newline='',
                                         dir=path.parent, delete=False) as stream:
            temporary = Path(stream.name)
            stream.write(text)
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary, path)
        _sync_directory(path.parent)
    finally:
        if temporary is not None and temporary.exists():
            temporary.unlink()


def atomic_write_json(path, data):
    """Serialize before touching disk so failed encoding preserves the old file."""
    _atomic_write(path, json.dumps(data, ensure_ascii=False, allow_nan=False) + '\n')


def _read_json(path):
    return json.loads(path.read_text(encoding='utf-8'))


def _audio_hash(path):
    digest = hashlib.sha256()
    try:
        with Path(path).open('rb') as stream:
            for block in iter(lambda: stream.read(1024 * 1024), b''):
                digest.update(block)
    except OSError as exc:
        raise ValueError('MOSS_AUDIO_CHANGED: source unavailable') from exc
    return digest.hexdigest()


def _validate_segment_manifest(segment, manifest):
    while segment is not None:
        if segment.model_manifest_sha256 != manifest:
            raise ValueError('segment revision provenance mismatch')
        segment = segment.alternate


class MossSpool:
    def __init__(self, root):
        self.root = Path(root).resolve()
        self.root.mkdir(parents=True, exist_ok=True)
        self._path('jobs').mkdir(exist_ok=True)

    def _path(self, *parts):
        path = self.root.joinpath(*parts)
        # Reject links even within the spool: derived writes must never follow
        # an alias to source audio or another revision.
        for candidate in (path, *path.parents):
            if candidate == self.root:
                break
            if candidate.is_symlink() or (hasattr(candidate, 'is_junction') and candidate.is_junction()):
                raise ValueError('spool path must not contain links')
        if not path.resolve().is_relative_to(self.root):
            raise ValueError('spool path escape')
        return path

    def _job_path(self, job_id, *parts):
        if not isinstance(job_id, str) or not re.fullmatch(r'[0-9a-f]{32}', job_id):
            raise ValueError('invalid job id')
        return self._path('jobs', job_id, *parts)

    def create_job(self, audio_path, model_manifest_sha256, windows, *, duration_ms,
                   runtime_versions, windowing_params, generation_params, created_at):
        source = Path(audio_path).resolve(strict=True)
        if source.is_relative_to(self.root):
            raise ValueError('source audio must be outside derived spool')
        job_id = uuid4().hex
        snapshot = JobSnapshot(job_id, JobState.QUEUED, _audio_hash(source),
                               model_manifest_sha256, 0.0, None)
        record = {'snapshot': snapshot.to_dict(), 'revision': {
            'audio_path': str(source), 'duration_ms': duration_ms,
            'runtime_versions': runtime_versions, 'windowing_params': windowing_params,
            'generation_params': generation_params, 'created_at': created_at}}
        plan = self._plan(windows)
        json.dumps(record, allow_nan=False)
        directory = self._job_path(job_id)
        directory.mkdir()
        for name in ('raw_generations', 'checkpoints', 'logs'):
            self._job_path(job_id, name).mkdir()
        atomic_write_json(self._job_path(job_id, 'windows.json'), plan)
        atomic_write_json(self._job_path(job_id, 'speaker_state.json'), {})
        _atomic_write(self._job_path(job_id, 'merged_segments.jsonl'), '')
        _atomic_write(self._job_path(job_id, 'logs', 'events.jsonl'), '')
        atomic_write_json(self._job_path(job_id, 'job.json'), record)
        _sync_directory(directory.parent)
        return self.load_job(job_id)

    @staticmethod
    def _plan(windows):
        if any(not isinstance(key, str) or not key for key in windows):
            raise ValueError('window IDs must be nonempty strings')
        return {key: asdict(window) for key, window in windows.items()}

    def load_job(self, job_id):
        record = _read_json(self._job_path(job_id, 'job.json'))
        if record['snapshot']['job_id'] != job_id:
            raise ValueError('job integrity mismatch')
        if _audio_hash(record['revision']['audio_path']) != record['snapshot']['audio_sha256']:
            raise ValueError('MOSS_AUDIO_CHANGED: source SHA256 mismatch')
        return record

    def _active(self, job_id):
        record = self.load_job(job_id)
        if record['snapshot']['state'] == JobState.COMPLETED.value:
            raise ValueError('completed job revision is immutable')
        return record

    def save_job(self, job_id, snapshot, *, windows=None):
        record = self._active(job_id)
        data = snapshot.to_dict()
        for key in ('job_id', 'audio_sha256', 'model_manifest_sha256'):
            if data[key] != record['snapshot'][key]:
                raise ValueError('revision provenance is immutable')
        json.dumps(data, allow_nan=False)
        # Validate all checkpoint commits before altering the plan or completing.
        completed = self.load_completed_windows(job_id)
        if windows is not None:
            plan = self._plan(windows)
            for result in completed:
                if plan.get(result.window_id) != asdict(result.window):
                    raise ValueError('completed window plan is immutable')
            for path in self._job_path(job_id, 'checkpoints').glob('*.json'):
                prior = _read_json(self._job_path(job_id, 'checkpoints', path.name))
                if prior['state'] in (WindowState.DONE.value, WindowState.FAILED.value):
                    window_id = prior['window_id']
                    if window_id in plan and plan[window_id] != prior['window']:
                        raise ValueError('terminal window plan is immutable; retry with a fresh ID')
            atomic_write_json(self._job_path(job_id, 'windows.json'), plan)
        record['snapshot'] = data
        atomic_write_json(self._job_path(job_id, 'job.json'), record)

    def _window_path(self, job_id, window_id, raw=False):
        if not isinstance(window_id, str) or not window_id:
            raise ValueError('window ID must be a nonempty string')
        name = hashlib.sha256(window_id.encode('utf-8')).hexdigest()
        return self._job_path(job_id, 'raw_generations' if raw else 'checkpoints',
                              name + ('.txt' if raw else '.json'))

    def _validate_result(self, job_id, record, result):
        snap = record['snapshot']
        plan = _read_json(self._job_path(job_id, 'windows.json'))
        if (result.audio_sha256 != snap['audio_sha256'] or
                result.model_manifest_sha256 != snap['model_manifest_sha256'] or
                plan.get(result.window_id) != asdict(result.window)):
            raise ValueError('window provenance or plan integrity mismatch')
        for segment in result.segments:
            if segment.window_id != result.window_id:
                raise ValueError('segment provenance integrity mismatch')
            _validate_segment_manifest(segment, result.model_manifest_sha256)

    def save_window_result(self, job_id, result):
        record = self._active(job_id)
        self._validate_result(job_id, record, result)
        checkpoint = self._window_path(job_id, result.window_id)
        if checkpoint.exists() and _read_json(checkpoint)['state'] in (
                WindowState.DONE.value, WindowState.FAILED.value):
            raise ValueError('terminal window is immutable; retry with a fresh ID')
        data = result.to_dict()
        json.dumps(data, allow_nan=False)
        # Raw text is durable first; only checkpoint replacement commits DONE.
        _atomic_write(self._window_path(job_id, result.window_id, raw=True), result.raw_generation)
        atomic_write_json(checkpoint, data)

    def load_completed_windows(self, job_id):
        record = self.load_job(job_id)
        results = []
        for path in sorted(self._job_path(job_id, 'checkpoints').glob('*.json')):
            data = _read_json(self._job_path(job_id, 'checkpoints', path.name))
            if data['state'] != WindowState.DONE.value:
                continue
            result = WindowResult.from_dict(data)
            self._validate_result(job_id, record, result)
            raw_path = self._window_path(job_id, result.window_id, raw=True)
            if path != self._window_path(job_id, result.window_id) or not raw_path.exists() or raw_path.read_bytes() != result.raw_generation.encode('utf-8'):
                raise ValueError('window raw/checkpoint integrity mismatch')
            results.append(result)
        return sorted(results, key=lambda result: (result.window.start_ms, result.window_id))

    def save_speaker_state(self, job_id, state):
        self._active(job_id)
        atomic_write_json(self._job_path(job_id, 'speaker_state.json'), state)

    def load_windows(self, job_id):
        self.load_job(job_id)
        return {key: WindowSpec(**value) for key, value in
                _read_json(self._job_path(job_id, 'windows.json')).items()}

    def load_window_results(self, job_id):
        record = self.load_job(job_id)
        results = []
        for path in self._job_path(job_id, 'checkpoints').glob('*.json'):
            result = WindowResult.from_dict(_read_json(self._job_path(job_id, 'checkpoints', path.name)))
            if result.state is WindowState.DONE:
                self._validate_result(job_id, record, result)
            if (result.audio_sha256 != record['snapshot']['audio_sha256'] or
                    result.model_manifest_sha256 != record['snapshot']['model_manifest_sha256']):
                raise ValueError('window revision provenance mismatch')
            for segment in result.segments:
                if segment.window_id != result.window_id:
                    raise ValueError('segment provenance integrity mismatch')
                _validate_segment_manifest(segment, result.model_manifest_sha256)
            raw = self._window_path(job_id, result.window_id, raw=True)
            if path != self._window_path(job_id, result.window_id) or not raw.exists() or raw.read_bytes() != result.raw_generation.encode('utf-8'):
                raise ValueError('window raw/checkpoint integrity mismatch')
            results.append(result)
        return tuple(sorted(results, key=lambda result: (result.window.start_ms, result.window_id)))

    def load_speaker_state(self, job_id):
        self.load_job(job_id)
        return _read_json(self._job_path(job_id, 'speaker_state.json'))

    def load_merged_segments(self, job_id):
        self.load_job(job_id)
        return tuple(NormalizedSegment.from_dict(json.loads(line)) for line in
                     self._job_path(job_id, 'merged_segments.jsonl').read_text(encoding='utf-8').splitlines())

    def append_event(self, job_id, event):
        self._active(job_id)
        line = json.dumps(event, ensure_ascii=False, allow_nan=False) + '\n'
        path = self._job_path(job_id, 'logs', 'events.jsonl')
        _atomic_write(path, path.read_text(encoding='utf-8') + line)

    def save_merged_segments(self, job_id, segments):
        record = self._active(job_id)
        data = []
        for segment in segments:
            _validate_segment_manifest(segment, record['snapshot']['model_manifest_sha256'])
            data.append(json.dumps(segment.to_dict(), ensure_ascii=False, allow_nan=False) + '\n')
        _atomic_write(self._job_path(job_id, 'merged_segments.jsonl'), ''.join(data))
