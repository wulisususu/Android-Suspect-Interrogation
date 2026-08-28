from __future__ import annotations

from typing import Any, Protocol

from app.ai.errors import WorkerCrashedError


PCM_SAMPLE_WIDTH_BYTES = 2


class StreamingVadRuntime(Protocol):
    def vad_stream(
        self,
        pcm: bytes,
        sample_rate: int,
        *,
        cache: dict[str, Any],
        is_final: bool,
        chunk_size_ms: int = 200,
    ) -> list[list[int]]: ...


class VadProgressSession:
    """Lightweight streaming VAD session used only for enrollment progress.

    It never runs ASR or speaker embedding. Closed speech ranges are accumulated
    exactly once; while a speech range is open, progress advances with received
    PCM so a continuously speaking person does not need to pause just to make
    the UI reach the target.
    """

    def __init__(
        self,
        session_id: str,
        sample_rate: int,
        runtime: StreamingVadRuntime,
        *,
        chunk_size_ms: int = 200,
    ) -> None:
        if not session_id:
            raise ValueError("session_id is required")
        if int(sample_rate) <= 0:
            raise ValueError("sample_rate must be positive")
        if int(chunk_size_ms) <= 0:
            raise ValueError("chunk_size_ms must be positive")
        self.session_id = session_id
        self.sample_rate = int(sample_rate)
        self.runtime = runtime
        self.chunk_size_ms = int(chunk_size_ms)
        self.vad_cache: dict[str, Any] = {}
        self._stream_samples = 0
        self._active_start_ms: int | None = None
        self._segments: list[list[int]] = []
        self._finalized = False

    @property
    def stream_offset_ms(self) -> int:
        return self._samples_to_ms(self._stream_samples)

    def push_pcm(self, pcm: bytes) -> dict[str, Any]:
        if self._finalized:
            raise RuntimeError("VAD progress session is already finalized")
        if not isinstance(pcm, (bytes, bytearray, memoryview)):
            raise TypeError("pcm must be bytes-like")
        chunk = bytes(pcm)
        if len(chunk) % PCM_SAMPLE_WIDTH_BYTES:
            raise ValueError("PCM16 input must contain complete 2-byte samples")
        if not chunk:
            return self._snapshot()

        self._stream_samples += len(chunk) // PCM_SAMPLE_WIDTH_BYTES
        events = self.runtime.vad_stream(
            chunk,
            self.sample_rate,
            cache=self.vad_cache,
            is_final=False,
            chunk_size_ms=self.chunk_size_ms,
        )
        self._consume(events)
        return self._snapshot()

    def finalize(self) -> dict[str, Any]:
        if self._finalized:
            return self._snapshot()
        events = self.runtime.vad_stream(
            b"",
            self.sample_rate,
            cache=self.vad_cache,
            is_final=True,
            chunk_size_ms=self.chunk_size_ms,
        )
        self._consume(events)
        if self._active_start_ms is not None:
            self._close_segment(self.stream_offset_ms)
        self._finalized = True
        return self._snapshot()

    def _consume(self, events: list[list[int]]) -> None:
        for item in events:
            if not isinstance(item, (list, tuple)) or len(item) != 2:
                raise WorkerCrashedError("FunASR streaming VAD event must contain [start_ms, end_ms]")
            start_ms, end_ms = int(item[0]), int(item[1])
            if start_ms >= 0 and end_ms == -1:
                self._open_segment(start_ms)
                continue
            if start_ms == -1 and end_ms >= 0:
                self._close_segment(end_ms)
                continue
            if start_ms >= 0 and end_ms >= 0:
                if self._active_start_ms is None:
                    self._open_segment(start_ms)
                self._close_segment(end_ms)
                continue
            if start_ms == -1 and end_ms == -1:
                continue
            raise WorkerCrashedError(
                "FunASR streaming VAD returned invalid negative boundary",
                details={"segment": [start_ms, end_ms]},
            )

    def _open_segment(self, start_ms: int) -> None:
        if start_ms > self.stream_offset_ms:
            raise WorkerCrashedError(
                "FunASR VAD start is beyond received audio",
                details={"start_ms": start_ms, "stream_offset_ms": self.stream_offset_ms},
            )
        if self._active_start_ms is None:
            self._active_start_ms = max(0, start_ms)

    def _close_segment(self, end_ms: int) -> None:
        start_ms = self._active_start_ms
        if start_ms is None:
            return
        bounded_end = min(max(0, end_ms), self.stream_offset_ms)
        if bounded_end > start_ms:
            self._append_segment(start_ms, bounded_end)
        self._active_start_ms = None

    def _append_segment(self, start_ms: int, end_ms: int) -> None:
        if not self._segments:
            self._segments.append([start_ms, end_ms])
            return
        last = self._segments[-1]
        if start_ms <= last[1]:
            last[1] = max(last[1], end_ms)
        else:
            self._segments.append([start_ms, end_ms])

    def _snapshot(self) -> dict[str, Any]:
        segments = [list(item) for item in self._segments]
        usable = sum(end - start for start, end in segments)
        if self._active_start_ms is not None and self.stream_offset_ms > self._active_start_ms:
            usable += self.stream_offset_ms - self._active_start_ms
        return {
            "sessionId": self.session_id,
            "streamOffsetMs": self.stream_offset_ms,
            "usableDurationMs": max(0, int(usable)),
            "segments": segments,
            "activeSpeechStartMs": self._active_start_ms,
            "finalized": self._finalized,
        }

    def _samples_to_ms(self, samples: int) -> int:
        return int(round(int(samples) * 1000.0 / self.sample_rate))
