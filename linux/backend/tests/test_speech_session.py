from __future__ import annotations

from dataclasses import dataclass, field

from app.ai.speech.types import SpeechEventType
from speech_worker.session import SpeechSession


@dataclass
class FakeRuntime:
    vad_outputs: list[list[list[int]]]
    vad_calls: list[dict] = field(default_factory=list)
    transcribe_calls: list[tuple[bytes, int]] = field(default_factory=list)
    speaker_calls: list[tuple[bytes, int]] = field(default_factory=list)

    def vad_stream(
        self,
        pcm: bytes,
        sample_rate: int,
        *,
        cache: dict,
        is_final: bool,
        chunk_size_ms: int = 200,
    ) -> list[list[int]]:
        self.vad_calls.append(
            {
                "pcm": pcm,
                "sample_rate": sample_rate,
                "cache": cache,
                "is_final": is_final,
                "chunk_size_ms": chunk_size_ms,
            }
        )
        return self.vad_outputs.pop(0) if self.vad_outputs else []

    def transcribe(self, pcm: bytes, sample_rate: int) -> dict:
        self.transcribe_calls.append((pcm, sample_rate))
        return {"text": "测试口供", "confidence": 0.93}

    def speaker_embedding(self, pcm: bytes, sample_rate: int) -> dict:
        self.speaker_calls.append((pcm, sample_rate))
        return {"embedding": [0.6, 0.8], "model_id": "xvector"}


def _pcm(ms: int, sample_rate: int = 16000, value: int = 1) -> bytes:
    samples = sample_rate * ms // 1000
    frame = int(value).to_bytes(2, byteorder="little", signed=True)
    return frame * samples


def test_push_pcm_feeds_only_new_chunk_into_streaming_vad():
    runtime = FakeRuntime(vad_outputs=[[], []])
    session = SpeechSession("session-1", 16000, runtime, chunk_size_ms=200)
    chunk1 = _pcm(200, value=1)
    chunk2 = _pcm(200, value=2)

    assert session.push_pcm(chunk1) == []
    assert session.push_pcm(chunk2) == []

    assert [call["pcm"] for call in runtime.vad_calls] == [chunk1, chunk2]
    assert runtime.vad_calls[0]["cache"] is runtime.vad_calls[1]["cache"]
    assert runtime.vad_calls[0]["is_final"] is False
    assert runtime.vad_calls[1]["is_final"] is False
    assert runtime.vad_calls[0]["chunk_size_ms"] == 200
    assert session.stream_offset_ms == 400


def test_start_then_end_decodes_utterance_once_with_shared_bounds():
    runtime = FakeRuntime(vad_outputs=[[[0, -1]], [[-1, 300]]])
    session = SpeechSession("session-2", 16000, runtime, chunk_size_ms=200)
    first = _pcm(200, value=1)
    second = _pcm(200, value=2)

    start_events = session.push_pcm(first)
    assert [event.type for event in start_events] == [SpeechEventType.VAD_START]
    assert start_events[0].start_ms == 0
    assert runtime.transcribe_calls == []
    assert runtime.speaker_calls == []

    final_events = session.push_pcm(second)
    assert [event.type for event in final_events] == [
        SpeechEventType.VAD_END,
        SpeechEventType.ASR_FINAL,
        SpeechEventType.SPEAKER_RESULT,
    ]
    assert [(event.start_ms, event.end_ms) for event in final_events] == [(0, 300)] * 3
    assert final_events[1].text == "测试口供"
    assert final_events[1].confidence == 0.93
    assert final_events[2].embedding == [0.6, 0.8]
    assert final_events[2].model_id == "xvector"
    assert all(event.type is not SpeechEventType.ASR_PARTIAL for event in final_events)

    expected_utterance = first + _pcm(100, value=2)
    assert runtime.transcribe_calls == [(expected_utterance, 16000)]
    assert runtime.speaker_calls == [(expected_utterance, 16000)]


def test_delayed_start_recovers_audio_from_preroll_using_absolute_vad_time():
    runtime = FakeRuntime(vad_outputs=[[], [[100, -1]], [[-1, 500]]])
    session = SpeechSession(
        "session-3",
        16000,
        runtime,
        chunk_size_ms=200,
        pre_roll_ms=600,
    )
    first = _pcm(200, value=1)
    second = _pcm(200, value=2)
    third = _pcm(200, value=3)

    assert session.push_pcm(first) == []
    start_events = session.push_pcm(second)
    assert len(start_events) == 1
    assert start_events[0].type is SpeechEventType.VAD_START
    assert start_events[0].start_ms == 100

    final_events = session.push_pcm(third)
    assert [(event.start_ms, event.end_ms) for event in final_events] == [(100, 500)] * 3

    expected = _pcm(100, value=1) + second + _pcm(100, value=3)
    assert runtime.transcribe_calls == [(expected, 16000)]
    assert runtime.speaker_calls == [(expected, 16000)]


def test_complete_segment_in_one_vad_result_is_decoded_once():
    runtime = FakeRuntime(vad_outputs=[[[50, 150]]])
    session = SpeechSession("session-4", 16000, runtime, chunk_size_ms=200)
    chunk = _pcm(200, value=7)

    events = session.push_pcm(chunk)

    assert [event.type for event in events] == [
        SpeechEventType.VAD_START,
        SpeechEventType.VAD_END,
        SpeechEventType.ASR_FINAL,
        SpeechEventType.SPEAKER_RESULT,
    ]
    assert events[0].start_ms == 50
    assert [(event.start_ms, event.end_ms) for event in events[1:]] == [(50, 150)] * 3
    assert runtime.transcribe_calls == [(_pcm(100, value=7), 16000)]
    assert runtime.speaker_calls == [(_pcm(100, value=7), 16000)]


def test_finalize_flushes_vad_and_closes_active_utterance_without_duplicate_decode():
    runtime = FakeRuntime(vad_outputs=[[[100, -1]], [[-1, 200]]])
    session = SpeechSession("session-5", 16000, runtime, chunk_size_ms=200)
    chunk = _pcm(200, value=9)

    session.push_pcm(chunk)
    events = session.finalize()

    assert runtime.vad_calls[-1]["pcm"] == b""
    assert runtime.vad_calls[-1]["is_final"] is True
    assert [event.type for event in events] == [
        SpeechEventType.VAD_END,
        SpeechEventType.ASR_FINAL,
        SpeechEventType.SPEAKER_RESULT,
    ]
    assert [(event.start_ms, event.end_ms) for event in events] == [(100, 200)] * 3
    expected = _pcm(100, value=9)
    assert runtime.transcribe_calls == [(expected, 16000)]
    assert runtime.speaker_calls == [(expected, 16000)]

    assert session.finalize() == []
    assert len(runtime.transcribe_calls) == 1
    assert len(runtime.speaker_calls) == 1
