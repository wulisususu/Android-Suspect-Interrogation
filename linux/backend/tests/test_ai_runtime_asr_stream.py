from __future__ import annotations

from fastapi import FastAPI
from fastapi.testclient import TestClient

from app.ai.types import ASRResult
from app.api.ai_runtime import router as ai_router


class RecordingSupervisor:
    def __init__(self):
        self.stream_inputs: list[bytes] = []
        self.transcribe_inputs: list[bytes] = []

    def stream_asr(self, audio: bytes, *, session_id: str, options=None):
        self.stream_inputs.append(bytes(audio))
        yield ASRResult(
            text=f"partial-{len(self.stream_inputs)}",
            confidence=0.9,
            model_id="test-asr",
            session_id=session_id,
            final=False,
        )

    def transcribe(self, audio: bytes, *, session_id: str, options=None):
        self.transcribe_inputs.append(bytes(audio))
        return ASRResult(
            text="final",
            confidence=0.95,
            model_id="test-asr",
            session_id=session_id,
            final=True,
        )

    def cancel(self, kind: str):
        assert kind == "asr"


def test_streaming_asr_processes_each_pcm_chunk_exactly_once_and_finalizes_full_audio():
    app = FastAPI()
    supervisor = RecordingSupervisor()
    app.state.ai_supervisor = supervisor
    app.include_router(ai_router, prefix="/api/v1")

    with TestClient(app) as client:
        with client.websocket_connect("/api/v1/ai/asr/stream?session_id=session-1") as ws:
            ws.send_bytes(b"A")
            assert ws.receive_json()["type"] == "partial"

            ws.send_bytes(b"B")
            assert ws.receive_json()["type"] == "partial"

            ws.send_text('{"type":"finalize"}')
            final = ws.receive_json()
            assert final["type"] == "final"
            assert final["result"]["text"] == "final"

            ws.send_text('{"type":"close"}')

    # A and B must each be consumed once by the streaming path. The historical
    # bug reprocessed A as part of AB on the second chunk.
    assert supervisor.stream_inputs == [b"A", b"B"]
    # Finalization is intentionally one whole-utterance pass for the legacy ASR
    # endpoint until capture orchestration delegates it to SpeechWorkerSession.
    assert supervisor.transcribe_inputs == [b"AB"]
