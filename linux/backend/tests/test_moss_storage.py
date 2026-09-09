import importlib
import json
from dataclasses import replace

import pytest

from moss_worker.types import JobSnapshot, JobState, WindowResult, WindowState, ParseStatus
from moss_worker.windowing import WindowSpec
from test_moss_types import segment


def storage():
    module = importlib.util.find_spec('moss_worker.storage')
    assert module is not None, 'durable storage implementation is missing'
    return importlib.import_module('moss_worker.storage')


def test_atomic_serialization_failure_preserves_previous_job(tmp_path):
    path = tmp_path / 'job.json'
    path.write_text('{"state": "QUEUED"}', encoding='utf-8')
    with pytest.raises(TypeError):
        storage().atomic_write_json(path, {'bad': object()})
    assert json.loads(path.read_text()) == {'state': 'QUEUED'}


def make_job(tmp_path, model='manifest'):
    wav = tmp_path / 'original.wav'
    if not wav.exists():
        wav.write_bytes(b'original audio bytes')
    spool = storage().MossSpool(tmp_path / 'spool')
    record = spool.create_job(wav, model, {'w:0': WindowSpec(0, 1000, 0, 10)},
                             duration_ms=1000, runtime_versions={'python': 'test'},
                             windowing_params={'overlap_ms': 120000},
                             generation_params={'temperature': 0}, created_at='2026-09-08T00:00:00Z')
    return spool, record, wav


def result(record, state=WindowState.DONE):
    snap = record['snapshot']
    return WindowResult('w:0', WindowSpec(0, 1000, 0, 10), state,
                        snap['audio_sha256'], snap['model_manifest_sha256'],
                        '你好 raw', (), ParseStatus.VALID, None)


def test_supervisor_public_reads_and_durable_events(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    assert spool.load_windows(job_id) == {'w:0': WindowSpec(0, 1000, 0, 10)}
    assert spool.load_speaker_state(job_id) == {}
    assert spool.load_merged_segments(job_id) == ()
    assert spool.load_window_results(job_id) == ()
    failed = replace(result(record), state=WindowState.FAILED, error='MOSS_CHILD_CRASHED')
    spool.save_window_result(job_id, failed)
    spool.save_job(job_id, JobSnapshot.from_dict(record['snapshot']), windows={})
    assert spool.load_window_results(job_id) == (failed,)
    spool.append_event(job_id, {'type': 'generation', 'perf': {'tokens': 7}})
    spool.append_event(job_id, {'type': 'restart'})
    path = spool.root / 'jobs' / job_id / 'logs' / 'events.jsonl'
    before = path.read_bytes()
    with pytest.raises(TypeError):
        spool.append_event(job_id, {'invalid': object()})
    assert path.read_bytes() == before
    assert [json.loads(line)['type'] for line in path.read_text().splitlines()] == ['generation', 'restart']


def test_revision_metadata_layout_and_new_model_revision(tmp_path):
    spool, record, wav = make_job(tmp_path)
    other = make_job(tmp_path, 'other-manifest')[1]
    job_id = record['snapshot']['job_id']
    assert other['snapshot']['job_id'] != job_id
    assert spool.load_job(job_id) == record
    assert record['revision']['runtime_versions'] == {'python': 'test'}
    assert record['revision']['generation_params'] == {'temperature': 0}
    root = tmp_path / 'spool' / 'jobs' / job_id
    assert {p.name for p in root.iterdir()} == {'job.json', 'windows.json', 'speaker_state.json', 'merged_segments.jsonl', 'raw_generations', 'checkpoints', 'logs'}
    assert (root / 'logs/events.jsonl').exists()
    assert json.loads((root / 'windows.json').read_text())['w:0']['window_minutes'] == 10
    assert wav.read_bytes() == b'original audio bytes'


def test_resume_only_done_and_raw_checkpoint_provenance(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    spool.save_window_result(job_id, result(record, WindowState.FAILED))
    assert spool.load_completed_windows(job_id) == []
    retry = replace(result(record), window_id='retry')
    spool.save_job(job_id, JobSnapshot.from_dict(record['snapshot']), windows={'retry': retry.window})
    spool.save_window_result(job_id, retry)
    resumed = storage().MossSpool(tmp_path / 'spool')
    assert resumed.load_completed_windows(job_id) == [retry]
    root = tmp_path / 'spool/jobs' / job_id
    assert next((root / 'raw_generations').glob('*.txt')).read_text(encoding='utf-8') == '你好 raw'
    with pytest.raises(ValueError):
        spool.save_window_result(job_id, replace(retry, raw_generation='changed'))
    with pytest.raises(ValueError):
        spool.save_job(job_id, JobSnapshot.from_dict(record['snapshot']), windows={})


@pytest.mark.parametrize('operation', ['load', 'resume', 'save'])
def test_source_changed_fails_closed(tmp_path, operation):
    spool, record, wav = make_job(tmp_path)
    wav.write_bytes(b'changed')
    job_id = record['snapshot']['job_id']
    with pytest.raises(ValueError, match='MOSS_AUDIO_CHANGED'):
        if operation == 'load':
            spool.load_job(job_id)
        elif operation == 'resume':
            spool.load_completed_windows(job_id)
        else:
            spool.save_speaker_state(job_id, {})


@pytest.mark.parametrize('operation', ['job', 'window', 'speaker', 'merged'])
def test_completed_revision_protects_every_write(tmp_path, operation):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    spool.save_window_result(job_id, result(record))
    spool.save_job(job_id, replace(JobSnapshot.from_dict(record['snapshot']), state=JobState.COMPLETED))
    with pytest.raises(ValueError, match='immutable'):
        if operation == 'job':
            spool.save_job(job_id, JobSnapshot.from_dict(record['snapshot']))
        elif operation == 'window':
            spool.save_window_result(job_id, result(record))
        elif operation == 'speaker':
            spool.save_speaker_state(job_id, {})
        else:
            spool.save_merged_segments(job_id, [])


@pytest.mark.parametrize('job_id', ['../outside', '/absolute', 'C:\\outside', '..', 'a/b'])
def test_job_path_escape_rejected(tmp_path, job_id):
    spool, _, _ = make_job(tmp_path)
    with pytest.raises(ValueError):
        spool.load_job(job_id)


def test_checkpoint_raw_integrity_and_manifest_checked(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    with pytest.raises(ValueError):
        spool.save_window_result(job_id, replace(result(record), model_manifest_sha256='wrong'))
    spool.save_window_result(job_id, result(record))
    raw = next((tmp_path / 'spool/jobs' / job_id / 'raw_generations').glob('*.txt'))
    raw.write_text('corruption')
    with pytest.raises(ValueError, match='integrity'):
        spool.load_completed_windows(job_id)


def test_interrupted_replace_leaves_previous_file_and_removes_temp(tmp_path, monkeypatch):
    module = storage()
    path = tmp_path / 'job.json'
    module.atomic_write_json(path, {'state': 'QUEUED'})
    def interrupted(source, destination):
        raise OSError('simulated interrupted replace')
    monkeypatch.setattr(module.os, 'replace', interrupted)
    with pytest.raises(OSError):
        module.atomic_write_json(path, {'state': 'COMPLETED'})
    assert json.loads(path.read_text()) == {'state': 'QUEUED'}
    assert list(tmp_path.iterdir()) == [path]


def test_raw_before_checkpoint_interruption_is_not_completed(tmp_path, monkeypatch):
    module = storage()
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    original = module.atomic_write_json
    def interrupt_checkpoint(path, data):
        if path.parent.name == 'checkpoints':
            raise OSError('checkpoint interrupted')
        original(path, data)
    monkeypatch.setattr(module, 'atomic_write_json', interrupt_checkpoint)
    with pytest.raises(OSError):
        spool.save_window_result(job_id, result(record))
    assert spool.load_completed_windows(job_id) == []
    monkeypatch.setattr(module, 'atomic_write_json', original)
    spool.save_window_result(job_id, result(record))
    assert spool.load_completed_windows(job_id) == [result(record)]


def test_retry_plan_retains_failed_evidence_and_unrelated_done(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    snap = JobSnapshot.from_dict(record['snapshot'])
    other = WindowSpec(1000, 2000, 0, 10)
    spool.save_job(job_id, snap, windows={'w:0': result(record).window, 'failed': other})
    spool.save_window_result(job_id, result(record))
    failed = replace(result(record, WindowState.FAILED), window_id='failed', window=other,
                     token_count=5120, normal_termination=False, error='GENERATION_LIMIT_REACHED')
    spool.save_window_result(job_id, failed)
    root = tmp_path / 'spool/jobs' / job_id
    before = {p.name: p.read_bytes() for p in (root / 'checkpoints').iterdir()}
    spool.save_job(job_id, snap, windows={'w:0': result(record).window, 'retry': WindowSpec(1000, 2000, 0, 10)})
    assert {p.name: p.read_bytes() for p in (root / 'checkpoints').iterdir()} == before
    assert spool.load_completed_windows(job_id) == [result(record)]


def test_repair_metadata_survives_checkpoint_roundtrip(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    repaired = segment(window_id='w:0', parse_status=ParseStatus.REPAIRED,
                       repair_reason='END_TIMESTAMP_CLAMPED_TO_WINDOW_END',
                       repair_original_end_ms=2520010)
    spool.save_window_result(job_id, replace(result(record), segments=(repaired,)))
    loaded, = spool.load_completed_windows(job_id)
    assert loaded.segments == (repaired,)
    checkpoint = next((tmp_path / 'spool/jobs' / job_id / 'checkpoints').glob('*.json'))
    data = json.loads(checkpoint.read_text(encoding='utf-8'))
    assert data['segments'][0]['repair_reason'] == 'END_TIMESTAMP_CLAMPED_TO_WINDOW_END'
    assert data['segments'][0]['repair_original_end_ms'] == 2520010


def test_speaker_and_merged_segment_roundtrip(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    value = segment(window_id='w:0', alternate=segment(window_id='w:0'))
    spool.save_speaker_state(job_id, {'next_speaker': 2})
    spool.save_merged_segments(job_id, [value])
    root = tmp_path / 'spool/jobs' / job_id
    assert json.loads((root / 'speaker_state.json').read_text()) == {'next_speaker': 2}
    assert type(value).from_dict(json.loads((root / 'merged_segments.jsonl').read_text(encoding='utf-8'))) == value


def test_symlink_checkpoint_escape_rejected(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    spool.save_window_result(job_id, result(record))
    checkpoint = next((tmp_path / 'spool/jobs' / job_id / 'checkpoints').iterdir())
    outside = tmp_path / 'outside.json'
    outside.write_bytes(checkpoint.read_bytes())
    checkpoint.unlink()
    try:
        checkpoint.symlink_to(outside)
    except OSError:
        pytest.skip('OS does not permit creating symlinks')
    with pytest.raises(ValueError, match='links'):
        spool.load_completed_windows(job_id)


def test_invalid_snapshot_does_not_change_retry_plan(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    snapshot = replace(JobSnapshot.from_dict(record['snapshot']), progress=float('nan'))
    root = tmp_path / 'spool/jobs' / job_id
    previous = (root / 'windows.json').read_bytes()
    with pytest.raises(ValueError):
        spool.save_job(job_id, snapshot, windows={'retry': WindowSpec(0, 1000, 0, 10)})
    assert (root / 'windows.json').read_bytes() == previous


def test_failed_attempt_is_immutable_and_id_cannot_be_reused_for_another_spec(tmp_path):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    failed = replace(result(record, WindowState.FAILED), token_count=5120,
                     normal_termination=False, error='GENERATION_LIMIT_REACHED')
    spool.save_window_result(job_id, failed)
    root = tmp_path / 'spool/jobs' / job_id
    evidence = {path: path.read_bytes() for folder in ('raw_generations', 'checkpoints')
                for path in (root / folder).iterdir()}
    with pytest.raises(ValueError, match='immutable'):
        spool.save_window_result(job_id, replace(result(record), raw_generation='replacement'))
    snapshot = JobSnapshot.from_dict(record['snapshot'])
    with pytest.raises(ValueError, match='immutable'):
        spool.save_job(job_id, snapshot, windows={'w:0': WindowSpec(0, 500, 0, 10)})
    spool.save_job(job_id, snapshot, windows={'retry': WindowSpec(0, 500, 0, 10)})
    # Removing the failed ID from the active plan must not permit later reuse.
    with pytest.raises(ValueError, match='immutable'):
        spool.save_job(job_id, snapshot, windows={'w:0': WindowSpec(0, 500, 0, 10)})
    assert all(path.read_bytes() == contents for path, contents in evidence.items())


@pytest.mark.parametrize('operation', ['window', 'merged', 'resume'])
def test_nested_alternate_manifest_must_match_revision(tmp_path, operation):
    spool, record, _ = make_job(tmp_path)
    job_id = record['snapshot']['job_id']
    valid = segment(window_id='w:0', alternate=segment(window_id='other'))
    invalid = replace(valid, alternate=replace(valid.alternate, model_manifest_sha256='foreign'))
    if operation == 'resume':
        spool.save_window_result(job_id, replace(result(record), segments=(valid,)))
        path = next((tmp_path / 'spool/jobs' / job_id / 'checkpoints').iterdir())
        data = json.loads(path.read_text(encoding='utf-8'))
        data['segments'][0] = invalid.to_dict()
        path.write_text(json.dumps(data), encoding='utf-8')
    with pytest.raises(ValueError, match='provenance'):
        if operation == 'window':
            spool.save_window_result(job_id, replace(result(record), segments=(invalid,)))
        elif operation == 'merged':
            spool.save_merged_segments(job_id, [invalid])
        else:
            spool.load_completed_windows(job_id)
