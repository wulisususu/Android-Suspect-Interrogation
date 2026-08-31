from __future__ import annotations

from queue import Empty, Full, Queue
from threading import RLock


class BrowserAudioInput:
    """Thread-safe PCM16 input used only for LAN browser test mode.

    The production ASR service consumes this object through the same
    start_record/read_audio_frames/stop_record contract as the Linux ALSA HAL.
    Browser frames are never persisted by this input buffer.
    """

    def __init__(self, *, max_frame_bytes: int = 64 * 1024, max_frames: int = 256) -> None:
        self.max_frame_bytes = max(2, int(max_frame_bytes))
        self._queue: Queue[bytes] = Queue(maxsize=max(1, int(max_frames)))
        self._lock = RLock()
        self._active = False

    @property
    def active(self) -> bool:
        with self._lock:
            return self._active

    def start_record(self) -> None:
        with self._lock:
            self._drain_locked()
            self._active = True

    def push_pcm(self, pcm: bytes | bytearray | memoryview) -> None:
        frame = bytes(pcm)
        if not frame or len(frame) % 2:
            raise ValueError("browser audio must be non-empty PCM16 bytes")
        if len(frame) > self.max_frame_bytes:
            raise ValueError("browser audio frame is too large")
        with self._lock:
            if not self._active:
                raise RuntimeError("browser audio input is not active")
        try:
            self._queue.put_nowait(frame)
        except Full as exc:
            raise RuntimeError("browser audio input buffer is full") from exc

    def read_audio_frames(self, timeout: float = 0.2) -> bytes:
        with self._lock:
            if not self._active:
                return b""
        try:
            return self._queue.get(timeout=max(0.001, float(timeout)))
        except Empty:
            return b""

    def stop_record(self) -> None:
        with self._lock:
            self._active = False
            self._drain_locked()

    def _drain_locked(self) -> None:
        while True:
            try:
                self._queue.get_nowait()
            except Empty:
                return
