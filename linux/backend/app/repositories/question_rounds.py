from __future__ import annotations

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import QuestionRound


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
