from __future__ import annotations

import inspect

from fastapi import FastAPI
from fastapi.testclient import TestClient

from app.api.asr import router as asr_router
from app.api.errors import install_error_handlers
from app.services.asr_capture_service import AsrCaptureService, _CaptureRuntime, _PreparationRuntime


class FakeCaptureService:
    def __init__(self) -> None:
        self.started: list[tuple[str, str]] = []
        self.preparation_started: list[tuple[str, str]] = []

    def start(self, case_id: str, source: str = "ALSA"):
        self.started.append((case_id, source))
        return {"caseId": case_id, "active": True, "source": source, "captureSessionId": "CAPTURE-1"}

    def start_preparation(self, case_id: str, source: str = "ALSA"):
        self.preparation_started.append((case_id, source))
        return {
            "caseId": case_id,
            "active": True,
            "mode": "QUESTION_PREP",
            "source": source,
            "captureSessionId": "PREP-1",
        }


class FakeSupervisor:
    speaker_accept_threshold = 0.70
    speaker_margin = None

    def health(self):
        return {"speech": {"state": "READY"}}

    def capabilities(self):
        return {
            "asr": {"state": "AVAILABLE"},
            "vad": {"state": "AVAILABLE"},
            "speaker": {"state": "AVAILABLE"},
        }


def make_app() -> tuple[FastAPI, FakeCaptureService]:
    app = FastAPI()
    capture = FakeCaptureService()
    app.state.asr_capture_service = capture
    app.state.ai_supervisor = FakeSupervisor()
    install_error_handlers(app)
    app.include_router(asr_router, prefix="/api/v1")
    return app, capture


def test_remote_browser_capture_auto_routes_to_browser_audio() -> None:
    app, capture = make_app()
    with TestClient(app) as client:
        response = client.post(
            "/api/v1/cases/CASE-REMOTE/asr/capture/start",
            headers={
                "Sec-CH-UA-Platform": '"Windows"',
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
            },
        )
    assert response.status_code == 200
    assert response.json()["source"] == "BROWSER"
    assert capture.started == [("CASE-REMOTE", "BROWSER")]


def test_explicit_capture_source_overrides_request_topology() -> None:
    app, capture = make_app()
    with TestClient(app) as client:
        response = client.post(
            "/api/v1/cases/CASE-OVERRIDE/asr/capture/start",
            json={"source": "ALSA"},
            headers={"Sec-CH-UA-Platform": '"Windows"'},
        )
    assert response.status_code == 200
    assert response.json()["source"] == "ALSA"
    assert capture.started == [("CASE-OVERRIDE", "ALSA")]


def test_question_preparation_uses_same_remote_browser_routing() -> None:
    app, capture = make_app()
    with TestClient(app) as client:
        response = client.post(
            "/api/v1/cases/CASE-PREP/asr/question-preparation/start",
            headers={"Sec-CH-UA-Platform": '"Windows"'},
        )
    assert response.status_code == 200
    assert response.json()["source"] == "BROWSER"
    assert capture.preparation_started == [("CASE-PREP", "BROWSER")]


def test_asr_capture_service_binds_audio_source_per_runtime() -> None:
    init_parameters = inspect.signature(AsrCaptureService.__init__).parameters
    start_parameters = inspect.signature(AsrCaptureService.start).parameters
    preparation_parameters = inspect.signature(AsrCaptureService.start_preparation).parameters

    assert "browser_audio_input" in init_parameters
    assert "source" in start_parameters
    assert "source" in preparation_parameters
    assert {"source", "audio_input"}.issubset(_CaptureRuntime.__dataclass_fields__)
    assert {"source", "audio_input"}.issubset(_PreparationRuntime.__dataclass_fields__)
