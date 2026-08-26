from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.base import utc_now
from app.database.models import InterrogationSession
from app.domain.enums import InterrogationStage, SessionStatus

ACTIVE = {SessionStatus.RUNNING.value, SessionStatus.PAUSED.value}


def active_for_case(db: Session, case_id: str) -> InterrogationSession | None:
    return db.scalar(
        select(InterrogationSession)
        .where(InterrogationSession.case_id == case_id, InterrogationSession.status.in_(ACTIVE))
        .order_by(InterrogationSession.updated_at.desc())
        .limit(1)
    )


def latest_for_case(db: Session, case_id: str) -> InterrogationSession | None:
    return db.scalar(
        select(InterrogationSession).where(InterrogationSession.case_id == case_id)
        .order_by(InterrogationSession.updated_at.desc()).limit(1)
    )


def get_by_id(db: Session, session_id: str) -> InterrogationSession | None:
    return db.get(InterrogationSession, session_id)


def create(db: Session, case_id: str, stage: str = InterrogationStage.IDENTITY.value) -> InterrogationSession:
    now = utc_now()
    row = InterrogationSession(
        id=str(uuid4()), case_id=case_id, status=SessionStatus.RUNNING.value,
        stage=stage, started_at=now,
    )
    db.add(row)
    db.flush()
    return row
