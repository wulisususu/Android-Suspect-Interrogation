from __future__ import annotations

from sqlalchemy.orm import Session

from app.domain.enums import InterrogationStage
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import facts as fact_repo
from app.repositories import persons as person_repo
from app.repositories import timeline as timeline_repo
from app.services.serializers import audit_dict, case_dict, fact_dict, person_dict, timeline_dict


class CaseService:
    def __init__(self, db: Session):
        self.db = db

    def _case_data(self, row) -> dict:
        data = case_dict(row)
        persons = person_repo.list_for_case(self.db, row.id)
        if not persons:
            return data
        identity = persons[-1]
        person = person_dict(identity)
        data.update({
            "suspectName": person["name"] or data["suspectName"],
            "gender": person["gender"] or data["gender"],
            "idNumber": person["idNumber"],
            "nation": person["nation"],
            "birthDate": person["birthDate"],
            "address": person["address"],
            "identitySource": person["source"],
            "identityCapturedAt": identity.created_at.isoformat() if identity.created_at else None,
        })
        return data

    def create(self, payload: dict) -> dict:
        row = case_repo.create(self.db, payload)
        fact_repo.seed_defaults(self.db, row.id)
        data = self._case_data(row)
        audit_repo.add(self.db, case_id=row.id, actor_id=row.operator_id, action="CASE_CREATE", target_type="CASE", target_id=row.id, after=data)
        self.db.commit()
        return data

    def get(self, case_id: str) -> dict:
        return self._case_data(case_repo.get(self.db, case_id))

    def list(self, limit: int = 100) -> list[dict]:
        return [self._case_data(row) for row in case_repo.list_all(self.db, limit)]

    def update(self, case_id: str, patch: dict, actor_id: str | None = None) -> dict:
        row = case_repo.get(self.db, case_id)
        before = self._case_data(row)
        if "stage" in patch:
            try:
                row.stage = InterrogationStage(str(patch["stage"])).value
            except ValueError as exc:
                raise DomainError("INVALID_STAGE", "无效审讯阶段", 400) from exc
        case_repo.update_fields(self.db, row, patch)
        after = self._case_data(row)
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="CASE_UPDATE", target_type="CASE", target_id=case_id, before=before, after=after, detail=patch)
        self.db.commit()
        return after

    def list_facts(self, case_id: str) -> list[dict]:
        case_repo.get(self.db, case_id)
        return [fact_dict(row) for row in fact_repo.list_for_case(self.db, case_id)]

    def update_fact(self, case_id: str, fact_key: str, patch: dict, actor_id: str | None = None) -> dict:
        case_repo.get(self.db, case_id)
        before_item = next((x for x in self.list_facts(case_id) if x["key"] == fact_key), None)
        row = fact_repo.update(self.db, case_id, fact_key, patch)
        after_item = fact_dict(row)
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="FACT_UPDATE", target_type="FACT", target_id=fact_key, before=before_item or {}, after=after_item)
        self.db.commit()
        return after_item

    def list_timeline(self, case_id: str) -> list[dict]:
        case_repo.get(self.db, case_id)
        return [timeline_dict(row) for row in timeline_repo.list_for_case(self.db, case_id)]

    def add_timeline(self, case_id: str, payload: dict, actor_id: str | None = None) -> dict:
        case_repo.get(self.db, case_id)
        row = timeline_repo.create(self.db, case_id, payload)
        data = timeline_dict(row)
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="TIMELINE_CREATE", target_type="TIMELINE", target_id=row.id, after=data)
        self.db.commit()
        return data

    def list_audit(self, case_id: str, limit: int = 200) -> list[dict]:
        case_repo.get(self.db, case_id)
        return [audit_dict(row) for row in audit_repo.list_for_case(self.db, case_id, limit)]
