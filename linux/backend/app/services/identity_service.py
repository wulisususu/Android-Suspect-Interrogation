from sqlalchemy.orm import Session

from app.domain.enums import WorkflowState
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import devices as device_repo
from app.repositories import persons as person_repo
from app.services.serializers import person_dict
from app.workflow.state import StateMachine


class IdentityService:
    def __init__(self, db: Session, hardware_gateway):
        self.db = db
        self.hardware = hardware_gateway

    def status(self) -> dict:
        return self.hardware.status()["devices"]["identity"] | {"device": "idcard_reader"}

    def read(self, case_id: str | None = None, actor_id: str | None = None) -> dict:
        case = case_repo.get(self.db, case_id) if case_id else None
        data = self.hardware.read_identity()
        row = person_repo.create(self.db, case_id=case_id, data=data)
        device_repo.add_event(self.db, case_id=case_id, session_id=None, device="identity", event="IDENTITY_SUCCESS", payload={"person_id": row.id})
        if case is not None:
            current = WorkflowState(case.workflow_state)
            if current == WorkflowState.IDENTITY_REQUIRED:
                case.workflow_state = StateMachine.transition(current, WorkflowState.IDENTITY_READY).value
            elif current not in {WorkflowState.IDENTITY_READY, WorkflowState.CASE_CREATED, WorkflowState.QUESTIONING, WorkflowState.PAUSED}:
                raise DomainError("IDENTITY_NOT_ALLOWED", f"当前状态不允许读取身份：{current.value}", 409)
            audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="IDENTITY_READ", target_type="PERSON", target_id=row.id, after={"name": row.name, "id_number": row.id_number})
        self.db.commit()
        return person_dict(row)
