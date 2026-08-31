from __future__ import annotations

import os
from datetime import datetime, timezone
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import ASRCaptureSession, ASRFragment, Message, ProcessedSpeechFragment
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import recognition_evidence as evidence_repo
from app.repositories import speaker_calibrations as calibration_repo


def create_capture_session(db: Session, *, case_id: str, interrogation_session_id: str | None, sample_rate: int) -> ASRCaptureSession:
    if sample_rate <= 0:
        raise DomainError("INVALID_SAMPLE_RATE", "采样率必须大于 0", 400)
    item = ASRCaptureSession(
        id=str(uuid4()), case_id=case_id, interrogation_session_id=interrogation_session_id,
        status="CAPTURING", sample_rate=sample_rate, started_at=datetime.now(timezone.utc), ended_at=None,
    )
    db.add(item)
    db.flush()
    return item


def get_capture_session(db: Session, capture_session_id: str) -> ASRCaptureSession:
    item = db.get(ASRCaptureSession, capture_session_id)
    if item is None:
        raise DomainError("ASR_CAPTURE_NOT_FOUND", "ASR 采集会话不存在", 404)
    return item


def finish_capture_session(db: Session, *, capture_session_id: str) -> ASRCaptureSession:
    item = get_capture_session(db, capture_session_id)
    item.status = "STOPPED"
    item.ended_at = datetime.now(timezone.utc)
    db.flush()
    return item


def get_fragment(db: Session, fragment_id: str) -> ASRFragment:
    item = db.get(ASRFragment, fragment_id)
    if item is None:
        raise DomainError("ASR_FRAGMENT_NOT_FOUND", "ASR 临时片段不存在", 404)
    return item


def list_fragments(db: Session, *, capture_session_id: str) -> list[ASRFragment]:
    stmt = select(ASRFragment).where(ASRFragment.capture_session_id == capture_session_id).order_by(ASRFragment.ordinal.asc())
    return list(db.scalars(stmt))


def get_processed(db: Session, fragment_id: str) -> ProcessedSpeechFragment | None:
    return db.get(ProcessedSpeechFragment, fragment_id)


def mark_processed(db: Session, *, fragment_id: str, case_id: str, action: str, target_id: str | None = None) -> ProcessedSpeechFragment:
    item = ProcessedSpeechFragment(fragment_id=fragment_id, case_id=case_id, action=action, target_id=target_id)
    db.add(item)
    db.flush()
    return item


def create_fragment(
    db: Session,
    *,
    capture_session_id: str,
    case_id: str,
    ordinal: int,
    started_at_ms: int,
    ended_at_ms: int,
    raw_text: str,
    speaker: str,
    speaker_source: str,
    voiceprint_verified: bool,
    low_confidence: bool,
    model_id: str,
    asr_confidence: float | None = None,
    speaker_id: str | None = None,
    speaker_name: str | None = None,
    speaker_score: float | None = None,
    second_best_score: float | None = None,
    speaker_threshold: float | None = None,
    speaker_margin: float | None = None,
    model_version: str | None = None,
    speaker_threshold_source: str | None = None,
    speaker_model_id: str | None = None,
    speaker_model_version: str | None = None,
    speaker_model_fingerprint: str | None = None,
    microphone_fingerprint: str | None = None,
) -> ASRFragment:
    if ordinal < 0 or started_at_ms < 0 or ended_at_ms < started_at_ms:
        raise DomainError("INVALID_ASR_FRAGMENT_RANGE", "ASR 片段序号或时间范围无效", 400)
    text = str(raw_text or "")
    item = ASRFragment(
        id=str(uuid4()), capture_session_id=capture_session_id, case_id=case_id, ordinal=ordinal,
        started_at_ms=started_at_ms, ended_at_ms=ended_at_ms, raw_text=text, edited_text=text,
        asr_confidence=asr_confidence, speaker=speaker, speaker_id=speaker_id, speaker_name=speaker_name,
        speaker_score=speaker_score, second_best_score=second_best_score, speaker_threshold=speaker_threshold,
        speaker_margin=speaker_margin, speaker_source=speaker_source, voiceprint_verified=voiceprint_verified,
        low_confidence=low_confidence, state="PENDING", model_id=model_id, model_version=model_version,
        confirmed_message_id=None,
    )
    db.add(item)
    db.flush()

    snapshot = calibration_repo.get_session_snapshot(db, capture_session_id)
    threshold_source = speaker_threshold_source or (snapshot.threshold_source if snapshot is not None else None)
    if speaker_model_fingerprint is None and snapshot is not None:
        speaker_model_fingerprint = snapshot.speaker_model_fingerprint
    if microphone_fingerprint is None and snapshot is not None:
        microphone_fingerprint = snapshot.microphone_fingerprint
    speaker_model_id = speaker_model_id or "xvector"
    speaker_model_version = speaker_model_version or os.environ.get("SUSPECT_XVECTOR_MODEL_VERSION", "local")

    evidence_repo.create_evidence(
        db,
        fragment_id=item.id,
        capture_session_id=capture_session_id,
        case_id=case_id,
        ai_speaker=item.speaker,
        speaker_id=item.speaker_id,
        speaker_name=item.speaker_name,
        speaker_source=item.speaker_source,
        score=item.speaker_score,
        second_best_score=item.second_best_score,
        threshold=item.speaker_threshold,
        margin=item.speaker_margin,
        threshold_source=threshold_source,
        voiceprint_verified=item.voiceprint_verified,
        low_confidence=item.low_confidence,
        asr_model_id=item.model_id,
        asr_model_version=item.model_version,
        speaker_model_id=speaker_model_id,
        speaker_model_version=speaker_model_version,
        speaker_model_fingerprint=speaker_model_fingerprint,
        microphone_fingerprint=microphone_fingerprint,
        calibration_id=None if snapshot is None else snapshot.calibration_id,
        calibration_status=None if snapshot is None else snapshot.calibration_status,
    )

    # Keep the cross-cutting audit event for operational traceability. The
    # authoritative immutable recognition evidence now lives in its own table.
    audit_repo.add(
        db,
        case_id=case_id,
        action="ASR_SPEAKER_DECISION",
        target_type="ASR_FRAGMENT",
        target_id=item.id,
        after={
            "speaker": item.speaker,
            "speaker_id": item.speaker_id,
            "speaker_name": item.speaker_name,
            "speaker_source": item.speaker_source,
            "voiceprint_verified": item.voiceprint_verified,
            "low_confidence": item.low_confidence,
        },
        detail={
            "score": item.speaker_score,
            "second_best_score": item.second_best_score,
            "threshold": item.speaker_threshold,
            "margin": item.speaker_margin,
            "threshold_source": threshold_source,
            "asr_model_id": item.model_id,
            "asr_model_version": item.model_version,
            "speaker_model_id": speaker_model_id,
            "speaker_model_version": speaker_model_version,
            "speaker_model_fingerprint": speaker_model_fingerprint,
            "microphone_fingerprint": microphone_fingerprint,
            "calibration_id": None if snapshot is None else snapshot.calibration_id,
            "calibration_status": None if snapshot is None else snapshot.calibration_status,
        },
    )
    return item


def update_fragment(
    db: Session,
    *,
    fragment_id: str,
    edited_text: str,
    speaker: str,
    speaker_id: str | None,
    speaker_name: str | None,
    speaker_source: str,
    voiceprint_verified: bool,
    low_confidence: bool,
    actor_id: str | None = None,
    reason: str | None = None,
) -> ASRFragment:
    item = get_fragment(db, fragment_id)
    if item.state == "CONFIRMED":
        raise DomainError("ASR_FRAGMENT_ALREADY_CONFIRMED", "已确认的 ASR 片段不能直接修改", 409)
    before_speaker = item.speaker
    before_text = item.edited_text
    after_text = str(edited_text or "")
    evidence_repo.append_revision(
        db,
        fragment_id=item.id,
        case_id=item.case_id,
        before_speaker=before_speaker,
        after_speaker=speaker,
        before_text=before_text,
        after_text=after_text,
        actor_id=actor_id,
        reason=reason,
    )
    item.edited_text = after_text
    item.speaker = speaker
    item.speaker_id = speaker_id
    item.speaker_name = speaker_name
    item.speaker_source = speaker_source
    item.voiceprint_verified = voiceprint_verified
    item.low_confidence = low_confidence
    item.state = "EDITED"
    db.flush()
    return item


def confirm_fragment(db: Session, *, fragment_id: str, message_id: str) -> ASRFragment:
    item = get_fragment(db, fragment_id)
    if db.get(Message, message_id) is None:
        raise DomainError("QA_NOT_FOUND", "正式问答记录不存在", 404)
    item.confirmed_message_id = message_id
    item.state = "CONFIRMED"
    db.flush()
    return item
