import struct

import pytest
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.ai.errors import BackendUnavailableError
from app.database.models import Case, OfficerVoiceprint, SessionVoiceAssignment
from app.database.session import init_database, make_engine
from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample
from app.repositories import sessions as session_repo
from app.repositories import voiceprints as voiceprint_repo
from app.services.officer_voiceprint_library import OfficerVoiceprintLibraryService


SAMPLE_RATE = 16_000
GOOD_SEGMENTS = [[0, 8000], [9000, 17000], [18000, 26000]]
MODEL_FP = "a" * 64
MIC_FP = "b" * 64
XVECTOR = "xvector"
ERES2NET = "eres2net_large"


class FakeSpeechClient:
    def __init__(self, embeddings):
        self.embeddings = list(embeddings)
        self.index = 0

    def health(self):
        return {
            "speaker_backends": {
                ERES2NET: {
                    "model_id": "eres2net-large",
                    "model_version": "rk3588-local",
                    "model_fingerprint": MODEL_FP,
                }
            }
        }

    def speech_segments(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        assert pcm and sample_rate == SAMPLE_RATE
        return [list(item) for item in GOOD_SEGMENTS]

    def extract_embedding(self, pcm: bytes, sample_rate: int = SAMPLE_RATE, *, backend: str = ERES2NET):
        assert pcm and sample_rate == SAMPLE_RATE
        assert backend == ERES2NET
        vector = self.embeddings[min(self.index, len(self.embeddings) - 1)]
        self.index += 1
        return {"embedding": vector, "backend_key": ERES2NET, "model_id": "eres2net-large", "model_version": "rk3588-local", "model_fingerprint": MODEL_FP}


class FakeDualSpeechClient:
    def __init__(self, *, fail_backend: str | None = None):
        self.fail_backend = fail_backend
        self.segment_calls = 0
        self.embedding_calls: list[tuple[str, bytes]] = []
        self._index = {XVECTOR: 0, ERES2NET: 0}
        self._vectors = {
            XVECTOR: [
                [1.0, 0.0, 0.0],
                [0.99, 0.05, 0.0],
                [0.98, -0.05, 0.0],
            ],
            ERES2NET: [
                [1.0, 0.0, 0.0, 0.0],
                [0.99, 0.05, 0.0, 0.0],
                [0.98, -0.05, 0.0, 0.0],
            ],
        }

    def health(self):
        return {
            "speaker_backends": {
                XVECTOR: {"ready": True, "model_fingerprint": "x" * 64},
                ERES2NET: {"ready": self.fail_backend != ERES2NET, "model_fingerprint": "e" * 64},
            }
        }

    def speech_segments(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        assert pcm and sample_rate == SAMPLE_RATE
        self.segment_calls += 1
        return [list(item) for item in GOOD_SEGMENTS]

    def extract_embedding(self, pcm: bytes, sample_rate: int = SAMPLE_RATE, *, backend: str):
        assert pcm and sample_rate == SAMPLE_RATE
        self.embedding_calls.append((backend, bytes(pcm)))
        if backend == self.fail_backend:
            raise BackendUnavailableError(
                f"{backend} unavailable in test",
                details={"backend_key": backend},
            )
        index = self._index[backend]
        self._index[backend] += 1
        vector = self._vectors[backend][min(index, len(self._vectors[backend]) - 1)]
        if backend == XVECTOR:
            return {
                "embedding": vector,
                "backend_key": XVECTOR,
                "model_id": "xvector",
                "model_version": "x-test",
                "model_fingerprint": "x" * 64,
            }
        return {
            "embedding": vector,
            "backend_key": ERES2NET,
            "model_id": "iic/speech_eres2net_large_200k_sv_zh-cn_16k-common",
            "model_version": "e-test",
            "model_fingerprint": "e" * 64,
        }


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


def test_one_officer_capture_creates_eres2net_samples_only(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = FakeDualSpeechClient()
        result = OfficerVoiceprintLibraryService(db, speech_client=speech).add_sample(
            "P-DUAL",
            "双模型警官",
            pcm16(30_000),
            actor_id="admin",
            audio_source="ALSA",
            device_id="default",
            device_name="Linux ALSA Microphone",
            microphone_fingerprint=MIC_FP,
            microphone_fingerprint_certainty="STRONG",
        )

        profiles = list(
            db.scalars(
                select(OfficerVoiceProfile)
                .where(OfficerVoiceProfile.officer_id == "P-DUAL")
                .order_by(OfficerVoiceProfile.model_key.asc())
            )
        )
        samples = list(
            db.scalars(
                select(OfficerVoiceSample)
                .join(OfficerVoiceProfile, OfficerVoiceSample.profile_id == OfficerVoiceProfile.id)
                .where(OfficerVoiceProfile.officer_id == "P-DUAL")
            )
        )
        assert speech.segment_calls == 1
        e_chunks = [pcm for backend, pcm in speech.embedding_calls if backend == ERES2NET]
        assert len(e_chunks) >= 3
        assert {profile.model_key for profile in profiles} == {ERES2NET}
        assert {sample.model_key for sample in samples} == {ERES2NET}
        assert profiles[0].embedding_dim == 4
        assert samples[0].model_fingerprint == "e" * 64
        assert result["modelKey"] == ERES2NET
        assert result["backends"][ERES2NET]["status"] == "READY"
    finally:
        db.close()
        engine.dispose()


def test_eres_failure_does_not_fall_back_to_legacy_xvector(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        with pytest.raises(BackendUnavailableError):
            OfficerVoiceprintLibraryService(
                db,
                speech_client=FakeDualSpeechClient(fail_backend=ERES2NET),
            ).add_sample("P-DUAL", "双模型警官", pcm16(30_000), audio_source="ALSA")

        profiles = list(db.scalars(select(OfficerVoiceProfile).where(OfficerVoiceProfile.officer_id == "P-DUAL")))
        assert profiles == []
    finally:
        db.close()
        engine.dispose()


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
            microphone_fingerprint="browser-" + MIC_FP[:56],
            microphone_fingerprint_certainty="REDUCED",
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
            microphone_fingerprint=MIC_FP,
            microphone_fingerprint_certainty="STRONG",
        )

        profile = db.scalar(
            select(OfficerVoiceProfile).where(
                OfficerVoiceProfile.officer_id == "P-001",
                OfficerVoiceProfile.model_key == ERES2NET,
            )
        )
        samples = list(db.scalars(select(OfficerVoiceSample).where(OfficerVoiceSample.profile_id == profile.id)))
        assert second["sampleCount"] == 2
        assert second["aggregateVersion"] == 2
        assert profile.sample_count == 2
        assert len(samples) == 2
        assert db.get(OfficerVoiceSample, first_sample_id).embedding == first_sample_embedding
        assert {row.audio_source for row in samples} == {"BROWSER", "ALSA"}
        assert {row.device_name for row in samples} == {"Windows Browser Microphone", "Linux ALSA Microphone"}
        alsa_sample = next(row for row in samples if row.audio_source == "ALSA")
        assert alsa_sample.model_fingerprint == MODEL_FP
        assert alsa_sample.microphone_fingerprint == MIC_FP
        assert alsa_sample.microphone_fingerprint_certainty == "STRONG"
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
