from __future__ import annotations

from uuid import uuid4

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.database.recognition_models import ASRRecognitionEvidence, ASRRecognitionRevision


def create_evidence(
    db: Session,
    *,
    fragment_id: str,
    capture_session_id: str,
    case_id: str,
    ai_speaker: str,
    speaker_id: str | None,
    speaker_name: str | None,
    speaker_source: str,
    score: float | None,
    second_best_score: float | None,
    threshold: float | None,
    margin: float | None,
    threshold_source: str | None,
    voiceprint_verified: bool,
    low_confidence: bool,
    asr_model_id: str | None,
    asr_model_version: str | None,
    speaker_model_id: str | None,
    speaker_model_version: str | None,
    speaker_model_fingerprint: str | None,
    microphone_fingerprint: str | None,
    calibration_id: str | None,
    calibration_status: str | None,
) -> ASRRecognitionEvidence:
    existing = get_evidence(db, fragment_id)
    if existing is not None:
        return existing
    row = ASRRecognitionEvidence(
        id=str(uuid4()),
        fragment_id=fragment_id,
        capture_session_id=capture_session_id,
        case_id=case_id,
        ai_speaker=ai_speaker,
        speaker_id=speaker_id,
        speaker_name=speaker_name,
        speaker_source=speaker_source,
        score=score,
        second_best_score=second_best_score,
        threshold=threshold,
        margin=margin,
        threshold_source=threshold_source,
        voiceprint_verified=bool(voiceprint_verified),
        low_confidence=bool(low_confidence),
        asr_model_id=asr_model_id,
        asr_model_version=asr_model_version,
        speaker_model_id=speaker_model_id,
        speaker_model_version=speaker_model_version,
        speaker_model_fingerprint=speaker_model_fingerprint,
        microphone_fingerprint=microphone_fingerprint,
        calibration_id=calibration_id,
        calibration_status=calibration_status,
    )
    db.add(row)
    db.flush()
    return row


def get_evidence(db: Session, fragment_id: str) -> ASRRecognitionEvidence | None:
    return db.scalar(select(ASRRecognitionEvidence).where(ASRRecognitionEvidence.fragment_id == fragment_id))


def list_revisions(db: Session, fragment_id: str) -> list[ASRRecognitionRevision]:
    stmt = (
        select(ASRRecognitionRevision)
        .where(ASRRecognitionRevision.fragment_id == fragment_id)
        .order_by(ASRRecognitionRevision.revision_no.asc(), ASRRecognitionRevision.created_at.asc())
    )
    return list(db.scalars(stmt))


def append_revision(
    db: Session,
    *,
    fragment_id: str,
    case_id: str,
    before_speaker: str,
    after_speaker: str,
    before_text: str,
    after_text: str,
    actor_id: str | None,
    reason: str | None,
) -> ASRRecognitionRevision:
    next_no = int(
        db.scalar(
            select(func.coalesce(func.max(ASRRecognitionRevision.revision_no), 0)).where(
                ASRRecognitionRevision.fragment_id == fragment_id
            )
        )
        or 0
    ) + 1
    row = ASRRecognitionRevision(
        id=str(uuid4()),
        fragment_id=fragment_id,
        case_id=case_id,
        revision_no=next_no,
        before_speaker=before_speaker,
        after_speaker=after_speaker,
        before_text=before_text,
        after_text=after_text,
        actor_id=actor_id,
        reason=(str(reason).strip() or None) if reason is not None else None,
    )
    db.add(row)
    db.flush()
    return row


def evidence_payload(row: ASRRecognitionEvidence | None) -> dict | None:
    if row is None:
        return None
    return {
        "evidenceId": row.id,
        "aiSpeaker": row.ai_speaker,
        "speakerId": row.speaker_id,
        "speakerName": row.speaker_name,
        "speakerSource": row.speaker_source,
        "score": row.score,
        "secondBestScore": row.second_best_score,
        "threshold": row.threshold,
        "margin": row.margin,
        "thresholdSource": row.threshold_source,
        "voiceprintVerified": row.voiceprint_verified,
        "lowConfidence": row.low_confidence,
        "asrModelId": row.asr_model_id,
        "asrModelVersion": row.asr_model_version,
        "speakerModelId": row.speaker_model_id,
        "speakerModelVersion": row.speaker_model_version,
        "speakerModelFingerprint": row.speaker_model_fingerprint,
        "microphoneFingerprint": row.microphone_fingerprint,
        "calibrationId": row.calibration_id,
        "calibrationStatus": row.calibration_status,
        "createdAt": row.created_at.isoformat() if row.created_at is not None else None,
    }


def revision_payload(row: ASRRecognitionRevision) -> dict:
    return {
        "revisionId": row.id,
        "revisionNo": row.revision_no,
        "beforeSpeaker": row.before_speaker,
        "afterSpeaker": row.after_speaker,
        "beforeText": row.before_text,
        "afterText": row.after_text,
        "actorId": row.actor_id,
        "reason": row.reason,
        "createdAt": row.created_at.isoformat() if row.created_at is not None else None,
    }
