from __future__ import annotations

import struct
from uuid import uuid4

from sqlalchemy.orm import Session

from app.database.session import init_database, make_engine
from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample
from app.services.speaker_calibration_service import (
    CalibrationStatus,
    CurrentMicrophoneIdentity,
    CurrentSpeakerModelIdentity,
    SpeakerCalibrationService,
)


MODEL_FP = "a" * 64
MIC_FP = "b" * 64


def _vector(axis: int, offset: float) -> bytes:
    values = [0.01, 0.01, 0.01]
    values[axis] = 1.0
    values[(axis + 1) % 3] += offset
    return struct.pack("<3f", *values)


def _seed_officer(db: Session, officer_id: str, axis: int, count: int = 3) -> None:
    profile = OfficerVoiceProfile(
        id=str(uuid4()), officer_id=officer_id, officer_name=officer_id,
        aggregate_embedding=_vector(axis, 0.0), embedding_dim=3,
        model_id="xvector", model_version="v1", aggregate_version=1,
        sample_count=count, active=True, revoked_at=None,
    )
    db.add(profile)
    db.flush()
    for index in range(count):
        db.add(OfficerVoiceSample(
            id=str(uuid4()), profile_id=profile.id, embedding=_vector(axis, (index - 1) * 0.03),
            embedding_dim=3, model_id="xvector", model_version="v1", model_fingerprint=MODEL_FP,
            quality="GOOD", usable_duration_ms=22_000, segment_count=3, audio_source="ALSA",
            device_id="hw:1,0", device_name="USB Mic", microphone_fingerprint=MIC_FP,
            microphone_fingerprint_certainty="STRONG", active=True,
        ))
    db.flush()


def _service(db: Session, *, model_fp: str = MODEL_FP, mic_fp: str = MIC_FP):
    return SpeakerCalibrationService(
        db,
        model_provider=lambda: CurrentSpeakerModelIdentity("xvector", "v1", model_fp),
        microphone_provider=lambda: CurrentMicrophoneIdentity("ALSA", "hw:1,0", "USB Mic", mic_fp, "STRONG"),
    )


def test_recompute_creates_valid_calibration_and_model_or_mic_change_expires_it(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path/'calibration.db'}")
    init_database(engine)
    db = Session(engine)
    try:
        for officer, axis in (("P1", 0), ("P2", 1), ("P3", 2)):
            _seed_officer(db, officer, axis)
        db.commit()

        service = _service(db)
        assert service.status()["status"] == CalibrationStatus.NOT_CALIBRATED.value
        created = service.recompute(actor_id="admin")
        assert created["status"] == CalibrationStatus.VALID.value
        assert created["calibration"]["far"] >= 0.0
        assert created["calibration"]["frr"] >= 0.0
        assert created["calibration"]["eer"] >= 0.0
        assert created["calibration"]["speakerModelFingerprint"] == MODEL_FP
        assert created["calibration"]["microphoneFingerprint"] == MIC_FP

        assert _service(db, model_fp="c" * 64).status()["status"] == CalibrationStatus.STALE_MODEL.value
        assert _service(db, mic_fp="d" * 64).status()["status"] == CalibrationStatus.STALE_MIC.value
    finally:
        db.close(); engine.dispose()


def test_material_corpus_growth_recommends_recompute_but_old_calibration_remains_usable(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path/'growth.db'}")
    init_database(engine)
    db = Session(engine)
    try:
        for officer, axis in (("P1", 0), ("P2", 1), ("P3", 2)):
            _seed_officer(db, officer, axis)
        db.commit()
        service = _service(db)
        service.recompute()
        assert service.status()["status"] == CalibrationStatus.VALID.value

        # +3 compatible samples reaches the advisory threshold.
        p1 = db.query(OfficerVoiceProfile).filter_by(officer_id="P1").one()
        for index in range(3):
            db.add(OfficerVoiceSample(
                id=str(uuid4()), profile_id=p1.id, embedding=_vector(0, 0.04 + index * 0.01), embedding_dim=3,
                model_id="xvector", model_version="v1", model_fingerprint=MODEL_FP, quality="GOOD",
                usable_duration_ms=21_000, segment_count=3, audio_source="ALSA", device_id="hw:1,0",
                device_name="USB Mic", microphone_fingerprint=MIC_FP,
                microphone_fingerprint_certainty="STRONG", active=True,
            ))
        db.commit()
        state = service.status()
        assert state["status"] == CalibrationStatus.RECOMPUTE_RECOMMENDED.value
        assert state["calibrationUsable"] is True
    finally:
        db.close(); engine.dispose()


def test_current_compatible_corpus_below_minimum_is_insufficient_after_history_exists(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path/'insufficient.db'}")
    init_database(engine)
    db = Session(engine)
    try:
        for officer, axis in (("P1", 0), ("P2", 1), ("P3", 2)):
            _seed_officer(db, officer, axis)
        db.commit()
        service = _service(db)
        service.recompute()

        p3 = db.query(OfficerVoiceProfile).filter_by(officer_id="P3").one()
        for sample in db.query(OfficerVoiceSample).filter_by(profile_id=p3.id).all():
            sample.active = False
        db.commit()

        state = service.status()
        assert state["status"] == CalibrationStatus.INSUFFICIENT_DATA.value
        assert state["calibrationUsable"] is False
    finally:
        db.close(); engine.dispose()
