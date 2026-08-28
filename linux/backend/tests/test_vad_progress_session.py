from __future__ import annotations

from typing import Any

from speech_worker.vad_progress import VadProgressSession


class FakeStreamingVadRuntime:
    def __init__(self, events: list[list[list[int]]]):
        self.events = list(events)
        self.calls: list[dict[str, Any]] = []

    def vad_stream(
        self,
        pcm: bytes,
        sample_rate: int,
        *,
        cache: dict[str, Any],
        is_final: bool,
        chunk_size_ms: int = 200,
    ) -> list[list[int]]:
        self.calls.append({
            "pcm": bytes(pcm),
            "sample_rate": sample_rate,
            "cache": cache,
            "is_final": is_final,
            "chunk_size_ms": chunk_size_ms,
        })
        return self.events.pop(0) if self.events else []


def pcm_ms(milliseconds: int) -> bytes:
    return b"\x01\x00" * (milliseconds * 16000 // 1000)


def test_open_speech_segment_counts_new_stream_time_without_double_counting():
    runtime = FakeStreamingVadRuntime([[[0, -1]], [], []])
    session = VadProgressSession("vp-1", 16000, runtime)

    first = session.push_pcm(pcm_ms(10000))
    second = session.push_pcm(pcm_ms(10000))
    final = session.finalize()

    assert first["usableDurationMs"] == 10000
    assert second["usableDurationMs"] == 20000
    assert final["usableDurationMs"] == 20000
    assert final["segments"] == [[0, 20000]]


def test_closed_and_reopened_speech_segments_accumulate_only_voiced_ranges():
    runtime = FakeStreamingVadRuntime([
        [[1000, -1]],
        [[-1, 6000]],
        [[9000, -1]],
        [[-1, 15000]],
        [],
    ])
    session = VadProgressSession("vp-2", 16000, runtime)

    session.push_pcm(pcm_ms(4000))
    after_first_end = session.push_pcm(pcm_ms(3000))
    session.push_pcm(pcm_ms(4000))
    after_second_end = session.push_pcm(pcm_ms(5000))
    final = session.finalize()

    assert after_first_end["usableDurationMs"] == 5000
    assert after_second_end["usableDurationMs"] == 11000
    assert final["segments"] == [[1000, 6000], [9000, 15000]]
    assert final["usableDurationMs"] == 11000
