from __future__ import annotations

import os
import socket
import stat
import threading
from dataclasses import dataclass
from pathlib import Path

import pytest

from app.ai.errors import ResourceBusyError
from app.ai.speech.client import SpeechWorkerClient
from app.ai.speech.types import SpeechEventType
from speech_worker.main import SpeechWorkerServer


@dataclass
class FakeRuntime:
    vad_calls: int = 0

    def health(self) -> dict:
        return {"status": "ready", "model_root": "/fake", "models": {"asr": True, "vad": True, "speaker": True}}

    def vad_stream(self, pcm: bytes, sample_rate: int, *, cache: dict, is_final: bool, chunk_size_ms: int = 200):
        self.vad_calls += 1
        if is_final:
            return [[-1, 200]]
        return [[0, -1]]

    def transcribe(self, pcm: bytes, sample_rate: int) -> dict:
        return {"text": "测试口供", "confidence": 0.95, "model_id": "paraformer"}

    def speaker_embedding(self, pcm: bytes, sample_rate: int) -> dict:
        return {"embedding": [0.6, 0.8], "model_id": "xvector"}


def _pcm(ms: int, sample_rate: int = 16000) -> bytes:
    samples = sample_rate * ms // 1000
    return (1).to_bytes(2, "little", signed=True) * samples


def _start_server(path: Path, runtime: FakeRuntime):
    server = SpeechWorkerServer(path, runtime)
    server.bind()
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    return server, thread


def _stop_server(server: SpeechWorkerServer, thread: threading.Thread):
    server.stop()
    thread.join(timeout=2.0)
    assert not thread.is_alive()


def test_server_round_trip_uses_unix_socket_and_session_lifecycle(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    runtime = FakeRuntime()
    server, thread = _start_server(socket_path, runtime)
    try:
        mode = stat.S_IMODE(socket_path.stat().st_mode)
        assert mode == 0o660
        client = SpeechWorkerClient(socket_path, timeout=1.0)

        health = client.health()
        assert health["status"] == "ready"
        assert health["sessions"] == 0

        opened = client.open_session("case-1", sample_rate=16000)
        assert opened == {"session_id": "case-1", "sample_rate": 16000}

        start_events = client.push_pcm("case-1", _pcm(200))
        assert [event.type for event in start_events] == [SpeechEventType.VAD_START]

        final_events = client.finalize_session("case-1")
        assert [event.type for event in final_events] == [
            SpeechEventType.VAD_END,
            SpeechEventType.ASR_FINAL,
            SpeechEventType.SPEAKER_RESULT,
        ]
        assert final_events[1].text == "测试口供"
        assert final_events[2].embedding == [0.6, 0.8]

        embedding = client.extract_embedding(_pcm(200), sample_rate=16000)
        assert embedding == {"embedding": [0.6, 0.8], "model_id": "xvector"}

        client.close_session("case-1")
        assert client.health()["sessions"] == 0
    finally:
        _stop_server(server, thread)

    assert not socket_path.exists()


def test_second_server_cannot_unlink_active_listener(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    first, thread = _start_server(socket_path, FakeRuntime())
    try:
        second = SpeechWorkerServer(socket_path, FakeRuntime())
        with pytest.raises(ResourceBusyError, match="active"):
            second.bind()

        assert socket_path.exists()
        assert SpeechWorkerClient(socket_path, timeout=1.0).health()["status"] == "ready"
    finally:
        _stop_server(first, thread)


def test_stale_unix_socket_is_replaced_only_after_listener_is_gone(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    stale = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    stale.bind(os.fspath(socket_path))
    stale.close()
    assert socket_path.exists()

    server, thread = _start_server(socket_path, FakeRuntime())
    try:
        assert SpeechWorkerClient(socket_path, timeout=1.0).health()["status"] == "ready"
    finally:
        _stop_server(server, thread)


def test_non_socket_path_is_never_deleted_as_stale_socket(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    socket_path.write_text("do not delete", encoding="utf-8")

    server = SpeechWorkerServer(socket_path, FakeRuntime())
    with pytest.raises(ResourceBusyError, match="not a Unix socket"):
        server.bind()

    assert socket_path.read_text(encoding="utf-8") == "do not delete"


def test_duplicate_session_open_is_rejected_without_resetting_existing_state(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    server, thread = _start_server(socket_path, FakeRuntime())
    try:
        client = SpeechWorkerClient(socket_path, timeout=1.0)
        client.open_session("case-dup", sample_rate=16000)
        client.push_pcm("case-dup", _pcm(200))

        with pytest.raises(ResourceBusyError):
            client.open_session("case-dup", sample_rate=16000)

        final_events = client.finalize_session("case-dup")
        assert [event.type for event in final_events][-2:] == [
            SpeechEventType.ASR_FINAL,
            SpeechEventType.SPEAKER_RESULT,
        ]
    finally:
        _stop_server(server, thread)
