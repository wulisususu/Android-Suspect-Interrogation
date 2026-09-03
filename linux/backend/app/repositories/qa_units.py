from __future__ import annotations

import json
from datetime import datetime
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import QAUnit, QAUnitFragment
from app.domain.errors import DomainError

_ROLES = {"QUESTION", "ANSWER"}


def create_open(db: Session, *, case_id: str, session_id: str | None, started_at: datetime) -> QAUnit:
    row = QAUnit(
        id=str(uuid4()),
        case_id=case_id,
        session_id=session_id,
        status="OPEN",
        raw_question_text="",
        raw_answer_text="",
        candidate_question_ids_json="[]",
        started_at=started_at,
    )
    db.add(row)
    db.flush()
    return row


def get(db: Session, qa_unit_id: str) -> QAUnit:
    row = db.get(QAUnit, qa_unit_id)
    if row is None:
        raise DomainError("QA_UNIT_NOT_FOUND", "问答单元不存在", 404)
    return row


def active_for_session(db: Session, case_id: str, session_id: str) -> QAUnit | None:
    return db.scalar(
        select(QAUnit)
        .where(QAUnit.case_id == case_id, QAUnit.session_id == session_id, QAUnit.status == "OPEN")
        .order_by(QAUnit.started_at.desc())
        .limit(1)
        .with_for_update()
    )


def find_for_fragment(db: Session, fragment_id: str) -> QAUnit | None:
    return db.scalar(
        select(QAUnit)
        .join(QAUnitFragment, QAUnitFragment.qa_unit_id == QAUnit.id)
        .where(QAUnitFragment.fragment_id == fragment_id)
        .limit(1)
    )


def append_fragment(db: Session, row: QAUnit, *, fragment_id: str, role: str, position: int) -> QAUnitFragment:
    normalized_role = str(role or "").upper()
    if normalized_role not in _ROLES:
        raise DomainError("INVALID_QA_FRAGMENT_ROLE", "问答片段角色无效", 400)
    link = QAUnitFragment(
        qa_unit_id=row.id,
        fragment_id=fragment_id,
        role=normalized_role,
        position=int(position),
    )
    db.add(link)
    db.flush()
    return link


def refresh_text(db: Session, row: QAUnit, *, raw_question_text: str, raw_answer_text: str) -> QAUnit:
    row.raw_question_text = str(raw_question_text or "").strip()
    row.raw_answer_text = str(raw_answer_text or "").strip()
    db.flush()
    return row


def close(db: Session, row: QAUnit, *, raw_question_text: str, raw_answer_text: str, ended_at: datetime) -> QAUnit:
    row.raw_question_text = str(raw_question_text or "").strip()
    row.raw_answer_text = str(raw_answer_text or "").strip()
    row.ended_at = ended_at
    row.status = "CLOSED"
    db.flush()
    return row


def list_for_case(db: Session, case_id: str) -> list[QAUnit]:
    stmt = select(QAUnit).where(QAUnit.case_id == case_id).order_by(QAUnit.started_at.asc(), QAUnit.created_at.asc())
    return list(db.scalars(stmt))


def list_recent_closed(db: Session, case_id: str, *, limit: int = 2) -> list[QAUnit]:
    stmt = (
        select(QAUnit)
        .where(QAUnit.case_id == case_id, QAUnit.status != "OPEN", QAUnit.ended_at.is_not(None))
        .order_by(QAUnit.ended_at.desc(), QAUnit.created_at.desc())
        .limit(max(0, int(limit)))
    )
    return list(db.scalars(stmt))


def mark_routing(db: Session, row: QAUnit) -> None:
    row.status = "ROUTING"
    db.flush()


def save_decision(
    db: Session,
    row: QAUnit,
    *,
    classification: str,
    target_question_id: str | None,
    formal_question_text: str | None,
    formal_answer_text: str | None,
    confidence: float | None,
    model_id: str | None,
    reason_code: str | None,
    status: str,
    candidate_question_ids: list[str] | tuple[str, ...] | None = None,
) -> None:
    row.classification = str(classification)
    row.target_question_id = target_question_id
    row.formal_question_text = formal_question_text
    row.formal_answer_text = formal_answer_text
    row.candidate_question_ids_json = json.dumps(list(candidate_question_ids or ()), ensure_ascii=False)
    row.confidence = confidence
    row.model_id = model_id
    row.reason_code = reason_code
    row.status = str(status)
    db.flush()
