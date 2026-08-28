import pytest

from app.domain.errors import DomainError
from app.services.audio_capture_service import AudioCaptureService


class FakeAudioManager:
    def __init__(self):
        self.started = 0
        self.stopped = 0

    def start_record(self, output_path=None):
        del output_path
        self.started += 1

    def read_audio_frames(self, timeout: float = 0.5):
        del timeout
        return b""

    def stop_record(self):
        self.stopped += 1


class FakeVadClient:
    def __init__(self):
        self.opened = []
        self.closed = []
        self.usable_ms = 0

    def open_vad_session(self, session_id: str, sample_rate: int = 16000):
        self.opened.append((session_id, sample_rate))
        return {"sessionId": session_id, "usableDurationMs": 0, "segments": []}

    def push_vad_pcm(self, session_id: str, pcm: bytes):
        self.usable_ms += len(pcm) * 1000 // (16000 * 2)
        return {"sessionId": session_id, "usableDurationMs": self.usable_ms, "segments": [[0, self.usable_ms]]}

    def finalize_vad_session(self, session_id: str):
        return {"sessionId": session_id, "usableDurationMs": self.usable_ms, "segments": [[0, self.usable_ms]]}

    def close_vad_session(self, session_id: str):
        self.closed.append(session_id)


def make_service():
    manager = FakeAudioManager()
    speech = FakeVadClient()
    service = AudioCaptureService(
        manager,
        speech_client=speech,
        sample_rate=16000,
        max_seconds=300,
        required_usable_speech_ms=20000,
        vad_chunk_ms=200,
    )
    return service, manager, speech


def test_legacy_start_defaults_to_alsa_source():
    service, manager, _ = make_service()

    status = service.start("suspect", "CASE-1")

    assert status["source"] == "ALSA"
    assert status["captureId"]
    assert manager.started == 1
    service.cancel(status["captureId"])


def test_browser_source_does_not_open_alsa_and_uses_same_vad_progress():
    service, manager, _ = make_service()

    status = service.start("suspect", "CASE-1", source="BROWSER")
    capture_id = status["captureId"]
    assert status["source"] == "BROWSER"
    assert manager.started == 0

    one_second_pcm = b"\x01\x00" * 16000
    progress = service.push_browser_pcm(capture_id, one_second_pcm)

    assert progress["source"] == "BROWSER"
    assert progress["recordedDurationMs"] == 1000
    assert progress["usableSpeechMs"] == 1000
    assert manager.started == 0
    service.cancel(capture_id)


def test_browser_pcm_rejects_stale_capture_id_and_alsa_capture():
    service, _, _ = make_service()
    browser = service.start("suspect", "CASE-1", source="BROWSER")

    with pytest.raises(DomainError) as stale:
        service.push_browser_pcm("wrong-id", b"\x01\x00" * 3200)
    assert stale.value.code == "CAPTURE_ID_MISMATCH"
    service.cancel(browser["captureId"])

    alsa = service.start("suspect", "CASE-1", source="ALSA")
    with pytest.raises(DomainError) as wrong_source:
        service.push_browser_pcm(alsa["captureId"], b"\x01\x00" * 3200)
    assert wrong_source.value.code == "CAPTURE_SOURCE_MISMATCH"
    service.cancel(alsa["captureId"])


def test_browser_cancel_releases_capture_without_returning_enrollment_pcm():
    service, manager, speech = make_service()
    status = service.start("suspect", "CASE-1", source="BROWSER")
    capture_id = status["captureId"]
    service.push_browser_pcm(capture_id, b"\x01\x00" * 3200)

    cancelled = service.cancel(capture_id)

    assert cancelled["cancelled"] is True
    assert cancelled["captureId"] == capture_id
    assert service.status()["active"] is False
    assert manager.started == 0
    assert manager.stopped == 0
    assert speech.closed

    with pytest.raises(DomainError) as exc_info:
        service.stop("suspect", "CASE-1")
    assert exc_info.value.code == "CAPTURE_NOT_ACTIVE"
