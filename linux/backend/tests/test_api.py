from fastapi.testclient import TestClient

from app.hardware_gateway.mock import MockHardwareGateway
from app.main import create_app


def payload(response):
    body = response.json()
    assert body["ok"] is True, body
    assert body["code"] == "OK"
    return body["data"]


def test_canonical_api_full_case_flow(tmp_path):
    db_url = f"sqlite:///{tmp_path / 'api.db'}"
    app = create_app(database_url=db_url, hardware_gateway=MockHardwareGateway(simulated=True))
    with TestClient(app) as client:
        health = client.get("/health")
        assert health.status_code == 200
        assert payload(health)["platform"] == "linux"

        created = payload(client.post("/api/v1/cases", json={"operator_id": "op-1", "suspectName": "测试对象", "officerName": "测试警官"}))
        case_id = created["id"]
        assert created["workflowState"] == "IDENTITY_REQUIRED"

        listed = payload(client.get("/api/v1/cases"))
        assert [x["id"] for x in listed] == [case_id]

        updated = payload(client.put(f"/api/v1/cases/{case_id}", json={"age": "22"}))
        assert updated["age"] == "22"

        identity = payload(client.post("/api/v1/identity/read", json={"case_id": case_id, "actor_id": "op-1"}))
        assert identity["name"] == "联调测试对象"
        assert payload(client.get(f"/api/v1/cases/{case_id}"))["workflowState"] == "IDENTITY_READY"

        session = payload(client.post(f"/api/v1/cases/{case_id}/session/start", json={"actor_id": "op-1"}))
        assert session["status"] == "RUNNING"
        assert session["state"] == "QUESTIONING"

        message = payload(client.post(f"/api/v1/cases/{case_id}/messages", json={"text": "你叫什么名字？", "speaker": "民警", "actor_id": "op-1"}))
        message_id = message["id"]
        assert message["version"] == 1

        revised = payload(client.put(f"/api/v1/cases/{case_id}/messages/{message_id}", json={"text": "请说明你的姓名。", "reason": "联调修订", "actor_id": "op-1"}))
        assert revised["id"] == message_id
        assert revised["version"] == 2

        revisions = payload(client.get(f"/api/v1/cases/{case_id}/messages/{message_id}/revisions"))
        assert len(revisions) == 1
        assert revisions[0]["oldText"] == "你叫什么名字？"
        assert revisions[0]["newText"] == "请说明你的姓名。"

        marked = payload(client.post(f"/api/v1/cases/{case_id}/messages/{message_id}/mark", json={"mark": "conflict", "actor_id": "op-1"}))
        assert marked["id"] == message_id
        assert marked["mark"] == "conflict"
        assert len(payload(client.get(f"/api/v1/cases/{case_id}/messages"))) == 1

        facts = payload(client.get(f"/api/v1/cases/{case_id}/facts"))
        assert len(facts) >= 7
        fact = payload(client.put(f"/api/v1/cases/{case_id}/facts/time", json={"value": "20:00", "status": "confirmed", "actor_id": "op-1"}))
        assert fact["value"] == "20:00"

        timeline = payload(client.post(f"/api/v1/cases/{case_id}/timeline", json={"time": "20:00", "title": "到达", "detail": "到达现场", "evidence": ["CAM-1"], "actor_id": "op-1"}))
        assert timeline["evidence"] == ["CAM-1"]

        assert payload(client.post(f"/api/v1/cases/{case_id}/session/pause", json={}))["state"] == "PAUSED"
        assert payload(client.post(f"/api/v1/cases/{case_id}/session/resume", json={}))["state"] == "QUESTIONING"
        assert payload(client.post(f"/api/v1/cases/{case_id}/session/stage", json={"stage": "STATEMENT"}))["stage"] == "STATEMENT"
        assert payload(client.post(f"/api/v1/cases/{case_id}/session/finish", json={}))["state"] == "SUMMARY"

        frozen = payload(client.post(f"/api/v1/cases/{case_id}/document/freeze", json={"actor_id": "op-1"}))
        assert frozen["status"] == "FROZEN"
        signed = payload(client.post(f"/api/v1/cases/{case_id}/signatures", json={"signer_role": "suspect", "signer_name": "测试对象", "image_data": "data:image/png;base64,AAA", "strokes_json": "[]", "actor_id": "op-1"}))
        assert signed["status"] == "SIGNED"
        report = payload(client.post(f"/api/v1/cases/{case_id}/report/generated", json={"actor_id": "op-1"}))
        assert report["reportStatus"] == "GENERATED"
        assert report["workflowState"] == "REPORT_GENERATED"

        audit = payload(client.get(f"/api/v1/cases/{case_id}/audit"))
        update_audit = next(x for x in audit if x["action"] == "QA_UPDATE")
        assert update_audit["before"]["text"] == "你叫什么名字？"
        assert update_audit["after"]["text"] == "请说明你的姓名。"


def test_confirmed_identity_intake_allows_session_start_without_hardware_reread(tmp_path):
    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'identity-confirm.db'}",
        hardware_gateway=MockHardwareGateway(simulated=False),
    )
    with TestClient(app) as client:
        created = payload(client.post("/api/v1/cases", json={"operator_id": "op-2", "suspectName": "赵某"}))
        case_id = created["id"]

        confirmed = payload(client.post("/api/v1/identity/confirm", json={
            "case_id": case_id,
            "actor_id": "op-2",
            "name": "赵某",
            "id_number": "320101199001010011",
            "gender": "男",
            "nation": "汉",
            "birth_date": "1990-01-01",
            "address": "测试地址",
            "source": "MANUAL",
        }))
        assert confirmed["caseId"] == case_id
        assert confirmed["name"] == "赵某"
        assert confirmed["idNumber"] == "320101199001010011"
        assert confirmed["source"] == "MANUAL"

        case = payload(client.get(f"/api/v1/cases/{case_id}"))
        assert case["workflowState"] == "IDENTITY_READY"

        session = payload(client.post(f"/api/v1/cases/{case_id}/session/start", json={"actor_id": "op-2"}))
        assert session["status"] == "RUNNING"
        assert session["state"] == "QUESTIONING"


def test_canonical_api_errors_are_structured(tmp_path):
    app = create_app(database_url=f"sqlite:///{tmp_path / 'errors.db'}", hardware_gateway=MockHardwareGateway(simulated=False))
    with TestClient(app) as client:
        missing = client.get("/api/v1/cases/does-not-exist")
        assert missing.status_code == 404
        assert missing.json() == {"ok": False, "code": "CASE_NOT_FOUND", "message": "案件不存在", "data": None}

        created = payload(client.post("/api/v1/cases", json={"operator_id": "op"}))
        case_id = created["id"]
        start = client.post(f"/api/v1/cases/{case_id}/session/start", json={})
        assert start.status_code == 409
        assert start.json()["code"] == "IDENTITY_REQUIRED"

        identity = client.post("/api/v1/identity/read", json={"case_id": case_id})
        assert identity.status_code == 409
        assert identity.json()["code"] == "DEVICE_NOT_CONNECTED"

        validation = client.post(f"/api/v1/cases/{case_id}/session/stage", json={})
        assert validation.status_code == 422
        assert validation.json()["ok"] is False
        assert validation.json()["code"] == "VALIDATION_ERROR"
