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
from app.database.voiceprint_models import OfficerVoiceProfile, SessionOfficerVoiceSnapshot
from app.domain.errors import DomainError


_FLOAT32_BYTES = 4
_SNAPSHOT_PREFIX = "__session_snapshot__:"
_DEFAULT_MODEL_KEY = "xvector"


def _embedding_bytes(embedding: bytes, embedding_dim: int) -> bytes:
    if not isinstance(embedding, (bytes, bytearray, memoryview)):
        raise DomainError("INVALID_VOICEPRINT_EMBEDDING", "声纹向量必须为二进制 float32 数据", 400)
    if embedding_dim <= 0 or len(embedding) != embedding_dim * _FLOAT32_BYTES:
        raise DomainError("INVALID_VOICEPRINT_EMBEDDING", "声纹向量维度与二进制长度不一致", 400)
    return bytes(embedding)


def _model_key(value: str | None) -> str:
    normalized = str(value or "").strip().lower()
    if not normalized:
        raise DomainError("VOICEPRINT_MODEL_KEY_REQUIRED", "声纹模型标识不能为空", 400)
    return normalized


def get_suspect(
    db: Session,
    case_id: str,
    *,
    model_key: str = _DEFAULT_MODEL_KEY,
    active_only: bool = True,
) -> SuspectVoiceprint | None:
    key = _model_key(model_key)
    stmt = select(SuspectVoiceprint).where(
        SuspectVoiceprint.case_id == case_id,
        SuspectVoiceprint.model_key == key,
    )
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
    model_key: str = _DEFAULT_MODEL_KEY,
) -> SuspectVoiceprint:
    key = _model_key(model_key)
    if get_suspect(db, case_id, model_key=key, active_only=False) is not None:
        raise DomainError("SUSPECT_VOICEPRINT_EXISTS", "该案件已存在同模型嫌疑人声纹，重新登记必须使用显式替换操作", 409)
    item = SuspectVoiceprint(
        id=str(uuid4()),
        case_id=case_id,
        model_key=key,
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
    model_key: str = _DEFAULT_MODEL_KEY,
) -> SuspectVoiceprint:
    key = _model_key(model_key)
    item = get_suspect(db, case_id, model_key=key, active_only=False)
    if item is None:
        raise DomainError("SUSPECT_VOICEPRINT_NOT_FOUND", "指定模型的嫌疑人声纹不存在", 404)
    item.embedding = _embedding_bytes(embedding, embedding_dim)
    item.embedding_dim = embedding_dim
    item.model_id = model_id
    item.model_version = model_version
    item.enrollment_quality = enrollment_quality
    item.usable_duration_ms = usable_duration_ms
    item.active = True
    db.flush()
    return item


def get_officer(
    db: Session,
    officer_id: str,
    *,
    model_key: str = _DEFAULT_MODEL_KEY,
    active_only: bool = True,
) -> OfficerVoiceprint | None:
    key = _model_key(model_key)
    stmt = select(OfficerVoiceprint).where(
        OfficerVoiceprint.officer_id == officer_id,
        OfficerVoiceprint.model_key == key,
    )
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
    model_key: str = _DEFAULT_MODEL_KEY,
) -> OfficerVoiceprint:
    key = _model_key(model_key)
    if get_officer(db, officer_id, model_key=key, active_only=False) is not None:
        raise DomainError("OFFICER_VOICEPRINT_EXISTS", "该民警已存在同模型声纹档案，请使用更新操作", 409)
    item = OfficerVoiceprint(
        id=str(uuid4()),
        officer_id=officer_id,
        model_key=key,
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
    model_key: str = _DEFAULT_MODEL_KEY,
) -> OfficerVoiceprint:
    key = _model_key(model_key)
    item = get_officer(db, officer_id, model_key=key, active_only=False)
    if item is None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "指定模型的民警声纹档案不存在", 404)
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


def revoke_officer(
    db: Session,
    *,
    officer_id: str,
    model_key: str = _DEFAULT_MODEL_KEY,
) -> OfficerVoiceprint:
    key = _model_key(model_key)
    item = get_officer(db, officer_id, model_key=key, active_only=False)
    if item is None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "指定模型的民警声纹档案不存在", 404)
    item.active = False
    item.revoked_at = datetime.now(timezone.utc)
    db.flush()
    return item


def _active_officer_or_error(
    db: Session,
    officer_id: str | None,
    *,
    model_key: str = _DEFAULT_MODEL_KEY,
) -> OfficerVoiceprint | None:
    if officer_id is None:
        return None
    key = _model_key(model_key)
    item = get_officer(db, officer_id, model_key=key, active_only=False)
    if item is None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", f"民警 {officer_id} 未登记 {key} 声纹", 404)
    if not item.active or item.revoked_at is not None:
        raise DomainError("OFFICER_VOICEPRINT_NOT_ACTIVE", f"民警 {officer_id} 的 {key} 声纹档案已停用", 409)
    return item


def _snapshot_officer_reference(
    db: Session,
    *,
    session_id: str,
    role: str,
    officer: OfficerVoiceprint,
) -> OfficerVoiceprint:
    profile = db.scalar(
        select(OfficerVoiceProfile).where(
            OfficerVoiceProfile.officer_id == officer.officer_id,
            OfficerVoiceProfile.model_key == officer.model_key,
        )
    )
    aggregate_version = int(profile.aggregate_version) if profile is not None else 1
    snapshot = OfficerVoiceprint(
        id=str(uuid4()),
        officer_id=f"{_SNAPSHOT_PREFIX}{uuid4().hex}",
        model_key=officer.model_key,
        officer_name=officer.officer_name,
        embedding=bytes(officer.embedding),
        embedding_dim=officer.embedding_dim,
        model_id=officer.model_id,
        model_version=officer.model_version,
        enrollment_quality=officer.enrollment_quality,
        usable_duration_ms=officer.usable_duration_ms,
        active=True,
        revoked_at=None,
    )
    db.add(snapshot)
    db.flush()

    metadata = db.scalar(
        select(SessionOfficerVoiceSnapshot).where(
            SessionOfficerVoiceSnapshot.session_id == session_id,
            SessionOfficerVoiceSnapshot.role == role,
        )
    )
    if metadata is None:
        metadata = SessionOfficerVoiceSnapshot(
            id=str(uuid4()),
            session_id=session_id,
            role=role,
            officer_id=officer.officer_id,
            profile_id=profile.id if profile is not None else None,
            aggregate_version=aggregate_version,
            voiceprint_snapshot_id=snapshot.id,
            model_key=snapshot.model_key,
            model_id=snapshot.model_id,
            model_version=snapshot.model_version,
        )
        db.add(metadata)
    else:
        metadata.officer_id = officer.officer_id
        metadata.profile_id = profile.id if profile is not None else None
        metadata.aggregate_version = aggregate_version
        metadata.voiceprint_snapshot_id = snapshot.id
        metadata.model_key = snapshot.model_key
        metadata.model_id = snapshot.model_id
        metadata.model_version = snapshot.model_version
        metadata.created_at = datetime.now(timezone.utc)
    db.flush()
    return snapshot


def _clear_snapshot_metadata(db: Session, *, session_id: str, role: str) -> None:
    metadata = db.scalar(
        select(SessionOfficerVoiceSnapshot).where(
            SessionOfficerVoiceSnapshot.session_id == session_id,
            SessionOfficerVoiceSnapshot.role == role,
        )
    )
    if metadata is not None:
        db.delete(metadata)
        db.flush()


def assign_session_roles(
    db: Session,
    *,
    session_id: str,
    suspect_voiceprint_id: str,
    interrogator_officer_id: str | None,
    recorder_officer_id: str | None,
    model_key: str = _DEFAULT_MODEL_KEY,
) -> SessionVoiceAssignment:
    key = _model_key(model_key)
    suspect = db.get(SuspectVoiceprint, suspect_voiceprint_id)
    if suspect is None or not suspect.active:
        raise DomainError("SUSPECT_VOICEPRINT_NOT_ACTIVE", "嫌疑人声纹不存在或未启用", 409)
    if suspect.model_key != key:
        raise DomainError("SUSPECT_VOICEPRINT_MODEL_MISMATCH", "嫌疑人声纹与当前声纹模型不匹配", 409)

    interrogator = _active_officer_or_error(db, interrogator_officer_id, model_key=key)
    recorder = _active_officer_or_error(db, recorder_officer_id, model_key=key)
    if interrogator and recorder:
        mode = "FULL"
    elif interrogator:
        mode = "SUSPECT_PLUS_INTERROGATOR"
    elif recorder:
        mode = "SUSPECT_PLUS_RECORDER"
    else:
        mode = "SUSPECT_ONLY"

    interrogator_snapshot = (
        _snapshot_officer_reference(
            db,
            session_id=session_id,
            role="INTERROGATOR",
            officer=interrogator,
        )
        if interrogator is not None
        else None
    )
    if interrogator is None:
        _clear_snapshot_metadata(db, session_id=session_id, role="INTERROGATOR")

    recorder_snapshot = (
        _snapshot_officer_reference(
            db,
            session_id=session_id,
            role="RECORDER",
            officer=recorder,
        )
        if recorder is not None
        else None
    )
    if recorder is None:
        _clear_snapshot_metadata(db, session_id=session_id, role="RECORDER")

    item = db.scalar(select(SessionVoiceAssignment).where(SessionVoiceAssignment.session_id == session_id))
    if item is None:
        item = SessionVoiceAssignment(
            id=str(uuid4()),
            session_id=session_id,
            suspect_voiceprint_id=suspect.id,
            recognition_mode=mode,
        )
        db.add(item)
    item.suspect_voiceprint_id = suspect.id
    item.interrogator_officer_id = interrogator.officer_id if interrogator else None
    item.interrogator_voiceprint_id = interrogator_snapshot.id if interrogator_snapshot else None
    item.recorder_officer_id = recorder.officer_id if recorder else None
    item.recorder_voiceprint_id = recorder_snapshot.id if recorder_snapshot else None
    item.recognition_mode = mode
    db.flush()
    return item