import os
import struct
import subprocess
import sys
from uuid import uuid4

from sqlalchemy import create_engine, inspect, text


CORE_TABLES = {
    "cases", "persons", "interrogation_sessions", "messages", "message_revisions",
    "facts", "timeline_events", "audit_logs", "device_events", "document_snapshots", "signature_records",
}
VOICEPRINT_TABLES = {
    "suspect_voiceprints", "officer_voiceprints", "session_voice_assignments", "asr_capture_sessions", "asr_fragments",
}
TEMPLATE_TABLES = {
    "standard_questions", "case_questions", "question_rounds", "pending_questions", "processed_speech_fragments",
}
OFFICER_LIBRARY_TABLES = {
    "officer_voice_profiles", "officer_voice_samples", "session_officer_voice_snapshots",
}
CALIBRATION_TABLES = {
    "speaker_device_calibrations", "session_speaker_calibration_snapshots",
}
RECOGNITION_EVIDENCE_TABLES = {
    "asr_recognition_evidence", "asr_recognition_revisions",
}
REQUIRED_TABLES = (
    CORE_TABLES | VOICEPRINT_TABLES | TEMPLATE_TABLES | OFFICER_LIBRARY_TABLES |
    CALIBRATION_TABLES | RECOGNITION_EVIDENCE_TABLES
)


def _run_alembic(tmp_path, target: str):
    db_file = tmp_path / "alembic.db"
    env = os.environ.copy()
    env["DATABASE_URL"] = f"sqlite:///{db_file}"
    result = subprocess.run(
        [sys.executable, "-m", "alembic", "-c", "alembic.ini", "upgrade", target],
        cwd=os.path.dirname(os.path.dirname(__file__)),
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )
    return db_file, env, result


def test_alembic_revision_0001_remains_core_only(tmp_path):
    db_file, _env, result = _run_alembic(tmp_path, "0001_linux_core_schema")
    assert result.returncode == 0, result.stdout + result.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        tables = set(inspect(engine).get_table_names())
        assert CORE_TABLES <= tables
        assert VOICEPRINT_TABLES.isdisjoint(tables)
        assert TEMPLATE_TABLES.isdisjoint(tables)
        assert OFFICER_LIBRARY_TABLES.isdisjoint(tables)
        assert CALIBRATION_TABLES.isdisjoint(tables)
        assert RECOGNITION_EVIDENCE_TABLES.isdisjoint(tables)
    finally:
        engine.dispose()


def test_alembic_revision_0002_remains_voiceprint_only(tmp_path):
    db_file, _env, result = _run_alembic(tmp_path, "0002_voiceprint_speech_pipeline")
    assert result.returncode == 0, result.stdout + result.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        tables = set(inspect(engine).get_table_names())
        assert CORE_TABLES | VOICEPRINT_TABLES <= tables
        assert TEMPLATE_TABLES.isdisjoint(tables)
        assert OFFICER_LIBRARY_TABLES.isdisjoint(tables)
        assert CALIBRATION_TABLES.isdisjoint(tables)
        assert RECOGNITION_EVIDENCE_TABLES.isdisjoint(tables)
        with engine.connect() as connection:
            revision = connection.execute(text("SELECT version_num FROM alembic_version")).scalar_one()
        assert revision == "0002_voiceprint_speech_pipeline"
    finally:
        engine.dispose()


def test_alembic_upgrade_head_builds_required_schema(tmp_path):
    db_file, _env, result = _run_alembic(tmp_path, "head")
    assert result.returncode == 0, result.stdout + result.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        inspector = inspect(engine)
        assert REQUIRED_TABLES <= set(inspector.get_table_names())
        evidence_columns = {item["name"] for item in inspector.get_columns("asr_recognition_evidence")}
        assert {
            "fragment_id", "ai_speaker", "score", "threshold", "margin", "threshold_source",
            "asr_model_version", "speaker_model_version", "speaker_model_fingerprint",
            "microphone_fingerprint", "calibration_id", "calibration_status",
        } <= evidence_columns
        revision_columns = {item["name"] for item in inspector.get_columns("asr_recognition_revisions")}
        assert {
            "fragment_id", "revision_no", "before_speaker", "after_speaker", "before_text",
            "after_text", "actor_id", "reason",
        } <= revision_columns
        with engine.connect() as connection:
            revision = connection.execute(text("SELECT version_num FROM alembic_version")).scalar_one()
        assert revision == "0006_asr_recognition_evidence"
    finally:
        engine.dispose()


def test_0004_migrates_legacy_officer_reference_and_freezes_existing_assignment(tmp_path):
    db_file, env, result = _run_alembic(tmp_path, "0003_template_interrogation_workspace")
    assert result.returncode == 0, result.stdout + result.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        now = "2026-08-31 00:00:00"
        embedding = struct.pack("<3f", 1.0, 0.0, 0.0)
        with engine.begin() as connection:
            connection.execute(text(
                "INSERT INTO cases (id, operator_id, case_type, suspect_name, gender, age, officer_name, workflow_state, stage, document_status, report_status, created_at, updated_at) "
                "VALUES ('CASE-M', NULL, 'suspect_interrogation', '嫌疑人', NULL, NULL, '测试警官', 'IDENTITY_REQUIRED', 'IDENTITY', 'DRAFT', 'PENDING', :now, :now)"
            ), {"now": now})
            connection.execute(text(
                "INSERT INTO interrogation_sessions (id, case_id, status, stage, started_at, paused_at, ended_at, created_at, updated_at) "
                "VALUES ('SESSION-M', 'CASE-M', 'READY', 'IDENTITY', NULL, NULL, NULL, :now, :now)"
            ), {"now": now})
            connection.execute(text(
                "INSERT INTO suspect_voiceprints (id, case_id, embedding, embedding_dim, model_id, model_version, enrollment_quality, usable_duration_ms, active, created_at, updated_at) "
                "VALUES ('SUS-M', 'CASE-M', :embedding, 3, 'xvector', 'v1', 'GOOD', 20000, 1, :now, :now)"
            ), {"embedding": embedding, "now": now})
            connection.execute(text(
                "INSERT INTO officer_voiceprints (id, officer_id, officer_name, embedding, embedding_dim, model_id, model_version, enrollment_quality, usable_duration_ms, active, revoked_at, created_at, updated_at) "
                "VALUES ('OFF-M', 'P-001', '张警官', :embedding, 3, 'xvector', 'v1', 'GOOD', 24000, 1, NULL, :now, :now)"
            ), {"embedding": embedding, "now": now})
            connection.execute(text(
                "INSERT INTO session_voice_assignments (id, session_id, suspect_voiceprint_id, interrogator_officer_id, interrogator_voiceprint_id, recorder_officer_id, recorder_voiceprint_id, recognition_mode, created_at, updated_at) "
                "VALUES (:id, 'SESSION-M', 'SUS-M', 'P-001', 'OFF-M', NULL, NULL, 'SUSPECT_PLUS_INTERROGATOR', :now, :now)"
            ), {"id": str(uuid4()), "now": now})
    finally:
        engine.dispose()

    result = subprocess.run(
        [sys.executable, "-m", "alembic", "-c", "alembic.ini", "upgrade", "head"],
        cwd=os.path.dirname(os.path.dirname(__file__)),
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )
    assert result.returncode == 0, result.stdout + result.stderr

    engine = create_engine(f"sqlite:///{db_file}")
    try:
        with engine.connect() as connection:
            profile = connection.execute(text(
                "SELECT id, officer_id, officer_name, sample_count, aggregate_version FROM officer_voice_profiles WHERE officer_id='P-001'"
            )).mappings().one()
            sample = connection.execute(text(
                "SELECT audio_source, active FROM officer_voice_samples WHERE profile_id=:profile_id"
            ), {"profile_id": profile["id"]}).mappings().one()
            snapshot = connection.execute(text(
                "SELECT officer_id, aggregate_version FROM session_officer_voice_snapshots WHERE session_id='SESSION-M' AND role='INTERROGATOR'"
            )).mappings().one()
        assert profile["officer_name"] == "张警官"
        assert profile["sample_count"] == 1
        assert profile["aggregate_version"] == 1
        assert sample["audio_source"] == "LEGACY_MIGRATED"
        assert bool(sample["active"]) is True
        assert snapshot["officer_id"] == "P-001"
        assert snapshot["aggregate_version"] == 1
    finally:
        engine.dispose()
