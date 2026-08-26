import json
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import TimelineEvent


def list_for_case(db: Session, case_id: str) -> list[TimelineEvent]:
    return list(db.scalars(select(TimelineEvent).where(TimelineEvent.case_id == case_id).order_by(TimelineEvent.created_at.asc())))


def create(db: Session, case_id: str, data: dict) -> TimelineEvent:
    row = TimelineEvent(
        id=str(uuid4()), case_id=case_id, time_label=str(data.get("time") or ""),
        title=str(data.get("title") or "时间线事件"), detail=str(data.get("detail") or ""),
        evidence_json=json.dumps(data.get("evidence") or [], ensure_ascii=False),
    )
    db.add(row)
    db.flush()
    return row
