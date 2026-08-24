from sqlalchemy.orm import Session
from models.extended_tables import TimelineEvent


def list_timeline(db: Session, case_id: str):
    return db.query(TimelineEvent).filter(TimelineEvent.case_id == case_id).all()


def create_timeline(db: Session, case_id: str, payload: dict):
    item = TimelineEvent(case_id=case_id, **payload)
    db.add(item)
    db.commit()
    db.refresh(item)
    return item
