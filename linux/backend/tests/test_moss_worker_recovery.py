"""Task 16: explicit worker-restart recovery (RECOVERY_REQUIRED, V1 ruling).

V1 never auto-resumes: a worker restart must leave COMPLETED evidence readable
and untouched, move every non-terminal spool job into the persisted
RECOVERY_REQUIRED state, and let cancel reach the existing idempotent terminal
semantics. Business resubmission happens on the app side against the same
immutable audio hash.
"""
import json
from dataclasses import replace

from moss_worker.storage import MossSpool
from moss_worker.types import JobState, ParseStatus, WindowResult, WindowState
from moss_worker.windowing import WindowSpec

from test_moss_supervisor import ScriptedChild, audio, make_supervisor, supervisor_module
from test_moss_types import segment


def done_window(supervisor, job, window_id="w0001"):
    window = supervisor.spool.load_windows(job.job_id)[window_id]
    return WindowResult(
        window_id, window, WindowState.DONE,
        job.audio_sha256, job.model_manifest_sha256, "raw",
        (segment(segment_id="w0001-s1", window_id=window_id),),
        ParseStatus.VALID, None, 16, True,
    )


def test_restart_marks_nonterminal_jobs_recovery_required(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor._state(job.job_id, JobState.DECODING)
    supervisor.close()

    recovered = make_supervisor(tmp_path, ScriptedChild())

    snapshot = recovered.get_job(job.job_id)
    assert snapshot.state is JobState.RECOVERY_REQUIRED
    persisted = json.loads(
        (tmp_path / "spool" / "jobs" / job.job_id / "job.json").read_text(encoding="utf-8")
    )["snapshot"]
    assert persisted["state"] == "RECOVERY_REQUIRED"
    assert "RECOVERY" in (snapshot.error or "")
    supervisor.close()
    recovered.close()


def test_queued_jobs_enter_recovery_required_without_running(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.close()

    recovered = make_supervisor(tmp_path, ScriptedChild())
    assert recovered.get_job(job.job_id).state is JobState.RECOVERY_REQUIRED
    recovered.run_pending()
    assert recovered.get_job(job.job_id).state is JobState.RECOVERY_REQUIRED
    recovered.close()


def test_terminal_states_survive_restart_unchanged(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    wav = audio(tmp_path, 1)
    completed = supervisor.submit(wav)
    failed = supervisor.submit(wav)
    supervisor._state(failed.job_id, JobState.FAILED, "MOSS_WINDOW_FAILED")
    supervisor.run_pending()
    assert supervisor.get_job(completed.job_id).state is JobState.COMPLETED
    supervisor.close()

    recovered = make_supervisor(tmp_path, ScriptedChild())
    assert recovered.get_job(completed.job_id).state is JobState.COMPLETED
    assert recovered.get_job(failed.job_id).state is JobState.FAILED
    recovered.close()


def test_completed_job_stays_readable_and_never_recomputed_after_restart(tmp_path):
    child = ScriptedChild()
    supervisor = make_supervisor(tmp_path, child)
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.run_pending()
    before = len(child.calls)
    result = supervisor.get_result(job.job_id)
    supervisor.close()

    recovered = make_supervisor(tmp_path, ScriptedChild())
    recovered.run_pending()
    assert recovered.get_result(job.job_id).segments == result.segments
    assert recovered.get_job(job.job_id).state is JobState.COMPLETED
    assert len(child.calls) == before
    recovered.close()


def test_recovery_scan_is_idempotent_and_preserves_first_evidence(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.close()

    first = make_supervisor(tmp_path, ScriptedChild())
    first_error = first.get_job(job.job_id).error
    second = make_supervisor(tmp_path, ScriptedChild())
    snapshot = second.get_job(job.job_id)
    assert snapshot.state is JobState.RECOVERY_REQUIRED
    assert snapshot.error == first_error
    first.close()
    second.close()


def test_cancel_recovery_required_is_idempotent_terminal(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.close()
    recovered = make_supervisor(tmp_path, ScriptedChild())
    assert recovered.get_job(job.job_id).state is JobState.RECOVERY_REQUIRED

    cancelled = recovered.cancel(job.job_id)
    assert cancelled.state is JobState.CANCELLED
    assert recovered.cancel(job.job_id).state is JobState.CANCELLED
    recovered.run_pending()
    assert recovered.get_job(job.job_id).state is JobState.CANCELLED
    recovered.close()


def test_recovery_required_reports_windows_evidence_with_segment_count(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    supervisor.spool.save_window_result(job.job_id, done_window(supervisor, job))
    supervisor.close()

    recovered = make_supervisor(tmp_path, ScriptedChild())
    assert recovered.get_job(job.job_id).state is JobState.RECOVERY_REQUIRED

    from moss_worker.main import MossWorkerServer
    payload = MossWorkerServer(tmp_path / "moss.sock", recovered)._job_payload(
        recovered.get_job(job.job_id)
    )
    assert payload["state"] == "RECOVERY_REQUIRED"
    windows = payload["windows"]
    assert [w["window_id"] for w in windows] == ["w0001"]
    assert windows[0]["state"] == "DONE"
    assert windows[0]["segment_count"] == 1
    recovered.close()


def test_window_status_segment_count_is_zero_for_failed_attempts(tmp_path):
    supervisor = make_supervisor(tmp_path, ScriptedChild())
    job = supervisor.submit(audio(tmp_path, 1))
    failed = replace(done_window(supervisor, job), state=WindowState.FAILED, segments=(), error="GENERATION_LIMIT_REACHED")
    supervisor.spool.save_window_result(job.job_id, failed)

    from moss_worker.main import MossWorkerServer
    payload = MossWorkerServer(tmp_path / "moss.sock", supervisor)._job_payload(
        supervisor.get_job(job.job_id)
    )
    assert payload["windows"][0]["segment_count"] == 0
    supervisor.close()
