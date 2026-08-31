from __future__ import annotations

import json

from app.api.asr import FragmentUpdateRequest, update_fragment as update_fragment_api
from app.database.models import AuditLog
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import asr_fragments as asr_repo
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.repositories import speaker_calibrations as calibration_repo


def _seed(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'recognition-evidence.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = case_repo.create(db, {"id": "CASE-EVIDENCE", "suspectName": "张某", "officerName": "李警官"})
        session = session_repo.create(db, case.id)
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=session.id,
            sample_rate=16_000,
        )
        calibration_repo.create_session_snapshot(
            db,
            capture_session_id=capture.id,
            interrogation_session_id=session.id,
            calibration_id=None,
            threshold=0.78,
            margin=0.06,
            threshold_source="DEVICE_CALIBRATED",
            calibration_status="VALID",
            speaker_model_fingerprint="a" * 64,
            microphone_fingerprint="b" * 64,
        )
        fragment = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case.id,
            ordinal=0,
            started_at_ms=0,
            ended_at_ms=1600,
            raw_text="原始识别文本",
            asr_confidence=0.93,
            speaker="SUSPECT",
            speaker_id="suspect-vp-1",
            speaker_name="张某",
            speaker_score=0.91,
            second_best_score=0.61,
            speaker_threshold=0.78,
            speaker_margin=0.06,
            speaker_source="X_VECTOR",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="paraformer",
            model_version="asr-v3",
            speaker_threshold_source="DEVICE_CALIBRATED",
            speaker_model_id="xvector",
            speaker_model_version="sv-v2",
            speaker_model_fingerprint="a" * 64,
            microphone_fingerprint="b" * 64,
        )
        db.commit()
        return engine, factory, case.id, fragment.id


def test_every_fragment_records_immutable_ai_recognition_evidence(tmp_path):
    engine, factory, _, fragment_id = _seed(tmp_path)
    with factory() as db:
        audit = (
            db.query(AuditLog)
            .filter(AuditLog.target_id == fragment_id, AuditLog.action == "ASR_SPEAKER_DECISION")
            .one()
        )
        after = json.loads(audit.after_json)
        detail = json.loads(audit.detail_json)

        assert after == {
            "low_confidence": False,
            "speaker": "SUSPECT",
            "speaker_id": "suspect-vp-1",
            "speaker_name": "张某",
            "speaker_source": "X_VECTOR",
            "voiceprint_verified": True,
        }
        assert detail["score"] == 0.91
        assert detail["second_best_score"] == 0.61
        assert detail["threshold"] == 0.78
        assert detail["margin"] == 0.06
        assert detail["threshold_source"] == "DEVICE_CALIBRATED"
        assert detail["asr_model_id"] == "paraformer"
        assert detail["asr_model_version"] == "asr-v3"
        assert detail["speaker_model_id"] == "xvector"
        assert detail["speaker_model_version"] == "sv-v2"
        assert detail["speaker_model_fingerprint"] == "a" * 64
        assert detail["microphone_fingerprint"] == "b" * 64
    engine.dispose()


def test_manual_correction_keeps_original_ai_audit_and_adds_human_revision(tmp_path):
    engine, factory, case_id, fragment_id = _seed(tmp_path)
    with factory() as db:
        payload = update_fragment_api(
            case_id,
            fragment_id,
            FragmentUpdateRequest(
                edited_text="人工修订文本",
                speaker="INTERROGATOR",
                actor_id="officer-001",
            ),
            db,
        )
        assert payload["rawText"] == "原始识别文本"
        assert payload["editedText"] == "人工修订文本"
        assert payload["speaker"] == "INTERROGATOR"
        assert payload["speakerSource"] == "MANUAL"

    with factory() as db:
        audits = list(
            db.query(AuditLog)
            .filter(AuditLog.target_id == fragment_id)
            .order_by(AuditLog.created_at.asc(), AuditLog.id.asc())
        )
        actions = [row.action for row in audits]
        assert "ASR_SPEAKER_DECISION" in actions
        assert "ASR_FRAGMENT_UPDATE" in actions

        ai = next(row for row in audits if row.action == "ASR_SPEAKER_DECISION")
        manual = next(row for row in audits if row.action == "ASR_FRAGMENT_UPDATE")
        assert json.loads(ai.after_json)["speaker"] == "SUSPECT"

        before = json.loads(manual.before_json)
        after = json.loads(manual.after_json)
        assert before["speaker"] == "SUSPECT"
        assert before["speaker_source"] == "X_VECTOR"
        assert after["speaker"] == "INTERROGATOR"
        assert after["speaker_source"] == "MANUAL"
        assert manual.actor_id == "officer-001"
    engine.dispose()


def test_text_only_correction_preserves_original_speaker_evidence(tmp_path):
    engine, factory, case_id, fragment_id = _seed(tmp_path)
    with factory() as db:
        payload = update_fragment_api(
            case_id,
            fragment_id,
            FragmentUpdateRequest(
                edited_text="只修订文字",
                speaker="SUSPECT",
                actor_id="officer-002",
            ),
            db,
        )
        assert payload["editedText"] == "只修订文字"
        assert payload["speaker"] == "SUSPECT"
        assert payload["speakerId"] == "suspect-vp-1"
        assert payload["speakerName"] == "张某"
        assert payload["speakerSource"] == "X_VECTOR"
        assert payload["voiceprintVerified"] is True
        assert payload["lowConfidence"] is False

    with factory() as db:
        manual = (
            db.query(AuditLog)
            .filter(AuditLog.target_id == fragment_id, AuditLog.action == "ASR_FRAGMENT_UPDATE")
            .one()
        )
        before = json.loads(manual.before_json)
        after = json.loads(manual.after_json)
        detail = json.loads(manual.detail_json)
        assert before["speaker_source"] == "X_VECTOR"
        assert after["speaker_source"] == "X_VECTOR"
        assert detail["speaker_changed"] is False
        assert manual.actor_id == "officer-002"
    engine.dispose()
