from __future__ import annotations

import os
import subprocess
import sys

import pytest
from sqlalchemy import create_engine, text

from app.database.migration_bootstrap import detect_legacy_baseline


BACKEND = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), "linux", "backend")


def _database_at_0003(tmp_path):
    db_file = tmp_path / "legacy.db"
    env = os.environ.copy()
    env["DATABASE_URL"] = f"sqlite:///{db_file}"
    result = subprocess.run(
        [sys.executable, "-m", "alembic", "-c", "alembic.ini", "upgrade", "0003_template_interrogation_workspace"],
        cwd=BACKEND,
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    return db_file


def test_detects_full_0003_legacy_schema_without_version_table(tmp_path):
    db_file = _database_at_0003(tmp_path)
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        with engine.begin() as connection:
            connection.execute(text("DROP TABLE alembic_version"))
        assert detect_legacy_baseline(db_file) == "0003_template_interrogation_workspace"
    finally:
        engine.dispose()


def test_promotes_failed_bootstrap_0001_marker_when_schema_is_really_0003(tmp_path):
    db_file = _database_at_0003(tmp_path)
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        with engine.begin() as connection:
            connection.execute(text("UPDATE alembic_version SET version_num='0001_linux_core_schema'"))
        assert detect_legacy_baseline(db_file) == "0003_template_interrogation_workspace"
    finally:
        engine.dispose()


def test_refuses_partial_legacy_0003_schema(tmp_path):
    db_file = _database_at_0003(tmp_path)
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        with engine.begin() as connection:
            connection.execute(text("DROP TABLE processed_speech_fragments"))
            connection.execute(text("DROP TABLE alembic_version"))
        with pytest.raises(RuntimeError, match="partial legacy migration schema"):
            detect_legacy_baseline(db_file)
    finally:
        engine.dispose()
