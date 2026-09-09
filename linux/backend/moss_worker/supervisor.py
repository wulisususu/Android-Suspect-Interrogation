"""Serial durable MOSS scheduling; native inference is isolated in a child."""
from dataclasses import asdict, replace
from datetime import datetime, timezone
from pathlib import Path
from threading import Event, Lock, RLock, Thread
from uuid import uuid4
import json
from queue import Empty, Queue
import subprocess
import sys
import time
import wave

from .context_budget import ContextBudget
from .merger import merge_adjacent
from .speaker_remap import SpeakerRemapper
from .types import JobResult, JobSnapshot, JobState, ParseStatus, WindowResult, WindowState
from .windowing import ContextBudgetExceeded, RetryExhausted, WindowSpec, plan_retry_windows, plan_windows


class ChildCrashed(RuntimeError):
    pass


class ChildCancelled(RuntimeError):
    pass


TERMINAL = {JobState.COMPLETED, JobState.FAILED, JobState.CANCELLED}
NATIVE_STATES = {JobState.ENCODING, JobState.BUILDING_EMBEDS, JobState.DECODING, JobState.PARSING}
RECOVERY_ERROR = 'MOSS_RECOVERY_REQUIRED: nonterminal job found after restart'


class ProcessChild:
    """One JSONL process, bounded stderr tail, and interruptible native waits."""
    def __init__(self, command, manifest_sha256, *, startup_timeout=120, terminate_timeout=2):
        self.command, self.manifest_sha256 = list(command), manifest_sha256
        self.startup_timeout, self.terminate_timeout = startup_timeout, terminate_timeout
        self.process = None
        self.threads = []
        self.stderr_tail = b''
        self._messages = Queue()

    def start(self):
        self.process = subprocess.Popen(self.command, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                        stderr=subprocess.PIPE, shell=False)
        def read_stdout():
            try:
                while True:
                    line = self.process.stdout.readline(2 * 1024 * 1024)
                    if not line:
                        break
                    if not line.endswith(b'\n'):
                        raise ValueError('MOSS_CHILD_PROTOCOL: oversized line')
                    self._messages.put(json.loads(line))
            except (ValueError, OSError) as exc:
                self._messages.put(exc)
            finally:
                self._messages.put(None)
        def read_stderr():
            while True:
                block = self.process.stderr.read(4096)
                if not block:
                    return
                self.stderr_tail = (self.stderr_tail + block)[-65536:]
        self.threads = [Thread(target=read_stdout, name='moss-stdout'),
                        Thread(target=read_stderr, name='moss-stderr')]
        for thread in self.threads:
            thread.start()
        try:
            try:
                ready = self._receive(self.startup_timeout)
            except Empty as exc:
                raise RuntimeError('MOSS_CHILD_NOT_READY: startup timeout') from exc
            if (ready.get('type') != 'ready' or ready.get('model_manifest_sha256') != self.manifest_sha256
                    or not ready.get('selftests')):
                raise RuntimeError('MOSS_CHILD_NOT_READY:' + str(ready))
        except Exception:
            self.close()
            raise

    def _receive(self, timeout):
        message = self._messages.get(timeout=timeout)
        if message is None:
            raise ChildCrashed('process exited; ' + self.stderr_tail.decode('utf-8', errors='replace'))
        if isinstance(message, Exception):
            raise RuntimeError('MOSS_CHILD_PROTOCOL:' + str(message))
        if not isinstance(message, dict):
            raise RuntimeError('MOSS_CHILD_PROTOCOL: expected object')
        return message

    def infer(self, wav, window_id, window, on_state, cancelled, grace):
        request_id = uuid4().hex
        request = dict(type='infer', request_id=request_id, window_id=window_id,
                       wav=str(wav), window=asdict(window))
        try:
            self.process.stdin.write((json.dumps(request) + '\n').encode('utf-8'))
            self.process.stdin.flush()
        except (BrokenPipeError, OSError) as exc:
            raise ChildCrashed(str(exc)) from exc
        deadline = None
        while True:
            if cancelled.is_set():
                deadline = deadline if deadline is not None else time.monotonic() + grace
                if time.monotonic() >= deadline:
                    self.close()
                    raise ChildCancelled('MOSS_CANCELLED')
            try:
                message = self._receive(min(.05, max(0, deadline - time.monotonic())) if deadline else .05)
            except Empty:
                continue
            if message.get('request_id') != request_id:
                raise RuntimeError('MOSS_CHILD_PROTOCOL: request mismatch')
            if message.get('type') == 'state':
                state = JobState(message['state'])
                if state not in NATIVE_STATES:
                    raise RuntimeError('MOSS_CHILD_PROTOCOL: invalid native state')
                on_state(state)
            elif message.get('type') == 'result':
                return WindowResult.from_dict(message['result']), message.get('generation_metadata')
            else:
                raise RuntimeError('MOSS_CHILD_ERROR:' + str(message))

    def close(self):
        if self.process is None:
            return
        if self.process.poll() is None:
            self.process.terminate()
            try:
                self.process.wait(timeout=self.terminate_timeout)
            except subprocess.TimeoutExpired:
                self.process.kill()
                self.process.wait(timeout=self.terminate_timeout)
        for thread in self.threads:
            thread.join(self.terminate_timeout)
        for stream in (self.process.stdin, self.process.stdout, self.process.stderr):
            stream.close()


class MossSupervisor:
    """Call run_pending from one scheduler thread; submit/cancel are concurrent.

    Native crash recovery is allowed once per job, including across power loss.
    runtime_versions must identify the actual pinned child runtime deployment.
    Test factories are injectable; production counting uses bundle tokenization.
    """
    def __init__(self, spool, *, bundle, manifest_sha256, runtime_versions,
                 child_factory=None, counter_factory=None, cancel_grace=10.0,
                 python_executable=sys.executable, rknn_library=None, rkllm_library=None):
        self.spool, self.bundle = spool, Path(bundle)
        self.manifest_sha256, self.runtime_versions = manifest_sha256, runtime_versions
        if child_factory is None:
            if not rknn_library or not rkllm_library:
                raise ValueError('Explicit private native library paths are required')
            command = [str(python_executable), '-u', '-m', 'moss_worker.child',
                       '--bundle', str(self.bundle), '--manifest-sha256', manifest_sha256,
                       '--rknn-library', str(rknn_library), '--rkllm-library', str(rkllm_library)]
            child_factory = lambda: ProcessChild(command, manifest_sha256)
        self.child_factory = child_factory
        self.counter_factory = counter_factory or self._actual_counter
        self.cancel_grace = cancel_grace
        self._child = None
        self._queue = []
        self._active_job = None
        self._cancel = {}
        self._serial, self._lock = Lock(), RLock()
        self._recovery_failures = {}
        # V1 crash-recovery ruling: never auto-resume. Jobs that a restart
        # found mid-flight become explicitly RECOVERY_REQUIRED (persisted);
        # COMPLETED/FAILED/CANCELLED evidence is left exactly as it is.
        self._recover_spool()

    def _recover_spool(self):
        """Startup scan: mark every non-terminal spool job RECOVERY_REQUIRED.

        Best effort per job: unreadable or audio-mismatched records keep their
        existing behavior (get_job reports them verbatim) and are recorded in
        ``recovery_failures`` instead of aborting the scan. Terminal states are
        skipped via a cheap job.json peek so a restart neither recomputes nor
        re-hashes large completed evidence files.
        """
        jobs_root = Path(self.spool.root) / 'jobs'
        if not jobs_root.is_dir():
            return
        for entry in sorted(jobs_root.iterdir()):
            if not entry.is_dir():
                continue
            job_id = entry.name
            try:
                peeked = self._peek_state(job_id)
                if peeked is not None and peeked in TERMINAL | {JobState.RECOVERY_REQUIRED}:
                    continue
                if self.get_job(job_id).state in TERMINAL | {JobState.RECOVERY_REQUIRED}:
                    continue
                self._state(job_id, JobState.RECOVERY_REQUIRED, RECOVERY_ERROR)
            except (ValueError, OSError) as exc:
                self._recovery_failures[job_id] = str(exc)

    def _peek_state(self, job_id):
        """Best-effort state read without integrity/hash work (scan fast path)."""
        try:
            record = json.loads(
                (Path(self.spool.root) / 'jobs' / job_id / 'job.json').read_text(encoding='utf-8')
            )
            return str(record['snapshot']['state'])
        except (OSError, ValueError, KeyError, TypeError):
            return None

    def _actual_counter(self, wav):
        from .audio_frontend import AudioFrontend
        from .embedding_builder import MossEmbeddingBuilder
        from .runtime import render_prompt, validate_model_bundle

        manifest = validate_model_bundle(self.bundle, self.manifest_sha256)
        frontend = AudioFrontend(manifest['processor_config'])
        builder = MossEmbeddingBuilder.from_bundle(self.bundle)
        return builder.interval_counter(render_prompt(self.bundle),
            lambda start, end: len(frontend.read_samples(wav, WindowSpec(start, end, 0, 10))))

    def submit(self, wav):
        wav = Path(wav).resolve(strict=True)
        with wave.open(str(wav), 'rb') as source:
            if (source.getnchannels(), source.getsampwidth(), source.getframerate(), source.getcomptype()) != (1, 2, 16000, 'NONE'):
                raise ValueError('MOSS_AUDIO_FORMAT: requires PCM16 mono 16kHz WAV')
            duration = (source.getnframes() * 1000 + 15999) // 16000
        if not duration:
            raise ValueError('MOSS_AUDIO_EMPTY')
        windows = {f'w{index:04d}': window for index, window in
                   enumerate(plan_windows(duration, self.counter_factory(wav)), 1)}
        record = self.spool.create_job(wav, self.manifest_sha256, windows,
            duration_ms=duration, runtime_versions=self.runtime_versions,
            windowing_params=dict(target_minutes=10, fallback_minutes=8, minimum_minutes=8,
                                  overlap_ms=120000, logical_chunk_ms=3600000),
            generation_params=dict(context_length=16384, max_new_tokens=5120, safety_margin=512,
                top_k=1, top_p=1, temperature=1, repeat_penalty=1, frequency_penalty=0,
                presence_penalty=0, mirostat=0, keep_history=0),
            created_at=datetime.now(timezone.utc).isoformat())
        snapshot = JobSnapshot.from_dict(record['snapshot'])
        with self._lock:
            self._queue.append(snapshot.job_id)
            self._cancel[snapshot.job_id] = Event()
        return snapshot

    def get_job(self, job_id):
        return JobSnapshot.from_dict(self.spool.load_job(job_id)['snapshot'])

    def queue_status(self):
        """Read-only health view: (queued job count, active job id or None).

        Queued jobs are submitted/resumed but not yet picked up by the
        scheduler thread; the active job is the one currently drained by
        run_pending. Read under the same lock that maintains both fields.
        """
        with self._lock:
            return len(self._queue), self._active_job

    @property
    def recovery_failures(self):
        """Jobs the startup scan could not mark (e.g. MOSS_AUDIO_CHANGED).

        Those records keep their existing verbatim get_job failure behavior;
        this mapping is diagnostic only.
        """
        return dict(self._recovery_failures)

    def resume(self, job_id):
        with self._lock:
            record = self.spool.load_job(job_id)
            snapshot = JobSnapshot.from_dict(record['snapshot'])
            if snapshot.state in TERMINAL:
                return snapshot
            if (snapshot.model_manifest_sha256 != self.manifest_sha256 or
                    record['revision']['runtime_versions'] != self.runtime_versions):
                raise ValueError('MOSS_REVISION_CHANGED: submit a new job')
            if snapshot.error == 'MOSS_CANCEL_REQUESTED':
                return self._state(job_id, JobState.CANCELLED)
            if job_id not in self._queue and job_id != self._active_job:
                self._queue.append(job_id)
                self._cancel[job_id] = Event()
            return snapshot

    def cancel(self, job_id):
        with self._lock:
            snapshot = self.get_job(job_id)
            if snapshot.state in TERMINAL:
                return snapshot
            self._cancel.setdefault(job_id, Event()).set()
            if job_id != self._active_job:
                return self._state(job_id, JobState.CANCELLED)
            return self._state(job_id, snapshot.state, 'MOSS_CANCEL_REQUESTED')

    def _state(self, job_id, state, error=None, windows=None):
        with self._lock:
            previous = self.get_job(job_id)
            if previous.state in TERMINAL:
                raise ValueError('terminal job cannot transition')
            current = replace(previous, state=JobState(state),
                              error=('MOSS_CANCEL_REQUESTED' if previous.error == 'MOSS_CANCEL_REQUESTED'
                                     and state not in TERMINAL else error),
                              progress=1.0 if state == JobState.COMPLETED else previous.progress)
            self.spool.save_job(job_id, current, windows=windows)
            return current

    def _restart(self):
        self._stop_child()
        self._child = self.child_factory()
        try:
            self._child.start()
        except Exception:
            self._stop_child()
            raise

    def _stop_child(self):
        if self._child is not None:
            self._child.close()
            self._child = None

    def _native_state(self, job_id, state):
        state = JobState(state)
        if state not in NATIVE_STATES:
            raise ValueError('MOSS_CHILD_PROTOCOL: invalid native state')
        self._state(job_id, state)

    def run_pending(self):
        """Drain serially; return integrity failures that cannot be checkpointed."""
        failures = {}
        with self._serial:
            while True:
                with self._lock:
                    if not self._queue:
                        return failures
                    job_id = self._queue.pop(0)
                try:
                    with self._lock:
                        if self.get_job(job_id).state in TERMINAL:
                            continue
                        self._active_job = job_id
                    self._run(job_id)
                except (ValueError, RuntimeError, OSError) as exc:
                    self._stop_child()
                    try:
                        if self.get_job(job_id).state not in TERMINAL:
                            self._state(job_id, JobState.FAILED, str(exc))
                    except (ValueError, OSError) as integrity_error:
                        failures[job_id] = str(integrity_error)
                finally:
                    with self._lock:
                        self._active_job = None

    def _run(self, job_id):
        record = self.spool.load_job(job_id)
        wav = Path(record['revision']['audio_path'])
        self._state(job_id, JobState.PREPARING)
        counter = self.counter_factory(wav)
        while True:
            if self._cancel[job_id].is_set():
                self._state(job_id, JobState.CANCELLED)
                return
            plan = self.spool.load_windows(job_id)
            attempts = self.spool.load_window_results(job_id)
            done = {result.window_id for result in attempts if result.state is WindowState.DONE}
            failed = {result.window_id: result for result in attempts if result.state is WindowState.FAILED}
            pending = [(key, window) for key, window in plan.items() if key not in done]
            if not pending:
                break
            identity, window = min(pending, key=lambda item: (item[1].start_ms, item[0]))
            if identity in failed:
                result = failed[identity]
                if (result.error or '').startswith('MOSS_CHILD_CRASHED:'):
                    crashes = sum((r.error or '').startswith('MOSS_CHILD_CRASHED:') for r in attempts)
                    if crashes > 1:
                        self._stop_child()
                        self._state(job_id, JobState.FAILED, result.error)
                        return
                    replacements = [window]
                    self._restart()
                elif result.error in ('MOSS_CONTEXT_BUDGET_EXCEEDED', 'MOSS_CONTEXT_OVERFLOW',
                                      'MOSS_OOM', 'MOSS_OUT_OF_MEMORY', 'GENERATION_LIMIT_REACHED'):
                    if result.error in ('MOSS_OOM', 'MOSS_OUT_OF_MEMORY'):
                        self._stop_child()
                    try:
                        replacements = plan_retry_windows(window, counter)
                    except (RetryExhausted, ContextBudgetExceeded) as exc:
                        self._state(job_id, JobState.FAILED, str(exc))
                        return
                else:
                    self._state(job_id, JobState.FAILED, result.error or 'MOSS_WINDOW_FAILED')
                    return
                del plan[identity]
                plan.update({'retry-' + uuid4().hex: replacement for replacement in replacements})
                self._state(job_id, JobState.PREPARING, windows=plan)
                continue
            if not ContextBudget().fits(counter(window.start_ms, window.end_ms)):
                snapshot = self.get_job(job_id)
                self.spool.save_window_result(job_id, WindowResult(identity, window, WindowState.FAILED,
                    snapshot.audio_sha256, snapshot.model_manifest_sha256, '', (), ParseStatus.INVALID,
                    'MOSS_CONTEXT_BUDGET_EXCEEDED'))
                continue
            if self._child is None:
                self._restart()
            try:
                result, metadata = self._child.infer(wav, identity, window,
                    lambda state: self._native_state(job_id, state), self._cancel[job_id], self.cancel_grace)
            except ChildCancelled:
                self._state(job_id, JobState.CANCELLED)
                self._restart()
                return
            except ChildCrashed as exc:
                snapshot = self.get_job(job_id)
                result = WindowResult(identity, window, WindowState.FAILED,
                    snapshot.audio_sha256, snapshot.model_manifest_sha256,
                    '', (), ParseStatus.INVALID, 'MOSS_CHILD_CRASHED:' + str(exc))
                self.spool.save_window_result(job_id, result)
                continue
            if result.state not in (WindowState.DONE, WindowState.FAILED):
                raise ValueError('MOSS_CHILD_PROTOCOL: nonterminal result')
            if result.window_id != identity or result.window != window:
                raise ValueError('MOSS_CHILD_PROTOCOL: result window mismatch')
            self.spool.save_window_result(job_id, result)
            if metadata is not None:
                self.spool.append_event(job_id, dict(type='generation', window_id=identity, metadata=metadata))
        self._merge(job_id)
        with self._lock:
            self._state(job_id, JobState.CANCELLED if self._cancel[job_id].is_set() else JobState.COMPLETED)

    def _merge(self, job_id):
        self._state(job_id, JobState.REMAPPING)
        remapper = SpeakerRemapper(self.spool.load_speaker_state(job_id) or None)
        merged, previous, previous_window = (), (), None
        for result in self.spool.load_completed_windows(job_id):
            current = remapper.map_adjacent(previous, result.segments, previous_window, result.window)
            merged = merge_adjacent(merged, current, previous_window, result.window)
            previous, previous_window = current, result.window
        self.spool.save_speaker_state(job_id, remapper.to_dict())
        self._state(job_id, JobState.MERGING)
        self.spool.save_merged_segments(job_id, merged)

    def get_result(self, job_id):
        snapshot = self.get_job(job_id)
        if snapshot.state is not JobState.COMPLETED:
            return None
        return JobResult(job_id, snapshot.audio_sha256, snapshot.model_manifest_sha256,
                         self.spool.load_merged_segments(job_id))

    def close(self):
        with self._serial:
            self._stop_child()
