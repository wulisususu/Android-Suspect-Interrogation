from sqlalchemy.orm import Session
from models.tables import Case, QARecord, InterrogationSession
import uuid, time


def now():
    return int(time.time()*1000)


def create_case(db: Session, data: dict):
    item = Case(
        id=data.get('id') or ('CASE-' + uuid.uuid4().hex[:8].upper()),
        suspect_name=data.get('suspectName','待录入'),
        gender=data.get('gender'),
        age=data.get('age'),
        officer_name=data.get('officerName','当前警官'),
        created_at=now(),
        updated_at=now()
    )
    db.add(item)
    db.commit()
    db.refresh(item)
    return item


def get_case(db: Session, case_id: str):
    return db.query(Case).filter(Case.id == case_id).first()


def list_cases(db: Session, limit=100):
    return db.query(Case).order_by(Case.updated_at.desc()).limit(limit).all()


def add_message(db: Session, case_id: str, session_id: str, speaker: str, text: str):
    count = db.query(QARecord).filter(QARecord.case_id==case_id).count()
    item = QARecord(
        id=str(uuid.uuid4()),
        case_id=case_id,
        session_id=session_id,
        seq=count+1,
        speaker=speaker,
        text=text,
        confirmed=True,
        created_at=now(),
        updated_at=now()
    )
    db.add(item)
    db.commit()
    db.refresh(item)
    return item
