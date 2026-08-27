from __future__ import annotations

from datetime import datetime, timezone
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import (
    OfficerVoiceprint,
    SessionVoiceAssignment,
    SuspectVoiceprint,
)
from app.domain.errors import DomainError


_FLOAT32_BYTES = 4


def _embedding_bytes(embedding: bytes, embedding_dim: int) -> bytes:
    if not isinstance(embedding, (bytes, bytearray, memoryview)):
        raise DomainError("INVALID_VOICEPRINT_EMBEDDING", "声纹向量必须为二进制 float32 数据", 400)
    if embedding_dim <= 0 or len(embedding) != embedding_dim * _FLOAT32_BYTES:
        raise DomainError("INVALID_VOICEPRINT_EMBEDDING", "声纹向量维度与二进制长度不一致", 400)
    return bytes(embedding)


def get_suspect(db: Session, case_id: str, *, active_only: bool = True) -> SuspectVoiceprint | None:
    stmt = select(SuspectVoiceprint).where(SuspectVoiceprint.case_id == case_id)
    if active_only:
        stmt = stmt.where(SuspectVoiceprint.active.is_(True))
    return db.scalar(stmt)


def enroll_suspect(
    db: Session,
    *,
    case_id: str,
    embedding: bytes,
    embedding_dim: int,
    model_id: str,
    enrollment_quality: str,
    usable_duration_ms: int,
    model_version: str | None = None,
) -> SuspectVoiceprint:
    if get_suspect(db, case_id, active_only=False) is not None:
        raise DomainError("SUSPECT_VOICEPRINT_EXISTS", "该案件已存在嫌疑人声纹，重新登记必须使用显式替换操作", 409)
    item = SuspectVoiceprint(
        id=str(uuid4()),
        case_id=case_id,
        embedding=_embedding_bytes(embedding, embedding_dim),
        embedding_dim=embedding_dim,
        model_id=model_id,
        model_version=model_version,
        enrollment_quality=enrollment_quality,
        usable_duration_ms=usable_duration_ms,
        active=True,
    )
    db.add(item)
    db.flush()
    return item


def replace_suspect(
    db: Session,
    *,
    case_id: str,
    embedding: bytes,
    embedding_dim: int,
    model_id: str,
    enrollment_quality: str,
    usable_duration_ms: int,
    model_version: str | None = None,
) -> SuspectVoiceprint:
    item = get_suspect(db, case_id, active_only=False)
    if item is None:
        raise DomainError("SUSPECT_VOICEPRINT_NOT_FOUND", "嫌疑人声纹不存在", 404)
    item.embedding = _embedding_bytes(embedding, embedding_dim)
    item.embedding_dim = embedding_dim
    item.model_id = model_id
    item.model_version = model_version
    item.enrollment_quality = enrollment_quality
    item.usable_duration_ms = usable_duration_ms
    item.active = True
    db.flush()
    return item


def get_officer(db: Session, officer_id: str, *, active_only: bool = True) -> OfficerVoiceprint | None:
    stmt = select(OfficerVoiceprint).where(OfficerVoiceprint.officer_id == officer_id)
    if active_only:
        stmt = stmt.where(OfficerVoiceprint.active.is_(True), OfficerVoiceprint.revoked_at.is_(None))
    return db.scalar(stmt)


def enroll_officer(
    db: Session,
    *,
    officer_id: str,
    officer_name: str,
    embedding: bytes,
    embedding_dim: int,
    model_id: str,
    enrollment_quality: str,
    usable_duration_ms: int,
    model_version: str | None = None,
) -> OfficerVoiceprint:
    if get_officer(db, officer_id, active_only=False) is not None:
        raise DomainError("OFFICER_VOICEPRINT_EXISTS", "该民警已存在声纹档案，请使用更新操作", 409)
    item = OfficerVoiceprint(
        id=str(uuid4()),
        officer_id=officer_id,
        officer_name=officer_name,
        embedding=_embedding_bytes(embedding, embedding_dim),
        embedding_dim=embedding_dim,
        model_id=model_id,
        model_version=model_version,
        enrollment_quality=enrollment_quality,
        usable_duration_ms=usable_duration_ms,
        active=True,
        revoked_at=None,
    )
    db.add(item)
    db.flush()
    return item


def update_officer(
    db: Session,
    *,
    officer_id: str,
    officer_name: str,
    embedding: bytes,
    embedding_dim: int,
    model_id: str,
    enrollment_quality: str,
    usable_duration_ms: int,
    model_version: str | None = None,
) -> OfficerVoiceprint:
    item = get_officer(db, officer_id, active_only=False)
    if item is None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "民警声纹档案不存在", 404)
    item.officer_name = officer_name
    item.embedding = _embedding_bytes(embedding, embedding_dim)
    item.embedding_dim = embedding_dim
    item.model_id = model_id
    item.model_version = model_version
    item.enrollment_quality = enrollment_quality
    item.usable_duration_ms = usable_duration_ms
    item.active = True
    item.revoked_at = None
    db.flush()
    return item


def revoke_officer(db: Session, *, officer_id: str) -> OfficerVoiceprint:
    item = get_officer(db, officer_id, active_only=False)
    if item is None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "民警声纹档案不存在", 404)
    item.active = False
    item.revoked_at = datetime.now(timezone.utc)
    db.flush()
    return item


def _active_officer_or_error(db: Session, officer_id: str | None) -> OfficerVoiceprint | None:
    if officer_id is None:
        return None
    item = get_officer(db, officer_id, active_only=False)
    if item is None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", f"民警 {officer_id} 未登记声纹", 404)
    if not item.active or item.revoked_at is not None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_ACTIVE", f"民警 {officer_id} 的声纹档案已停用", 409)
    return item


def assign_session_roles(
    db: Session,
    *,
    session_id: str,
    suspect_voiceprint_id: str,
    interrogator_officer_id: str | None,
    recorder_officer_id: str | None,
) -> SessionVoiceAssignment:
    suspect = db.get(SuspectVoiceprint, suspect_voiceprint_id)
    if suspect is None or not suspect.active:
        raise DomainError("SUSPECT_VOICEPRINT_NOT_ACTIVE", "嫌疑人声纹不存在或未启用", 409)

    interrogator = _active_officer_or_error(db, interrogator_officer_id)
    recorder = _active_officer_or_error(db, recorder_officer_id)
    if interrogator and recorder:
        mode = "FULL"
    elif interrogator:
        mode = "SUSPECT_PLUS_INTERROGATOR"
    elif recorder:
        mode = "SUSPECT_PLUS_RECORDER"
    else:
        mode = "SUSPECT_ONLY"

    item = db.scalar(select(SessionVoiceAssignment).where(SessionVoiceAssignment.session_id == session_id))
    if item is None:
        item = SessionVoiceAssignment(id=str(uuid4()), session_id=session_id, suspect_voiceprint_id=suspect.id, recognition_mode=mode)
        db.add(item)
    item.suspect_voiceprint_id = suspect.id
    item.interrogator_officer_id = interrogator.officer_id if interrogator else None
    item.interrogator_voiceprint_id = interrogator.id if interrogator else None
    item.recorder_officer_id = recorder.officer_id if recorder else None
    item.recorder_voiceprint_id = recorder.id if recorder else None
    item.recognition_mode = mode
    db.flush()
    return item
