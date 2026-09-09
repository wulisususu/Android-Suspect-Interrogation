"""Task 16: MOSS interrogation-integration tables (models + alembic migration).

The MOSS business path owns exactly these tables; no existing realtime-ASR
table may gain MOSS columns. The migration follows the repository subprocess
pattern used by ``tests/test_migrations.py`` (temporary-file sqlite).
"""
import os
import subprocess
import sys
from pathlib import Path

from sqlalchemy import create_engine, inspect, text

from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import cases as case_repo


MOSS_TABLES = {"moss_transcriptions", "moss_transcription_revisions", "moss_speaker_mappings"}
ALEMBIC_HEAD = "0013_moss_transcription_integration"


def _run_alembic(tmp_path: Path, target: str):
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


def test_orm_create_all_builds_moss_tables_and_roundtrips(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'orm.db'}")
    try:
        init_database(engine)
        inspector = inspect(engine)
        assert MOSS_TABLES <= set(inspector.get_table_names())

        factory = make_session_factory(engine)
        with factory() as db:
            case = case_repo.create(db, {"id": "CASE-MOSS", "suspectName": "张某", "officerName": "李警官"})
            db.commit()
            assert case.id == "CASE-MOSS"

            from app.database.moss_models import (
                MossSpeakerMapping,
                MossTranscription,
                MossTranscriptionRevision,
            )

            row = MossTranscription(
                id="MT-1", case_id="CASE-MOSS",
                audio_path="D:/evidence/audio.wav", audio_sha256="a" * 64,
                job_id="job-1", model_manifest_sha256="manifest",
                state="QUEUED", error=None, windows_json="[]",
            )
            revision = MossTranscriptionRevision(
                id="MTR-1", transcription_id="MT-1", case_id="CASE-MOSS",
                job_id="job-1", revision_no=1,
                audio_sha256="a" * 64, model_manifest_sha256="manifest",
                segments_json="[]", provenance_json="[]", mapping_snapshot_json="{}",
            )
            mapping = MossSpeakerMapping(
                id="MSM-1", case_id="CASE-MOSS", global_speaker="GS01", role="民警",
            )
            db.add_all([row, revision, mapping])
            db.commit()

        with factory() as db:
            from app.database.moss_models import (
                MossSpeakerMapping,
                MossTranscription,
                MossTranscriptionRevision,
            )

            loaded = db.get(MossTranscription, "MT-1")
            assert loaded.case_id == "CASE-MOSS"
            assert loaded.audio_sha256 == "a" * 64
            assert loaded.revisions[0].id == "MTR-1"
            assert loaded.revisions[0].revision_no == 1
            assert db.get(MossSpeakerMapping, "MSM-1").role == "民警"
    finally:
        engine.dispose()


def test_alembic_upgrade_head_creates_moss_tables(tmp_path):
    db_file, _env, result = _run_alembic(tmp_path, "head")
    assert result.returncode == 0, result.stdout + result.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        inspector = inspect(engine)
        assert MOSS_TABLES <= set(inspector.get_table_names())
        transcription_columns = {c["name"] for c in inspector.get_columns("moss_transcriptions")}
        assert {
            "id", "case_id", "audio_path", "audio_sha256", "job_id",
            "model_manifest_sha256", "state", "error", "windows_json",
            "created_at", "updated_at",
        } <= transcription_columns
        revision_columns = {c["name"] for c in inspector.get_columns("moss_transcription_revisions")}
        assert {
            "id", "transcription_id", "case_id", "job_id", "revision_no",
            "audio_sha256", "model_manifest_sha256",
            "segments_json", "provenance_json", "mapping_snapshot_json", "created_at",
        } <= revision_columns
        mapping_columns = {c["name"] for c in inspector.get_columns("moss_speaker_mappings")}
        assert {"id", "case_id", "global_speaker", "role", "created_at", "updated_at"} <= mapping_columns
        with engine.connect() as connection:
            revision = connection.execute(text("SELECT version_num FROM alembic_version")).scalar_one()
        assert revision == ALEMBIC_HEAD
    finally:
        engine.dispose()


def test_alembic_0012_does_not_create_moss_tables(tmp_path):
    db_file, _env, result = _run_alembic(tmp_path, "0012_mark_xvector_voiceprints_for_reenrollment")
    assert result.returncode == 0, result.stdout + result.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        assert MOSS_TABLES.isdisjoint(set(inspect(engine).get_table_names()))
    finally:
        engine.dispose()
