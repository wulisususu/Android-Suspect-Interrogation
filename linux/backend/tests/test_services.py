from sqlalchemy.orm import Session

from app.ai_gateway.mock import DeterministicAIGateway
from app.database.models import Message
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.hardware_gateway.mock import MockHardwareGateway
from app.services.case_service import CaseService
from app.services.document_service import DocumentService
from app.services.identity_service import IdentityService
from app.services.message_service import MessageService
from app.services.session_service import SessionService


def make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'service.sqlite3'}")
    init_database(engine)
    return engine, Session(engine)


def test_full_service_workflow_revision_audit_and_documents(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        cases = CaseService(db)
        identity = IdentityService(db, MockHardwareGateway(simulated=True))
        sessions = SessionService(db)
        messages = MessageService(db)
        documents = DocumentService(db)

        case = cases.create({"operator_id": "officer-1", "suspectName": "测试对象", "officerName": "测试警官"})
        assert case["workflowState"] == "IDENTITY_REQUIRED"
        assert len(cases.list_facts(case["id"])) >= 7

        person = identity.read(case["id"], actor_id="officer-1")
        assert person["name"] == "联调测试对象"
        assert cases.get(case["id"])["workflowState"] == "IDENTITY_READY"

        session = sessions.start(case["id"], actor_id="officer-1")
        assert session["status"] == "RUNNING"
        assert cases.get(case["id"])["workflowState"] == "QUESTIONING"

        created = messages.create(case["id"], text="你叫什么？", speaker="民警", actor_id="officer-1")
        original_id = created["id"]
        revised = messages.revise(case["id"], original_id, text="请说明你的姓名。", reason="联调修订", actor_id="officer-1")
        marked = messages.mark(case["id"], original_id, "conflict", actor_id="officer-1")
        assert revised["id"] == original_id
        assert marked["id"] == original_id
        assert db.query(Message).count() == 1

        revisions = messages.revisions(case["id"], original_id)
        assert len(revisions) == 1
        assert revisions[0]["oldText"] == "你叫什么？"
        assert revisions[0]["newText"] == "请说明你的姓名。"

        sessions.pause(case["id"], actor_id="officer-1")
        assert cases.get(case["id"])["workflowState"] == "PAUSED"
        sessions.resume(case["id"], actor_id="officer-1")
        sessions.change_stage(case["id"], "STATEMENT", actor_id="officer-1")
        completed = sessions.finish(case["id"], actor_id="officer-1")
        assert completed["status"] == "COMPLETED"
        assert cases.get(case["id"])["workflowState"] == "SUMMARY"

        frozen = documents.freeze(case["id"], actor_id="officer-1")
        assert frozen["status"] == "FROZEN"
        assert cases.get(case["id"])["workflowState"] == "FROZEN"

        signed = documents.sign(
            case["id"], signer_role="suspect", signer_name="测试对象",
            image_data="data:image/png;base64,TEST", strokes_json="[]", actor_id="officer-1"
        )
        assert signed["status"] == "SIGNED"
        assert cases.get(case["id"])["workflowState"] == "SIGNED"

        report = documents.mark_report_generated(case["id"], actor_id="officer-1")
        assert report["reportStatus"] == "GENERATED"
        assert cases.get(case["id"])["workflowState"] == "REPORT_GENERATED"

        audit = cases.list_audit(case["id"])
        edit = next(item for item in audit if item["action"] == "QA_UPDATE")
        assert edit["before"]["text"] == "你叫什么？"
        assert edit["after"]["text"] == "请说明你的姓名。"
        assert any(item["action"] == "QA_MARK" for item in audit)
    finally:
        db.close()
        engine.dispose()


def test_device_gateway_never_fakes_real_hardware(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        case = CaseService(db).create({"operator_id": "officer"})
        identity = IdentityService(db, MockHardwareGateway(simulated=False))
        try:
            identity.read(case["id"])
            raise AssertionError("expected DEVICE_NOT_CONNECTED")
        except DomainError as exc:
            assert exc.code == "DEVICE_NOT_CONNECTED"
            assert exc.status_code == 409
    finally:
        db.close()
        engine.dispose()


def test_deterministic_ai_gateway_is_offline_and_repeatable():
    gateway = DeterministicAIGateway()
    first = gateway.generate("  测试回答  ")
    second = gateway.generate("测试回答")
    assert first == second
    assert first["text"].startswith("离线模拟回复：")
