from __future__ import annotations

import hashlib
import os
import socket
import stat
import threading
import time
import wave
from pathlib import Path

import pytest

from app.ai.errors import (
    AIError,
    BackendUnavailableError,
    ResourceBusyError,
    WorkerCrashedError,
    WorkerTimeoutError,
)
from app.ai.moss.client import MossWorkerClient
from app.ai.moss.types import (
    MossAudioChangedError,
    MossGenerationLimitError,
    MossJobNotFoundError,
    MossJobResult,
    MossJobSnapshot,
)
from moss_worker.main import MossWorkerServer
from moss_worker.protocol import recv_frame, send_frame
from moss_worker.storage import MossSpool
from moss_worker.supervisor import MossSupervisor
from moss_worker.types import (
    JobResult,
    JobSnapshot,
    JobState,
    MergeStatus,
    ParseStatus,
    WindowResult,
    WindowState,
)
from moss_worker.windowing import WindowSpec


# --------------------------------------------------------------------------
# Shared helpers and fakes
# --------------------------------------------------------------------------


def _af_unix_required() -> None:
    """Mirror the runtime platform skip used by test_moss_storage.py symlinks."""
    if not hasattr(socket, "AF_UNIX"):
        pytest.skip("AF_UNIX is unavailable on this platform")


def _snapshot(job_id="job-1", state=JobState.QUEUED, error=None) -> JobSnapshot:
    return JobSnapshot(job_id, state, "audio-sha", "manifest", 0.0, error)


def _window_result(
    window_id="w0001",
    window=None,
    state=WindowState.FAILED,
    error="GENERATION_LIMIT_REACHED",
    token_count=5120,
    normal_termination=False,
) -> WindowResult:
    return WindowResult(
        window_id,
        window or WindowSpec(0, 720000, 0, 12),
        state,
        "audio-sha",
        "manifest",
        "[0.0][S01]你好" if state is WindowState.DONE else error or "raw",
        (),
        ParseStatus.VALID if state is WindowState.DONE else ParseStatus.INVALID,
        error,
        token_count,
        normal_termination,
    )


class FakeSpool:
    def __init__(self, results=()):
        self._results = tuple(results)

    def load_window_results(self, job_id):
        return self._results


class FakeSupervisor:
    """Server-facing stand-in mirroring the MossSupervisor public surface."""

    def __init__(self, *, job=None, result=None, spool=None, run_failures=None):
        self.manifest_sha256 = "manifest"
        self.runtime_versions = {"python": "test"}
        self.job = job
        self.result = result
        self.spool = spool or FakeSpool()
        self.run_failures = dict(run_failures or {})
        self.run_pending_calls = 0
        self.errors: dict = {}
        self.submitted: list = []
        self.cancelled: list = []

    def fail(self, op, exc):
        self.errors[op] = exc

    def _maybe_fail(self, op):
        exc = self.errors.get(op)
        if exc is not None:
            raise exc

    def run_pending(self):
        self.run_pending_calls += 1
        self._maybe_fail("run_pending")
        return dict(self.run_failures)

    def submit(self, wav):
        self._maybe_fail("submit")
        self.submitted.append(Path(wav))
        return self.job

    def get_job(self, job_id):
        self._maybe_fail("get_job")
        return self.job

    def get_result(self, job_id):
        self._maybe_fail("get_result")
        return self.result

    def cancel(self, job_id):
        self._maybe_fail("cancel")
        self.cancelled.append(job_id)
        return self.job


def _server(supervisor, **kwargs) -> MossWorkerServer:
    return MossWorkerServer(Path("unused.sock"), supervisor, **kwargs)


def _write_wav(tmp_path: Path, seconds: int = 1) -> Path:
    path = tmp_path / "audio.wav"
    with wave.open(str(path), "wb") as stream:
        stream.setparams((1, 2, 16000, 0, "NONE", "not compressed"))
        for _ in range(seconds):
            stream.writeframes(b"\0" * 32000)
    return path


# --------------------------------------------------------------------------
# Server op routing (platform-independent: plain dict dispatch)
# --------------------------------------------------------------------------


def test_health_reports_manifest_runtime_and_scheduler_state():
    supervisor = FakeSupervisor(run_failures={"job-9": "MOSS_AUDIO_CHANGED: source SHA256 mismatch"})
    server = _server(supervisor)
    server._run_pending_once()

    health = server._dispatch({"op": "health"})

    assert supervisor.run_pending_calls == 1
    assert health["status"] == "ok"
    assert health["manifest_sha256"] == "manifest"
    assert health["runtime_versions"] == {"python": "test"}
    assert health["run_failures"] == {"job-9": "MOSS_AUDIO_CHANGED: source SHA256 mismatch"}
    assert health["scheduler_error"] is None


def test_scheduler_error_is_surfaced_and_not_silently_swallowed():
    supervisor = FakeSupervisor()
    supervisor.fail("run_pending", RuntimeError("MOSS_CHILD_CRASHED: boom"))
    server = _server(supervisor)

    server._run_pending_once()
    health = server._dispatch({"op": "health"})

    assert "MOSS_CHILD_CRASHED" in health["scheduler_error"]


def test_submit_job_preserves_failed_interval_attempt_tier_and_termination_metadata():
    supervisor = FakeSupervisor(job=_snapshot(), spool=FakeSpool([_window_result()]))

    result = _server(supervisor)._dispatch({"op": "submit_job", "audio_path": "E:/audio/证词.wav"})

    assert result["job_id"] == "job-1"
    assert result["state"] == "QUEUED"
    status = result["windows"][0]
    assert (status["start_ms"], status["end_ms"]) == (0, 720000)
    assert status["window_minutes"] == 12
    assert status["state"] == "FAILED"
    assert status["error"] == "GENERATION_LIMIT_REACHED"
    assert status["token_count"] == 5120
    assert status["normal_termination"] is False
    assert supervisor.submitted == [Path("E:/audio/证词.wav")]


def test_submit_job_requires_audio_path():
    with pytest.raises(AIError, match="audio_path is required"):
        _server(FakeSupervisor())._dispatch({"op": "submit_job"})


def test_submit_job_rejects_declared_hash_mismatch_before_creating_job(tmp_path):
    wav = _write_wav(tmp_path)
    supervisor = FakeSupervisor(job=_snapshot())

    with pytest.raises(AIError) as exc_info:
        _server(supervisor)._dispatch(
            {"op": "submit_job", "audio_path": str(wav), "audio_sha256": "0" * 64}
        )

    assert exc_info.value.code == "MOSS_AUDIO_CHANGED"
    assert supervisor.submitted == []


def test_submit_job_accepts_declared_hash_case_insensitively_and_forwards(tmp_path):
    wav = _write_wav(tmp_path)
    sha = hashlib.sha256(wav.read_bytes()).hexdigest()
    supervisor = FakeSupervisor(job=_snapshot())

    result = _server(supervisor)._dispatch(
        {"op": "submit_job", "audio_path": str(wav), "audio_sha256": sha.upper()}
    )

    assert result["job_id"] == "job-1"
    assert supervisor.submitted == [wav]


def test_get_job_dispatch_includes_job_and_window_evidence():
    supervisor = FakeSupervisor(
        job=_snapshot(state=JobState.FAILED, error="GENERATION_LIMIT_REACHED"),
        spool=FakeSpool([_window_result()]),
    )

    result = _server(supervisor)._dispatch({"op": "get_job", "job_id": "job-1"})

    assert result["state"] == "FAILED"
    assert result["error"] == "GENERATION_LIMIT_REACHED"
    assert result["windows"][0]["error"] == "GENERATION_LIMIT_REACHED"


def test_get_result_dispatch_returns_none_for_unfinished_job():
    supervisor = FakeSupervisor(job=_snapshot(state=JobState.DECODING))

    result = _server(supervisor)._dispatch({"op": "get_result", "job_id": "job-1"})

    assert result["result"] is None


def test_get_result_dispatch_returns_completed_result_with_provenance():
    from test_moss_types import segment

    job_result = JobResult("job-1", "audio-sha", "manifest", (segment(),))
    supervisor = FakeSupervisor(job=_snapshot(state=JobState.COMPLETED), result=job_result)

    result = _server(supervisor)._dispatch({"op": "get_result", "job_id": "job-1"})

    assert result["result"]["job_id"] == "job-1"
    assert result["result"]["audio_sha256"] == "audio-sha"
    assert result["result"]["model_manifest_sha256"] == "manifest"
    assert result["result"]["segments"][0]["text"] == "你好"


def test_cancel_job_dispatch_returns_snapshot():
    supervisor = FakeSupervisor(job=_snapshot(state=JobState.CANCELLED))

    result = _server(supervisor)._dispatch({"op": "cancel_job", "job_id": "job-1"})

    assert result["state"] == "CANCELLED"
    assert supervisor.cancelled == ["job-1"]


def test_missing_job_maps_to_moss_job_not_found():
    supervisor = FakeSupervisor()
    supervisor.fail("get_job", FileNotFoundError("jobs/unknown/job.json"))

    with pytest.raises(AIError) as exc_info:
        _server(supervisor)._dispatch({"op": "get_job", "job_id": "unknown"})

    assert exc_info.value.code == "MOSS_JOB_NOT_FOUND"
    assert exc_info.value.details == {"job_id": "unknown"}


def test_invalid_job_id_maps_to_moss_job_not_found():
    supervisor = FakeSupervisor()
    supervisor.fail("cancel", ValueError("invalid job id"))

    with pytest.raises(AIError) as exc_info:
        _server(supervisor)._dispatch({"op": "cancel_job", "job_id": "../escape"})

    assert exc_info.value.code == "MOSS_JOB_NOT_FOUND"


@pytest.mark.parametrize(
    ("failing_op", "op", "message", "expected_code"),
    [
        ("get_job", "get_job", "MOSS_AUDIO_CHANGED: source SHA256 mismatch", "MOSS_AUDIO_CHANGED"),
        ("submit", "submit_job", "MOSS_AUDIO_FORMAT: requires PCM16 mono 16kHz WAV", "MOSS_AUDIO_FORMAT"),
        ("get_result", "get_result", "MOSS_REVISION_CHANGED: submit a new job", "MOSS_REVISION_CHANGED"),
        ("cancel", "cancel_job", "MOSS_CANCEL_REQUESTED", "MOSS_CANCEL_REQUESTED"),
    ],
)
def test_exact_moss_value_error_codes_pass_through_to_wire(failing_op, op, message, expected_code):
    supervisor = FakeSupervisor()
    supervisor.fail(failing_op, ValueError(message))

    with pytest.raises(AIError) as exc_info:
        _server(supervisor)._dispatch({"op": op, "job_id": "job-1", "audio_path": "x.wav"})

    assert exc_info.value.code == expected_code
    assert str(exc_info.value) == message


def test_non_moss_value_error_maps_to_generic_ai_error():
    supervisor = FakeSupervisor()
    supervisor.fail("get_job", ValueError("terminal job cannot transition"))

    with pytest.raises(AIError) as exc_info:
        _server(supervisor)._dispatch({"op": "get_job", "job_id": "job-1"})

    assert exc_info.value.code == "AI_ERROR"
    assert "terminal job cannot transition" in str(exc_info.value)


def test_corrupt_wav_submission_maps_to_audio_corrupt(tmp_path):
    supervisor = FakeSupervisor()
    supervisor.fail("submit", wave.Error("file does not start with RIFF id"))

    with pytest.raises(AIError) as exc_info:
        _server(supervisor)._dispatch({"op": "submit_job", "audio_path": str(tmp_path / "x.wav")})

    assert exc_info.value.code == "MOSS_AUDIO_CORRUPT"


def test_missing_audio_file_maps_to_generic_request_error():
    supervisor = FakeSupervisor()
    supervisor.fail("submit", FileNotFoundError("missing.wav"))

    with pytest.raises(AIError) as exc_info:
        _server(supervisor)._dispatch({"op": "submit_job", "audio_path": "missing.wav"})

    assert exc_info.value.code == "AI_ERROR"


def test_unknown_op_is_rejected():
    with pytest.raises(AIError, match="unknown moss operation"):
        _server(FakeSupervisor())._dispatch({"op": "nope"})


# --------------------------------------------------------------------------
# Connection envelope over socket_pair (platform-independent)
# --------------------------------------------------------------------------


@pytest.fixture
def socket_pair():
    left, right = socket.socketpair()
    try:
        yield left, right
    finally:
        left.close()
        right.close()


def test_connection_envelope_echoes_request_id_and_wraps_results(socket_pair):
    a, b = socket_pair
    supervisor = FakeSupervisor(job=_snapshot())
    server = _server(supervisor)
    thread = threading.Thread(target=server._handle_connection, args=(b,), daemon=True)
    thread.start()
    try:
        send_frame(a, {"request_id": "req-8", "op": "get_job", "job_id": "job-1"})
        response = recv_frame(a)
    finally:
        thread.join(timeout=2.0)

    assert not thread.is_alive()
    assert response["request_id"] == "req-8"
    assert response["ok"] is True
    assert response["result"]["job_id"] == "job-1"
    assert response["result"]["windows"] == []


def test_connection_envelope_maps_exact_moss_error_codes(socket_pair):
    a, b = socket_pair
    supervisor = FakeSupervisor()
    supervisor.fail("get_job", ValueError("MOSS_AUDIO_CHANGED: source SHA256 mismatch"))
    server = _server(supervisor)
    thread = threading.Thread(target=server._handle_connection, args=(b,), daemon=True)
    thread.start()
    try:
        send_frame(a, {"request_id": "req-9", "op": "get_job", "job_id": "job-1"})
        response = recv_frame(a)
    finally:
        thread.join(timeout=2.0)

    assert response["request_id"] == "req-9"
    assert response["ok"] is False
    assert response["error"]["code"] == "MOSS_AUDIO_CHANGED"
    assert response["error"]["message"] == "MOSS_AUDIO_CHANGED: source SHA256 mismatch"
    assert response["error"]["details"] == {}


def test_connection_envelope_reports_unexpected_failures_as_worker_crashed(socket_pair):
    a, b = socket_pair
    supervisor = FakeSupervisor()
    supervisor.fail("get_job", RuntimeError("NPU firmware panic"))
    server = _server(supervisor)
    thread = threading.Thread(target=server._handle_connection, args=(b,), daemon=True)
    thread.start()
    try:
        send_frame(a, {"request_id": "req-10", "op": "get_job", "job_id": "job-1"})
        response = recv_frame(a)
    finally:
        thread.join(timeout=2.0)

    assert response["ok"] is False
    assert response["error"]["code"] == "WORKER_CRASHED"


# --------------------------------------------------------------------------
# Client response validation and typed payloads (platform-independent)
# --------------------------------------------------------------------------


def _client() -> MossWorkerClient:
    return MossWorkerClient(Path("unused.sock"))


def test_client_passes_result_through_only_when_ok_true():
    result = _client()._validated_result(
        "req-1", {"request_id": "req-1", "ok": True, "result": {"status": "ok"}}, op="health"
    )
    assert result == {"status": "ok"}


def test_client_rejects_request_id_mismatch():
    with pytest.raises(WorkerCrashedError, match="request_id mismatch"):
        _client()._validated_result(
            "req-1", {"request_id": "other", "ok": True, "result": {}}, op="health"
        )


def test_client_rejects_missing_boolean_ok():
    with pytest.raises(WorkerCrashedError, match="boolean ok"):
        _client()._validated_result(
            "req-1", {"request_id": "req-1", "ok": "yes", "result": {}}, op="health"
        )


@pytest.mark.parametrize(
    ("code", "expected_type"),
    [
        ("MOSS_AUDIO_CHANGED", MossAudioChangedError),
        ("MOSS_JOB_NOT_FOUND", MossJobNotFoundError),
        ("GENERATION_LIMIT_REACHED", MossGenerationLimitError),
    ],
)
def test_client_maps_exact_error_codes_to_typed_moss_errors(code, expected_type):
    with pytest.raises(expected_type) as exc_info:
        _client()._validated_result(
            "req-1",
            {
                "request_id": "req-1",
                "ok": False,
                "error": {"code": code, "message": "worker refused", "details": {"job_id": "j1"}},
            },
            op="get_job",
        )

    assert exc_info.value.code == code
    assert exc_info.value.details == {"job_id": "j1"}


def test_client_unknown_error_code_falls_back_to_ai_error():
    with pytest.raises(AIError) as exc_info:
        _client()._validated_result(
            "req-1",
            {
                "request_id": "req-1",
                "ok": False,
                "error": {"code": "MOSS_SPEAKER_ASSIGNMENT_LIMIT", "message": "limit", "details": {}},
            },
            op="submit_job",
        )

    assert type(exc_info.value) is AIError


def test_client_rejects_malformed_error_payload():
    with pytest.raises(WorkerCrashedError, match="malformed"):
        _client()._validated_result(
            "req-1", {"request_id": "req-1", "ok": False, "error": "boom"}, op="health"
        )


def test_client_parses_snapshot_with_window_evidence():
    payload = {
        "job_id": "job-1",
        "state": "FAILED",
        "audio_sha256": "a",
        "model_manifest_sha256": "m",
        "progress": 1.0,
        "error": "GENERATION_LIMIT_REACHED",
        "windows": [
            {
                "window_id": "w1",
                "start_ms": 600000,
                "end_ms": 1320000,
                "window_minutes": 10,
                "state": "FAILED",
                "parse_status": "INVALID",
                "error": "GENERATION_LIMIT_REACHED",
                "token_count": 5120,
                "normal_termination": False,
            }
        ],
    }

    snapshot = _client()._snapshot(payload)

    assert isinstance(snapshot, MossJobSnapshot)
    assert snapshot.state == "FAILED"
    assert snapshot.error == "GENERATION_LIMIT_REACHED"
    assert (snapshot.windows[0].start_ms, snapshot.windows[0].end_ms) == (600000, 1320000)
    assert snapshot.windows[0].window_minutes == 10
    assert snapshot.windows[0].error == "GENERATION_LIMIT_REACHED"
    assert snapshot.windows[0].token_count == 5120
    assert snapshot.windows[0].normal_termination is False


def test_client_rejects_malformed_snapshot():
    with pytest.raises(WorkerCrashedError, match="malformed job snapshot"):
        _client()._snapshot({"unexpected": True})


def test_client_rejects_malformed_job_result():
    with pytest.raises(WorkerCrashedError, match="malformed job result"):
        _client()._job_result({"job_id": "job-1"})


def test_job_result_parses_segments_with_alternate_and_provenance():
    from test_moss_types import segment

    payload = segment(
        alternate=segment(segment_id="s2", text="另一版本"),
        merge_status=MergeStatus.CONFLICT,
    ).to_dict()

    result = MossJobResult.from_dict(
        {
            "job_id": "job-1",
            "audio_sha256": "a",
            "model_manifest_sha256": "m",
            "segments": [payload],
        }
    )

    assert isinstance(result, MossJobResult)
    assert result.segments[0].global_speaker is None
    assert result.segments[0].alternate is not None
    assert result.segments[0].alternate.text == "另一版本"
    assert result.segments[0].model_manifest_sha256 == "manifest"


# --------------------------------------------------------------------------
# Full client/server integration over AF_UNIX (Linux production transport)
# --------------------------------------------------------------------------


class InstantChild:
    def __init__(self, wav):
        self.wav = wav
        self.starts = 0

    def start(self):
        self.starts += 1

    def close(self):
        pass

    def infer(self, wav, window_id, window, on_state, cancelled, grace):
        from test_moss_types import segment

        on_state(JobState.ENCODING)
        audio_sha = hashlib.sha256(Path(wav).read_bytes()).hexdigest()
        result = WindowResult(
            window_id,
            window,
            WindowState.DONE,
            audio_sha,
            "manifest",
            "[0.0][S01]你好[1.0]",
            (segment(segment_id=f"{window_id}-s1", window_id=window_id),),
            ParseStatus.VALID,
            None,
            2,
            True,
        )
        return result, {"perf": {"generate_tokens": 2}}


def _supervisor(tmp_path: Path, child) -> MossSupervisor:
    return MossSupervisor(
        MossSpool(tmp_path / "spool"),
        bundle=tmp_path,
        manifest_sha256="manifest",
        runtime_versions={"python": "test"},
        child_factory=lambda: child,
        counter_factory=lambda wav: (lambda start, end: 100),
    )


def _start_server(path: Path, supervisor):
    server = MossWorkerServer(path, supervisor, run_pending_interval=0.01)
    server.bind()
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    return server, thread


def _stop_server(server, thread) -> None:
    server.stop()
    thread.join(timeout=2.0)
    assert not thread.is_alive()


def _wait_for_terminal(client: MossWorkerClient, job_id: str, timeout: float = 10.0) -> MossJobSnapshot:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        snapshot = client.get_job(job_id)
        if snapshot.state in {"COMPLETED", "FAILED", "CANCELLED"}:
            return snapshot
        time.sleep(0.02)
    raise AssertionError("job did not reach a terminal state in time")


def test_client_and_server_round_trip_full_job_lifecycle(tmp_path):
    _af_unix_required()
    wav = _write_wav(tmp_path)
    socket_path = tmp_path / "moss.sock"
    server, thread = _start_server(socket_path, _supervisor(tmp_path, InstantChild(wav)))
    try:
        assert stat.S_IMODE(socket_path.stat().st_mode) == 0o660
        client = MossWorkerClient(socket_path, timeout=2.0)

        health = client.health()
        assert health["status"] == "ok"
        assert health["manifest_sha256"] == "manifest"
        assert health["runtime_versions"] == {"python": "test"}

        job = client.submit_job(str(wav))
        assert isinstance(job, MossJobSnapshot)
        assert job.state == "QUEUED"

        snapshot = _wait_for_terminal(client, job.job_id)
        assert snapshot.state == "COMPLETED"
        assert snapshot.audio_sha256 == hashlib.sha256(wav.read_bytes()).hexdigest()

        result = client.get_result(job.job_id)
        assert isinstance(result, MossJobResult)
        assert result.job_id == job.job_id
        assert result.model_manifest_sha256 == "manifest"
        assert result.segments[0].text == "你好"
        assert result.segments[0].global_speaker == "GS01"
    finally:
        _stop_server(server, thread)
    assert not socket_path.exists()


def test_cancel_running_job_through_client(tmp_path):
    _af_unix_required()
    wav = _write_wav(tmp_path)
    entered, release = threading.Event(), threading.Event()

    class BlockingChild(InstantChild):
        def infer(self, wav, window_id, window, on_state, cancelled, grace):
            entered.set()
            assert release.wait(5)
            return super().infer(wav, window_id, window, on_state, cancelled, grace)

    socket_path = tmp_path / "moss.sock"
    server, thread = _start_server(socket_path, _supervisor(tmp_path, BlockingChild(wav)))
    try:
        client = MossWorkerClient(socket_path, timeout=2.0)
        job = client.submit_job(str(wav))
        assert entered.wait(5)

        snapshot = client.cancel_job(job.job_id)
        assert snapshot.error == "MOSS_CANCEL_REQUESTED"

        release.set()
        final = _wait_for_terminal(client, job.job_id)
        assert final.state == "CANCELLED"
        assert client.get_result(job.job_id) is None
    finally:
        release.set()
        _stop_server(server, thread)


def test_submit_missing_audio_returns_typed_error(tmp_path):
    _af_unix_required()
    socket_path = tmp_path / "moss.sock"
    server, thread = _start_server(
        socket_path, _supervisor(tmp_path, InstantChild(tmp_path / "unused.wav"))
    )
    try:
        client = MossWorkerClient(socket_path, timeout=1.0)
        with pytest.raises(AIError) as exc_info:
            client.submit_job(str(tmp_path / "missing.wav"))
        assert exc_info.value.code == "AI_ERROR"
    finally:
        _stop_server(server, thread)


def test_submit_declared_hash_mismatch_is_rejected_through_wire(tmp_path):
    _af_unix_required()
    wav = _write_wav(tmp_path)
    socket_path = tmp_path / "moss.sock"
    server, thread = _start_server(socket_path, _supervisor(tmp_path, InstantChild(wav)))
    try:
        client = MossWorkerClient(socket_path, timeout=1.0)
        with pytest.raises(MossAudioChangedError) as exc_info:
            client.submit_job(str(wav), audio_sha256="0" * 64)
        assert exc_info.value.code == "MOSS_AUDIO_CHANGED"
    finally:
        _stop_server(server, thread)


def test_client_missing_socket_maps_to_backend_unavailable(tmp_path):
    _af_unix_required()
    client = MossWorkerClient(tmp_path / "missing.sock", timeout=0.2)
    with pytest.raises(BackendUnavailableError):
        client.health()


def test_client_timeout_maps_to_worker_timeout(tmp_path):
    _af_unix_required()
    socket_path = tmp_path / "moss.sock"
    entered, release = threading.Event(), threading.Event()

    class BlockingSupervisor(FakeSupervisor):
        def get_job(self, job_id):
            entered.set()
            assert release.wait(5)
            return self.job

    server, thread = _start_server(socket_path, BlockingSupervisor(job=_snapshot()))
    try:
        client = MossWorkerClient(socket_path, timeout=0.2)
        with pytest.raises(WorkerTimeoutError):
            client.get_job("job-1")
        assert entered.wait(2)
    finally:
        release.set()
        _stop_server(server, thread)


def test_second_server_cannot_unlink_active_listener(tmp_path):
    _af_unix_required()
    socket_path = tmp_path / "moss.sock"
    first, thread = _start_server(socket_path, FakeSupervisor(job=_snapshot()))
    try:
        second = MossWorkerServer(socket_path, FakeSupervisor(job=_snapshot()))
        with pytest.raises(ResourceBusyError, match="active"):
            second.bind()

        assert socket_path.exists()
        assert MossWorkerClient(socket_path, timeout=1.0).health()["status"] == "ok"
    finally:
        _stop_server(first, thread)


def test_stale_unix_socket_is_replaced_only_after_listener_is_gone(tmp_path):
    _af_unix_required()
    socket_path = tmp_path / "moss.sock"
    stale = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    stale.bind(os.fspath(socket_path))
    stale.close()
    assert socket_path.exists()

    server, thread = _start_server(socket_path, FakeSupervisor(job=_snapshot()))
    try:
        assert MossWorkerClient(socket_path, timeout=1.0).health()["status"] == "ok"
    finally:
        _stop_server(server, thread)
    assert not socket_path.exists()


def test_non_socket_path_is_never_deleted_as_stale_socket(tmp_path):
    _af_unix_required()
    socket_path = tmp_path / "moss.sock"
    socket_path.write_text("do not delete", encoding="utf-8")

    server = MossWorkerServer(socket_path, FakeSupervisor(job=_snapshot()))
    with pytest.raises(ResourceBusyError, match="not a Unix socket"):
        server.bind()

    assert socket_path.read_text(encoding="utf-8") == "do not delete"
