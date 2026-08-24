import json
import uuid
import time
from sqlalchemy.orm import Session
from models.extended_tables import Fact, TimelineEvent, AuditLog


def now():
    return int(time.time() * 1000)


def list_facts(db: Session, case_id: str):
    return db.query(Fact).filter(Fact.case_id == case_id).all()


def update_fact(db: Session, case_id: str, key: str, value: dict):
    item = db.query(Fact).filter(Fact.case_id == case_id, Fact.fact_key == key).first()
    if not item:
        return None
    item.value = value.get('value', item.value)
    item.status = value.get('status', item.status)
    item.suggestion = value.get('suggestion', item.suggestion)
    item.updated_at = now()
    db.commit()
    return item


def list_timeline(db: Session, case_id: str):
    return db.query(TimelineEvent).filter(TimelineEvent.case_id == case_id).all()


def add_timeline(db: Session, case_id: str, payload: dict):
    item = TimelineEvent(
        id=str(uuid.uuid4()),
        case_id=case_id,
        time_label=payload.get('time', ''),
        title=payload.get('title', ''),
        detail=payload.get('detail', ''),
        evidence_json=json.dumps(payload.get('evidence', []), ensure_ascii=False),
        created_at=now()
    )
    db.add(item)
    db.commit()
    return item


def add_audit(db: Session, case_id: str, action: str, detail=None):
    item = AuditLog(
        id=str(uuid.uuid4()),
        case_id=case_id,
        action=action,
        detail_json=json.dumps(detail or {}, ensure_ascii=False),
        created_at=now()
    )
    db.add(item)
    db.commit()
    return item
