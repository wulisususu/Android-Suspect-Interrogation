from __future__ import annotations

import json
from datetime import datetime, timezone
from uuid import uuid4

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.database.models import PendingQuestion, QuestionRound
from app.domain.errors import DomainError


def _json_ids(raw: str) -> list[str]:
    try:
        value = json.loads(raw or "[]")
    except (TypeError, ValueError):
        return []
    return [str(item) for item in value] if isinstance(value, list) else []


def _join_text(existing: str, incoming: str) -> str:
    left = str(existing or "").strip()
    right = str(incoming or "").strip()
    if not left:
        return right
    if not right:
        return left
    return f"{left} {right}"


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


def latest_for_question(db: Session, case_id: str, case_question_id: str) -> QuestionRound | None:
    stmt = (
        select(QuestionRound)
        .where(
            QuestionRound.case_id == case_id,
            QuestionRound.case_question_id == case_question_id,
            QuestionRound.status != "DETACHED",
        )
        .order_by(QuestionRound.round_no.desc(), QuestionRound.started_at.desc())
        .limit(1)
        .with_for_update()
    )
    return db.scalar(stmt)


def get_round(db: Session, round_id: str) -> QuestionRound:
    row = db.get(QuestionRound, round_id)
    if row is None:
        raise DomainError("QUESTION_ROUND_NOT_FOUND", "问答轮次不存在", 404)
    return row


def get_pending(db: Session, pending_id: str) -> PendingQuestion:
    row = db.get(PendingQuestion, pending_id)
    if row is None:
        raise DomainError("PENDING_QUESTION_NOT_FOUND", "待处理问题不存在", 404)
    return row


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


def defer_active_pending(db: Session, case_id: str, session_id: str) -> list[PendingQuestion]:
    stmt = select(PendingQuestion).where(
        PendingQuestion.case_id == case_id,
        PendingQuestion.session_id == session_id,
        PendingQuestion.status == "PENDING",
    ).with_for_update()
    rows = list(db.scalars(stmt))
    for row in rows:
        row.status = "DEFERRED"
    db.flush()
    return rows


def close_active(db: Session, case_id: str, session_id: str) -> list[QuestionRound]:
    stmt = select(QuestionRound).where(
        QuestionRound.case_id == case_id,
        QuestionRound.session_id == session_id,
        QuestionRound.status == "ACTIVE",
    ).with_for_update()
    rows = list(db.scalars(stmt))
    now = datetime.now(timezone.utc)
    for row in rows:
        row.status = "CLOSED"
        row.ended_at = now
    db.flush()
    return rows


def next_round_no(db: Session, case_question_id: str) -> int:
    current = db.scalar(
        select(func.coalesce(func.max(QuestionRound.round_no), 0)).where(
            QuestionRound.case_question_id == case_question_id,
            QuestionRound.status != "DETACHED",
        )
    ) or 0
    return int(current) + 1


def create_round(
    db: Session,
    *,
    case_id: str,
    session_id: str | None,
    case_question_id: str,
    actual_question_text: str,
    officer_fragment_id: str | None,
    answer_text: str = "",
    answer_fragment_ids: list[str] | None = None,
    status: str = "ACTIVE",
) -> QuestionRound:
    row = QuestionRound(
        id=str(uuid4()),
        case_id=case_id,
        session_id=session_id,
        case_question_id=case_question_id,
        round_no=next_round_no(db, case_question_id),
        actual_question_text=str(actual_question_text or "").strip(),
        officer_fragment_id=officer_fragment_id,
        answer_text=str(answer_text or "").strip(),
        answer_fragment_ids_json=json.dumps(answer_fragment_ids or [], ensure_ascii=False),
        status=status,
        started_at=datetime.now(timezone.utc),
        ended_at=None if status == "ACTIVE" else datetime.now(timezone.utc),
    )
    db.add(row)
    db.flush()
    return row


def append_round_answer(db: Session, row: QuestionRound, text: str, fragment_ids: list[str]) -> QuestionRound:
    existing_ids = _json_ids(row.answer_fragment_ids_json)
    new_ids = [value for value in fragment_ids if value not in existing_ids]
    if not new_ids:
        return row
    row.answer_text = _join_text(row.answer_text, text)
    row.answer_fragment_ids_json = json.dumps(existing_ids + new_ids, ensure_ascii=False)
    db.flush()
    return row


def create_pending(
    db: Session,
    *,
    case_id: str,
    session_id: str | None,
    officer_fragment_id: str,
    question_text: str,
    match_status: str,
    candidate_question_ids: list[str] | None = None,
) -> PendingQuestion:
    row = PendingQuestion(
        id=str(uuid4()),
        case_id=case_id,
        session_id=session_id,
        officer_fragment_id=officer_fragment_id,
        question_text=str(question_text or "").strip(),
        match_status=match_status,
        candidate_question_ids_json=json.dumps(candidate_question_ids or [], ensure_ascii=False),
        buffered_answer_text="",
        buffered_fragment_ids_json="[]",
        status="PENDING",
    )
    db.add(row)
    db.flush()
    return row


def append_pending_answer(db: Session, row: PendingQuestion, text: str, fragment_id: str) -> PendingQuestion:
    existing_ids = _json_ids(row.buffered_fragment_ids_json)
    if fragment_id in existing_ids:
        return row
    row.buffered_answer_text = _join_text(row.buffered_answer_text, text)
    row.buffered_fragment_ids_json = json.dumps(existing_ids + [fragment_id], ensure_ascii=False)
    db.flush()
    return row
