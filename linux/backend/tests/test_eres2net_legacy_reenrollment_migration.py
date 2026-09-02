from __future__ import annotations

import os
import struct
import subprocess
import sys
from pathlib import Path

from sqlalchemy import create_engine, text


def test_legacy_xvector_voiceprints_are_preserved_but_require_reenrollment(tmp_path: Path) -> None:
    db_file = tmp_path / "legacy-voiceprint.db"
    env = os.environ | {"DATABASE_URL": f"sqlite:///{db_file}"}
    root = Path(__file__).resolve().parents[1]
    initial = subprocess.run(
        [sys.executable, "-m", "alembic", "-c", "alembic.ini", "upgrade", "0011_speaker_backend_comparison_evidence"],
        cwd=root,
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )
    assert initial.returncode == 0, initial.stdout + initial.stderr

    original = struct.pack("<3f", 0.25, 0.5, 0.75)
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        with engine.begin() as connection:
            connection.execute(text("INSERT INTO cases (id, case_type, suspect_name, officer_name, workflow_state, stage, document_status, report_status, created_at, updated_at) VALUES ('CASE-LEGACY', 'suspect_interrogation', '嫌疑人', '警官', 'IDENTITY_REQUIRED', 'IDENTITY', 'DRAFT', 'PENDING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"))
            connection.execute(text("INSERT INTO suspect_voiceprints (id, case_id, embedding, embedding_dim, model_key, model_id, model_version, enrollment_quality, usable_duration_ms, active, created_at, updated_at) VALUES ('SUS-LEGACY', 'CASE-LEGACY', :embedding, 3, 'xvector', 'xvector', 'legacy', 'GOOD', 22000, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"), {"embedding": original})
    finally:
        engine.dispose()

    upgraded = subprocess.run(
        [sys.executable, "-m", "alembic", "-c", "alembic.ini", "upgrade", "head"],
        cwd=root,
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )
    assert upgraded.returncode == 0, upgraded.stdout + upgraded.stderr
    engine = create_engine(f"sqlite:///{db_file}")
    try:
        with engine.connect() as connection:
            row = connection.execute(text("SELECT embedding, embedding_dim, model_key, enrollment_quality FROM suspect_voiceprints WHERE id='SUS-LEGACY'" )).mappings().one()
        assert bytes(row["embedding"]) == original
        assert row["embedding_dim"] == 3
        assert row["model_key"] == "xvector"
        assert row["enrollment_quality"] == "NEEDS_REENROLL"
    finally:
        engine.dispose()
