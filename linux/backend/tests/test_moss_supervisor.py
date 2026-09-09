import hashlib
import importlib
import wave
import sys
import time
from collections import Counter
from dataclasses import replace
from threading import Event, Thread

import pytest

from moss_worker.storage import MossSpool
from moss_worker.types import JobState, ParseStatus, WindowResult, WindowState


def supervisor_module():
    assert importlib.util.find_spec('moss_worker.supervisor'), 'supervisor implementation missing'
    return importlib.import_module('moss_worker.supervisor')


def audio(tmp_path, minutes=13):
    path = tmp_path / 'original.wav'
    with wave.open(str(path), 'wb') as stream:
        stream.setparams((1, 2, 16000, 0, 'NONE', 'not compressed'))
        for _ in range(minutes * 60):
            stream.writeframes(b'\0' * 32000)
    return path


class CrashOnceChild:
    def __init__(self):
        self.calls = []
        self.starts = 0
        self.crashed = False

    def start(self):
        self.starts += 1

    def close(self):
        pass

    def infer(self, wav, window_id, window, on_state, cancelled, grace):
        self.calls.append((window_id, window))
        if window.start_ms and not self.crashed:
            self.crashed = True
            raise supervisor_module().ChildCrashed('SIG11')
        return WindowResult(window_id, window, WindowState.DONE,
                            hashlib.sha256(wav.read_bytes()).hexdigest(), 'manifest',
                            'raw', (), ParseStatus.VALID, None), None


def test_crash_resume_preserves_done_and_retries_same_coverage_once(tmp_path):
    module = supervisor_module()
    child = CrashOnceChild()
    supervisor = module.MossSupervisor(MossSpool(tmp_path / 'spool'),
        bundle=tmp_path, manifest_sha256='manifest', runtime_versions={'python': 'test'},
        child_factory=lambda: child, counter_factory=lambda wav: lambda start, end: 100)
    job = supervisor.submit(audio(tmp_path))
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.COMPLETED
    counts = Counter((w.start_ms, w.end_ms) for _, w in child.calls)
    assert counts == {(0, 600000): 1, (480000, 780000): 2}
    assert len({identity for identity, _ in child.calls}) == 3
    assert child.starts == 2
    supervisor.close()


class ScriptedChild(CrashOnceChild):
    def __init__(self, action=lambda window: None):
        super().__init__()
        self.action = action
        self.crashed = True

    def infer(self, *args):
        result, metadata = super().infer(*args)
        error = self.action(result.window)
        if error == 'crash':
            raise supervisor_module().ChildCrashed('SIG11')
        return replace(result, state=WindowState.FAILED if error else WindowState.DONE,
                       error=error, raw_generation=error or 'raw'), {'perf': {'tokens': 1}}


def make_supervisor(tmp_path, child, **kwargs):
    return supervisor_module().MossSupervisor(MossSpool(tmp_path / 'spool'),
        bundle=tmp_path, manifest_sha256='manifest', runtime_versions={'python': 'test'},
        child_factory=lambda: child, counter_factory=lambda wav: lambda start, end: 100, **kwargs)


@pytest.mark.parametrize('error', ['MOSS_CONTEXT_BUDGET_EXCEEDED', 'MOSS_OOM', 'GENERATION_LIMIT_REACHED'])
def test_retry_covers_entire_interval_and_preserves_raw_attempts(tmp_path, error):
    child = ScriptedChild(lambda window: error if window.window_minutes > 8 else None)
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 12))
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.COMPLETED
    done = supervisor.spool.load_completed_windows(job.job_id)
    end = 0
    for result in done:
        assert result.window.start_ms <= end
        end = max(end, result.window.end_ms)
        assert result.window.window_minutes == 8
    assert end == 720000
    attempts = supervisor.spool.load_window_results(job.job_id)
    assert all(r.raw_generation == error for r in attempts if r.state is WindowState.FAILED)
    assert len({identity for identity, _ in child.calls}) == len(child.calls)
    supervisor.close()


def test_submit_records_approved_window_policy_revision(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    record = supervisor.spool.load_job(job.job_id)
    assert record['revision']['windowing_params'] == dict(
        target_minutes=10, fallback_minutes=8, minimum_minutes=8,
        overlap_ms=120000, logical_chunk_ms=3600000)
    supervisor.close()


def test_minimum_and_clipped_tail_failure_is_terminal(tmp_path):
    child = ScriptedChild(lambda window: 'GENERATION_LIMIT_REACHED')
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.run_pending()
    assert [w.window_minutes for _, w in child.calls] == [10, 8]
    assert supervisor.get_job(job.job_id).state is JobState.FAILED
    assert supervisor.get_result(job.job_id) is None
    supervisor.resume(job.job_id)
    supervisor.run_pending()
    assert len(child.calls) == 2
    supervisor.close()


def test_cancel_queued_is_immediate_and_terminal(tmp_path):
    child = ScriptedChild()
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    assert supervisor.cancel(job.job_id).state is JobState.CANCELLED
    supervisor.resume(job.job_id)
    supervisor.run_pending()
    assert not child.calls
    with pytest.raises(ValueError, match='terminal'):
        supervisor._state(job.job_id, JobState.PREPARING)
    supervisor.close()


def test_resume_after_done_checkpoint_does_not_repeat_inference(tmp_path, monkeypatch):
    child = ScriptedChild()
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    def power_loss(job_id):
        raise KeyboardInterrupt('power loss before merge')
    monkeypatch.setattr(supervisor, '_merge', power_loss)
    with pytest.raises(KeyboardInterrupt):
        supervisor.run_pending()
    assert len(supervisor.spool.load_completed_windows(job.job_id)) == 1
    recovered = make_supervisor(tmp_path, child)
    recovered.resume(job.job_id)
    recovered.run_pending()
    assert recovered.get_job(job.job_id).state is JobState.COMPLETED
    assert len(child.calls) == 1
    supervisor.close()
    recovered.close()


def test_crash_budget_survives_power_loss_before_plan_replacement(tmp_path, monkeypatch):
    child = ScriptedChild(lambda window: 'crash')
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    original = supervisor.spool.save_window_result
    def crash_after_save(job_id, result):
        original(job_id, result)
        raise KeyboardInterrupt('power loss after FAILED commit')
    monkeypatch.setattr(supervisor.spool, 'save_window_result', crash_after_save)
    with pytest.raises(KeyboardInterrupt):
        supervisor.run_pending()
    recovered = make_supervisor(tmp_path, child)
    recovered.resume(job.job_id)
    recovered.run_pending()
    assert recovered.get_job(job.job_id).state is JobState.FAILED
    assert len(child.calls) == 2
    supervisor.close()
    recovered.close()


def test_cancel_running_preserves_done_and_restarts_child(tmp_path):
    entered = Event()
    class WaitingChild(ScriptedChild):
        def infer(self, wav, identity, window, on_state, cancelled, grace):
            if window.start_ms:
                entered.set()
                assert cancelled.wait(5)
                assert grace == .01
                raise supervisor_module().ChildCancelled()
            return super().infer(wav, identity, window, on_state, cancelled, grace)
    child = WaitingChild()
    supervisor = make_supervisor(tmp_path, child, cancel_grace=.01)
    job = supervisor.submit(audio(tmp_path))
    thread = Thread(target=supervisor.run_pending)
    thread.start()
    try:
        assert entered.wait(5)
        supervisor.cancel(job.job_id)
    finally:
        thread.join(5)
        assert not thread.is_alive()
    assert supervisor.get_job(job.job_id).state is JobState.CANCELLED
    assert len(supervisor.spool.load_completed_windows(job.job_id)) == 1
    assert child.starts == 2
    supervisor.close()


def test_transport_readiness_state_result_and_bounded_stderr(tmp_path):
    module = supervisor_module()
    script = """
import json, sys
sys.stderr.write('x' * 200000); sys.stderr.flush()
print(json.dumps({'type':'ready','model_manifest_sha256':'manifest','selftests':{'ok':True}}), flush=True)
for line in sys.stdin:
    request = json.loads(line)
    if request['type'] == 'shutdown': break
    print(json.dumps({'type':'state','request_id':request['request_id'],'state':'ENCODING'}), flush=True)
    result = dict(window_id=request['window_id'], window=request['window'], state='DONE',
        audio_sha256='audio', model_manifest_sha256='manifest', raw_generation='raw', segments=[],
        parse_status='VALID', error=None, token_count=1, normal_termination=True)
    print(json.dumps({'type':'result','request_id':request['request_id'],'result':result,'generation_metadata':{'perf':{'tokens':1}}}), flush=True)
"""
    child = module.ProcessChild([sys.executable, '-u', '-c', script], 'manifest')
    child.start()
    states = []
    from moss_worker.windowing import WindowSpec
    try:
        result, metadata = child.infer(tmp_path / 'source.wav', 'w1', WindowSpec(0, 1000, 0, 12),
                                       states.append, Event(), 10)
        assert result.state is WindowState.DONE
        assert metadata == {'perf': {'tokens': 1}}
        assert states == ['ENCODING']
        assert len(child.stderr_tail) <= 65536
    finally:
        child.close()
    assert not any(thread.is_alive() for thread in child.threads)


def test_transport_cancellation_kills_native_after_grace(tmp_path):
    module = supervisor_module()
    script = """
import json, sys, time
print(json.dumps({'type':'ready','model_manifest_sha256':'manifest','selftests':{'ok':True}}), flush=True)
for line in sys.stdin:
    time.sleep(60)
"""
    child = module.ProcessChild([sys.executable, '-u', '-c', script], 'manifest')
    child.start()
    cancelled = Event()
    cancelled.set()
    from moss_worker.windowing import WindowSpec
    start = time.monotonic()
    try:
        with pytest.raises(module.ChildCancelled):
            child.infer(tmp_path / 'source.wav', 'w1', WindowSpec(0, 1000, 0, 12),
                        lambda state: None, cancelled, .05)
        assert .04 <= time.monotonic() - start < 3
    finally:
        child.close()
    assert child.process.poll() is not None
    assert not any(thread.is_alive() for thread in child.threads)


@pytest.mark.parametrize('message', [
    {'type': 'not_ready', 'error': 'bad hash'},
    {'type': 'ready', 'model_manifest_sha256': 'wrong', 'selftests': {'ok': True}},
    {'type': 'ready', 'model_manifest_sha256': 'manifest', 'selftests': {}},
])
def test_transport_refuses_unverified_child(message):
    import json
    module = supervisor_module()
    child = module.ProcessChild([sys.executable, '-c', 'print(' + repr(json.dumps(message)) + ')'], 'manifest')
    with pytest.raises(RuntimeError):
        child.start()
    assert child.process.poll() is not None


def test_resume_checks_model_runtime_and_audio_revision(tmp_path):
    child = ScriptedChild()
    supervisor = make_supervisor(tmp_path, child)
    wav = audio(tmp_path, 1)
    job = supervisor.submit(wav)
    other = make_supervisor(tmp_path, child)
    other.runtime_versions = {'python': 'different'}
    with pytest.raises(ValueError, match='MOSS_REVISION_CHANGED'):
        other.resume(job.job_id)
    with wav.open('ab') as stream:
        stream.write(b'changed')
    with pytest.raises(ValueError, match='MOSS_AUDIO_CHANGED'):
        supervisor.get_job(job.job_id)


def test_actual_counter_required_again_before_inference(tmp_path):
    child = ScriptedChild()
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.counter_factory = lambda wav: lambda start, end: 10753
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.FAILED
    assert not child.calls


def test_default_counter_uses_actual_frontend_samples_and_rendered_prompt(tmp_path, monkeypatch):
    from moss_worker import audio_frontend, embedding_builder, runtime
    calls = []
    monkeypatch.setattr(runtime, 'validate_model_bundle', lambda path, digest:
                        calls.append(('validate', digest)) or {'processor_config': {}})
    monkeypatch.setattr(runtime, 'render_prompt', lambda path: 'actual rendered prompt')
    class Frontend:
        def __init__(self, config):
            pass
        def read_samples(self, wav, window):
            calls.append(('samples', window.start_ms, window.end_ms))
            return [0] * 123
    class Builder:
        def interval_counter(self, prompt, provider):
            assert prompt == 'actual rendered prompt'
            return lambda start, end: provider(start, end)
    monkeypatch.setattr(audio_frontend, 'AudioFrontend', Frontend)
    monkeypatch.setattr(embedding_builder.MossEmbeddingBuilder, 'from_bundle', lambda path: Builder())
    supervisor = supervisor_module().MossSupervisor(MossSpool(tmp_path / 'spool'),
        bundle=tmp_path, manifest_sha256='manifest', runtime_versions={'python': 'test'},
        child_factory=ScriptedChild)
    job = supervisor.submit(audio(tmp_path, 1))
    assert ('validate', 'manifest') in calls
    assert ('samples', 0, 60000) in calls
    assert supervisor.cancel_grace == 10
    assert supervisor.get_job(job.job_id).state is JobState.QUEUED


def test_default_child_command_is_explicit_no_shell(tmp_path):
    supervisor = supervisor_module().MossSupervisor(MossSpool(tmp_path / 'spool'),
        bundle=tmp_path, manifest_sha256='manifest', runtime_versions={'python': 'test'},
        python_executable='/private/python3.10', rknn_library='/private/rknn.so', rkllm_library='/private/rkllm.so')
    child = supervisor.child_factory()
    assert child.command == ['/private/python3.10', '-u', '-m', 'moss_worker.child',
        '--bundle', str(tmp_path), '--manifest-sha256', 'manifest',
        '--rknn-library', '/private/rknn.so', '--rkllm-library', '/private/rkllm.so']


def test_revision_records_actual_generation_policy(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    revision = supervisor.spool.load_job(job.job_id)['revision']
    assert revision['generation_params'] == dict(context_length=16384, max_new_tokens=5120,
        safety_margin=512, top_k=1, top_p=1, temperature=1, repeat_penalty=1,
        frequency_penalty=0, presence_penalty=0, mirostat=0, keep_history=0)


def test_result_must_match_requested_window_not_other_active_window(tmp_path):
    from moss_worker.windowing import WindowSpec
    class WrongChild(ScriptedChild):
        def infer(self, *args):
            result, metadata = super().infer(*args)
            if len(self.calls) > 1:
                raise AssertionError('must reject wrong window before next call')
            return replace(result, window_id='w0002', window=WindowSpec(600000, 780000, 0, 12)), metadata
    supervisor = make_supervisor(tmp_path, WrongChild())
    job = supervisor.submit(audio(tmp_path))
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.FAILED
    assert supervisor.spool.load_completed_windows(job.job_id) == []
    supervisor.close()


def test_cancel_request_survives_restart_and_does_not_infer(tmp_path):
    child = ScriptedChild()
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor._state(job.job_id, JobState.DECODING, 'MOSS_CANCEL_REQUESTED')
    recovered = make_supervisor(tmp_path, child)
    assert recovered.resume(job.job_id).state is JobState.CANCELLED
    recovered.run_pending()
    assert not child.calls


def test_unknown_native_state_cannot_complete_job(tmp_path):
    class BadChild(ScriptedChild):
        def infer(self, wav, identity, window, on_state, cancelled, grace):
            on_state('COMPLETED')
            return super().infer(wav, identity, window, on_state, cancelled, grace)
    supervisor = make_supervisor(tmp_path, BadChild())
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.FAILED


def test_simultaneous_runners_are_serial_and_queued_cancel_stays_available(tmp_path):
    entered, release = Event(), Event()
    class BlockingChild(ScriptedChild):
        def infer(self, *args):
            entered.set()
            assert release.wait(5)
            return super().infer(*args)
    child = BlockingChild()
    supervisor = make_supervisor(tmp_path, child)
    wav = audio(tmp_path, 1)
    first, second = supervisor.submit(wav), supervisor.submit(wav)
    runners = [Thread(target=supervisor.run_pending) for _ in range(2)]
    for thread in runners:
        thread.start()
    try:
        assert entered.wait(5)
        assert supervisor.cancel(second.job_id).state is JobState.CANCELLED
    finally:
        release.set()
        for thread in runners:
            thread.join(5)
            assert not thread.is_alive()
    assert len(child.calls) == 1
    assert supervisor.get_job(first.job_id).state is JobState.COMPLETED
    supervisor.close()


def test_queue_status_counts_queued_jobs_and_names_the_active_job(tmp_path):
    entered, release = Event(), Event()
    class BlockingChild(ScriptedChild):
        def infer(self, *args):
            entered.set()
            assert release.wait(5)
            return super().infer(*args)
    supervisor = make_supervisor(tmp_path, BlockingChild())
    wav = audio(tmp_path, 1)
    first, second = supervisor.submit(wav), supervisor.submit(wav)
    assert supervisor.queue_status() == (2, None)
    runner = Thread(target=supervisor.run_pending)
    runner.start()
    try:
        assert entered.wait(5)
        assert supervisor.queue_status() == (1, first.job_id)
    finally:
        release.set()
        runner.join(5)
        assert not runner.is_alive()
    assert supervisor.queue_status() == (0, None)
    supervisor.close()


def test_startup_timeout_is_bounded_and_child_reaped():
    module = supervisor_module()
    child = module.ProcessChild([sys.executable, '-c', 'import time; time.sleep(60)'],
                                'manifest', startup_timeout=.05)
    with pytest.raises(RuntimeError, match='NOT_READY'):
        child.start()
    assert child.process.poll() is not None


def test_crashed_child_does_not_poison_next_queued_job(tmp_path):
    class DeadChild(ScriptedChild):
        def __init__(self, crash):
            super().__init__()
            self.crash = crash
        def infer(self, *args):
            if self.crash:
                raise supervisor_module().ChildCrashed('SIG11')
            return super().infer(*args)
    created = []
    def factory():
        child = DeadChild(len(created) < 2)
        created.append(child)
        return child
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    supervisor.child_factory = factory
    wav = audio(tmp_path, 1)
    first, second = supervisor.submit(wav), supervisor.submit(wav)
    supervisor.run_pending()
    assert supervisor.get_job(first.job_id).state is JobState.FAILED
    assert supervisor.get_job(second.job_id).state is JobState.COMPLETED
    assert len(created[2].calls) == 1
    assert len(supervisor.spool.load_window_results(second.job_id)) == 1
    supervisor.close()


def test_invalid_nonterminal_window_result_fails_without_retry(tmp_path):
    class BadChild(ScriptedChild):
        def infer(self, *args):
            result, metadata = super().infer(*args)
            if len(self.calls) > 1:
                raise AssertionError('must reject first nonterminal result')
            return replace(result, state=WindowState.RUNNING), metadata
    supervisor = make_supervisor(tmp_path, BadChild())
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.FAILED
    supervisor.close()


def test_first_window_partial_replacements_never_publish_authoritative_output(tmp_path):
    def failure(window):
        if window.window_minutes == 10 or window.start_ms:
            return 'GENERATION_LIMIT_REACHED'
    child = ScriptedChild(failure)
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 12))
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.FAILED
    assert supervisor.get_result(job.job_id) is None
    assert supervisor.spool.load_merged_segments(job.job_id) == ()
    assert len(supervisor.spool.load_completed_windows(job.job_id)) == 1
    supervisor.close()


def test_speaker_merge_replay_after_checkpoint_is_stable(tmp_path, monkeypatch):
    from test_moss_types import segment
    class SpeakingChild(ScriptedChild):
        def infer(self, *args):
            result, metadata = super().infer(*args)
            # 590000 sits inside both planned windows' shared overlap region
            # (W1 0-10min, W2 8-13min) so the merger deduplicates across windows.
            utterance = segment(window_id=result.window_id, segment_id=result.window_id + '-s1',
                start_ms=590000, end_ms=591000)
            return replace(result, segments=(utterance,)), metadata
    child = SpeakingChild()
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path))
    original = supervisor.spool.save_merged_segments
    def power_loss(job_id, segments):
        original(job_id, segments)
        raise KeyboardInterrupt()
    monkeypatch.setattr(supervisor.spool, 'save_merged_segments', power_loss)
    with pytest.raises(KeyboardInterrupt):
        supervisor.run_pending()
    before = supervisor.spool.load_merged_segments(job.job_id)
    assert len(before) == 1
    assert before[0].global_speaker == 'GS01'
    recovered = make_supervisor(tmp_path, child)
    recovered.resume(job.job_id)
    recovered.run_pending()
    assert recovered.get_result(job.job_id).segments == before
    assert len(child.calls) == 2
    supervisor.close()
    recovered.close()


def test_changed_audio_does_not_strand_unrelated_queued_job(tmp_path):
    child = ScriptedChild()
    supervisor = make_supervisor(tmp_path, child)
    first_wav = audio(tmp_path, 1)
    first = supervisor.submit(first_wav)
    other_dir = tmp_path / 'other'
    other_dir.mkdir()
    second = supervisor.submit(audio(other_dir, 1))
    with first_wav.open('ab') as stream:
        stream.write(b'changed')
    failures = supervisor.run_pending()
    assert 'MOSS_AUDIO_CHANGED' in failures[first.job_id]
    assert supervisor.get_job(second.job_id).state is JobState.COMPLETED
    with pytest.raises(ValueError, match='MOSS_AUDIO_CHANGED'):
        supervisor.get_job(first.job_id)
    supervisor.close()


def test_explicit_oom_releases_child_before_smaller_retry(tmp_path):
    child = ScriptedChild(lambda window: 'MOSS_OOM' if window.window_minutes == 10 else None)
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.run_pending()
    assert supervisor.get_job(job.job_id).state is JobState.COMPLETED
    assert child.starts == 2
    supervisor.close()
