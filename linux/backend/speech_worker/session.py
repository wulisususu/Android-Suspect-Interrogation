from __future__ import annotations

import time
from typing import Any, Protocol

from app.ai.errors import AIError, WorkerCrashedError
from app.ai.speech.types import SpeechEvent, SpeechEventType


PCM_SAMPLE_WIDTH_BYTES = 2


class SpeechRuntime(Protocol):
    def vad_stream(
        self,
        pcm: bytes,
        sample_rate: int,
        *,
        cache: dict[str, Any],
        is_final: bool,
        chunk_size_ms: int = 200,
    ) -> list[list[int]]: ...

    def transcribe(self, pcm: bytes, sample_rate: int) -> dict[str, Any]: ...

    def speaker_embedding(self, pcm: bytes, sample_rate: int) -> dict[str, Any]: ...


class SpeechSession:
    """Session-local streaming VAD state and utterance assembly.

    Input is 16-bit mono PCM. FunASR streaming VAD timestamps are treated as
    absolute milliseconds from the beginning of this session. Only new PCM is
    passed to VAD; a bounded pre-roll window is retained so delayed VAD start
    events can recover already-received audio without keeping the whole stream.
    """

    def __init__(
        self,
        session_id: str,
        sample_rate: int,
        runtime: SpeechRuntime,
        *,
        chunk_size_ms: int = 200,
        pre_roll_ms: int = 1200,
    ) -> None:
        if not session_id:
            raise ValueError("session_id is required")
        if int(sample_rate) <= 0:
            raise ValueError("sample_rate must be positive")
        if int(chunk_size_ms) <= 0:
            raise ValueError("chunk_size_ms must be positive")
        if int(pre_roll_ms) < 0:
            raise ValueError("pre_roll_ms cannot be negative")

        self.session_id = session_id
        self.sample_rate = int(sample_rate)
        self.runtime = runtime
        self.chunk_size_ms = int(chunk_size_ms)
        self.pre_roll_ms = int(pre_roll_ms)

        self.pre_roll_pcm = b""
        self.current_utterance_pcm = bytearray()
        self.vad_cache: dict[str, Any] = {}
        self.utterance_start_ms: int | None = None
        self.stream_offset_ms = 0
        self.last_activity_monotonic = time.monotonic()

        self._pre_roll_start_ms = 0
        self._capture_start_ms: int | None = None
        self._stream_samples = 0
        self._finalized = False

    def push_pcm(self, pcm: bytes) -> list[SpeechEvent]:
        if self._finalized:
            raise RuntimeError("speech session is already finalized")
        if not isinstance(pcm, (bytes, bytearray, memoryview)):
            raise TypeError("pcm must be bytes-like")
        chunk = bytes(pcm)
        if len(chunk) % PCM_SAMPLE_WIDTH_BYTES:
            raise ValueError("PCM16 input must contain complete 2-byte samples")
        if not chunk:
            return []

        chunk_samples = len(chunk) // PCM_SAMPLE_WIDTH_BYTES
        self._stream_samples += chunk_samples
        chunk_end_ms = self._samples_to_ms(self._stream_samples)
        self.stream_offset_ms = chunk_end_ms
        self.last_activity_monotonic = time.monotonic()

        if self.utterance_start_ms is None:
            self._append_pre_roll(chunk, chunk_end_ms)
        else:
            self.current_utterance_pcm.extend(chunk)

        vad_events = self.runtime.vad_stream(
            chunk,
            self.sample_rate,
            cache=self.vad_cache,
            is_final=False,
            chunk_size_ms=self.chunk_size_ms,
        )
        return self._consume_vad_events(vad_events)

    def finalize(self) -> list[SpeechEvent]:
        if self._finalized:
            return []

        self.last_activity_monotonic = time.monotonic()
        vad_events = self.runtime.vad_stream(
            b"",
            self.sample_rate,
            cache=self.vad_cache,
            is_final=True,
            chunk_size_ms=self.chunk_size_ms,
        )
        events = self._consume_vad_events(vad_events)

        if self.utterance_start_ms is not None:
            if self.stream_offset_ms > self.utterance_start_ms:
                events.extend(self._finish_utterance(self.stream_offset_ms, forced_final=True))
            else:
                self._reset_utterance()

        self._finalized = True
        return events

    def _consume_vad_events(self, vad_events: list[list[int]]) -> list[SpeechEvent]:
        events: list[SpeechEvent] = []
        for segment in vad_events:
            if not isinstance(segment, (list, tuple)) or len(segment) != 2:
                raise WorkerCrashedError("FunASR streaming VAD event must contain [start_ms, end_ms]")
            start_ms, end_ms = int(segment[0]), int(segment[1])

            if start_ms >= 0 and end_ms == -1:
                if self.utterance_start_ms is None:
                    events.append(self._start_utterance(start_ms))
                continue

            if start_ms == -1 and end_ms >= 0:
                if self.utterance_start_ms is not None:
                    events.extend(self._finish_utterance(end_ms))
                continue

            if start_ms >= 0 and end_ms >= 0:
                if self.utterance_start_ms is None:
                    events.append(self._start_utterance(start_ms))
                events.extend(self._finish_utterance(end_ms))
                continue

            if start_ms == -1 and end_ms == -1:
                continue
            raise WorkerCrashedError(
                "FunASR streaming VAD returned invalid negative boundary",
                details={"segment": [start_ms, end_ms]},
            )
        return events

    def _start_utterance(self, start_ms: int) -> SpeechEvent:
        if start_ms > self.stream_offset_ms:
            raise WorkerCrashedError(
                "FunASR VAD start is beyond received audio",
                details={"start_ms": start_ms, "stream_offset_ms": self.stream_offset_ms},
            )

        capture_start_ms = max(start_ms, self._pre_roll_start_ms)
        offset_ms = max(0, capture_start_ms - self._pre_roll_start_ms)
        offset_bytes = min(len(self.pre_roll_pcm), self._ms_to_bytes(offset_ms))
        self.current_utterance_pcm = bytearray(self.pre_roll_pcm[offset_bytes:])
        self.utterance_start_ms = start_ms
        self._capture_start_ms = capture_start_ms
        self.pre_roll_pcm = b""
        self._pre_roll_start_ms = self.stream_offset_ms

        details: dict[str, Any] = {}
        if capture_start_ms != start_ms:
            details["pre_roll_truncated"] = True
            details["captured_from_ms"] = capture_start_ms
        return SpeechEvent(
            type=SpeechEventType.VAD_START,
            session_id=self.session_id,
            start_ms=start_ms,
            details=details,
        )

    def _finish_utterance(self, end_ms: int, *, forced_final: bool = False) -> list[SpeechEvent]:
        start_ms = self.utterance_start_ms
        capture_start_ms = self._capture_start_ms
        if start_ms is None or capture_start_ms is None:
            return []
        if end_ms <= start_ms:
            raise WorkerCrashedError(
                "FunASR VAD end must be after start",
                details={"start_ms": start_ms, "end_ms": end_ms},
            )
        if end_ms > self.stream_offset_ms:
            raise WorkerCrashedError(
                "FunASR VAD end is beyond received audio",
                details={"end_ms": end_ms, "stream_offset_ms": self.stream_offset_ms},
            )

        captured_duration_ms = max(0, end_ms - capture_start_ms)
        utterance_bytes = min(
            len(self.current_utterance_pcm),
            self._ms_to_bytes(captured_duration_ms),
        )
        utterance_pcm = bytes(self.current_utterance_pcm[:utterance_bytes])
        trailing_pcm = bytes(self.current_utterance_pcm[utterance_bytes:])

        self._reset_utterance()
        self._set_pre_roll_after_boundary(trailing_pcm, end_ms)

        if not utterance_pcm:
            return [
                SpeechEvent(
                    type=SpeechEventType.VAD_END,
                    session_id=self.session_id,
                    start_ms=start_ms,
                    end_ms=end_ms,
                    details={"forced_final": forced_final} if forced_final else {},
                )
            ]

        # ASR is authoritative for text. Its failure must propagate so callers
        # never fabricate a transcript. Speaker attribution is independent and
        # may degrade to UNKNOWN when the configured speaker backend is unavailable.
        asr = self.runtime.transcribe(utterance_pcm, self.sample_rate)
        common_details: dict[str, Any] = {"forced_final": True} if forced_final else {}
        speaker: dict[str, Any] | None = None
        try:
            speaker = self.runtime.speaker_embedding(utterance_pcm, self.sample_rate)
        except AIError as exc:
            common_details = {
                **common_details,
                "speaker_unavailable": True,
                "speaker_error_code": exc.code,
            }

        events = [
            SpeechEvent(
                type=SpeechEventType.VAD_END,
                session_id=self.session_id,
                start_ms=start_ms,
                end_ms=end_ms,
                details=common_details,
            ),
            SpeechEvent(
                type=SpeechEventType.ASR_FINAL,
                session_id=self.session_id,
                start_ms=start_ms,
                end_ms=end_ms,
                text=str(asr.get("text") or ""),
                confidence=None if asr.get("confidence") is None else float(asr["confidence"]),
                model_id=str(asr.get("model_id") or "paraformer"),
                details={
                    **common_details,
                    **({"model_version": str(asr["model_version"])} if asr.get("model_version") is not None else {}),
                },
            ),
        ]
        if speaker is not None:
            backend_key = str(speaker.get("backend_key") or "").strip()
            model_id = str(speaker.get("model_id") or "").strip()
            if not backend_key or not model_id:
                raise WorkerCrashedError(
                    "speaker result did not contain required model metadata",
                    details={
                        "has_backend_key": bool(backend_key),
                        "has_model_id": bool(model_id),
                    },
                )

            speaker_details: dict[str, Any] = {
                "backend_key": backend_key,
                **({"forced_final": True} if forced_final else {}),
            }
            if speaker.get("model_version") is not None:
                speaker_details["model_version"] = str(speaker["model_version"])
            if speaker.get("model_fingerprint") is not None:
                speaker_details["model_fingerprint"] = str(speaker["model_fingerprint"])
            if speaker.get("latency_ms") is not None:
                speaker_details["latency_ms"] = float(speaker["latency_ms"])
            events.append(
                SpeechEvent(
                    type=SpeechEventType.SPEAKER_RESULT,
                    session_id=self.session_id,
                    start_ms=start_ms,
                    end_ms=end_ms,
                    embedding=[float(value) for value in speaker.get("embedding", [])],
                    model_id=model_id,
                    details=speaker_details,
                )
            )
        return events

    def _append_pre_roll(self, pcm: bytes, end_ms: int) -> None:
        max_bytes = self._ms_to_bytes(self.pre_roll_ms)
        if max_bytes <= 0:
            self.pre_roll_pcm = b""
            self._pre_roll_start_ms = end_ms
            return
        combined = self.pre_roll_pcm + pcm
        if len(combined) > max_bytes:
            combined = combined[-max_bytes:]
        self.pre_roll_pcm = combined
        retained_ms = self._bytes_to_ms(len(combined))
        self._pre_roll_start_ms = max(0, end_ms - retained_ms)

    def _set_pre_roll_after_boundary(self, pcm: bytes, boundary_ms: int) -> None:
        max_bytes = self._ms_to_bytes(self.pre_roll_ms)
        if max_bytes <= 0 or not pcm:
            self.pre_roll_pcm = b""
            self._pre_roll_start_ms = self.stream_offset_ms
            return
        kept = pcm[-max_bytes:]
        kept_ms = self._bytes_to_ms(len(kept))
        self.pre_roll_pcm = kept
        self._pre_roll_start_ms = max(boundary_ms, self.stream_offset_ms - kept_ms)

    def _reset_utterance(self) -> None:
        self.current_utterance_pcm = bytearray()
        self.utterance_start_ms = None
        self._capture_start_ms = None

    def _ms_to_bytes(self, milliseconds: int) -> int:
        samples = int(round(int(milliseconds) * self.sample_rate / 1000.0))
        return max(0, samples) * PCM_SAMPLE_WIDTH_BYTES

    def _bytes_to_ms(self, size: int) -> int:
        samples = int(size) // PCM_SAMPLE_WIDTH_BYTES
        return self._samples_to_ms(samples)

    def _samples_to_ms(self, samples: int) -> int:
        return int(round(int(samples) * 1000.0 / self.sample_rate))
