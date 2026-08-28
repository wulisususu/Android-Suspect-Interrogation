from __future__ import annotations

import threading
import uuid
from dataclasses import dataclass, field
from typing import Any

from app.domain.errors import DomainError


_CAPTURE_SOURCES = {"ALSA", "BROWSER"}
_COMPLETE_REASONS = {"USABLE_SPEECH_TARGET", "SAFETY_TIMEOUT"}


@dataclass
class _Capture:
    kind: str
    subject_id: str
    capture_id: str
    source: str
    max_bytes: int
    vad_session_id: str | None = None
    buffer: bytearray = field(default_factory=bytearray)
    vad_pending: bytearray = field(default_factory=bytearray)
    usable_speech_ms: int = 0
    complete_reason: str | None = None
    last_batch_confirmation_ms: int = 0
    stop_event: threading.Event = field(default_factory=threading.Event)
    done_event: threading.Event = field(default_factory=threading.Event)
    error: Exception | None = None
    thread: threading.Thread | None = None


class AudioCaptureService:
    """Own one PCM16 voiceprint enrollment capture.

    ALSA capture reads from the RK3588 recorder in a collector thread.
    BROWSER capture receives PCM through ``push_browser_pcm`` and never opens
    the board recorder. Both sources share the same streaming FSMN-VAD buffer
    and final enrollment PCM. A source is fixed for the lifetime of a capture.
    """

    def __init__(
        self,
        device_manager: Any,
        *,
        speech_client: Any | None = None,
        sample_rate: int = 16000,
        max_seconds: int = 300,
        required_usable_speech_ms: int = 20000,
        vad_chunk_ms: int = 200,
        read_timeout: float = 0.5,
        stop_wait_seconds: float = 5.0,
    ) -> None:
        self.device_manager = device_manager
        self.speech_client = speech_client
        self.sample_rate = int(sample_rate)
        self.max_seconds = int(max_seconds)
        self.required_usable_speech_ms = int(required_usable_speech_ms)
        self.vad_chunk_ms = int(vad_chunk_ms)
        self.read_timeout = max(0.01, float(read_timeout))
        self.stop_wait_seconds = max(0.1, float(stop_wait_seconds))
        if self.sample_rate <= 0 or self.max_seconds <= 0:
            raise ValueError("sample_rate and max_seconds must be positive")
        if self.required_usable_speech_ms <= 0 or self.vad_chunk_ms <= 0:
            raise ValueError("required_usable_speech_ms and vad_chunk_ms must be positive")
        self.max_bytes = self.sample_rate * 2 * self.max_seconds
        self.vad_chunk_bytes = max(2, self.sample_rate * 2 * self.vad_chunk_ms // 1000)
        self._lock = threading.RLock()
        self._capture: _Capture | None = None

    def start(self, kind: str, subject_id: str, source: str = "ALSA") -> dict:
        kind = str(kind).strip()
        subject_id = str(subject_id).strip()
        source = str(source or "ALSA").strip().upper()
        if not kind or not subject_id:
            raise DomainError("CAPTURE_SUBJECT_REQUIRED", "录音对象不能为空", 400)
        if source not in _CAPTURE_SOURCES:
            raise DomainError("CAPTURE_SOURCE_INVALID", "声纹录音音源无效", 400)

        with self._lock:
            active = self._capture
        if active is not None:
            self.stop(active.kind, active.subject_id)

        vad_session_id: str | None = None
        if self.speech_client is not None:
            vad_session_id = f"voiceprint-{uuid.uuid4().hex}"
            try:
                self.speech_client.open_vad_session(vad_session_id, self.sample_rate)
            except Exception as exc:
                raise DomainError("VOICEPRINT_VAD_UNAVAILABLE", f"无法启动实时有效语音检测：{exc}", 503) from exc

        capture = _Capture(
            kind=kind,
            subject_id=subject_id,
            capture_id=uuid.uuid4().hex,
            source=source,
            max_bytes=self.max_bytes,
            vad_session_id=vad_session_id,
        )

        if source == "BROWSER":
            with self._lock:
                self._capture = capture
                return self._status_for(capture)

        with self._lock:
            try:
                self.device_manager.start_record()
            except Exception as exc:
                self._close_vad_session(vad_session_id)
                raise DomainError("AUDIO_CAPTURE_FAILED", f"无法启动录音设备：{exc}", 500) from exc
            self._capture = capture
            initial_status = self._status_for(capture)
            thread = threading.Thread(
                target=self._collect,
                args=(capture,),
                daemon=True,
                name=f"voiceprint-capture-{kind}",
            )
            capture.thread = thread
            thread.start()
            return initial_status

    def stop(self, kind: str, subject_id: str) -> bytes:
        kind = str(kind).strip()
        subject_id = str(subject_id).strip()
        with self._lock:
            capture = self._capture
            if capture is None:
                raise DomainError("CAPTURE_NOT_ACTIVE", "当前没有正在进行的声纹录音", 409)
            if capture.kind != kind or capture.subject_id != subject_id:
                raise DomainError("CAPTURE_SUBJECT_MISMATCH", "当前声纹录音对象不匹配", 409)
            if capture.complete_reason is None:
                capture.complete_reason = "MANUAL_STOP"
            thread = capture.thread
            if capture.source == "ALSA":
                capture.stop_event.set()

        if capture.source == "ALSA":
            if thread is not None and thread.is_alive():
                thread.join(timeout=self.stop_wait_seconds)
            if not capture.done_event.wait(timeout=self.stop_wait_seconds):
                raise DomainError("AUDIO_CAPTURE_STOP_TIMEOUT", "录音设备停止超时", 500)
        else:
            try:
                self._finalize_vad(capture)
            except Exception as exc:
                capture.error = capture.error or exc
            capture.done_event.set()

        with self._lock:
            if self._capture is capture:
                self._capture = None
        if capture.error is not None:
            raise DomainError("AUDIO_CAPTURE_FAILED", f"录音采集失败：{capture.error}", 500) from capture.error
        return bytes(capture.buffer)

    def cancel(self, capture_id: str | None = None) -> dict:
        with self._lock:
            capture = self._capture
            if capture is None:
                raise DomainError("CAPTURE_NOT_ACTIVE", "当前没有正在进行的声纹录音", 409)
            if capture_id and capture.capture_id != str(capture_id):
                raise DomainError("CAPTURE_ID_MISMATCH", "声纹录音会话已失效，请重新开始", 409)
            capture.complete_reason = "CANCELLED"
            thread = capture.thread
            if capture.source == "ALSA":
                capture.stop_event.set()

        if capture.source == "ALSA":
            if thread is not None and thread.is_alive():
                thread.join(timeout=self.stop_wait_seconds)
            if not capture.done_event.wait(timeout=self.stop_wait_seconds):
                raise DomainError("AUDIO_CAPTURE_STOP_TIMEOUT", "录音设备停止超时", 500)
        else:
            self._close_vad_session(capture.vad_session_id)
            capture.vad_session_id = None
            capture.vad_pending.clear()
            capture.done_event.set()

        with self._lock:
            if self._capture is capture:
                self._capture = None
        return {"cancelled": True, "captureId": capture.capture_id, "source": capture.source}

    def push_browser_pcm(self, capture_id: str, pcm: bytes) -> dict:
        if not isinstance(pcm, (bytes, bytearray, memoryview)):
            raise DomainError("CAPTURE_PCM_INVALID", "浏览器声纹音频必须为 PCM16 二进制数据", 400)
        chunk = bytes(pcm)
        if not chunk:
            raise DomainError("CAPTURE_PCM_EMPTY", "浏览器声纹音频不能为空", 400)
        if len(chunk) % 2:
            raise DomainError("CAPTURE_PCM_ALIGNMENT", "浏览器声纹音频必须按 PCM16 样本对齐", 400)

        with self._lock:
            capture = self._capture
            if capture is None:
                raise DomainError("CAPTURE_NOT_ACTIVE", "当前没有正在进行的声纹录音", 409)
            if capture.capture_id != str(capture_id):
                raise DomainError("CAPTURE_ID_MISMATCH", "声纹录音会话已失效，请重新开始", 409)
            if capture.source != "BROWSER":
                raise DomainError("CAPTURE_SOURCE_MISMATCH", "当前声纹录音不是浏览器音源", 409)
            if capture.complete_reason in _COMPLETE_REASONS:
                return self._status_for(capture)
            self._ingest_chunk(capture, chunk)
            return self._status_for(capture)

    def status(self) -> dict:
        with self._lock:
            capture = self._capture
            if capture is None:
                target_ms = self.required_usable_speech_ms if self.speech_client is not None else self.max_seconds * 1000
                return {
                    "active": False,
                    "kind": None,
                    "subjectId": None,
                    "captureId": None,
                    "source": None,
                    "sampleRate": self.sample_rate,
                    "capturedBytes": 0,
                    "maxBytes": self.max_bytes,
                    "capturedDurationMs": 0,
                    "recordedDurationMs": 0,
                    "usableSpeechMs": 0,
                    "requiredUsableSpeechMs": self.required_usable_speech_ms,
                    "targetDurationMs": target_ms,
                    "safetyLimitMs": self.max_seconds * 1000,
                    "complete": False,
                    "completeReason": None,
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
                self._ingest_chunk(capture, bytes(frames))
                if capture.complete_reason in _COMPLETE_REASONS:
                    break
        except Exception as exc:
            capture.error = exc
        finally:
            try:
                self._finalize_vad(capture)
            except Exception as exc:
                if capture.error is None:
                    capture.error = exc
            try:
                self.device_manager.stop_record()
            except Exception as exc:
                if capture.error is None:
                    capture.error = exc
            capture.done_event.set()

    def _ingest_chunk(self, capture: _Capture, pcm: bytes) -> None:
        if not pcm or capture.complete_reason in _COMPLETE_REASONS:
            return
        remaining = capture.max_bytes - len(capture.buffer)
        if remaining <= 0:
            capture.complete_reason = "SAFETY_TIMEOUT"
            capture.stop_event.set()
            return
        chunk = pcm[:remaining]
        if len(chunk) % 2:
            chunk = chunk[:-1]
        if not chunk:
            return
        capture.buffer.extend(chunk)
        if capture.vad_session_id is not None:
            capture.vad_pending.extend(chunk)
            self._push_ready_vad_chunks(capture)
            if self._effective_speech_target_confirmed(capture):
                capture.complete_reason = "USABLE_SPEECH_TARGET"
                capture.stop_event.set()
                return
        if len(capture.buffer) >= capture.max_bytes:
            capture.complete_reason = "SAFETY_TIMEOUT"
            capture.stop_event.set()

    def _push_ready_vad_chunks(self, capture: _Capture) -> None:
        session_id = capture.vad_session_id
        if session_id is None or self.speech_client is None:
            return
        while len(capture.vad_pending) >= self.vad_chunk_bytes:
            chunk = bytes(capture.vad_pending[:self.vad_chunk_bytes])
            del capture.vad_pending[:self.vad_chunk_bytes]
            progress = self.speech_client.push_vad_pcm(session_id, chunk)
            capture.usable_speech_ms = max(0, int(progress.get("usableDurationMs") or 0))

    def _effective_speech_target_confirmed(self, capture: _Capture) -> bool:
        if capture.usable_speech_ms < self.required_usable_speech_ms:
            return False
        batch_vad = getattr(self.speech_client, "speech_segments", None)
        if not callable(batch_vad):
            return True
        captured_ms = self._recorded_duration_ms(capture)
        if captured_ms - capture.last_batch_confirmation_ms < 1000:
            return False
        capture.last_batch_confirmation_ms = captured_ms
        segments = batch_vad(bytes(capture.buffer), self.sample_rate)
        capture.usable_speech_ms = sum(max(0, int(end) - int(start)) for start, end in segments)
        return capture.usable_speech_ms >= self.required_usable_speech_ms

    def _finalize_vad(self, capture: _Capture) -> None:
        session_id = capture.vad_session_id
        if session_id is None or self.speech_client is None:
            return
        try:
            if capture.vad_pending:
                progress = self.speech_client.push_vad_pcm(session_id, bytes(capture.vad_pending))
                capture.vad_pending.clear()
                capture.usable_speech_ms = max(0, int(progress.get("usableDurationMs") or 0))
            progress = self.speech_client.finalize_vad_session(session_id)
            capture.usable_speech_ms = max(capture.usable_speech_ms, int(progress.get("usableDurationMs") or 0))
        finally:
            self._close_vad_session(session_id)
            capture.vad_session_id = None

    def _close_vad_session(self, session_id: str | None) -> None:
        if session_id is None or self.speech_client is None:
            return
        try:
            self.speech_client.close_vad_session(session_id)
        except Exception:
            pass

    def _recorded_duration_ms(self, capture: _Capture) -> int:
        return len(capture.buffer) * 1000 // (self.sample_rate * 2)

    def _status_for(self, capture: _Capture) -> dict:
        streaming_vad = self.speech_client is not None
        recorded_ms = self._recorded_duration_ms(capture)
        target_ms = self.required_usable_speech_ms if streaming_vad else self.max_seconds * 1000
        return {
            "active": True,
            "kind": capture.kind,
            "subjectId": capture.subject_id,
            "captureId": capture.capture_id,
            "source": capture.source,
            "sampleRate": self.sample_rate,
            "capturedBytes": len(capture.buffer),
            "capturedDurationMs": recorded_ms,
            "recordedDurationMs": recorded_ms,
            "maxBytes": capture.max_bytes,
            "usableSpeechMs": capture.usable_speech_ms,
            "requiredUsableSpeechMs": self.required_usable_speech_ms,
            "safetyLimitMs": self.max_seconds * 1000,
            "targetDurationMs": target_ms,
            "complete": capture.complete_reason in _COMPLETE_REASONS,
            "completeReason": capture.complete_reason,
        }
