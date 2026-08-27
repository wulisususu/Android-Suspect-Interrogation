from __future__ import annotations

import threading
from dataclasses import dataclass, field
from typing import Any

from app.domain.errors import DomainError


@dataclass
class _Capture:
    kind: str
    subject_id: str
    max_bytes: int
    buffer: bytearray = field(default_factory=bytearray)
    stop_event: threading.Event = field(default_factory=threading.Event)
    done_event: threading.Event = field(default_factory=threading.Event)
    error: Exception | None = None
    thread: threading.Thread | None = None


class AudioCaptureService:
    """Own a single bounded PCM16 enrollment capture at a time.

    The hardware recorder is process-global, so enrollment capture is also
    process-global. Model/VAD work is deliberately kept out of this service;
    callers consume the returned PCM only after the recorder has been released.
    """

    def __init__(
        self,
        device_manager: Any,
        *,
        sample_rate: int = 16000,
        max_seconds: int = 30,
        read_timeout: float = 0.5,
        stop_wait_seconds: float = 2.0,
    ) -> None:
        self.device_manager = device_manager
        self.sample_rate = int(sample_rate)
        self.max_seconds = int(max_seconds)
        self.read_timeout = max(0.01, float(read_timeout))
        self.stop_wait_seconds = max(0.1, float(stop_wait_seconds))
        if self.sample_rate <= 0 or self.max_seconds <= 0:
            raise ValueError("sample_rate and max_seconds must be positive")
        self.max_bytes = self.sample_rate * 2 * self.max_seconds
        self._lock = threading.RLock()
        self._capture: _Capture | None = None

    def start(self, kind: str, subject_id: str) -> dict:
        kind = str(kind).strip()
        subject_id = str(subject_id).strip()
        if not kind or not subject_id:
            raise DomainError("CAPTURE_SUBJECT_REQUIRED", "录音对象不能为空", 400)

        with self._lock:
            if self._capture is not None:
                active = self._capture
                raise DomainError(
                    "RESOURCE_BUSY",
                    "已有声纹录音正在进行",
                    409,
                    data={"kind": active.kind, "subjectId": active.subject_id},
                )
            capture = _Capture(kind=kind, subject_id=subject_id, max_bytes=self.max_bytes)
            try:
                self.device_manager.start_record()
            except Exception as exc:
                raise DomainError("AUDIO_CAPTURE_FAILED", f"无法启动录音设备：{exc}", 500) from exc
            self._capture = capture
            thread = threading.Thread(
                target=self._collect,
                args=(capture,),
                daemon=True,
                name=f"voiceprint-capture-{kind}",
            )
            capture.thread = thread
            thread.start()
            return self._status_for(capture)

    def stop(self, kind: str, subject_id: str) -> bytes:
        kind = str(kind).strip()
        subject_id = str(subject_id).strip()
        with self._lock:
            capture = self._capture
            if capture is None:
                raise DomainError("CAPTURE_NOT_ACTIVE", "当前没有正在进行的声纹录音", 409)
            if capture.kind != kind or capture.subject_id != subject_id:
                raise DomainError("CAPTURE_SUBJECT_MISMATCH", "当前声纹录音对象不匹配", 409)
            capture.stop_event.set()
            thread = capture.thread

        if thread is not None and thread.is_alive():
            thread.join(timeout=self.stop_wait_seconds)
        if not capture.done_event.wait(timeout=self.stop_wait_seconds):
            raise DomainError("AUDIO_CAPTURE_STOP_TIMEOUT", "录音设备停止超时", 500)

        with self._lock:
            if self._capture is capture:
                self._capture = None

        if capture.error is not None:
            raise DomainError(
                "AUDIO_CAPTURE_FAILED",
                f"录音采集失败：{capture.error}",
                500,
            ) from capture.error
        return bytes(capture.buffer)

    def status(self) -> dict:
        with self._lock:
            capture = self._capture
            if capture is None:
                return {
                    "active": False,
                    "kind": None,
                    "subjectId": None,
                    "sampleRate": self.sample_rate,
                    "capturedBytes": 0,
                    "maxBytes": self.max_bytes,
                    "complete": False,
                }
            return self._status_for(capture)

    def _collect(self, capture: _Capture) -> None:
        try:
            while not capture.stop_event.is_set() and len(capture.buffer) < capture.max_bytes:
                frames = self.device_manager.read_audio_frames(timeout=self.read_timeout)
                if not frames:
                    continue
                if not isinstance(frames, (bytes, bytearray, memoryview)):
                    raise TypeError("audio recorder returned non-bytes PCM frames")
                remaining = capture.max_bytes - len(capture.buffer)
                capture.buffer.extend(bytes(frames)[:remaining])
                if len(capture.buffer) >= capture.max_bytes:
                    capture.stop_event.set()
                    break
        except Exception as exc:
            capture.error = exc
        finally:
            try:
                self.device_manager.stop_record()
            except Exception as exc:
                if capture.error is None:
                    capture.error = exc
            capture.done_event.set()

    def _status_for(self, capture: _Capture) -> dict:
        return {
            "active": True,
            "kind": capture.kind,
            "subjectId": capture.subject_id,
            "sampleRate": self.sample_rate,
            "capturedBytes": len(capture.buffer),
            "maxBytes": capture.max_bytes,
            "complete": capture.done_event.is_set(),
        }
