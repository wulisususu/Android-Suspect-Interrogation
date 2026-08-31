import struct

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import Case, OfficerVoiceprint, SessionVoiceAssignment
from app.database.session import init_database, make_engine
from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample
from app.repositories import sessions as session_repo
from app.repositories import voiceprints as voiceprint_repo
from app.services.officer_voiceprint_library import OfficerVoiceprintLibraryService


SAMPLE_RATE = 16_000
GOOD_SEGMENTS = [[0, 8000], [9000, 17000], [18000, 26000]]


class FakeSpeechClient:
    def __init__(self, embeddings):
        self.embeddings = list(embeddings)
        self.index = 0

    def speech_segments(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        assert pcm and sample_rate == SAMPLE_RATE
        return [list(item) for item in GOOD_SEGMENTS]

    def extract_embedding(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        assert pcm and sample_rate == SAMPLE_RATE
        vector = self.embeddings[min(self.index, len(self.embeddings) - 1)]
        self.index += 1
        return {"embedding": vector, "model_id": "xvector", "model_version": "rk3588-local"}


def pcm16(duration_ms: int, sample: int = 1200) -> bytes:
    samples = duration_ms * SAMPLE_RATE // 1000
    return struct.pack(f"<{samples}h", *([sample] * samples))


def make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'officer-library.sqlite3'}")
    init_database(engine)
    db = Session(engine)
    db.add(Case(id="CASE-1", officer_name="测试警官"))
    db.commit()
    return engine, db


def service(db: Session, axis: int = 0) -> OfficerVoiceprintLibraryService:
    vectors = [
        [1.0, 0.0, 0.0] if axis == 0 else [0.0, 1.0, 0.0],
        [0.99, 0.05, 0.0] if axis == 0 else [0.05, 0.99, 0.0],
        [0.98, -0.05, 0.0] if axis == 0 else [-0.05, 0.98, 0.0],
    ]
    return OfficerVoiceprintLibraryService(db, speech_client=FakeSpeechClient(vectors))


def test_second_enrollment_appends_sample_and_increments_aggregate_version(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        first = service(db, 0).add_sample(
            "P-001",
            "张警官",
            pcm16(30_000),
            actor_id="admin",
            audio_source="BROWSER",
            device_id="browser-default",
            device_name="Windows Browser Microphone",
        )
        first_sample_id = first["latestSampleId"]
        first_sample_embedding = db.get(OfficerVoiceSample, first_sample_id).embedding

        second = service(db, 1).add_sample(
            "P-001",
            "张警官",
            pcm16(30_000),
            actor_id="admin",
            audio_source="ALSA",
            device_id="default",
            device_name="Linux ALSA Microphone",
        )

        profile = db.scalar(select(OfficerVoiceProfile).where(OfficerVoiceProfile.officer_id == "P-001"))
        samples = list(db.scalars(select(OfficerVoiceSample).where(OfficerVoiceSample.profile_id == profile.id)))
        assert second["sampleCount"] == 2
        assert second["aggregateVersion"] == 2
        assert profile.sample_count == 2
        assert len(samples) == 2
        assert db.get(OfficerVoiceSample, first_sample_id).embedding == first_sample_embedding
        assert {row.audio_source for row in samples} == {"BROWSER", "ALSA"}
        assert {row.device_name for row in samples} == {"Windows Browser Microphone", "Linux ALSA Microphone"}
    finally:
        db.close()
        engine.dispose()


def test_disabling_sample_preserves_history_and_rebuilds_reference(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        first = service(db, 0).add_sample("P-001", "张警官", pcm16(30_000), audio_source="BROWSER")
        second = service(db, 1).add_sample("P-001", "张警官", pcm16(30_000), audio_source="ALSA")
        before_version = second["aggregateVersion"]

        result = service(db, 0).disable_sample("P-001", first["latestSampleId"], reason="环境噪声", actor_id="admin")
        disabled = db.get(OfficerVoiceSample, first["latestSampleId"])

        assert disabled is not None
        assert disabled.active is False
        assert disabled.disabled_at is not None
        assert disabled.disabled_reason == "环境噪声"
        assert result["sampleCount"] == 1
        assert result["aggregateVersion"] == before_version + 1
    finally:
        db.close()
        engine.dispose()


def test_session_binding_freezes_officer_reference_version(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        library = service(db, 0)
        first = library.add_sample("P-001", "张警官", pcm16(30_000), audio_source="BROWSER")
        bridge_before = voiceprint_repo.get_officer(db, "P-001")
        bridge_before_embedding = bytes(bridge_before.embedding)

        suspect_embedding = struct.pack("<3f", 1.0, 0.0, 0.0)
        suspect = voiceprint_repo.enroll_suspect(
            db,
            case_id="CASE-1",
            embedding=suspect_embedding,
            embedding_dim=3,
            model_id="xvector",
            model_version="rk3588-local",
            enrollment_quality="GOOD",
            usable_duration_ms=20_000,
        )
        session = session_repo.create(db, "CASE-1")
        db.commit()
        assignment = voiceprint_repo.assign_session_roles(
            db,
            session_id=session.id,
            suspect_voiceprint_id=suspect.id,
            interrogator_officer_id="P-001",
            recorder_officer_id=None,
        )
        db.commit()
        frozen_id = assignment.interrogator_voiceprint_id
        frozen = db.get(OfficerVoiceprint, frozen_id)
        assert frozen is not None
        assert frozen.officer_id.startswith("__session_snapshot__:")
        assert bytes(frozen.embedding) == bridge_before_embedding

        library = service(db, 1)
        after = library.add_sample("P-001", "张警官", pcm16(30_000), audio_source="ALSA")
        bridge_after = voiceprint_repo.get_officer(db, "P-001")
        frozen_after = db.get(OfficerVoiceprint, frozen_id)
        assignment_after = db.scalar(select(SessionVoiceAssignment).where(SessionVoiceAssignment.session_id == session.id))

        assert after["aggregateVersion"] == first["aggregateVersion"] + 1
        assert bytes(bridge_after.embedding) != bridge_before_embedding
        assert assignment_after.interrogator_voiceprint_id == frozen_id
        assert bytes(frozen_after.embedding) == bridge_before_embedding
    finally:
        db.close()
        engine.dispose()
