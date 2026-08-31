from __future__ import annotations

import inspect

from app.database.models import ASRFragment
from app.repositories import asr_fragments as asr_repo


REQUIRED_SPEAKER_EVIDENCE_COLUMNS = {
    "speaker_threshold_source",
    "speaker_model_id",
    "speaker_model_version",
}


def test_asr_fragment_persists_complete_speaker_recognition_evidence_contract():
    columns = set(ASRFragment.__table__.columns.keys())
    assert REQUIRED_SPEAKER_EVIDENCE_COLUMNS.issubset(columns)

    parameters = set(inspect.signature(asr_repo.create_fragment).parameters)
    assert REQUIRED_SPEAKER_EVIDENCE_COLUMNS.issubset(parameters)
