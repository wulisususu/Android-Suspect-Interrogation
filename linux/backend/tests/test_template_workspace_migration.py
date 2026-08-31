from __future__ import annotations

import os
import subprocess
import sys

from sqlalchemy import create_engine, inspect, text

from app.database.models import (
    CaseQuestion,
    PendingQuestion,
    ProcessedSpeechFragment,
    QuestionRound,
    StandardQuestion,
)


TEMPLATE_TABLES = {
    "standard_questions",
    "case_questions",
    "question_rounds",
    "pending_questions",
    "processed_speech_fragments",
}


def _run_alembic(tmp_path, action: str, target: str):
    db_file = tmp_path / "template-workspace.db"
    env = os.environ.copy()
    env["DATABASE_URL"] = f"sqlite:///{db_file}"
    result = subprocess.run(
        [sys.executable, "-m", "alembic", "-c", "alembic.ini", action, target],
        cwd=os.path.dirname(os.path.dirname(__file__)),
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )
    return db_file, env, result


def test_template_workspace_models_are_importable():
    assert StandardQuestion.__tablename__ == "standard_questions"
    assert CaseQuestion.__tablename__ == "case_questions"
    assert QuestionRound.__tablename__ == "question_rounds"
    assert PendingQuestion.__tablename__ == "pending_questions"
    assert ProcessedSpeechFragment.__tablename__ == "processed_speech_fragments"


def test_0003_creates_template_workspace_tables(tmp_path):
    # This is a revision-specific contract. Keep it pinned to 0003 even when
    # newer migrations are added after the template workspace feature.
    db_file, _env, result = _run_alembic(tmp_path, "upgrade", "0003_template_interrogation_workspace")
    assert result.returncode == 0, result.stdout + result.stderr

    engine = create_engine(f"sqlite:///{db_file}")
    try:
        tables = set(inspect(engine).get_table_names())
        assert TEMPLATE_TABLES <= tables
        with engine.connect() as connection:
            revision = connection.execute(text("SELECT version_num FROM alembic_version")).scalar_one()
        assert revision == "0003_template_interrogation_workspace"
    finally:
        engine.dispose()


def test_0003_downgrade_removes_only_template_workspace_tables(tmp_path):
    db_file, env, upgrade = _run_alembic(tmp_path, "upgrade", "head")
    assert upgrade.returncode == 0, upgrade.stdout + upgrade.stderr

    downgrade = subprocess.run(
        [
            sys.executable,
            "-m",
            "alembic",
            "-c",
            "alembic.ini",
            "downgrade",
            "0002_voiceprint_speech_pipeline",
        ],
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
        assert TEMPLATE_TABLES.isdisjoint(tables)
        assert "asr_fragments" in tables
        with engine.connect() as connection:
            revision = connection.execute(text("SELECT version_num FROM alembic_version")).scalar_one()
        assert revision == "0002_voiceprint_speech_pipeline"
    finally:
        engine.dispose()
