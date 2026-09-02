from __future__ import annotations

from sqlalchemy import inspect

from app.database.recognition_models import ASRRecognitionEvidence, SpeakerBackendComparisonEvidence
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import asr_fragments as asr_repo
from app.repositories import cases as case_repo
from app.repositories import recognition_evidence as recognition_repo
from app.repositories import sessions as session_repo
from app.repositories import speaker_compare_evidence as compare_repo


def _fragment(factory):
    with factory() as db:
        case = case_repo.create(
            db,
            {"id": "CASE-COMPARE-EVIDENCE", "suspectName": "测试嫌疑人", "officerName": "测试民警"},
        )
        interrogation = session_repo.create(db, case.id)
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=interrogation.id,
            sample_rate=16_000,
        )
        fragment = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case.id,
            ordinal=0,
            started_at_ms=0,
            ended_at_ms=1500,
            raw_text="我是测试嫌疑人",
            speaker="SUSPECT",
            speaker_source="SPEAKER_EMBEDDING",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="paraformer",
            model_version="asr-v1",
            speaker_score=0.93,
            second_best_score=0.31,
            speaker_threshold=0.78,
            speaker_margin=0.06,
            speaker_threshold_source="DEVICE_CALIBRATED",
            speaker_model_id="xvector-model",
            speaker_model_version="xv-v1",
            speaker_model_fingerprint="a" * 64,
            microphone_fingerprint="c" * 64,
        )
        db.commit()
        return case.id, capture.id, fragment.id


def _create_compare_row(
    db,
    *,
    fragment_id: str,
    capture_session_id: str,
    case_id: str,
    backend_key: str,
    authoritative: bool,
    role: str,
    score: float | None,
    latency_ms: float | None,
    error_code: str | None = None,
):
    return compare_repo.create_evidence(
        db,
        fragment_id=fragment_id,
        capture_session_id=capture_session_id,
        case_id=case_id,
        backend_key=backend_key,
        authoritative=authoritative,
        available=error_code is None,
        role=role,
        speaker_source="SPEAKER_EMBEDDING" if error_code is None else "UNASSIGNED",
        voiceprint_verified=error_code is None,
        score=score,
        second_best_score=0.31 if score is not None else None,
        threshold=0.78,
        margin=0.06,
        calibration_id=f"CAL-{backend_key}",
        calibration_status="VALID",
        model_id=f"model-{backend_key}",
        model_version="v1",
        model_fingerprint=("a" if backend_key == "xvector" else "b") * 64,
        latency_ms=latency_ms,
        error_code=error_code,
        candidate_scores=[
            {"role": "SUSPECT", "score": score},
            {"role": "INTERROGATOR", "score": 0.31},
        ] if score is not None else [],
    )


def test_compare_evidence_is_separate_from_single_authoritative_recognition_evidence(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'compare-evidence.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    case_id, capture_id, fragment_id = _fragment(factory)

    with factory() as db:
        _create_compare_row(
            db,
            fragment_id=fragment_id,
            capture_session_id=capture_id,
            case_id=case_id,
            backend_key="xvector",
            authoritative=True,
            role="SUSPECT",
            score=0.93,
            latency_ms=9.0,
        )
        _create_compare_row(
            db,
            fragment_id=fragment_id,
            capture_session_id=capture_id,
            case_id=case_id,
            backend_key="eres2net_large",
            authoritative=False,
            role="INTERROGATOR",
            score=0.88,
            latency_ms=21.0,
        )
        db.commit()

        rows = compare_repo.list_for_fragment(db, fragment_id)
        assert [row.backend_key for row in rows] == ["xvector", "eres2net_large"]
        assert [row.authoritative for row in rows] == [True, False]
        assert rows[0].role == "SUSPECT"
        assert rows[1].role == "INTERROGATOR"
        assert rows[1].latency_ms == 21.0
        assert rows[1].candidate_scores_json

        authoritative = recognition_repo.get_evidence(db, fragment_id)
        assert authoritative is not None
        assert authoritative.ai_speaker == "SUSPECT"
        assert db.query(ASRRecognitionEvidence).filter_by(fragment_id=fragment_id).count() == 1
        assert db.query(SpeakerBackendComparisonEvidence).filter_by(fragment_id=fragment_id).count() == 2

    columns = {item["name"] for item in inspect(engine).get_columns("speaker_backend_comparison_evidence")}
    assert "embedding" not in columns
    assert "pcm" not in columns
    assert "audio" not in columns
    engine.dispose()


def test_secondary_failure_is_persisted_as_diagnostic_without_biometric_payload(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'compare-failure.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    case_id, capture_id, fragment_id = _fragment(factory)

    with factory() as db:
        _create_compare_row(
            db,
            fragment_id=fragment_id,
            capture_session_id=capture_id,
            case_id=case_id,
            backend_key="xvector",
            authoritative=True,
            role="SUSPECT",
            score=0.93,
            latency_ms=9.0,
        )
        secondary = _create_compare_row(
            db,
            fragment_id=fragment_id,
            capture_session_id=capture_id,
            case_id=case_id,
            backend_key="eres2net_large",
            authoritative=False,
            role="UNKNOWN",
            score=None,
            latency_ms=None,
            error_code="BACKEND_UNAVAILABLE",
        )
        db.commit()

        assert secondary.available is False
        assert secondary.error_code == "BACKEND_UNAVAILABLE"
        assert secondary.score is None
        assert secondary.candidate_scores_json == "[]"

        authoritative = recognition_repo.get_evidence(db, fragment_id)
        assert authoritative is not None
        assert authoritative.ai_speaker == "SUSPECT"

    engine.dispose()
