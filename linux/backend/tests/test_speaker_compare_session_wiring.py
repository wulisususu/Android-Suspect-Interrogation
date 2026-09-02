from __future__ import annotations

import socket
import threading
from pathlib import Path

from app.ai.speech.client import SpeechWorkerClient
from app.ai.speech.protocol import recv_frame, send_frame


def _serve_open_once(socket_path: Path, captured: dict) -> threading.Thread:
    ready = threading.Event()

    def run() -> None:
        socket_path.unlink(missing_ok=True)
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as server:
            server.bind(str(socket_path))
            server.listen(1)
            ready.set()
            conn, _ = server.accept()
            with conn:
                request = recv_frame(conn)
                captured.update(request)
                send_frame(
                    conn,
                    {
                        "request_id": request["request_id"],
                        "ok": True,
                        "result": {
                            "session_id": request["session_id"],
                            "sample_rate": request["sample_rate"],
                            "speaker_backend": request["speaker_backend"],
                            "authoritative_backend": request.get("authoritative_backend"),
                        },
                    },
                )
        socket_path.unlink(missing_ok=True)

    thread = threading.Thread(target=run, daemon=True)
    thread.start()
    assert ready.wait(timeout=1)
    return thread


def test_compare_open_session_sends_authoritative_backend_to_worker(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    captured: dict = {}
    thread = _serve_open_once(socket_path, captured)

    result = SpeechWorkerClient(socket_path, timeout=0.5).open_session(
        "compare-session",
        sample_rate=16_000,
        speaker_backend="compare",
        authoritative_backend="xvector",
    )

    thread.join(timeout=1)
    assert captured["speaker_backend"] == "compare"
    assert captured["authoritative_backend"] == "xvector"
    assert result["authoritative_backend"] == "xvector"


def test_single_backend_open_session_does_not_require_authoritative_backend(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    captured: dict = {}
    thread = _serve_open_once(socket_path, captured)

    result = SpeechWorkerClient(socket_path, timeout=0.5).open_session(
        "single-session",
        sample_rate=16_000,
        speaker_backend="eres2net_large",
    )

    thread.join(timeout=1)
    assert captured["speaker_backend"] == "eres2net_large"
    assert "authoritative_backend" not in captured
    assert result["speaker_backend"] == "eres2net_large"
