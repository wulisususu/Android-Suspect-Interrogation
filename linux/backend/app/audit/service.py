from sqlalchemy.orm import Session

from app.repositories import audit as audit_repo
from app.services.serializers import audit_dict


class AuditService:
    def __init__(self, db: Session):
        self.db = db

    def record(self, **kwargs):
        return audit_repo.add(self.db, **kwargs)

    def list(self, case_id: str, limit: int = 200) -> list[dict]:
        return [audit_dict(row) for row in audit_repo.list_for_case(self.db, case_id, limit)]
