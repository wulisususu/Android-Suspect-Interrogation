from fastapi.testclient import TestClient

from app.hardware_gateway.mock import MockHardwareGateway
from app.main import create_app


def ok(response):
    body = response.json()
    assert body["ok"] is True, body
    return body["data"]


def test_websocket_can_reconnect_same_persisted_session_after_disconnect(tmp_path, enroll_test_suspect_voiceprint):
    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'reconnect-release.db'}",
        hardware_gateway=MockHardwareGateway(simulated=True),
    )

    with TestClient(app) as client:
        case = ok(client.post("/api/v1/cases", json={"operator_id": "release-reconnect"}))
        ok(client.post("/api/v1/identity/read", json={"case_id": case["id"]}))
        enroll_test_suspect_voiceprint(app, case["id"])
        session = ok(client.post(f"/api/v1/cases/{case['id']}/session/start", json={}))
        session_id = session["id"]

        with client.websocket_connect(f"/ws/interrogation/{session_id}") as first:
            initial = first.receive_json()
            assert initial["event"] == "STATE_SYNC"
            assert initial["session_id"] == session_id
            assert initial["payload"]["session"]["state"] == "QUESTIONING"

        ok(client.post(f"/api/v1/cases/{case['id']}/session/pause", json={}))

        with client.websocket_connect(f"/ws/interrogation/{session_id}") as second:
            resumed = second.receive_json()
            assert resumed["event"] == "STATE_SYNC"
            assert resumed["session_id"] == session_id
            assert resumed["payload"]["session"]["state"] == "PAUSED"
