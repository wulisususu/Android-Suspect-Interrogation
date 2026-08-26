import json
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import DeviceEvent


def add_event(db: Session, *, case_id: str | None, session_id: str | None, device: str, event: str, payload: dict | None = None) -> DeviceEvent:
    row = DeviceEvent(
        id=str(uuid4()), case_id=case_id, session_id=session_id, device=device, event=event,
        payload_json=json.dumps(payload or {}, ensure_ascii=False, sort_keys=True),
    )
    db.add(row)
    db.flush()
    return row


def list_for_case(db: Session, case_id: str) -> list[DeviceEvent]:
    return list(db.scalars(select(DeviceEvent).where(DeviceEvent.case_id == case_id).order_by(DeviceEvent.created_at.asc())))
