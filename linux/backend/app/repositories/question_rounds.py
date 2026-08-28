from __future__ import annotations

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import PendingQuestion, QuestionRound


def list_for_case(db: Session, case_id: str) -> list[QuestionRound]:
    stmt = (
        select(QuestionRound)
        .where(QuestionRound.case_id == case_id, QuestionRound.status != "DETACHED")
        .order_by(QuestionRound.started_at.asc(), QuestionRound.round_no.asc())
    )
    return list(db.scalars(stmt))


def list_for_question(db: Session, case_id: str, case_question_id: str) -> list[QuestionRound]:
    stmt = (
        select(QuestionRound)
        .where(
            QuestionRound.case_id == case_id,
            QuestionRound.case_question_id == case_question_id,
            QuestionRound.status != "DETACHED",
        )
        .order_by(QuestionRound.round_no.asc())
    )
    return list(db.scalars(stmt))


def active_round(db: Session, case_id: str, session_id: str) -> QuestionRound | None:
    stmt = (
        select(QuestionRound)
        .where(
            QuestionRound.case_id == case_id,
            QuestionRound.session_id == session_id,
            QuestionRound.status == "ACTIVE",
        )
        .order_by(QuestionRound.started_at.desc(), QuestionRound.created_at.desc())
        .limit(1)
        .with_for_update()
    )
    return db.scalar(stmt)


def active_pending(db: Session, case_id: str, session_id: str) -> PendingQuestion | None:
    stmt = (
        select(PendingQuestion)
        .where(
            PendingQuestion.case_id == case_id,
            PendingQuestion.session_id == session_id,
            PendingQuestion.status == "PENDING",
        )
        .order_by(PendingQuestion.created_at.desc())
        .limit(1)
        .with_for_update()
    )
    return db.scalar(stmt)
