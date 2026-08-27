import math
import struct

import pytest
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import AuditLog, Case, OfficerVoiceprint, SessionVoiceAssignment, SuspectVoiceprint
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.repositories import sessions as session_repo
from app.services.voiceprint_service import VoiceprintService


SAMPLE_RATE = 16000
GOOD_SEGMENTS = [[0, 8000], [9000, 17000], [18000, 26000]]
GOOD_EMBEDDINGS = [
    [1.0, 0.0, 0.0],
    [0.99, 0.1, 0.0],
    [0.98, -0.1, 0.0],
]


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


def good_speech() -> FakeSpeechClient:
    return FakeSpeechClient(GOOD_SEGMENTS, GOOD_EMBEDDINGS)


def unpack_embedding(row: SuspectVoiceprint | OfficerVoiceprint) -> tuple[float, ...]:
    return struct.unpack(f"<{row.embedding_dim}f", row.embedding)


def test_suspect_enrollment_uses_vad_multiple_embeddings_and_audits(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = good_speech()
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


def test_officer_library_enroll_update_revoke_and_list_preserves_identity_history(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        service = VoiceprintService(db, speech_client=good_speech())
        enrolled = service.enroll_officer("P-001", "张警官", pcm16(30000), actor_id="admin")
        assert enrolled["officerId"] == "P-001"
        assert enrolled["officerName"] == "张警官"
        assert enrolled["active"] is True
        assert [item["officerId"] for item in service.list_officers()] == ["P-001"]

        service.speech_client = good_speech()
        updated = service.update_officer("P-001", pcm16(30000), actor_id="admin")
        assert updated["officerId"] == "P-001"
        assert updated["officerName"] == "张警官"
        assert updated["active"] is True

        revoked = service.revoke_officer("P-001", actor_id="admin")
        assert revoked["active"] is False
        assert service.list_officers() == []
        history = service.list_officers(active_only=False)
        assert len(history) == 1
        assert history[0]["officerId"] == "P-001"
        assert history[0]["revokedAt"] is not None

        row = db.scalar(select(OfficerVoiceprint).where(OfficerVoiceprint.officer_id == "P-001"))
        assert row is not None
        assert row.active is False
        assert row.revoked_at is not None
        actions = set(db.scalars(select(AuditLog.action).where(AuditLog.action.like("OFFICER_VOICEPRINT_%"))))
        assert {
            "OFFICER_VOICEPRINT_ENROLL",
            "OFFICER_VOICEPRINT_UPDATE",
            "OFFICER_VOICEPRINT_REVOKE",
        }.issubset(actions)
    finally:
        db.close()
        engine.dispose()


def test_readiness_requires_suspect_but_never_requires_police_voiceprints(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        service = VoiceprintService(db, speech_client=good_speech())
        before = service.readiness("CASE-1")
        assert before == {
            "suspectReady": False,
            "interrogatorReady": False,
            "recorderReady": False,
            "recognitionMode": "SUSPECT_ONLY",
            "canStart": False,
        }

        service.enroll_suspect("CASE-1", pcm16(30000), actor_id="op")
        after = service.readiness("CASE-1")
        assert after == {
            "suspectReady": True,
            "interrogatorReady": False,
            "recorderReady": False,
            "recognitionMode": "SUSPECT_ONLY",
            "canStart": True,
        }
    finally:
        db.close()
        engine.dispose()


def test_bind_roles_uses_active_session_and_active_officer_profiles(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        service = VoiceprintService(db, speech_client=good_speech())
        service.enroll_suspect("CASE-1", pcm16(30000), actor_id="op")
        service.speech_client = good_speech()
        service.enroll_officer("P-001", "主审张警官", pcm16(30000), actor_id="admin")
        service.speech_client = good_speech()
        service.enroll_officer("P-002", "记录李警官", pcm16(30000), actor_id="admin")

        with pytest.raises(DomainError) as exc_info:
            service.bind_roles("CASE-1", "P-001", "P-002", actor_id="op")
        assert exc_info.value.code == "SESSION_NOT_ACTIVE"

        session = session_repo.create(db, "CASE-1")
        db.commit()
        bound = service.bind_roles("CASE-1", "P-001", "P-002", actor_id="op")
        assert bound["sessionId"] == session.id
        assert bound["recognitionMode"] == "FULL"
        assert bound["interrogatorReady"] is True
        assert bound["recorderReady"] is True

        assignment = db.scalar(select(SessionVoiceAssignment).where(SessionVoiceAssignment.session_id == session.id))
        assert assignment is not None
        assert assignment.interrogator_officer_id == "P-001"
        assert assignment.recorder_officer_id == "P-002"
        audit = db.scalar(select(AuditLog).where(AuditLog.action == "SESSION_VOICE_ROLE_BIND"))
        assert audit is not None
        assert "embedding" not in audit.detail_json.lower()
    finally:
        db.close()
        engine.dispose()
