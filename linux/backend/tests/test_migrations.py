import os
import subprocess
import sys

from sqlalchemy import create_engine, inspect


REQUIRED_TABLES = {
    "cases", "persons", "interrogation_sessions", "messages", "message_revisions",
    "facts", "timeline_events", "audit_logs", "device_events", "document_snapshots", "signature_records",
    "suspect_voiceprints", "officer_voiceprints", "session_voice_assignments", "asr_capture_sessions", "asr_fragments",
}


def test_alembic_upgrade_head_builds_required_schema(tmp_path):
    db_file = tmp_path / "alembic.db"
    env = os.environ.copy()
    env["DATABASE_URL"] = f"sqlite:///{db_file}"
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
        assert REQUIRED_TABLES <= set(inspect(engine).get_table_names())
    finally:
        engine.dispose()
