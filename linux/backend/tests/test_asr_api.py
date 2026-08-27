from __future__ import annotations

from fastapi import FastAPI
from fastapi.testclient import TestClient

from app.api.asr import router as asr_router
from app.api.errors import install_error_handlers
from app.database.models import ASRFragment, Message
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import asr_fragments as asr_repo
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo


class FakeCaptureService:
    def __init__(self):
        self.started: list[str] = []
        self.stopped: list[str] = []
        self.shutdown_calls = 0

    def status(self, case_id: str):
        return {"caseId": case_id, "active": case_id in self.started and case_id not in self.stopped}

    def start(self, case_id: str):
        self.started.append(case_id)
        return {"caseId": case_id, "active": True, "captureSessionId": "CAPTURE-FAKE"}

    def stop(self, case_id: str):
        self.stopped.append(case_id)
        return {"caseId": case_id, "active": False, "captureSessionId": "CAPTURE-FAKE"}

    def shutdown(self):
        self.shutdown_calls += 1


class FakeSupervisor:
    speaker_accept_threshold = 0.70
    speaker_margin = 0.10

    def health(self):
        return {"speech": {"state": "READY", "backend": "in-process-mock"}}

    def capabilities(self):
        return {
            "asr": {"state": "AVAILABLE", "speech_worker": True},
            "vad": {"state": "AVAILABLE"},
            "speaker": {"state": "AVAILABLE"},
        }


def _app(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'api.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    capture = FakeCaptureService()
    supervisor = FakeSupervisor()
    app = FastAPI()
    app.state.session_factory = factory
    app.state.asr_capture_service = capture
    app.state.ai_supervisor = supervisor
    install_error_handlers(app)
    app.include_router(asr_router, prefix="/api/v1")
    return app, engine, factory, capture


def _seed_fragment(factory):
    with factory() as db:
        case = case_repo.create(db, {"id": "CASE-ASR", "suspectName": "张某", "officerName": "李警官"})
        session = session_repo.create(db, case.id)
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=session.id,
            sample_rate=16_000,
        )
        fragment = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case.id,
            ordinal=0,
            started_at_ms=0,
            ended_at_ms=1300,
            raw_text="原始识别",
            asr_confidence=0.91,
            speaker="SUSPECT",
            speaker_source="X_VECTOR",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="test-paraformer",
            model_version="v1",
        )
        second = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case.id,
            ordinal=1,
            started_at_ms=1500,
            ended_at_ms=2800,
            raw_text="第二段",
            asr_confidence=0.88,
            speaker="SUSPECT",
            speaker_source="X_VECTOR",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="test-paraformer",
        )
        db.commit()
        return case.id, session.id, capture.id, fragment.id, second.id


def test_canonical_asr_routes_are_registered(tmp_path):
    app, engine, _, _ = _app(tmp_path)
    paths = set(app.openapi()["paths"])
    expected = {
        "/api/v1/asr/status",
        "/api/v1/asr/start",
        "/api/v1/asr/stop",
        "/api/v1/cases/{case_id}/asr/capture",
        "/api/v1/cases/{case_id}/asr/capture/start",
        "/api/v1/cases/{case_id}/asr/capture/stop",
        "/api/v1/cases/{case_id}/asr/fragments",
        "/api/v1/cases/{case_id}/asr/fragments/{fragment_id}",
        "/api/v1/cases/{case_id}/asr/fragments/{fragment_id}/confirm",
        "/api/v1/cases/{case_id}/asr/fragments/confirm",
        "/api/v1/cases/{case_id}/asr/fragments/apply",
        "/api/v1/cases/{case_id}/asr/fragments/{fragment_id}/discard",
    }
    assert expected.issubset(paths)
    engine.dispose()


def test_asr_status_and_capture_routes_delegate_without_starting_global_audio(tmp_path):
    app, engine, _, capture = _app(tmp_path)
    with TestClient(app) as client:
        status = client.get("/api/v1/asr/status").json()
        assert status["state"] == "AVAILABLE"
        assert status["calibration"]["configured"] is True

        assert client.post("/api/v1/asr/start").status_code == 200
        assert capture.started == []

        started = client.post("/api/v1/cases/CASE-1/asr/capture/start")
        assert started.status_code == 200
        assert started.json()["active"] is True
        assert capture.started == ["CASE-1"]

        current = client.get("/api/v1/cases/CASE-1/asr/capture")
        assert current.json()["active"] is True

        stopped = client.post("/api/v1/cases/CASE-1/asr/capture/stop")
        assert stopped.json()["active"] is False
        assert capture.stopped == ["CASE-1"]

        assert client.post("/api/v1/asr/stop").status_code == 200
        assert capture.shutdown_calls == 1
    engine.dispose()


def test_fragment_update_is_manual_and_preserves_raw_text_then_confirm_creates_official_message(tmp_path):
    app, engine, factory, _ = _app(tmp_path)
    case_id, session_id, _, fragment_id, _ = _seed_fragment(factory)

    with TestClient(app) as client:
        listed = client.get(f"/api/v1/cases/{case_id}/asr/fragments")
        assert listed.status_code == 200
        assert listed.json()[0]["rawText"] == "原始识别"

        updated = client.put(
            f"/api/v1/cases/{case_id}/asr/fragments/{fragment_id}",
            json={"edited_text": "人工修订文本", "speaker": "INTERROGATOR"},
        )
        assert updated.status_code == 200
        payload = updated.json()
        assert payload["rawText"] == "原始识别"
        assert payload["editedText"] == "人工修订文本"
        assert payload["speaker"] == "INTERROGATOR"
        assert payload["speakerSource"] == "MANUAL"
        assert payload["voiceprintVerified"] is False

        confirmed = client.post(f"/api/v1/cases/{case_id}/asr/fragments/{fragment_id}/confirm")
        assert confirmed.status_code == 200
        assert confirmed.json()["state"] == "CONFIRMED"

    with factory() as db:
        fragment = db.get(ASRFragment, fragment_id)
        assert fragment.raw_text == "原始识别"
        assert fragment.edited_text == "人工修订文本"
        assert fragment.state == "CONFIRMED"
        message = db.get(Message, fragment.confirmed_message_id)
        assert message is not None
        assert message.session_id == session_id
        assert message.text == "人工修订文本"
        assert message.speaker == "民警"
    engine.dispose()


def test_batch_confirm_apply_and_discard_never_duplicate_official_messages(tmp_path):
    app, engine, factory, _ = _app(tmp_path)
    case_id, _, _, first_id, second_id = _seed_fragment(factory)

    with TestClient(app) as client:
        discarded = client.post(f"/api/v1/cases/{case_id}/asr/fragments/{second_id}/discard")
        assert discarded.status_code == 200
        assert discarded.json()["state"] == "DISCARDED"

        batch = client.post(
            f"/api/v1/cases/{case_id}/asr/fragments/confirm",
            json={"fragment_ids": [first_id]},
        )
        assert batch.status_code == 200
        assert batch.json()["confirmedCount"] == 1

        applied = client.post(
            f"/api/v1/cases/{case_id}/asr/fragments/apply",
            json={"fragment_ids": [first_id]},
        )
        assert applied.status_code == 200
        assert applied.json()["confirmedCount"] == 0

    with factory() as db:
        assert db.query(Message).count() == 1
        assert db.get(ASRFragment, first_id).state == "CONFIRMED"
        assert db.get(ASRFragment, second_id).state == "DISCARDED"
    engine.dispose()


def test_unknown_speaker_must_be_resolved_before_official_confirmation(tmp_path):
    app, engine, factory, _ = _app(tmp_path)
    case_id, _, _, fragment_id, _ = _seed_fragment(factory)

    with factory() as db:
        fragment = db.get(ASRFragment, fragment_id)
        fragment.speaker = "UNKNOWN"
        fragment.speaker_source = "UNASSIGNED"
        fragment.voiceprint_verified = False
        fragment.low_confidence = True
        db.commit()

    with TestClient(app) as client:
        response = client.post(f"/api/v1/cases/{case_id}/asr/fragments/{fragment_id}/confirm")
        assert response.status_code == 409
        error = response.json()
        assert error["code"] == "ASR_SPEAKER_CONFIRMATION_REQUIRED"

    with factory() as db:
        assert db.get(ASRFragment, fragment_id).state == "PENDING"
        assert db.query(Message).count() == 0
    engine.dispose()


def test_confirmation_rolls_back_official_message_if_fragment_link_fails(tmp_path, monkeypatch):
    app, engine, factory, _ = _app(tmp_path)
    case_id, _, _, fragment_id, _ = _seed_fragment(factory)

    def fail_link(*_args, **_kwargs):
        raise RuntimeError("simulated fragment-link failure")

    monkeypatch.setattr(asr_repo, "confirm_fragment", fail_link)
    with TestClient(app, raise_server_exceptions=False) as client:
        response = client.post(f"/api/v1/cases/{case_id}/asr/fragments/{fragment_id}/confirm")
        assert response.status_code == 500

    with factory() as db:
        fragment = db.get(ASRFragment, fragment_id)
        assert fragment.state == "PENDING"
        assert fragment.confirmed_message_id is None
        assert db.query(Message).count() == 0
    engine.dispose()
