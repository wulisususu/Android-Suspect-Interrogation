from fastapi.testclient import TestClient
from starlette.websockets import WebSocketDisconnect

from app.hardware_gateway.mock import MockHardwareGateway
from app.main import create_app


class FakeCaptureService:
    def __init__(self):
        self.active = None
        self.started_sources = []
        self.pushed = []
        self.cancelled = []

    def start(self, kind: str, subject_id: str, source: str = "ALSA"):
        source = source.upper()
        self.started_sources.append(source)
        self.active = {
            "active": True,
            "kind": kind,
            "subjectId": subject_id,
            "captureId": "CAP-BROWSER-1",
            "source": source,
            "recordedDurationMs": 0,
            "usableSpeechMs": 0,
            "requiredUsableSpeechMs": 20000,
            "targetDurationMs": 20000,
            "complete": False,
            "completeReason": None,
        }
        return dict(self.active)

    def status(self):
        if self.active is None:
            return {
                "active": False,
                "captureId": None,
                "source": None,
                "recordedDurationMs": 0,
                "usableSpeechMs": 0,
                "requiredUsableSpeechMs": 20000,
                "targetDurationMs": 20000,
                "complete": False,
                "completeReason": None,
            }
        return dict(self.active)

    def push_browser_pcm(self, capture_id: str, pcm: bytes):
        assert self.active is not None
        assert capture_id == self.active["captureId"]
        self.pushed.append(bytes(pcm))
        self.active["recordedDurationMs"] += len(pcm) * 1000 // (16000 * 2)
        return dict(self.active)

    def cancel(self, capture_id: str | None = None):
        self.cancelled.append(capture_id)
        source = self.active["source"] if self.active else None
        self.active = None
        return {"cancelled": True, "captureId": capture_id, "source": source}


def payload(response):
    body = response.json()
    assert body["ok"] is True, body
    return body["data"]


def make_app(tmp_path):
    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'browser-voiceprint.db'}",
        hardware_gateway=MockHardwareGateway(simulated=False),
    )
    capture = FakeCaptureService()
    app.state.voiceprint_capture = capture
    return app, capture


def test_suspect_enrollment_start_accepts_explicit_browser_source_and_returns_capture_identity(tmp_path):
    app, capture = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = payload(client.post("/api/v1/cases", json={"operator_id": "op", "suspectName": "远程测试"}))["id"]

        started = payload(client.post(
            f"/api/v1/cases/{case_id}/voiceprints/suspect/enrollment/start",
            json={"source": "BROWSER"},
        ))

        assert capture.started_sources == ["BROWSER"]
        assert started["source"] == "BROWSER"
        assert started["captureId"] == "CAP-BROWSER-1"


def test_legacy_start_without_source_still_selects_alsa(tmp_path):
    app, capture = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = payload(client.post("/api/v1/cases", json={"operator_id": "op"}))["id"]
        started = payload(client.post(f"/api/v1/cases/{case_id}/voiceprints/suspect/enrollment/start", json={}))

    assert capture.started_sources == ["ALSA"]
    assert started["source"] == "ALSA"


def test_cancel_endpoint_releases_matching_browser_capture_without_enrollment(tmp_path):
    app, capture = make_app(tmp_path)
    capture.start("suspect", "CASE-1", source="BROWSER")
    app.state.voiceprint_enrollment_context = {
        "kind": "suspect",
        "subject_id": "CASE-1",
        "capture_id": "CAP-BROWSER-1",
        "source": "BROWSER",
    }

    with TestClient(app) as client:
        cancelled = payload(client.post(
            "/api/v1/voiceprints/enrollment/cancel",
            json={"capture_id": "CAP-BROWSER-1"},
        ))

    assert cancelled["cancelled"] is True
    assert capture.cancelled == ["CAP-BROWSER-1"]
    assert app.state.voiceprint_enrollment_context == {}


def test_binary_websocket_forwards_pcm_to_current_browser_capture(tmp_path):
    app, capture = make_app(tmp_path)
    capture.start("suspect", "CASE-1", source="BROWSER")

    with TestClient(app) as client:
        with client.websocket_connect("/ws/voiceprints/enrollment/CAP-BROWSER-1") as websocket:
            websocket.send_bytes(b"\x01\x00" * 3200)

    assert capture.pushed == [b"\x01\x00" * 3200]
    assert capture.cancelled == ["CAP-BROWSER-1"]


def test_browser_websocket_rejects_text_frames(tmp_path):
    app, capture = make_app(tmp_path)
    capture.start("suspect", "CASE-1", source="BROWSER")

    with TestClient(app) as client:
        with client.websocket_connect("/ws/voiceprints/enrollment/CAP-BROWSER-1") as websocket:
            websocket.send_text("not-pcm")
            message = websocket.receive()
            assert message["type"] == "websocket.close"
            assert message["code"] == 1003

    assert capture.pushed == []


def test_browser_websocket_rejects_odd_or_oversized_pcm(tmp_path):
    app, capture = make_app(tmp_path)
    capture.start("suspect", "CASE-1", source="BROWSER")

    with TestClient(app) as client:
        with client.websocket_connect("/ws/voiceprints/enrollment/CAP-BROWSER-1") as websocket:
            websocket.send_bytes(b"\x00")
            close = websocket.receive()
            assert close["type"] == "websocket.close"
            assert close["code"] == 1008

    capture.start("suspect", "CASE-1", source="BROWSER")
    with TestClient(app) as client:
        with client.websocket_connect("/ws/voiceprints/enrollment/CAP-BROWSER-1") as websocket:
            websocket.send_bytes(b"\x00\x00" * 40000)
            close = websocket.receive()
            assert close["type"] == "websocket.close"
            assert close["code"] == 1009

    assert capture.pushed == []
