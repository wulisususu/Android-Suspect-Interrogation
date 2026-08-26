from fastapi.testclient import TestClient

from app.hardware_gateway.mock import MockHardwareGateway
from app.main import create_app


def unwrap(response):
    body = response.json()
    assert response.status_code < 400, body
    assert body["ok"] is True, body
    return body["data"]


def test_required_flow_survives_backend_restart(tmp_path):
    db_file = tmp_path / "restart.db"
    url = f"sqlite:///{db_file}"

    first_app = create_app(database_url=url, hardware_gateway=MockHardwareGateway(simulated=True))
    with TestClient(first_app) as client:
        case = unwrap(client.post("/api/v1/cases", json={"operator_id": "officer-1", "suspectName": "重启测试对象"}))
        case_id = case["id"]
        unwrap(client.post("/api/v1/identity/read", json={"case_id": case_id, "actor_id": "officer-1"}))
        unwrap(client.post(f"/api/v1/cases/{case_id}/session/start", json={}))
        message = unwrap(client.post(f"/api/v1/cases/{case_id}/messages", json={"text": "原始回答", "speaker": "嫌疑人"}))
        message_id = message["id"]
        unwrap(client.put(f"/api/v1/cases/{case_id}/messages/{message_id}", json={"text": "修订后的回答", "reason": "核对录音", "actor_id": "officer-1"}))
        unwrap(client.post(f"/api/v1/cases/{case_id}/messages/{message_id}/mark", json={"mark": "highlight"}))
        unwrap(client.post(f"/api/v1/cases/{case_id}/session/pause", json={}))
        unwrap(client.post(f"/api/v1/cases/{case_id}/session/resume", json={}))
        unwrap(client.post(f"/api/v1/cases/{case_id}/session/finish", json={}))
        snapshot = unwrap(client.post(f"/api/v1/cases/{case_id}/document/freeze", json={"actor_id": "officer-1"}))
        assert snapshot["status"] == "FROZEN"

    first_app.state.engine.dispose()

    second_app = create_app(database_url=url, hardware_gateway=MockHardwareGateway(simulated=False))
    with TestClient(second_app) as client:
        restored_case = unwrap(client.get(f"/api/v1/cases/{case_id}"))
        assert restored_case["workflowState"] == "FROZEN"
        assert restored_case["documentStatus"] == "FROZEN"

        messages = unwrap(client.get(f"/api/v1/cases/{case_id}/messages"))
        assert len(messages) == 1
        assert messages[0]["id"] == message_id
        assert messages[0]["text"] == "修订后的回答"
        assert messages[0]["version"] == 2
        assert messages[0]["mark"] == "highlight"

        revisions = unwrap(client.get(f"/api/v1/cases/{case_id}/messages/{message_id}/revisions"))
        assert len(revisions) == 1
        assert revisions[0]["oldText"] == "原始回答"
        assert revisions[0]["newText"] == "修订后的回答"

        session = unwrap(client.get(f"/api/v1/cases/{case_id}/session"))
        assert session["status"] == "COMPLETED"
        assert session["state"] == "FROZEN"

        document = unwrap(client.get(f"/api/v1/cases/{case_id}/document/status"))
        assert document["snapshot"]["id"] == snapshot["id"]
        assert document["documentStatus"] == "FROZEN"

        audit = unwrap(client.get(f"/api/v1/cases/{case_id}/audit"))
        actions = {row["action"] for row in audit}
        assert {"QA_UPDATE", "QA_MARK", "SESSION_PAUSE", "SESSION_RESUME", "SESSION_FINISH", "DOCUMENT_FREEZE"} <= actions
