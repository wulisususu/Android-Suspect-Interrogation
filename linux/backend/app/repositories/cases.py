from datetime import datetime, timezone
from uuid import uuid4

from sqlalchemy import or_, select
from sqlalchemy.orm import Session

from app.database.models import Case, Person
from app.domain.errors import DomainError


def new_case_id() -> str:
    return f"CASE-{datetime.now(timezone.utc).strftime('%Y%m%d')}-{uuid4().hex[:6].upper()}"


def create(db: Session, data: dict) -> Case:
    item = Case(
        id=str(data.get("id") or new_case_id()),
        operator_id=data.get("operator_id") or data.get("operatorId"),
        case_type=str(data.get("case_type") or data.get("caseType") or "suspect_interrogation"),
        suspect_name=str(data.get("suspectName") or data.get("suspect_name") or "待录入"),
        gender=(str(data.get("gender")) if data.get("gender") not in (None, "") else None),
        age=(str(data.get("age")) if data.get("age") not in (None, "") else None),
        officer_name=str(data.get("officerName") or data.get("officer_name") or data.get("operator_id") or "当前警官"),
    )
    db.add(item)
    db.flush()
    return item


def get(db: Session, case_id: str) -> Case:
    item = db.get(Case, case_id)
    if item is None:
        raise DomainError("CASE_NOT_FOUND", "案件不存在", 404)
    return item


def list_all(db: Session, limit: int = 100, query: str | None = None) -> list[Case]:
    statement = select(Case)
    normalized = str(query or "").strip()
    if normalized:
        statement = statement.outerjoin(Person, Person.case_id == Case.id)
        if normalized.isdecimal():
            escaped = normalized.replace("\\", "\\\\").replace("%", "\\%").replace("_", "\\_")
            condition = Person.id_number.like(f"{escaped}%", escape="\\")
        else:
            condition = or_(Case.suspect_name == normalized, Person.name == normalized)
        statement = statement.where(condition).distinct()
    return list(db.scalars(statement.order_by(Case.updated_at.desc()).limit(int(limit))))


def update_fields(db: Session, item: Case, patch: dict) -> Case:
    mapping = {
        "operator_id": "operator_id", "operatorId": "operator_id",
        "case_type": "case_type", "caseType": "case_type",
        "suspectName": "suspect_name", "suspect_name": "suspect_name",
        "gender": "gender", "age": "age",
        "officerName": "officer_name", "officer_name": "officer_name",
    }
    for key, attr in mapping.items():
        if key in patch:
            value = patch[key]
            setattr(item, attr, None if value is None else str(value))
    db.flush()
    return item
