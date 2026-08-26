from fastapi.testclient import TestClient

from app.hardware_gateway.mock import MockHardwareGateway
from app.main import create_app


def ok(response):
    body = response.json()
    assert body["ok"] is True, body
    return body["data"]


def create_running_case(client):
    case = ok(client.post("/api/v1/cases", json={"operator_id": "op-ws"}))
    ok(client.post("/api/v1/identity/read", json={"case_id": case["id"]}))
    session = ok(client.post(f"/api/v1/cases/{case['id']}/session/start", json={}))
    return case["id"], session["id"]


def test_websocket_initial_sync_ai_and_protocol_error(tmp_path):
    app = create_app(database_url=f"sqlite:///{tmp_path / 'ws.db'}", hardware_gateway=MockHardwareGateway(simulated=True))
    with TestClient(app) as client:
        case_id, session_id = create_running_case(client)
        with client.websocket_connect(f"/ws/interrogation/{session_id}") as ws:
            first = ws.receive_json()
            assert first["session_id"] == session_id
            assert first["event"] == "STATE_SYNC"
            assert first["seq"] >= 1
            assert first["timestamp"].endswith("+00:00")
            assert first["payload"]["case_id"] == case_id
            assert first["payload"]["session"]["state"] == "QUESTIONING"

            ws.send_json({"session_id": session_id, "event": "USER_TEXT", "seq": 1, "timestamp": "2026-08-26T00:00:00+00:00", "payload": {"text": "  测试   问题  "}})
            ai = ws.receive_json()
            assert ai["event"] == "AI_RESPONSE"
            assert ai["session_id"] == session_id
            assert ai["payload"]["mock"] is True
            assert "测试 问题" in ai["payload"]["text"]

            ws.send_json({"payload": {}})
            error = ws.receive_json()
            assert error["event"] == "PROTOCOL_ERROR"
            assert error["payload"]["code"] == "INVALID_WEBSOCKET_ENVELOPE"


def test_websocket_reconnect_sync_comes_from_persisted_database(tmp_path):
    app = create_app(database_url=f"sqlite:///{tmp_path / 'reconnect.db'}", hardware_gateway=MockHardwareGateway(simulated=True))
    with TestClient(app) as client:
        case_id, session_id = create_running_case(client)
        with client.websocket_connect(f"/ws/interrogation/{session_id}") as ws:
            assert ws.receive_json()["payload"]["session"]["state"] == "QUESTIONING"

        ok(client.post(f"/api/v1/cases/{case_id}/session/pause", json={}))

        with client.websocket_connect(f"/ws/interrogation/{session_id}") as ws:
            sync = ws.receive_json()
            assert sync["event"] == "STATE_SYNC"
            assert sync["payload"]["session"]["status"] == "PAUSED"
            assert sync["payload"]["session"]["state"] == "PAUSED"
            ws.send_json({"session_id": session_id, "event": "STATE_SYNC_REQUEST", "seq": 9, "timestamp": "2026-08-26T00:00:00+00:00", "payload": {}})
            requested = ws.receive_json()
            assert requested["event"] == "STATE_SYNC"
            assert requested["payload"]["session"]["state"] == "PAUSED"
