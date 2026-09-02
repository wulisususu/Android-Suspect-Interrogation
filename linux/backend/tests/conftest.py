from __future__ import annotations

import struct

import pytest

from app.repositories import voiceprints as voiceprint_repo


_TEST_EMBEDDING = struct.pack("<4f", 1.0, 0.0, 0.0, 0.0)


@pytest.fixture
def enroll_test_suspect_voiceprint():
    """Explicitly satisfy the mandatory suspect-voiceprint prerequisite in unrelated tests."""

    def enroll(target, case_id: str) -> None:
        owns_session = hasattr(target, "state") and hasattr(target.state, "session_factory")
        db = target.state.session_factory() if owns_session else target
        try:
            if voiceprint_repo.get_suspect(db, case_id) is None:
                voiceprint_repo.enroll_suspect(
                    db,
                    case_id=case_id,
                    model_key="eres2net_large",
                    embedding=_TEST_EMBEDDING,
                    embedding_dim=4,
                    model_id="test-eres2net-large",
                    model_version="fixture",
                    enrollment_quality="TEST_FIXTURE",
                    usable_duration_ms=20_000,
                )
                db.commit()
        finally:
            if owns_session:
                db.close()

    return enroll
