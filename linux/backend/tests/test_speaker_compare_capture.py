from __future__ import annotations

import struct

from app.ai.speech.types import SpeechEvent, SpeechEventType
from app.database.models import ASRFragment
from app.database.recognition_models import ASRRecognitionEvidence
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import asr_fragments as asr_repo
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.repositories import speaker_calibrations as calibration_repo
from app.repositories import speaker_compare_evidence as compare_repo
from app.repositories import voiceprints as voiceprint_repo
from app.services.asr_capture_service import AsrCaptureService, _CaptureRuntime
from app.services.speaker_calibration_runtime import ResolvedSpeakerCalibration


def _embedding(*values: float) -> bytes:
    return struct.pack(f"<{len(values)}f", *values)


def _seed(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'compare-capture.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = case_repo.create(
            db,
            {"id": "CASE-COMPARE-CAPTURE", "suspectName": "测试嫌疑人", "officerName": "测试民警"},
        )
        interrogation = session_repo.create(db, case.id)
        voiceprint_repo.enroll_suspect(
            db,
            case_id=case.id,
            model_key="xvector",
            embedding=_embedding(1.0, 0.0),
            embedding_dim=2,
            model_id="xvector-model",
            model_version="xv-v1",
            enrollment_quality="TEST",
            usable_duration_ms=20_000,
        )
        voiceprint_repo.enroll_suspect(
            db,
            case_id=case.id,
            model_key="eres2net_large",
            embedding=_embedding(0.0, 1.0),
            embedding_dim=2,
            model_id="eres-model",
            model_version="eres-v1",
            enrollment_quality="TEST",
            usable_duration_ms=20_000,
        )
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=interrogation.id,
            sample_rate=16_000,
        )
        calibration_repo.create_session_snapshot(
            db,
            capture_session_id=capture.id,
            interrogation_session_id=interrogation.id,
            calibration_id=None,
            threshold=0.80,
            margin=None,
            threshold_source="DEVICE_CALIBRATED",
            calibration_status="VALID",
            speaker_backend_key="xvector",
            speaker_model_fingerprint="a" * 64,
            microphone_fingerprint="c" * 64,
        )
        db.commit()
        return engine, factory, case.id, interrogation.id, capture.id


def _secondary_calibration() -> ResolvedSpeakerCalibration:
    return ResolvedSpeakerCalibration(
        calibration_id="CAL-E",
        threshold=0.80,
        margin=None,
        source="DEVICE_CALIBRATED",
        status="VALID",
        speaker_model_fingerprint="b" * 64,
        microphone_fingerprint="c" * 64,
        speaker_backend_key="eres2net_large",
    )


def _service(factory) -> AsrCaptureService:
    return AsrCaptureService(
        session_factory=factory,
        device_manager=object(),
        ai_supervisor=object(),
        publish_event=lambda *_args: None,
        speaker_model_key="compare",
        speaker_authoritative_backend="xvector",
    )


def _runtime(case_id: str, interrogation_id: str, capture_id: str) -> _CaptureRuntime:
    return _CaptureRuntime(
        case_id=case_id,
        interrogation_session_id=interrogation_id,
        capture_session_id=capture_id,
        speech_session_id=capture_id,
        speaker_threshold=0.80,
        speaker_margin=None,
        threshold_source="DEVICE_CALIBRATED",
        calibration_id="CAL-X",
        calibration_status="VALID",
        speaker_model_fingerprint="a" * 64,
        microphone_fingerprint="c" * 64,
        authoritative_speaker_backend="xvector",
        secondary_speaker_backend="eres2net_large",
        secondary_calibration=_secondary_calibration(),
    )


def _asr(*, speaker_unavailable: bool = False) -> SpeechEvent:
    details = {"model_version": "asr-v1"}
    if speaker_unavailable:
        details.update(
            {
                "speaker_unavailable": True,
                "speaker_error_code": "BACKEND_UNAVAILABLE",
                "speaker_backend_key": "xvector",
            }
        )
    return SpeechEvent(
        type=SpeechEventType.ASR_FINAL,
        session_id="speech",
        start_ms=0,
        end_ms=1500,
        text="我是测试嫌疑人",
        confidence=0.95,
        model_id="paraformer",
        details=details,
    )


def _speaker(event_type: SpeechEventType, backend: str, embedding: list[float]) -> SpeechEvent:
    return SpeechEvent(
        type=event_type,
        session_id="speech",
        start_ms=0,
        end_ms=1500,
        embedding=embedding,
        model_id=f"model-{backend}",
        details={
            "backend_key": backend,
            "model_version": "v1",
            "model_fingerprint": ("a" if backend == "xvector" else "b") * 64,
            "latency_ms": 9.0 if backend == "xvector" else 21.0,
            **({"diagnostic_only": True} if event_type is SpeechEventType.SPEAKER_COMPARE_RESULT else {}),
        },
    )


def test_secondary_disagreement_is_persisted_but_cannot_mutate_authoritative_fragment(tmp_path):
    engine, factory, case_id, interrogation_id, capture_id = _seed(tmp_path)
    service = _service(factory)
    runtime = _runtime(case_id, interrogation_id, capture_id)

    service._consume_events(
        runtime,
        [
            _asr(),
            _speaker(SpeechEventType.SPEAKER_RESULT, "xvector", [1.0, 0.0]),
            _speaker(SpeechEventType.SPEAKER_COMPARE_RESULT, "eres2net_large", [1.0, 0.0]),
        ],
    )

    with factory() as db:
        fragment = db.query(ASRFragment).one()
        assert fragment.speaker == "SUSPECT"
        assert fragment.voiceprint_verified is True
        assert db.query(ASRRecognitionEvidence).filter_by(fragment_id=fragment.id).count() == 1

        rows = compare_repo.list_for_fragment(db, fragment.id)
        assert len(rows) == 2
        assert rows[0].backend_key == "xvector"
        assert rows[0].authoritative is True
        assert rows[0].role == "SUSPECT"
        assert rows[0].score == 1.0
        assert rows[1].backend_key == "eres2net_large"
        assert rows[1].authoritative is False
        assert rows[1].role == "OFFICER_FALLBACK"
        assert rows[1].score == 0.0
        assert rows[1].latency_ms == 21.0
        assert '\"role\":\"SUSPECT\"' in rows[1].candidate_scores_json

    engine.dispose()


def test_authoritative_failure_keeps_fragment_unknown_even_when_secondary_matches(tmp_path):
    engine, factory, case_id, interrogation_id, capture_id = _seed(tmp_path)
    service = _service(factory)
    runtime = _runtime(case_id, interrogation_id, capture_id)

    service._consume_events(
        runtime,
        [
            _asr(speaker_unavailable=True),
            _speaker(SpeechEventType.SPEAKER_COMPARE_RESULT, "eres2net_large", [0.0, 1.0]),
        ],
    )

    with factory() as db:
        fragment = db.query(ASRFragment).one()
        assert fragment.speaker == "UNKNOWN"
        assert fragment.voiceprint_verified is False
        assert db.query(ASRRecognitionEvidence).filter_by(fragment_id=fragment.id).count() == 1

        rows = compare_repo.list_for_fragment(db, fragment.id)
        assert len(rows) == 2
        assert rows[0].backend_key == "xvector"
        assert rows[0].authoritative is True
        assert rows[0].available is False
        assert rows[0].role == "UNKNOWN"
        assert rows[0].error_code == "BACKEND_UNAVAILABLE"
        assert rows[1].backend_key == "eres2net_large"
        assert rows[1].authoritative is False
        assert rows[1].role == "SUSPECT"
        assert rows[1].voiceprint_verified is True

    engine.dispose()
