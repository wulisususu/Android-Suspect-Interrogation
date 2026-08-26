import hashlib
import json

from sqlalchemy.orm import Session

from app.domain.enums import WorkflowState
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import documents as document_repo
from app.repositories import facts as fact_repo
from app.repositories import messages as message_repo
from app.repositories import sessions as session_repo
from app.services.serializers import case_dict, fact_dict, message_dict, signature_dict, snapshot_dict
from app.workflow.state import StateMachine


class DocumentService:
    def __init__(self, db: Session):
        self.db = db

    def status(self, case_id: str) -> dict:
        case = case_repo.get(self.db, case_id)
        snapshot = document_repo.latest_snapshot(self.db, case_id)
        signatures = document_repo.list_signatures(self.db, case_id)
        return {
            "caseId": case_id, "workflowState": case.workflow_state, "documentStatus": case.document_status,
            "reportStatus": case.report_status, "snapshot": snapshot_dict(snapshot) if snapshot else None,
            "signatures": [signature_dict(row) for row in signatures],
        }

    def freeze(self, case_id: str, actor_id: str | None = None) -> dict:
        case = case_repo.get(self.db, case_id)
        if WorkflowState(case.workflow_state) != WorkflowState.SUMMARY:
            raise DomainError("DOCUMENT_FREEZE_NOT_ALLOWED", "仅复核阶段可以冻结笔录", 409)
        latest_session = session_repo.latest_for_case(self.db, case_id)
        payload = {
            "case": case_dict(case),
            "messages": [message_dict(row) for row in message_repo.list_for_case(self.db, case_id)],
            "facts": [fact_dict(row) for row in fact_repo.list_for_case(self.db, case_id)],
        }
        content = json.dumps(payload, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
        digest = hashlib.sha256(content.encode("utf-8")).hexdigest()
        snapshot = document_repo.create_snapshot(self.db, case_id=case_id, session_id=latest_session.id if latest_session else None,
                                                 content_json=content, content_hash=digest)
        case.workflow_state = StateMachine.transition(WorkflowState.SUMMARY, WorkflowState.FROZEN).value
        case.document_status = "FROZEN"
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="DOCUMENT_FREEZE", target_type="DOCUMENT", target_id=snapshot.id,
                       after={"version": snapshot.version, "content_hash": snapshot.content_hash})
        self.db.commit()
        return snapshot_dict(snapshot)

    def sign(self, case_id: str, *, signer_role: str, signer_name: str, image_data: str, strokes_json: str = "[]", actor_id: str | None = None) -> dict:
        case = case_repo.get(self.db, case_id)
        if WorkflowState(case.workflow_state) != WorkflowState.FROZEN:
            raise DomainError("SIGNATURE_NOT_ALLOWED", "笔录冻结后才能签名", 409)
        snapshot = document_repo.latest_snapshot(self.db, case_id)
        if snapshot is None:
            raise DomainError("DOCUMENT_NOT_FROZEN", "未找到冻结笔录快照", 409)
        session = session_repo.latest_for_case(self.db, case_id)
        signature = document_repo.create_signature(
            self.db, case_id=case_id, session_id=session.id if session else None, snapshot_id=snapshot.id,
            signer_role=signer_role, signer_name=signer_name, image_data=image_data, strokes_json=strokes_json,
        )
        case.workflow_state = StateMachine.transition(WorkflowState.FROZEN, WorkflowState.SIGNED).value
        case.document_status = "SIGNED"
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="SIGNATURE_SAVE", target_type="SIGNATURE", target_id=signature.id,
                       after={"signer_role": signer_role, "signer_name": signer_name, "snapshot_id": snapshot.id})
        self.db.commit()
        data = signature_dict(signature)
        data["status"] = "SIGNED"
        return data

    def list_signatures(self, case_id: str) -> list[dict]:
        case_repo.get(self.db, case_id)
        return [signature_dict(row) for row in document_repo.list_signatures(self.db, case_id)]

    def mark_report_generated(self, case_id: str, actor_id: str | None = None) -> dict:
        case = case_repo.get(self.db, case_id)
        if WorkflowState(case.workflow_state) != WorkflowState.SIGNED:
            raise DomainError("REPORT_NOT_ALLOWED", "完成签名后才能生成报告", 409)
        case.workflow_state = StateMachine.transition(WorkflowState.SIGNED, WorkflowState.REPORT_GENERATED).value
        case.report_status = "GENERATED"
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="REPORT_GENERATED", target_type="CASE", target_id=case_id,
                       after={"reportStatus": "GENERATED"})
        self.db.commit()
        return self.status(case_id)
