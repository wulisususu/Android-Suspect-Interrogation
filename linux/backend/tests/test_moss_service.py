from __future__ import annotations

import hashlib
import json
import wave
from pathlib import Path

import pytest

from app.ai.errors import AIError, BackendUnavailableError, ModelNotInstalledError
from app.ai.moss.types import (
    MossAudioChangedError,
    MossAudioCorruptError,
    MossJobResult,
    MossJobSnapshot,
    MossTranscriptSegment,
)
from app.ai.registry import ModelRegistry
from app.ai.settings import AISettings
from app.services.moss_transcription import (
    MossJobTerminalError,
    MossResultMissingError,
    MossResultNotReadyError,
    MossTranscriptionService,
)


# --------------------------------------------------------------------------
# Shared helpers and fakes (no AF_UNIX: client interaction is faked exactly
# like the Task 12 layered tests, minus the socket transport)
# --------------------------------------------------------------------------


def _write_wav(tmp_path: Path, seconds: int = 1) -> Path:
    path = tmp_path / "audio.wav"
    with wave.open(str(path), "wb") as stream:
        stream.setparams((1, 2, 16000, 0, "NONE", "not compressed"))
        for _ in range(seconds):
            stream.writeframes(b"\0" * 32000)
    return path


def _snapshot(state: str = "QUEUED", error: str | None = None) -> MossJobSnapshot:
    return MossJobSnapshot(
        job_id="job-1",
        state=state,
        audio_sha256="audio-sha",
        model_manifest_sha256="manifest",
        progress=0.0,
        error=error,
        windows=(),
    )


def _segment(**overrides) -> MossTranscriptSegment:
    payload = {
        "segment_id": "s1",
        "window_id": "w0001",
        "start_ms": 0,
        "end_ms": 12000,
        "local_speaker": "S01",
        "global_speaker": "GS01",
        "text": "你好",
        "speaker_mapping_confidence": 0.91,
        "parse_status": "VALID",
        "merge_status": "PRIMARY",
        "alternate": None,
        "model_manifest_sha256": "manifest",
    }
    payload.update(overrides)
    return MossTranscriptSegment.from_dict(payload)


def _result() -> MossJobResult:
    return MossJobResult(
        job_id="job-1",
        audio_sha256="audio-sha",
        model_manifest_sha256="manifest",
        segments=(_segment(),),
    )


class FakeClient:
    """Client stand-in that records which timeout instance received each op."""

    def __init__(self, socket_path, *, timeout):
        self.socket_path = socket_path
        self.timeout = timeout
        self.submit_calls: list[tuple[str, str]] = []
        self.job_calls: list[str] = []
        self.result_calls: list[str] = []
        self.cancel_calls: list[str] = []
        self.health_calls = 0
        self.snapshot = _snapshot()
        self.result: MossJobResult | None = None
        self.health_payload: dict = {
            "status": "ok",
            "manifest_sha256": "manifest",
            "runtime_versions": {"rknn": "2.3.2"},
            "run_failures": {},
            "scheduler_error": None,
        }
        self.errors: dict[str, Exception] = {}

    def fail(self, op: str, exc: Exception) -> None:
        self.errors[op] = exc

    def _maybe_fail(self, op: str) -> None:
        exc = self.errors.get(op)
        if exc is not None:
            raise exc

    def submit_job(self, audio_path, audio_sha256=None):
        self._maybe_fail("submit_job")
        self.submit_calls.append((str(audio_path), str(audio_sha256)))
        return self.snapshot

    def get_job(self, job_id):
        self._maybe_fail("get_job")
        self.job_calls.append(str(job_id))
        return self.snapshot

    def get_result(self, job_id):
        self._maybe_fail("get_result")
        self.result_calls.append(str(job_id))
        return self.result

    def cancel_job(self, job_id):
        self._maybe_fail("cancel_job")
        self.cancel_calls.append(str(job_id))
        return self.snapshot

    def health(self):
        self._maybe_fail("health")
        self.health_calls += 1
        return dict(self.health_payload)


def _make_service(**kwargs) -> tuple[MossTranscriptionService, list[FakeClient]]:
    created: list[FakeClient] = []

    def create(socket_path, *, timeout):
        client = FakeClient(socket_path, timeout=timeout)
        created.append(client)
        return client

    options = dict(
        socket_path="unused.sock",
        request_timeout=2.5,
        submit_timeout=900.0,
        client_factory=create,
    )
    options.update(kwargs)
    return MossTranscriptionService(**options), created


def _registry(tmp_path: Path, *, installed: bool) -> ModelRegistry:
    config = tmp_path / "registry.yaml"
    config.write_text(
        json.dumps(
            {
                "models": {
                    "moss.default": {
                        "kind": "moss",
                        "backend": "moss-worker",
                        "path": "moss-rk3588",
                        "architecture": "moss",
                        "required_files": ["manifest.json"],
                        "device": "npu",
                        "context": 16384,
                        "memory_mb": 1,
                        "capabilities": ["transcription"],
                    }
                }
            }
        ),
        encoding="utf-8",
    )
    model_root = tmp_path / "models"
    if installed:
        target = model_root / "moss-rk3588" / "manifest.json"
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text("{}", encoding="utf-8")
    return ModelRegistry.load(config, model_root)


# --------------------------------------------------------------------------
# Contract 1: submit_job rides an independent long-timeout client
# --------------------------------------------------------------------------


def test_service_builds_two_clients_with_independent_timeouts():
    service, created = _make_service()

    assert len(created) == 2
    short, long = created
    assert short is not long
    assert short.timeout == 2.5
    assert long.timeout == 900.0
    assert service.request_timeout == 2.5
    assert service.submit_timeout == 900.0


def test_submit_job_rides_the_dedicated_long_timeout_client(tmp_path):
    wav = _write_wav(tmp_path)
    service, created = _make_service()
    short, long = created

    service.submit_job(wav, "a" * 64)

    assert len(long.submit_calls) == 1
    assert short.submit_calls == []


def test_get_job_cancel_and_result_ride_the_short_rpc_client():
    service, created = _make_service()
    short, long = created
    short.snapshot = _snapshot(state="COMPLETED")
    short.result = _result()

    service.get_job("job-1")
    service.cancel_job("job-1")
    service.get_result("job-1")

    # get_result probes get_job first to disambiguate the three None states,
    # so the short client sees the explicit poll plus the internal probe.
    assert short.job_calls == ["job-1", "job-1"]
    assert short.cancel_calls == ["job-1"]
    assert short.result_calls == ["job-1"]
    assert long.job_calls == []
    assert long.result_calls == []
    assert long.cancel_calls == []


def test_submit_timeout_must_exceed_the_short_rpc_budget():
    created_clients: list[FakeClient] = []

    def factory(socket_path, *, timeout):
        client = FakeClient(socket_path, timeout=timeout)
        created_clients.append(client)
        return client

    with pytest.raises(ValueError):
        MossTranscriptionService(
            socket_path="unused.sock",
            request_timeout=5.0,
            submit_timeout=5.0,
            client_factory=factory,
        )
    assert created_clients == []


# --------------------------------------------------------------------------
# submit_job: path/hash resolution and fail-closed guards
# --------------------------------------------------------------------------


def test_submit_declares_the_saved_source_hash_for_pre_submit_verification(tmp_path):
    wav = _write_wav(tmp_path)
    service, created = _make_service()

    service.submit_job(wav, hashlib.sha256(wav.read_bytes()).hexdigest().upper())

    path, sha = created[1].submit_calls[0]
    assert path == str(wav.expanduser().resolve())
    assert sha == hashlib.sha256(wav.read_bytes()).hexdigest()


def test_submit_computes_the_source_hash_when_not_declared(tmp_path):
    wav = _write_wav(tmp_path)
    service, created = _make_service()

    service.submit_job(wav)

    assert created[1].submit_calls[0][1] == hashlib.sha256(wav.read_bytes()).hexdigest()


def test_submit_missing_audio_fails_fast_without_worker_round_trip(tmp_path):
    service, created = _make_service()

    with pytest.raises(AIError) as exc_info:
        service.submit_job(tmp_path / "missing.wav")

    assert created[1].submit_calls == []
    assert exc_info.value.details.get("audio_path")


def test_submit_with_model_not_installed_fails_closed_before_rpc(tmp_path):
    wav = _write_wav(tmp_path)
    service, created = _make_service(registry=_registry(tmp_path, installed=False))

    with pytest.raises(ModelNotInstalledError) as exc_info:
        service.submit_job(wav)

    assert created[1].submit_calls == []
    assert exc_info.value.details["model_id"] == "moss.default"
    assert exc_info.value.details["missing_files"]


# --------------------------------------------------------------------------
# submit_job: service-side error-code mapping (Task 12 review memo)
# --------------------------------------------------------------------------


def test_submit_maps_unmapped_moss_audio_empty_to_audio_corrupt(tmp_path):
    wav = _write_wav(tmp_path)
    service, created = _make_service()
    created[1].fail("submit_job", AIError("MOSS_AUDIO_EMPTY"))

    with pytest.raises(MossAudioCorruptError) as exc_info:
        service.submit_job(wav)

    assert exc_info.value.code == "MOSS_AUDIO_CORRUPT"
    assert exc_info.value.details.get("moss_code") == "MOSS_AUDIO_EMPTY"


def test_submit_passes_typed_worker_errors_through_unchanged(tmp_path):
    wav = _write_wav(tmp_path)
    service, created = _make_service()
    changed = MossAudioChangedError("submitted audio does not match the declared SHA256")
    created[1].fail("submit_job", changed)

    with pytest.raises(MossAudioChangedError) as exc_info:
        service.submit_job(wav)

    assert exc_info.value is changed


def test_submit_passes_unmapped_non_moss_errors_through(tmp_path):
    wav = _write_wav(tmp_path)
    service, created = _make_service()
    created[1].fail("submit_job", AIError("audio file is unavailable"))

    with pytest.raises(AIError) as exc_info:
        service.submit_job(wav)

    assert type(exc_info.value) is AIError


# --------------------------------------------------------------------------
# Contract 2: get_result three-state semantics
# --------------------------------------------------------------------------


def test_get_result_returns_typed_transcript_with_opaque_anonymous_speakers():
    service, created = _make_service()
    short, _long = created
    short.snapshot = _snapshot(state="COMPLETED")
    short.result = _result()

    transcript = service.get_result("job-1")

    assert isinstance(transcript, MossJobResult)
    segment = transcript.segments[0]
    # GSxx stays the worker's anonymous global label, verbatim: the service
    # never performs person identification or binds GSxx to a named person.
    assert segment.global_speaker == "GS01"
    assert segment.local_speaker == "S01"
    assert segment.model_manifest_sha256 == "manifest"
    assert segment.text == "你好"


def test_get_result_for_running_job_is_result_not_ready_without_result_rpc():
    service, created = _make_service()
    short, _long = created
    short.snapshot = _snapshot(state="DECODING")

    with pytest.raises(MossResultNotReadyError) as exc_info:
        service.get_result("job-1")

    # 409-class outcome: a typed retry-later condition, not an error stack.
    assert exc_info.value.code == "MOSS_RESULT_NOT_READY"
    assert exc_info.value.details["job_id"] == "job-1"
    assert exc_info.value.details["state"] == "DECODING"
    assert short.result_calls == []


@pytest.mark.parametrize(
    "state",
    ["QUEUED", "PREPARING", "ENCODING", "BUILDING_EMBEDS", "PARSING", "REMAPPING", "MERGING"],
)
def test_get_result_treats_every_working_state_as_not_ready(state):
    service, created = _make_service()
    created[0].snapshot = _snapshot(state=state)

    with pytest.raises(MossResultNotReadyError):
        service.get_result("job-1")


def test_get_result_completed_but_missing_result_is_worker_storage_inconsistency():
    service, created = _make_service()
    short, _long = created
    short.snapshot = _snapshot(state="COMPLETED")
    short.result = None

    with pytest.raises(MossResultMissingError) as exc_info:
        service.get_result("job-1")

    # Never fabricate an empty transcript out of a COMPLETED job.
    assert exc_info.value.code == "MOSS_RESULT_MISSING"
    assert exc_info.value.details["state"] == "COMPLETED"
    assert exc_info.value.snapshot.state == "COMPLETED"


@pytest.mark.parametrize("state", ["FAILED", "CANCELLED"])
def test_get_result_passes_terminal_states_through_without_fabricating_results(state):
    service, created = _make_service()
    short, _long = created
    short.snapshot = _snapshot(state=state, error="GENERATION_LIMIT_REACHED")

    with pytest.raises(MossJobTerminalError) as exc_info:
        service.get_result("job-1")

    carried = exc_info.value.snapshot
    assert carried.state == state
    assert carried.error == "GENERATION_LIMIT_REACHED"
    assert exc_info.value.details["state"] == state


# --------------------------------------------------------------------------
# health(): worker/model/manifest/queue/active job/runtime/last error
# --------------------------------------------------------------------------


def test_health_reports_worker_model_manifest_runtime_queue_and_active_job(tmp_path):
    service, created = _make_service(registry=_registry(tmp_path, installed=True))
    short, _long = created
    short.health_payload = {
        "status": "ok",
        "manifest_sha256": "a50ce60b",
        "runtime_versions": {"rknn": "2.3.2", "rkllm": "1.3.0"},
        "queue_depth": 2,
        "active_job": "job-7",
        "run_failures": {},
        "scheduler_error": None,
    }

    snapshot = service.health()

    assert snapshot["worker"] == "AVAILABLE"
    assert snapshot["model"] == "INSTALLED"
    assert snapshot["manifest_sha256"] == "a50ce60b"
    assert snapshot["runtime_versions"] == {"rknn": "2.3.2", "rkllm": "1.3.0"}
    # Task 14: the worker health op publishes queue depth / active job now;
    # the service passes the worker-reported values through verbatim.
    assert snapshot["queue_depth"] == 2
    assert snapshot["active_job"] == "job-7"
    assert snapshot["last_error"] is None


def test_health_reports_null_queue_and_active_job_when_worker_omits_them():
    service, created = _make_service()
    short, _long = created
    assert "queue_depth" not in short.health_payload
    assert "active_job" not in short.health_payload

    snapshot = service.health()

    # Older worker builds without the Task 14 health fields stay compatible.
    assert snapshot["queue_depth"] is None
    assert snapshot["active_job"] is None


def test_health_last_error_prefers_scheduler_error_then_run_failures():
    service, created = _make_service()
    short, _long = created
    short.health_payload = dict(
        short.health_payload,
        run_failures={"job-9": "MOSS_AUDIO_CHANGED: source SHA256 mismatch"},
        scheduler_error=None,
    )
    assert "MOSS_AUDIO_CHANGED" in service.health()["last_error"]

    short.health_payload["scheduler_error"] = "RuntimeError: MOSS_CHILD_CRASHED: boom"
    assert "MOSS_CHILD_CRASHED" in service.health()["last_error"]


def test_health_survives_an_unreachable_worker():
    service, created = _make_service()
    created[0].fail("health", BackendUnavailableError("moss worker socket is unavailable"))

    snapshot = service.health()

    assert snapshot["worker"] == "UNAVAILABLE"
    assert snapshot["last_error"] == "moss worker socket is unavailable"
    assert snapshot["manifest_sha256"] is None


def test_health_model_state_reflects_registry_installation(tmp_path):
    missing, _created = _make_service(registry=_registry(tmp_path, installed=False))
    assert missing.health()["model"] == "NOT_INSTALLED"

    installed, _created = _make_service(registry=_registry(tmp_path, installed=True))
    assert installed.health()["model"] == "INSTALLED"

    unknown, _created = _make_service(registry=None)
    assert unknown.health()["model"] == "UNKNOWN"


# --------------------------------------------------------------------------
# from_settings(): env-driven wiring
# --------------------------------------------------------------------------


def test_from_settings_wires_socket_timeouts_model_id_and_registry(monkeypatch, tmp_path):
    for key in (
        "MOSS_ENABLED",
        "SUSPECT_MOSS_SOCKET",
        "MOSS_SPOOL_ROOT",
        "MOSS_MODEL_ID",
        "MOSS_REQUEST_TIMEOUT",
        "MOSS_SUBMIT_TIMEOUT",
    ):
        monkeypatch.delenv(key, raising=False)
    monkeypatch.setenv("SUSPECT_MOSS_SOCKET", "/tmp/custom/moss.sock")
    monkeypatch.setenv("MOSS_REQUEST_TIMEOUT", "3")
    monkeypatch.setenv("MOSS_SUBMIT_TIMEOUT", "7200")
    monkeypatch.setenv("MODEL_REGISTRY", str(tmp_path / "registry.yaml"))
    monkeypatch.setenv("MODEL_ROOT", str(tmp_path / "models"))
    (tmp_path / "registry.yaml").write_text(
        json.dumps(
            {
                "models": {
                    "moss.default": {
                        "kind": "moss",
                        "backend": "moss-worker",
                        "path": "moss-rk3588",
                        "architecture": "moss",
                        "required_files": ["manifest.json"],
                        "device": "npu",
                        "context": 16384,
                        "memory_mb": 1,
                        "capabilities": ["transcription"],
                    }
                }
            }
        ),
        encoding="utf-8",
    )

    service = MossTranscriptionService.from_settings(AISettings.from_env())

    assert service.socket_path.as_posix() == "/tmp/custom/moss.sock"
    assert service.request_timeout == 3.0
    assert service.submit_timeout == 7200.0
    assert service.model_id == "moss.default"
    assert service.model_state() == "NOT_INSTALLED"
