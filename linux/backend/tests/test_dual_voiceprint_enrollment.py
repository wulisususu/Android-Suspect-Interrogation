from __future__ import annotations

import struct
from pathlib import Path

import pytest
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.ai.errors import BackendUnavailableError
from app.ai.speech.client import SpeechWorkerClient
from app.database.models import Case, SuspectVoiceprint
from app.database.session import init_database, make_engine
from app.services.voiceprint_service import VoiceprintService
from speech_worker.main import SpeechWorkerServer


SAMPLE_RATE = 16000
GOOD_SEGMENTS = [[0, 8000], [9000, 17000], [18000, 26000]]
XVECTOR = "xvector"
ERES2NET = "eres2net_large"


def pcm16(duration_ms: int = 30000, sample: int = 1200) -> bytes:
    samples = duration_ms * SAMPLE_RATE // 1000
    return struct.pack(f"<{samples}h", *([sample] * samples))


def make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'dual-enrollment.sqlite3'}")
    init_database(engine)
    db = Session(engine)
    db.add(Case(id="CASE-DUAL", officer_name="测试警官"))
    db.commit()
    return engine, db


class CapturingSpeechWorkerClient(SpeechWorkerClient):
    def __init__(self):
        super().__init__(Path("/tmp/not-used.sock"))
        self.requests: list[tuple[str, dict]] = []

    def _request(self, op: str, **payload):
        self.requests.append((op, payload))
        return {
            "embedding": [1.0, 0.0],
            "backend_key": payload.get("backend_key"),
            "model_id": payload.get("backend_key"),
        }


class BackendAwareRuntime:
    def __init__(self):
        self.calls: list[str | None] = []

    def speaker_embedding(self, pcm: bytes, sample_rate: int, *, backend_key: str | None = None):
        assert pcm == b"\x01\x00"
        assert sample_rate == SAMPLE_RATE
        self.calls.append(backend_key)
        return {
            "embedding": [1.0, 0.0],
            "backend_key": backend_key,
            "model_id": backend_key,
        }


class FakeDualSpeechClient:
    def __init__(self, *, fail_backend: str | None = None):
        self.fail_backend = fail_backend
        self.segment_calls = 0
        self.embedding_calls: list[tuple[str, bytes]] = []
        self._per_backend_index = {XVECTOR: 0, ERES2NET: 0}
        self._vectors = {
            XVECTOR: [
                [1.0, 0.0, 0.0],
                [0.99, 0.1, 0.0],
                [0.98, -0.1, 0.0],
            ],
            ERES2NET: [
                [1.0, 0.0, 0.0, 0.0],
                [0.99, 0.1, 0.0, 0.0],
                [0.98, -0.1, 0.0, 0.0],
            ],
        }

    def speech_segments(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        assert pcm
        assert sample_rate == SAMPLE_RATE
        self.segment_calls += 1
        return [list(item) for item in GOOD_SEGMENTS]

    def extract_embedding(self, pcm: bytes, sample_rate: int = SAMPLE_RATE, *, backend: str):
        assert pcm
        assert sample_rate == SAMPLE_RATE
        assert backend in {XVECTOR, ERES2NET}
        self.embedding_calls.append((backend, bytes(pcm)))
        if backend == self.fail_backend:
            raise BackendUnavailableError(
                f"{backend} unavailable in test",
                details={"backend_key": backend},
            )
        index = self._per_backend_index[backend]
        self._per_backend_index[backend] += 1
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


def test_speech_client_sends_requested_embedding_backend():
    client = CapturingSpeechWorkerClient()

    result = client.extract_embedding(b"\x01\x00", sample_rate=SAMPLE_RATE, backend=ERES2NET)

    assert result["backend_key"] == ERES2NET
    assert client.requests == [
        (
            "extract_embedding",
            {
                "sample_rate": SAMPLE_RATE,
                "pcm_b64": "AQA=",
                "backend_key": ERES2NET,
            },
        )
    ]


def test_speech_worker_dispatch_forwards_embedding_backend_to_runtime(tmp_path):
    runtime = BackendAwareRuntime()
    server = SpeechWorkerServer(tmp_path / "unused.sock", runtime)

    result = server._dispatch(
        {
            "op": "extract_embedding",
            "sample_rate": SAMPLE_RATE,
            "pcm_b64": "AQA=",
            "backend_key": ERES2NET,
        }
    )

    assert result["backend_key"] == ERES2NET
    assert runtime.calls == [ERES2NET]


def test_suspect_capture_builds_one_eres2net_reference(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = FakeDualSpeechClient()
        result = VoiceprintService(db, speech_client=speech).enroll_suspect(
            "CASE-DUAL",
            pcm16(),
            actor_id="op-dual",
        )

        rows = list(
            db.scalars(
                select(SuspectVoiceprint)
                .where(SuspectVoiceprint.case_id == "CASE-DUAL")
                .order_by(SuspectVoiceprint.model_key.asc())
            )
        )
        assert speech.segment_calls == 1
        e_chunks = [pcm for backend, pcm in speech.embedding_calls if backend == ERES2NET]
        assert len(e_chunks) >= 3

        assert {row.model_key for row in rows} == {ERES2NET}
        assert rows[0].embedding_dim == 4
        assert rows[0].model_id.startswith("iic/speech_eres2net_large")

        assert result["ready"] is True
        assert result["voiceprintId"] == rows[0].id
        assert result["modelKey"] == ERES2NET
        assert result["embeddingDim"] == 4
    finally:
        db.close()
        engine.dispose()


def test_eres_failure_does_not_persist_a_fallback_reference(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        speech = FakeDualSpeechClient(fail_backend=ERES2NET)
        with pytest.raises(BackendUnavailableError):
            VoiceprintService(db, speech_client=speech).enroll_suspect(
                "CASE-DUAL",
                pcm16(),
                actor_id="op-dual",
            )

        rows = list(db.scalars(select(SuspectVoiceprint).where(SuspectVoiceprint.case_id == "CASE-DUAL")))
        assert rows == []
    finally:
        db.close()
        engine.dispose()
