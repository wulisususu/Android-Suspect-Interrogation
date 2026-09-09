import pytest

from moss_worker.types import MergeStatus, ParseStatus, WindowSpec


WINDOW = WindowSpec(30 * 60000, 42 * 60000, 0, 10)


def parse(raw, **kwargs):
    from moss_worker.parser import parse_generation
    return parse_generation(raw, WINDOW, **kwargs)


def test_complete_segment_has_absolute_times_and_unknown_provenance():
    raw = '[12.0][S01]你好[13.5]'
    result = parse(raw)
    segment, = result.valid_segments
    assert (segment.start_ms, segment.end_ms) == (1812000, 1813500)
    assert (segment.local_speaker, segment.text) == ('S01', '你好')
    assert segment.parse_status is ParseStatus.VALID
    assert segment.merge_status is MergeStatus.PRIMARY
    assert segment.global_speaker is segment.alternate is None
    assert segment.speaker_mapping_confidence is None
    assert segment.model_manifest_sha256 == ''
    assert segment.repair_reason is None
    assert segment.repair_original_end_ms is None
    assert result.raw_generation == raw
    assert not result.invalid_fragments


def test_shared_boundary_is_explicit_repair():
    result = parse('[1.0][S01]第一句[2.5][S02]第二句[3.0]')
    first, second = result.valid_segments
    assert first.end_ms == second.start_ms == 1802500
    assert first.parse_status is ParseStatus.REPAIRED
    assert first.repair_reason == 'END_MISSING_REPAIRED_FROM_NEXT_START'
    assert first.repair_original_end_ms is None
    assert second.parse_status is ParseStatus.VALID
    assert second.repair_reason is None
    assert not result.invalid_fragments


def test_official_separate_end_start_and_whitespace():
    raw = ' \n[0.00][S01]甲 [5.88][6.75][S002]乙 [11.35]\n'
    result = parse(raw)
    assert [(s.start_ms, s.end_ms) for s in result.valid_segments] == [
        (1800000, 1805880), (1806750, 1811350)]
    assert all(s.parse_status is ParseStatus.VALID for s in result.valid_segments)
    assert result.raw_generation == raw
    assert not result.invalid_fragments


@pytest.mark.parametrize('raw', [
    'unexpected[0][S01]甲[1]', '[0][S01]甲[1]unexpected',
    '[-1][S01]甲[1]', '[2][S01]甲[1]', '[0][S1]甲[1]',
    '[0][s01]甲[1]', '[0][S01] [1]', '[0][S01]甲',
    '[0][S01]甲[bad][1][S02]乙[2]', '[NaN][S01]甲[1]',
    '[1e2][S01]甲[101]', '[0][S01]甲[1.2.3]',
    '[0][S01]甲[721]', '[' + '9' * 500 + '][S01]甲[1]',
    '[0][S01]甲[-1][0][S02]乙[1]', '[0][S01]甲[1][BAD]乙[2]',
])
def test_invalid_input_is_retained_without_suffix_salvage(raw):
    result = parse(raw)
    assert result.invalid_fragments
    assert result.raw_generation == raw
    assert all(f.raw and f.reason and f.parse_status is ParseStatus.INVALID
               for f in result.invalid_fragments)
    assert not any(s.text == '乙' for s in result.valid_segments)
    if raw not in ('[0][S01]甲[1]unexpected', '[0][S01]甲[1][BAD]乙[2]'):
        assert not result.valid_segments
        assert result.invalid_fragments[0].raw == raw


def test_unbounded_final_fragment_does_not_enter_timeline():
    raw = '[0][S01]甲[1][2][S02]未结束'
    result = parse(raw)
    assert [s.text for s in result.valid_segments] == ['甲']
    assert result.invalid_fragments[0].raw == '[2][S02]未结束'


def test_decreasing_next_start_keeps_only_valid_prefix():
    result = parse('[0][S01]甲[2][1][S02]乙[3]')
    assert [s.text for s in result.valid_segments] == ['甲']
    assert result.invalid_fragments[0].raw == '[1][S02]乙[3]'


def test_round_half_up_and_exact_order_before_rounding():
    segment, = parse('[0.0005][S01]甲[0.0015]').valid_segments
    assert (segment.start_ms, segment.end_ms) == (1800001, 1800002)
    assert not parse('[0.0005][S01]甲[0.0004]').valid_segments
    clamped, = parse('[719][S01]甲[720.0001]').valid_segments
    assert clamped.parse_status is ParseStatus.REPAIRED
    assert clamped.end_ms == 2520000
    assert clamped.repair_reason == 'END_TIMESTAMP_CLAMPED_TO_WINDOW_END'


def test_end_overshoot_within_model_raster_tolerance_is_clamped():
    # User-approved 2026-09-09: a segment end may land at most one 10 ms model
    # raster step past the window end; the parser clamps it to the window
    # end and records the original value for audit.
    for raw, original_end_ms in (('[719.99][S01]甲[720.009]', 2520009),
                                 ('[719.99][S01]甲[720.01]', 2520010)):
        segment, = parse(raw).valid_segments
        assert segment.end_ms == 2520000
        assert segment.parse_status is ParseStatus.REPAIRED
        assert segment.repair_reason == 'END_TIMESTAMP_CLAMPED_TO_WINDOW_END'
        assert segment.repair_original_end_ms == original_end_ms


def test_end_overshoot_beyond_model_raster_tolerance_is_not_forgiven():
    for raw in ('[719][S01]甲[720.011]', '[719][S01]甲[720.1]', '[719][S01]甲[721]'):
        result = parse(raw)
        assert not result.valid_segments
        assert result.invalid_fragments[0].raw == raw
        assert result.invalid_fragments[0].parse_status is ParseStatus.INVALID


def test_start_timestamp_overshoot_is_never_clamped():
    result = parse('[720.005][S01]甲[720.5]')
    assert not result.valid_segments
    assert result.invalid_fragments[0].reason == 'Start timestamp is decreasing or outside the window'


def test_exact_window_boundary_stays_valid_without_repair_metadata():
    segment, = parse('[720][S01]甲[720]').valid_segments
    assert segment.parse_status is ParseStatus.VALID
    assert segment.repair_reason is None
    assert segment.repair_original_end_ms is None


def test_dangling_trailing_timestamp_is_downgraded_to_terminal_drop():
    result = parse('[0][S01]甲[1][2.5]')
    assert [s.text for s in result.valid_segments] == ['甲']
    assert not result.invalid_fragments
    assert result.repair_reason == 'DANGLING_TRAILING_TIMESTAMP_DROPPED'
    assert result.repair_original_text == '[2.5]'
    assert result.raw_generation == '[0][S01]甲[1][2.5]'


def test_dangling_out_of_window_timestamp_without_content_is_dropped():
    result = parse('[0][S01]甲[1][721]')
    assert [s.text for s in result.valid_segments] == ['甲']
    assert not result.invalid_fragments
    assert result.repair_reason == 'DANGLING_TRAILING_TIMESTAMP_DROPPED'
    assert result.repair_original_text == '[721]'


def test_dangling_trailing_timestamp_keeps_whitespace_verbatim():
    result = parse('[0][S01]甲[1][2.5] \n')
    assert [s.text for s in result.valid_segments] == ['甲']
    assert not result.invalid_fragments
    assert result.repair_reason == 'DANGLING_TRAILING_TIMESTAMP_DROPPED'
    assert result.repair_original_text == '[2.5] \n'


def test_lone_trailing_timestamp_drops_without_segments():
    result = parse('[5]')
    assert not result.valid_segments
    assert not result.invalid_fragments
    assert result.repair_reason == 'DANGLING_TRAILING_TIMESTAMP_DROPPED'
    assert result.repair_original_text == '[5]'


def test_trailing_fragment_with_speaker_is_never_dropped():
    result = parse('[0][S01]甲[1][2][S01]')
    assert result.valid_segments[0].text == '甲'
    assert result.invalid_fragments[0].raw == '[2][S01]'
    assert result.repair_reason is None


def test_content_segment_overshoot_beyond_tolerance_stays_invalid():
    result = parse('[0][S01]甲[719.99][S02]乙[720.11]')
    assert [s.text for s in result.valid_segments] == ['甲']
    assert result.invalid_fragments[0].raw == '[719.99][S02]乙[720.11]'
    assert result.invalid_fragments[0].reason == 'End timestamp is decreasing or outside the window'
    assert result.repair_reason is None


def test_exact_window_boundary_and_zero_duration_are_valid():
    assert len(parse('[720][S01]甲[720]').valid_segments) == 1


def test_ids_are_deterministic_and_provenance_can_be_injected():
    raw = '[0][S01]甲[1][2][S01]乙[3]'
    first = parse(raw)
    assert first == parse(raw)
    assert len({s.segment_id for s in first.valid_segments}) == 2
    injected = parse(raw, window_id='actual-window', model_manifest_sha256='a' * 64)
    assert all(s.window_id == 'actual-window' and s.model_manifest_sha256 == 'a' * 64
               for s in injected.valid_segments)


def test_empty_generation_preserves_raw_without_timeline():
    result = parse(' \n')
    assert result.raw_generation == ' \n'
    assert not result.valid_segments


def test_shared_boundary_with_unbounded_tail_retains_tail_verbatim():
    result = parse('[0][S01]甲[1][S02]未结束')
    assert result.valid_segments[0].parse_status is ParseStatus.REPAIRED
    assert result.invalid_fragments[0].raw == '[1][S02]未结束'


@pytest.mark.parametrize('window', [WindowSpec(-1, 1000, 0, 10), WindowSpec(2, 1, 0, 10)])
def test_invalid_window_bounds_are_programming_errors(window):
    from moss_worker.parser import parse_generation
    with pytest.raises(ValueError, match='bounds'):
        parse_generation('[0][S01]甲[1]', window)
