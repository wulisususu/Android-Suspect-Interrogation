import os
import subprocess
import sys

from sqlalchemy import create_engine, inspect, text


CORE_TABLES = {
    "cases", "persons", "interrogation_sessions", "messages", "message_revisions",
    "facts", "timeline_events", "audit_logs", "device_events", "document_snapshots", "signature_records",
}
VOICEPRINT_TABLES = {
    "suspect_voiceprints", "officer_voiceprints", "session_voice_assignments", "asr_capture_sessions", "asr_fragments",
}
REQUIRED_TABLES = CORE_TABLES | VOICEPRINT_TABLES


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
    finally:
        engine.dispose()


def test_alembic_upgrade_head_builds_required_schema(tmp_path):
    db_file, _env, result = _run_alembic(tmp_path, "head")
    assert result.returncode == 0, result.stdout + result.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        assert REQUIRED_TABLES <= set(inspect(engine).get_table_names())
        with engine.connect() as connection:
            revision = connection.execute(text("SELECT version_num FROM alembic_version")).scalar_one()
        assert revision == "0002_voiceprint_speech_pipeline"
    finally:
        engine.dispose()


def test_voiceprint_migration_downgrades_to_core_schema(tmp_path):
    db_file, env, result = _run_alembic(tmp_path, "head")
    assert result.returncode == 0, result.stdout + result.stderr
    downgrade = subprocess.run(
        [sys.executable, "-m", "alembic", "-c", "alembic.ini", "downgrade", "0001_linux_core_schema"],
        cwd=os.path.dirname(os.path.dirname(__file__)),
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )
    assert downgrade.returncode == 0, downgrade.stdout + downgrade.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        tables = set(inspect(engine).get_table_names())
        assert CORE_TABLES <= tables
        assert VOICEPRINT_TABLES.isdisjoint(tables)
    finally:
        engine.dispose()
