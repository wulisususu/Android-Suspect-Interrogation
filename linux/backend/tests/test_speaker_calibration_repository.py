from __future__ import annotations

from datetime import datetime, timedelta, timezone

from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import asr_fragments as asr_repo
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo


def test_calibration_history_is_append_only_and_snapshot_is_immutable(tmp_path):
    from app.repositories import speaker_calibrations as repo

    engine = make_engine(f"sqlite:///{tmp_path / 'calibration-repo.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    now = datetime.now(timezone.utc)

    payload = dict(
        status_at_creation="VALID",
        threshold=0.73,
        margin=0.08,
        far=0.0,
        frr=0.05,
        eer=0.04,
        eer_threshold=0.69,
        eer_far=0.04,
        eer_frr=0.04,
        genuine_trial_count=20,
        impostor_trial_count=40,
        officer_count=4,
        sample_count=12,
        corpus_digest="a" * 64,
        algorithm_version="speaker-calibration-v1",
        speaker_model_id="xvector",
        speaker_model_version="legacy",
        speaker_model_fingerprint="b" * 64,
        audio_source="ALSA",
        microphone_id="hw:1,0",
        microphone_name="USB Mic",
        microphone_fingerprint="c" * 64,
        microphone_fingerprint_certainty="STRONG",
        created_by="admin",
        created_at=now,
    )

    with factory() as db:
        first = repo.create_calibration(db, **payload)
        second = repo.create_calibration(
            db,
            **{
                **payload,
                "threshold": 0.75,
                "corpus_digest": "d" * 64,
                "created_at": now + timedelta(seconds=1),
            },
        )

        case = case_repo.create(
            db,
            {"id": "CASE-CAL-REPO", "suspectName": "测试嫌疑人", "officerName": "测试民警"},
        )
        interrogation = session_repo.create(db, case.id)
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=interrogation.id,
            sample_rate=16000,
        )
        db.commit()

        history = repo.list_calibrations(db)
        assert [item.id for item in history] == [second.id, first.id]
        assert repo.latest_calibration(db).id == second.id
        assert first.threshold == 0.73
        assert second.threshold == 0.75

        snapshot = repo.create_session_snapshot(
            db,
            capture_session_id=capture.id,
            interrogation_session_id=interrogation.id,
            calibration_id=second.id,
            threshold=0.75,
            margin=0.08,
            threshold_source="DEVICE_CALIBRATED",
            calibration_status="VALID",
            speaker_model_fingerprint="b" * 64,
            microphone_fingerprint="c" * 64,
        )
        db.commit()

        loaded = repo.get_session_snapshot(db, capture.id)
        assert loaded is not None
        assert loaded.id == snapshot.id
        assert loaded.calibration_id == second.id
        assert loaded.threshold == 0.75
        assert loaded.margin == 0.08
        assert loaded.threshold_source == "DEVICE_CALIBRATED"
        assert loaded.calibration_status == "VALID"

    engine.dispose()
