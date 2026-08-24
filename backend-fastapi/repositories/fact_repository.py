from sqlalchemy.orm import Session
from models.extended_tables import Fact, TimelineEvent, AuditLog
import time, uuid


def now():
    return int(time.time()*1000)


def list_facts(db: Session, case_id):
    return db.query(Fact).filter(Fact.case_id==case_id).all()


def update_fact(db: Session, case_id, key, value, status):
    item=db.query(Fact).filter(Fact.case_id==case_id, Fact.fact_key==key).first()
    if not item:
        return None
    item.value=value
    item.status=status
    item.updated_at=now()
    db.commit()
    return item


def add_audit(db: Session, case_id, action, detail):
    item=AuditLog(id=str(uuid.uuid4()),case_id=case_id,action=action,detail_json=detail,created_at=now())
    db.add(item)
    db.commit()
    return item
