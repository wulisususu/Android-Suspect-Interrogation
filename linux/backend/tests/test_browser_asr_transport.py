from fastapi import FastAPI
from fastapi.testclient import TestClient
import pytest
from starlette.websockets import WebSocketDisconnect

from app.services.browser_audio_input import BrowserAudioInput
from app.websocket.browser_asr import router


class FakeAsrCaptureService:
    def __init__(self, status_by_case: dict[str, dict[str, object]]):
        self.status_by_case = status_by_case

    def status(self, case_id: str) -> dict[str, object]:
        return dict(self.status_by_case.get(case_id, {"active": False}))


def make_app(status_by_case: dict[str, dict[str, object]]) -> tuple[FastAPI, BrowserAudioInput]:
    app = FastAPI()
    browser_input = BrowserAudioInput()
    browser_input.start_record()
    app.state.browser_audio_input = browser_input
    app.state.asr_capture_service = FakeAsrCaptureService(status_by_case)
    app.include_router(router)
    return app, browser_input


def test_browser_asr_socket_accepts_only_the_active_browser_capture():
    app, browser_input = make_app({
        "CASE-A": {
            "active": True,
            "captureSessionId": "CAPTURE-A",
            "source": "BROWSER",
        },
    })

    with TestClient(app) as client:
        with client.websocket_connect("/ws/asr/cases/CASE-A/capture/CAPTURE-A") as websocket:
            websocket.send_bytes(b"\x01\x00" * 160)

    assert browser_input.read_audio_frames(timeout=0.01) == b"\x01\x00" * 160


@pytest.mark.parametrize(
    "case_id,capture_id,status_by_case",
    [
        ("CASE-B", "CAPTURE-A", {"CASE-A": {"active": True, "captureSessionId": "CAPTURE-A", "source": "BROWSER"}}),
        ("CASE-A", "CAPTURE-B", {"CASE-A": {"active": True, "captureSessionId": "CAPTURE-A", "source": "BROWSER"}}),
        ("CASE-A", "CAPTURE-A", {"CASE-A": {"active": True, "captureSessionId": "CAPTURE-A", "source": "ALSA"}}),
        ("CASE-A", "CAPTURE-A", {"CASE-A": {"active": False, "captureSessionId": "CAPTURE-A", "source": "BROWSER"}}),
    ],
)
def test_browser_asr_socket_rejects_any_connection_not_bound_to_active_browser_capture(
    case_id: str,
    capture_id: str,
    status_by_case: dict[str, dict[str, object]],
):
    app, browser_input = make_app(status_by_case)

    with TestClient(app) as client:
        with pytest.raises(WebSocketDisconnect) as close:
            with client.websocket_connect(f"/ws/asr/cases/{case_id}/capture/{capture_id}"):
                pass

    assert close.value.code == 4409
    assert browser_input.read_audio_frames(timeout=0.01) == b""


def test_browser_asr_socket_rechecks_capture_before_accepting_each_pcm_frame():
    status_by_case = {
        "CASE-A": {
            "active": True,
            "captureSessionId": "CAPTURE-A",
            "source": "BROWSER",
        },
    }
    app, browser_input = make_app(status_by_case)

    with TestClient(app) as client:
        with client.websocket_connect("/ws/asr/cases/CASE-A/capture/CAPTURE-A") as websocket:
            status_by_case["CASE-A"] = {
                "active": True,
                "captureSessionId": "CAPTURE-B",
                "source": "BROWSER",
            }
            websocket.send_bytes(b"\x01\x00" * 160)
            close = websocket.receive()

    assert close["type"] == "websocket.close"
    assert close["code"] == 4409
    assert browser_input.read_audio_frames(timeout=0.01) == b""
