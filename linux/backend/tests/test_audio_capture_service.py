import threading
import time
import pytest

from app.domain.errors import DomainError
from app.services.audio_capture_service import AudioCaptureService


class FakeAudioManager:
    def __init__(self, frames=None, read_error: Exception | None = None):
        self.frames = list(frames or [b"\x01\x00" * 800])
        self.read_error = read_error
        self.started = 0
        self.stopped = 0
        self.reads = 0
        self._lock = threading.Lock()

    def start_record(self, output_path=None):
        del output_path
        self.started += 1

    def read_audio_frames(self, timeout: float = 0.5):
        del timeout
        with self._lock:
            self.reads += 1
            if self.read_error is not None:
                error = self.read_error
                self.read_error = None
                raise error
            if self.frames:
                return self.frames.pop(0)
        time.sleep(0.002)
        return b""

    def stop_record(self):
        self.stopped += 1


def wait_until(predicate, timeout=1.0):
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if predicate():
            return
        time.sleep(0.005)
    raise AssertionError("condition was not reached")


def test_capture_start_stop_collects_pcm_and_releases_recorder():
    manager = FakeAudioManager(frames=[b"\x01\x00" * 1600, b"\x02\x00" * 1600])
    service = AudioCaptureService(manager, sample_rate=16000, max_seconds=30)

    started = service.start("suspect", "CASE-1")
    assert started["active"] is True
    assert started["kind"] == "suspect"
    assert started["subjectId"] == "CASE-1"
    wait_until(lambda: manager.reads >= 2)

    pcm = service.stop("suspect", "CASE-1")
    assert pcm.startswith(b"\x01\x00")
    assert b"\x02\x00" in pcm
    assert manager.started == 1
    assert manager.stopped == 1
    assert service.status()["active"] is False


def test_new_capture_replaces_and_releases_a_stale_capture():
    manager = FakeAudioManager(frames=[])
    service = AudioCaptureService(manager, sample_rate=16000, max_seconds=30)
    service.start("suspect", "CASE-1")

    replacement = service.start("officer", "P-001")

    assert replacement["kind"] == "officer"
    assert replacement["subjectId"] == "P-001"
    assert manager.started == 2
    assert manager.stopped == 1
    service.stop("officer", "P-001")


def test_capture_stops_automatically_at_max_pcm_bytes():
    one_second = b"\x01\x00" * 16000
    manager = FakeAudioManager(frames=[one_second, one_second, one_second])
    service = AudioCaptureService(manager, sample_rate=16000, max_seconds=2)
    service.start("suspect", "CASE-1")

    wait_until(lambda: manager.stopped == 1)
    pcm = service.stop("suspect", "CASE-1")
    assert len(pcm) == 16000 * 2 * 2
    assert manager.stopped == 1


def test_capture_status_reports_real_collection_progress():
    one_second = b"\x01\x00" * 16000
    manager = FakeAudioManager(frames=[one_second])
    service = AudioCaptureService(manager, sample_rate=16000, max_seconds=2)
    service.start("suspect", "CASE-1")

    wait_until(lambda: manager.reads >= 1)
    status = service.status()

    assert status["capturedDurationMs"] == 1000
    assert status["targetDurationMs"] == 2000
    assert status["complete"] is False
    service.stop("suspect", "CASE-1")


def test_capture_read_failure_still_releases_recorder_and_surfaces_typed_error():
    manager = FakeAudioManager(read_error=RuntimeError("device read failed"))
    service = AudioCaptureService(manager, sample_rate=16000, max_seconds=30)
    service.start("suspect", "CASE-1")
    wait_until(lambda: manager.stopped == 1)

    with pytest.raises(DomainError) as exc_info:
        service.stop("suspect", "CASE-1")
    assert exc_info.value.code == "AUDIO_CAPTURE_FAILED"
    assert manager.stopped == 1
    assert service.status()["active"] is False
