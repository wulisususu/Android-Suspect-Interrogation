from __future__ import annotations

from datetime import datetime
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.voiceprint_models import SpeakerDeviceCalibration, SessionSpeakerCalibrationSnapshot


def create_calibration(
    db: Session,
    *,
    status_at_creation: str,
    threshold: float,
    margin: float | None,
    far: float,
    frr: float,
    eer: float,
    eer_threshold: float,
    eer_far: float,
    eer_frr: float,
    genuine_trial_count: int,
    impostor_trial_count: int,
    officer_count: int,
    sample_count: int,
    corpus_digest: str,
    algorithm_version: str,
    speaker_backend_key: str = "eres2net_large",
    speaker_model_id: str,
    speaker_model_version: str | None,
    speaker_model_fingerprint: str,
    audio_source: str,
    microphone_id: str,
    microphone_name: str,
    microphone_fingerprint: str,
    microphone_fingerprint_certainty: str,
    created_by: str | None = None,
    created_at: datetime | None = None,
) -> SpeakerDeviceCalibration:
    values = {
        "id": str(uuid4()),
        "status_at_creation": str(status_at_creation),
        "threshold": float(threshold),
        "margin": None if margin is None else float(margin),
        "far": float(far),
        "frr": float(frr),
        "eer": float(eer),
        "eer_threshold": float(eer_threshold),
        "eer_far": float(eer_far),
        "eer_frr": float(eer_frr),
        "genuine_trial_count": int(genuine_trial_count),
        "impostor_trial_count": int(impostor_trial_count),
        "officer_count": int(officer_count),
        "sample_count": int(sample_count),
        "corpus_digest": str(corpus_digest),
        "algorithm_version": str(algorithm_version),
        "speaker_backend_key": str(speaker_backend_key or "eres2net_large").strip().lower(),
        "speaker_model_id": str(speaker_model_id),
        "speaker_model_version": None if speaker_model_version is None else str(speaker_model_version),
        "speaker_model_fingerprint": str(speaker_model_fingerprint),
        "audio_source": str(audio_source),
        "microphone_id": str(microphone_id),
        "microphone_name": str(microphone_name),
        "microphone_fingerprint": str(microphone_fingerprint),
        "microphone_fingerprint_certainty": str(microphone_fingerprint_certainty),
        "created_by": None if created_by is None else str(created_by),
    }
    if created_at is not None:
        values["created_at"] = created_at
    row = SpeakerDeviceCalibration(**values)
    db.add(row)
    db.flush()
    return row


def latest_calibration(
    db: Session,
    *,
    speaker_backend_key: str | None = None,
    speaker_model_fingerprint: str | None = None,
    microphone_fingerprint: str | None = None,
) -> SpeakerDeviceCalibration | None:
    query = select(SpeakerDeviceCalibration)
    if speaker_backend_key is not None:
        query = query.where(
            SpeakerDeviceCalibration.speaker_backend_key == str(speaker_backend_key).strip().lower()
        )
    if speaker_model_fingerprint is not None:
        query = query.where(
            SpeakerDeviceCalibration.speaker_model_fingerprint == str(speaker_model_fingerprint)
        )
    if microphone_fingerprint is not None:
        query = query.where(
            SpeakerDeviceCalibration.microphone_fingerprint == str(microphone_fingerprint)
        )
    return db.scalars(
        query.order_by(SpeakerDeviceCalibration.created_at.desc(), SpeakerDeviceCalibration.id.desc()).limit(1)
    ).first()


def list_calibrations(
    db: Session,
    *,
    limit: int = 100,
    speaker_backend_key: str | None = None,
) -> list[SpeakerDeviceCalibration]:
    query = select(SpeakerDeviceCalibration)
    if speaker_backend_key is not None:
        query = query.where(
            SpeakerDeviceCalibration.speaker_backend_key == str(speaker_backend_key).strip().lower()
        )
    return list(
        db.scalars(
            query.order_by(SpeakerDeviceCalibration.created_at.desc(), SpeakerDeviceCalibration.id.desc())
            .limit(max(1, int(limit)))
        )
    )


def create_session_snapshot(
    db: Session,
    *,
    capture_session_id: str,
    interrogation_session_id: str | None,
    calibration_id: str | None,
    threshold: float,
    margin: float | None,
    threshold_source: str,
    calibration_status: str,
    speaker_backend_key: str = "eres2net_large",
    speaker_model_fingerprint: str | None,
    microphone_fingerprint: str | None,
) -> SessionSpeakerCalibrationSnapshot:
    row = SessionSpeakerCalibrationSnapshot(
        id=str(uuid4()),
        capture_session_id=str(capture_session_id),
        interrogation_session_id=(None if interrogation_session_id is None else str(interrogation_session_id)),
        calibration_id=(None if calibration_id is None else str(calibration_id)),
        threshold=float(threshold),
        margin=None if margin is None else float(margin),
        threshold_source=str(threshold_source),
        calibration_status=str(calibration_status),
        speaker_backend_key=str(speaker_backend_key or "eres2net_large").strip().lower(),
        speaker_model_fingerprint=(
            None if speaker_model_fingerprint is None else str(speaker_model_fingerprint)
        ),
        microphone_fingerprint=(None if microphone_fingerprint is None else str(microphone_fingerprint)),
    )
    db.add(row)
    db.flush()
    return row


def get_session_snapshot(db: Session, capture_session_id: str) -> SessionSpeakerCalibrationSnapshot | None:
    return db.scalar(
        select(SessionSpeakerCalibrationSnapshot).where(
            SessionSpeakerCalibrationSnapshot.capture_session_id == str(capture_session_id)
        )
    )
