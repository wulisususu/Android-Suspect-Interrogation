from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import Person


def create(db: Session, *, case_id: str | None, data: dict, role: str = "suspect") -> Person:
    row = Person(
        id=str(uuid4()), case_id=case_id, role=role, name=str(data.get("name") or ""),
        id_number=str(data.get("id_number") or data.get("idNumber") or ""),
        gender=data.get("gender"), nation=data.get("nation"), birth_date=data.get("birth_date") or data.get("birthDate"),
        address=data.get("address"), source=str(data.get("source") or "idcard"),
    )
    db.add(row)
    db.flush()
    return row


def list_for_case(db: Session, case_id: str) -> list[Person]:
    return list(db.scalars(select(Person).where(Person.case_id == case_id).order_by(Person.created_at.asc())))
