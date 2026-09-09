"""Task 16: MOSS transcription business API contract.

Mirrors ``tests/test_asr_api.py``: a bare FastAPI app with the router under
``/api/v1``, real error handlers, and a fake/injected coordinator. The
disabled state uses the real coordinator with ``MOSS_ENABLED=0`` semantics.
"""
from __future__ import annotations

import hashlib
from pathlib import Path

from fastapi import FastAPI
from fastapi.testclient import TestClient

from app.api.errors import install_error_handlers
from app.api.moss_transcription import router as moss_router
from app.database.session import init_database, make_engine, make_session_factory
from app.domain.errors import DomainError
from app.repositories import cases as case_repo
from app.services.moss_transcription_coordinator import MossTranscriptionCoordinator

from test_moss_transcription_coordinator import FakeTranscriptionService


def _app(tmp_path: Path, *, coordinator=None):
    engine = make_engine(f"sqlite:///{tmp_path / 'api.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    if coordinator is None:
        coordinator = MossTranscriptionCoordinator(
            session_factory=factory, transcription_service=None, enabled=False
        )
    app = FastAPI()
    app.state.session_factory = factory
    app.state.moss_coordinator = coordinator
    install_error_handlers(app)
    app.include_router(moss_router, prefix="/api/v1")
    return app, engine, factory


def _seed_case(factory) -> None:
    with factory() as db:
        case_repo.create(db, {"id": "CASE-MOSS", "suspectName": "张某", "officerName": "李警官"})
        db.commit()


def _audio(tmp_path: Path) -> Path:
    path = tmp_path / "recording.wav"
    path.write_bytes(b"RIFF-fake-wav-audio")
    return path


def _enabled_app(tmp_path: Path):
    app_engine = make_engine(f"sqlite:///{tmp_path / 'api-enabled.db'}")
    init_database(app_engine)
    factory = make_session_factory(app_engine)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = MossTranscriptionCoordinator(
        session_factory=factory, transcription_service=fake, enabled=True
    )
    app = FastAPI()
    app.state.session_factory = factory
    app.state.moss_coordinator = coordinator
    install_error_handlers(app)
    app.include_router(moss_router, prefix="/api/v1")
    return app, app_engine, factory, fake


def test_canonical_moss_routes_are_registered(tmp_path):
    app, engine, _factory = _app(tmp_path)
    paths = set(app.openapi()["paths"])
    expected = {
        "/api/v1/cases/{case_id}/moss-transcription",
        "/api/v1/cases/{case_id}/moss-transcription/transcript",
        "/api/v1/cases/{case_id}/moss-transcription/resubmit",
        "/api/v1/cases/{case_id}/moss-speaker-mapping",
    }
    assert expected <= paths
    engine.dispose()


def test_disabled_endpoints_answer_503_moss_disabled(tmp_path):
    app, engine, factory = _app(tmp_path)
    _seed_case(factory)
    wav = _audio(tmp_path)
    with TestClient(app) as client:
        for method, url, json_body in (
            ("post", "/api/v1/cases/CASE-MOSS/moss-transcription", {"audioPath": str(wav)}),
            ("get", "/api/v1/cases/CASE-MOSS/moss-transcription", None),
            ("get", "/api/v1/cases/CASE-MOSS/moss-transcription/transcript", None),
            ("post", "/api/v1/cases/CASE-MOSS/moss-transcription/resubmit", {"audioPath": str(wav)}),
            ("get", "/api/v1/cases/CASE-MOSS/moss-speaker-mapping", None),
            ("put", "/api/v1/cases/CASE-MOSS/moss-speaker-mapping", {"mappings": []}),
        ):
            kwargs = {"json": json_body} if json_body is not None else {}
            response = getattr(client, method)(url, **kwargs)
            assert response.status_code == 503, (method, url)
            payload = response.json()
            assert payload["ok"] is False
            assert payload["code"] == "MOSS_DISABLED"
    engine.dispose()


def test_submit_status_transcript_and_mapping_contract(tmp_path):
    app, engine, factory, fake = _enabled_app(tmp_path)
    wav = _audio(tmp_path)
    sha = hashlib.sha256(wav.read_bytes()).hexdigest()
    with TestClient(app) as client:
        submitted = client.post(
            "/api/v1/cases/CASE-MOSS/moss-transcription",
            json={"audioPath": str(wav)},
        )
        assert submitted.status_code == 200
        assert submitted.json()["ok"] is True
        assert submitted.json()["data"]["jobId"] == "job-1"
        assert submitted.json()["data"]["state"] == "QUEUED"
        assert submitted.json()["data"]["audioSha256"] == sha
        assert fake.submit_calls == [(str(wav.resolve()), sha)]

        status = client.get("/api/v1/cases/CASE-MOSS/moss-transcription")
        assert status.status_code == 200
        assert status.json()["data"]["state"] == "QUEUED"
        assert status.json()["data"]["windows"] == []

        mapping = client.put(
            "/api/v1/cases/CASE-MOSS/moss-speaker-mapping",
            json={"mappings": [{"globalSpeaker": "GS01", "role": "民警"}, {"globalSpeaker": "GS02", "role": "嫌疑人"}]},
        )
        assert mapping.status_code == 200
        assert mapping.json()["data"] == [
            {"globalSpeaker": "GS01", "role": "民警"},
            {"globalSpeaker": "GS02", "role": "嫌疑人"},
        ]

        # Drive the job to COMPLETED through the same coordinator the API uses.
        from app.ai.moss.types import MossJobResult, MossJobSnapshot, MossTranscriptSegment, MossWindowStatus
        fake.snapshots["job-1"] = MossJobSnapshot(
            job_id="job-1", state="COMPLETED", audio_sha256=sha,
            model_manifest_sha256="manifest", progress=1.0, error=None,
            windows=(MossWindowStatus(
                window_id="w0001", start_ms=0, end_ms=60_000, window_minutes=10,
                state="DONE", parse_status="VALID", error=None, token_count=16,
                normal_termination=True, segment_count=1,
            ),),
        )
        fake.results["job-1"] = MossJobResult(
            job_id="job-1", audio_sha256=sha, model_manifest_sha256="manifest",
            segments=(MossTranscriptSegment.from_dict({
                "segment_id": "s1", "window_id": "w0001", "start_ms": 0, "end_ms": 12_000,
                "local_speaker": "S01", "global_speaker": "GS01", "text": "你好",
                "speaker_mapping_confidence": 0.91, "parse_status": "VALID",
                "merge_status": "PRIMARY", "alternate": None,
                "model_manifest_sha256": "manifest",
            }),),
        )
        assert app.state.moss_coordinator.poll_once() == 1

        transcript = client.get("/api/v1/cases/CASE-MOSS/moss-transcription/transcript")
        assert transcript.status_code == 200
        data = transcript.json()["data"]
        assert data["revisionNo"] == 1
        segment = data["segments"][0]
        assert segment["gs"] == "GS01"
        assert segment["role"] == "民警"
        assert segment["text"] == "你好"

        status = client.get("/api/v1/cases/CASE-MOSS/moss-transcription")
        assert status.json()["data"]["windows"] == [
            {"windowId": "w0001", "state": "DONE", "segmentCount": 1, "startMs": 0, "endMs": 60_000}
        ]
    engine.dispose()


def test_resubmit_hash_mismatch_maps_to_409_contract(tmp_path):
    app, engine, factory, fake = _enabled_app(tmp_path)
    wav = _audio(tmp_path)
    with TestClient(app) as client:
        first = client.post(
            "/api/v1/cases/CASE-MOSS/moss-transcription", json={"audioPath": str(wav)}
        )
        assert first.status_code == 200
        coordinator = app.state.moss_coordinator
        from app.ai.moss.types import MossJobSnapshot
        failed = fake.snapshots["job-1"]
        fake.snapshots["job-1"] = MossJobSnapshot(
            job_id="job-1", state="FAILED", audio_sha256=failed.audio_sha256,
            model_manifest_sha256="manifest", progress=0.0, error="MOSS_OOM", windows=(),
        )
        coordinator.poll_once()

        tampered = tmp_path / "tampered.wav"
        tampered.write_bytes(b"RIFF-different-audio")
        response = client.post(
            "/api/v1/cases/CASE-MOSS/moss-transcription/resubmit",
            json={"audioPath": str(tampered)},
        )
        assert response.status_code == 409
        payload = response.json()
        assert payload["ok"] is False
        assert payload["code"] == "MOSS_AUDIO_HASH_MISMATCH"
        assert len(fake.submit_calls) == 1
    engine.dispose()


def test_unknown_case_maps_to_404_case_not_found(tmp_path):
    app, engine, factory, _fake = _enabled_app(tmp_path)
    wav = _audio(tmp_path)
    with TestClient(app) as client:
        response = client.post(
            "/api/v1/cases/CASE-MISSING/moss-transcription", json={"audioPath": str(wav)}
        )
        assert response.status_code == 404
        assert response.json()["code"] == "CASE_NOT_FOUND"
    engine.dispose()


def test_worker_unavailable_maps_to_503_contract(tmp_path):
    app, engine, factory, fake = _enabled_app(tmp_path)
    wav = _audio(tmp_path)
    with TestClient(app) as client:
        from app.ai.errors import BackendUnavailableError
        fake.errors["submit_job"] = BackendUnavailableError("moss worker socket is unavailable")
        response = client.post(
            "/api/v1/cases/CASE-MOSS/moss-transcription", json={"audioPath": str(wav)}
        )
        assert response.status_code == 503
        assert response.json()["code"] == "BACKEND_UNAVAILABLE"
    engine.dispose()


# --------------------------------------------------------------------------
# create_app wiring: default MOSS_ENABLED=0 keeps the endpoints degraded
# --------------------------------------------------------------------------


class _FakeManager:
    device_monitor = None

    def open_all(self, strict: bool = False):
        pass

    def start_monitor(self):
        pass

    def stop_monitor(self):
        pass

    def close_all(self):
        pass


class _FakeSupervisor:
    speaker_accept_threshold = 0.70
    speaker_margin = 0.10

    def health(self):
        return {"speech": {"state": "READY", "backend": "test"}}

    def capabilities(self):
        return {}

    def shutdown(self):
        pass


class _FakeGateway:
    def status(self):
        return {}


def test_create_app_wires_moss_coordinator_disabled_by_default(tmp_path, monkeypatch):
    monkeypatch.delenv("MOSS_ENABLED", raising=False)
    from app.main import create_app

    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'main-moss.db'}",
        hardware_gateway=_FakeGateway(),
        hardware_manager=_FakeManager(),
        ai_supervisor=_FakeSupervisor(),
    )
    paths = set(app.openapi()["paths"])
    assert "/api/v1/cases/{case_id}/moss-transcription" in paths
    assert "/api/v1/cases/{case_id}/moss-speaker-mapping" in paths

    coordinator = app.state.moss_coordinator
    assert coordinator is not None
    assert coordinator.enabled is False

    with app.state.session_factory() as db:
        case_repo.create(db, {"id": "CASE-MOSS", "suspectName": "张某", "officerName": "李警官"})
        db.commit()

    with TestClient(app) as client:
        response = client.post(
            "/api/v1/cases/CASE-MOSS/moss-transcription",
            json={"audioPath": "whatever.wav"},
        )
        assert response.status_code == 503
        assert response.json()["code"] == "MOSS_DISABLED"
        # The disabled poller never runs with the app lifecycle.
        assert coordinator.running is False
