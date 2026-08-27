from pathlib import Path

from app.ai.speech.client import SpeechWorkerClient
from app.ai.speech.mock_worker import MockSpeechWorker


def test_client_can_request_vad_segments_without_running_asr(tmp_path: Path):
    socket_path = tmp_path / "speech.sock"
    pcm = b"\x01\x00" * 16000

    with MockSpeechWorker(socket_path) as worker:
        segments = SpeechWorkerClient(socket_path, timeout=0.5).speech_segments(pcm, sample_rate=16000)

    assert segments == [[100, 900]]
    assert worker.last_request["op"] == "speech_segments"
    assert worker.last_request["sample_rate"] == 16000
