"""Replay verbatim RK3588 board generations through the MOSS parser and runtime.

The fixtures under ``tests/fixtures`` are byte-verbatim ``raw_generation``
captures from the fallback-gradient board runs (2026-09-09, audio sha256
``bd4776d6b321e7f5fd4d140576e3b2c9ffbe52d03acc9d149ec8fa707c53b998``, model
manifest ``a50ce60b04e3715a4ce9d05381336fd95072f359c7883115e946d55321657e69``).
The 8-minute capture is the production failure this repair policy fixes: its
final segment ends at 480.01 s, overshooting the 480.000 s window by exactly
one 10 ms model-raster step, which previously invalidated all 74 good
segments (board outcome: ``MOSS_INVALID_GENERATION``, 0 published segments).
"""
from pathlib import Path
from types import SimpleNamespace

import numpy as np
import pytest

from moss_worker.types import ParseStatus, WindowState, WindowSpec

FIXTURES = Path(__file__).parent / 'fixtures'


def load_replay(name):
    lines = (FIXTURES / name).read_text(encoding='utf-8').splitlines()
    raw = [line for line in lines if line and not line.startswith('#')]
    assert len(raw) == 1, 'fixture must hold exactly one verbatim raw_generation line'
    return raw[0]


def parse(raw, window):
    from moss_worker.parser import parse_generation
    return parse_generation(raw, window)


def gradient_8m():
    return load_replay('moss_replay_gradient_8m_w1.txt')


def test_board_8m_w1_overshoot_is_repaired_not_invalidated():
    parsed = parse(gradient_8m(), WindowSpec(0, 480000, 0, 8))
    assert len(parsed.valid_segments) == 75
    assert not parsed.invalid_fragments
    statuses = [segment.parse_status for segment in parsed.valid_segments]
    assert statuses.count(ParseStatus.VALID) == 74
    assert statuses.count(ParseStatus.REPAIRED) == 1
    repaired = parsed.valid_segments[-1]
    assert repaired.parse_status is ParseStatus.REPAIRED
    assert repaired.repair_reason == 'END_TIMESTAMP_CLAMPED_TO_WINDOW_END'
    assert repaired.repair_original_end_ms == 480010
    assert repaired.end_ms == 480000
    assert repaired.start_ms == 475460
    assert repaired.local_speaker == 'S01'
    assert repaired.text == '我们来确认一下周末的安排。星期六上午，你打算几点到图书馆？'
    # Runtime window verdict derives from the segment statuses: REPAIRED wins,
    # so the board run that previously died as MOSS_INVALID_GENERATION publishes.
    assert any(segment.parse_status is ParseStatus.REPAIRED
               for segment in parsed.valid_segments)


def test_board_8m_generation_with_110ms_overshoot_gets_zero_forgiveness():
    raw = gradient_8m()
    assert raw.count('[480.01]') == 1
    reversed_raw = raw.replace('[480.01]', '[480.11]')
    parsed = parse(reversed_raw, WindowSpec(0, 480000, 0, 8))
    assert len(parsed.valid_segments) == 74
    assert all(segment.parse_status is ParseStatus.VALID
               for segment in parsed.valid_segments)
    assert len(parsed.invalid_fragments) == 1
    fragment = parsed.invalid_fragments[0]
    assert fragment.raw.startswith('[475.46]')
    assert fragment.raw.endswith('[480.11]')
    assert fragment.parse_status is ParseStatus.INVALID


@pytest.mark.parametrize('fixture,minutes,expected_segments', [
    ('moss_replay_gradient_10m_w1.txt', 10, 94),
    ('moss_replay_gradient_12m_w1.txt', 12, 112),
])
def test_in_bounds_board_generations_remain_all_valid(fixture, minutes, expected_segments):
    parsed = parse(load_replay(fixture), WindowSpec(0, minutes * 60000, 0, minutes))
    assert len(parsed.valid_segments) == expected_segments
    assert all(segment.parse_status is ParseStatus.VALID
               for segment in parsed.valid_segments)
    assert all(segment.repair_reason is None and segment.repair_original_end_ms is None
               for segment in parsed.valid_segments)
    assert not parsed.invalid_fragments


def make_runtime(tmp_path, *, text):
    from moss_worker.runtime import MossRuntime

    wav = tmp_path / 'window.wav'
    wav.write_bytes(b'audio')
    chunks = [SimpleNamespace(features=np.ones((1, 80, 3000), np.float32), valid_tokens=2),
              SimpleNamespace(features=np.ones((1, 80, 3000), np.float32) * 2, valid_tokens=1)]

    def encode(chunk):
        return np.full((chunk.valid_tokens, 1024), chunk.features[0, 0, 0], np.float32)

    def build(prompt, audio):
        np.testing.assert_array_equal(audio[:, 0], [1, 1, 2])
        return SimpleNamespace(embeds=audio)

    generation = SimpleNamespace(text=text, token_count=2902, normal_termination=True,
                                 perf={}, error=None)
    runtime = MossRuntime(frontend=SimpleNamespace(chunks=lambda path, window: iter(chunks)),
                          encoder=SimpleNamespace(encode=encode, close=lambda: None),
                          builder=SimpleNamespace(build=build),
                          decoder=SimpleNamespace(decode=lambda embeds: generation, close=lambda: None),
                          rendered_prompt='rendered', manifest_sha256='a' * 64)
    return runtime, wav


def test_runtime_publishes_repaired_window_for_board_8m_generation(tmp_path):
    runtime, wav = make_runtime(tmp_path, text=gradient_8m())
    result = runtime.infer_window(WindowSpec(0, 480000, 0, 8), wav)
    assert result.state is WindowState.DONE
    assert result.error is None
    assert result.parse_status is ParseStatus.REPAIRED
    assert len(result.segments) == 75
    assert result.segments[-1].repair_original_end_ms == 480010


def test_runtime_still_rejects_content_overshoot_beyond_tolerance(tmp_path):
    reversed_raw = gradient_8m().replace('[480.01]', '[480.11]')
    runtime, wav = make_runtime(tmp_path, text=reversed_raw)
    result = runtime.infer_window(WindowSpec(0, 480000, 0, 8), wav)
    assert result.state is WindowState.FAILED
    assert result.error == 'MOSS_INVALID_GENERATION'
    assert result.parse_status is ParseStatus.INVALID
    assert result.segments == ()
