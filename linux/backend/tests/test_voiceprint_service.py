import math
import struct

import pytest
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import AuditLog, Case, SuspectVoiceprint
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.services.voiceprint_service import VoiceprintService


SAMPLE_RATE = 16000


def make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'voiceprint-service.sqlite3'}")
    init_database(engine)
    db = Session(engine)
    db.add(Case(id="CASE-1", officer_name="测试警官"))
    db.commit()
    return engine, db


def pcm16(duration_ms: int, sample: int = 1200) -> bytes:
    samples = duration_ms * SAMPLE_RATE // 1000
    return struct.pack(f"<{samples}h", *([sample] * samples))


def clipped_pcm16(duration_ms: int) -> bytes:
    samples = duration_ms * SAMPLE_RATE // 1000
    clipped = max(1, samples // 10)
    values = [32767] * clipped + [1200] * (samples - clipped)
    return struct.pack(f"<{samples}h", *values)


class FakeSpeechClient:
    def __init__(self, segments, embeddings=None):
        self.segments = segments
        self.embeddings = list(embeddings or [[1.0, 0.0, 0.0]])
        self.segment_calls = 0
        self.embedding_calls = 0

    def speech_segments(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        assert pcm
        assert sample_rate == SAMPLE_RATE
        self.segment_calls += 1
        return [list(item) for item in self.segments]

    def extract_embedding(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        assert pcm
        assert sample_rate == SAMPLE_RATE
        vector = self.embeddings[min(self.embedding_calls, len(self.embeddings) - 1)]
        self.embedding_calls += 1
        return {"embedding": vector, "model_id": "xvector", "model_version": "rk3588-local"}


def unpack_embedding(row: SuspectVoiceprint) -> tuple[float, ...]:
    return struct.unpack(f"<{row.embedding_dim}f", row.embedding)


def test_suspect_enrollment_uses_vad_multiple_embeddings_and_audits(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = FakeSpeechClient(
            [[0, 8000], [9000, 17000], [18000, 26000]],
            embeddings=[
                [1.0, 0.0, 0.0],
                [0.99, 0.1, 0.0],
                [0.98, -0.1, 0.0],
            ],
        )
        result = VoiceprintService(db, speech_client=speech).enroll_suspect(
            "CASE-1",
            pcm16(30000),
            actor_id="op-1",
        )

        assert result["caseId"] == "CASE-1"
        assert result["ready"] is True
        assert result["usableDurationMs"] == 24000
        assert result["embeddingDim"] == 3
        assert speech.segment_calls == 1
        assert speech.embedding_calls >= 3

        row = db.scalar(select(SuspectVoiceprint).where(SuspectVoiceprint.case_id == "CASE-1"))
        assert row is not None
        vector = unpack_embedding(row)
        assert math.sqrt(sum(value * value for value in vector)) == pytest.approx(1.0, abs=1e-5)
        assert row.model_id == "xvector"
        assert row.model_version == "rk3588-local"
        assert row.enrollment_quality == "GOOD"

        audit = db.scalar(select(AuditLog).where(AuditLog.action == "SUSPECT_VOICEPRINT_ENROLL"))
        assert audit is not None
        assert "embedding" not in audit.detail_json.lower()
    finally:
        db.close()
        engine.dispose()


def test_suspect_enrollment_rejects_silence_before_model_calls(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = FakeSpeechClient([[0, 30000]])
        with pytest.raises(DomainError) as exc_info:
            VoiceprintService(db, speech_client=speech).enroll_suspect(
                "CASE-1",
                pcm16(30000, sample=0),
                actor_id="op-1",
            )
        assert exc_info.value.code == "VOICEPRINT_AUDIO_SILENT"
        assert speech.segment_calls == 0
        assert speech.embedding_calls == 0
    finally:
        db.close()
        engine.dispose()


def test_suspect_enrollment_rejects_clearly_clipped_audio_before_model_calls(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = FakeSpeechClient([[0, 30000]])
        with pytest.raises(DomainError) as exc_info:
            VoiceprintService(db, speech_client=speech).enroll_suspect(
                "CASE-1",
                clipped_pcm16(1000),
                actor_id="op-1",
            )
        assert exc_info.value.code == "VOICEPRINT_AUDIO_CLIPPED"
        assert speech.segment_calls == 0
        assert speech.embedding_calls == 0
    finally:
        db.close()
        engine.dispose()


def test_suspect_enrollment_requires_twenty_seconds_vad_positive_speech(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = FakeSpeechClient([[0, 6000], [7000, 13000], [14000, 19000]])
        with pytest.raises(DomainError) as exc_info:
            VoiceprintService(db, speech_client=speech).enroll_suspect(
                "CASE-1",
                pcm16(30000),
                actor_id="op-1",
            )
        assert exc_info.value.code == "VOICEPRINT_INSUFFICIENT_SPEECH"
        assert speech.embedding_calls == 0
    finally:
        db.close()
        engine.dispose()
