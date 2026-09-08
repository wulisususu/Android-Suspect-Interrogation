import pytest

from moss_worker.context_budget import ContextBudget
from moss_worker.windowing import (
    ContextBudgetExceeded, RetryExhausted, WindowSpec, plan_retry_windows, plan_windows,
)

MINUTE = 60000


def counter(max_minutes):
    return lambda start, end: 10752 if end - start <= max_minutes * MINUTE else 10753


def assert_coverage(windows, start, end):
    assert windows[0].start_ms == start
    assert windows[-1].end_ms == end
    for left, right in zip(windows, windows[1:]):
        assert right.start_ms == left.end_ms - 2 * MINUTE
        assert right.end_ms > left.end_ms


@pytest.mark.parametrize('minutes', [60, 65, 125])
@pytest.mark.parametrize('allowed', [12, 10, 8])
def test_complete_coverage_with_fixed_overlap(minutes, allowed):
    windows = plan_windows(minutes * MINUTE, counter(allowed))
    assert_coverage(windows, 0, minutes * MINUTE)
    assert all(w.end_ms - w.start_ms <= allowed * MINUTE for w in windows)
    assert all(w.logical_chunk_index == (w.end_ms - 1) // (60 * MINUTE) for w in windows)


def test_hour_boundary_keeps_overlap_into_next_logical_chunk():
    windows = plan_windows(120 * MINUTE, counter(12))
    assert [(w.start_ms // MINUTE, w.end_ms // MINUTE, w.logical_chunk_index)
            for w in windows[:7]] == [
        (0, 12, 0), (10, 22, 0), (20, 32, 0), (30, 42, 0),
        (40, 52, 0), (50, 60, 0), (58, 70, 1),
    ]
    assert all(w.logical_chunk_index == (w.start_ms + 2 * MINUTE) // (60 * MINUTE)
               for w in windows[1:])


def test_actual_interval_count_controls_each_selection():
    seen = []
    def exact(start, end):
        seen.append((start, end))
        return 10753 if start == 0 and end == 12 * MINUTE else 10752
    windows = plan_windows(30 * MINUTE, exact)
    assert windows[0].end_ms == 10 * MINUTE
    assert windows[1].end_ms - windows[1].start_ms == 12 * MINUTE
    assert (0, 12 * MINUTE) in seen and (0, 10 * MINUTE) in seen


def test_no_estimate_or_subminimum_fallback_when_eight_does_not_fit():
    seen = []
    def exact(start, end):
        seen.append(end - start)
        return 10753
    with pytest.raises(ContextBudgetExceeded):
        plan_windows(60 * MINUTE, exact)
    assert seen == [12 * MINUTE, 10 * MINUTE, 8 * MINUTE]
    with pytest.raises(ContextBudgetExceeded):
        plan_windows(60 * MINUTE, counter(12), ContextBudget(max_context_len=4096))


def test_actual_short_recording_tail_is_allowed_once():
    windows = plan_windows(13 * MINUTE, counter(12))
    assert [(w.start_ms, w.end_ms) for w in windows] == [(0, 12 * MINUTE), (10 * MINUTE, 13 * MINUTE)]
    assert len(plan_windows(MINUTE, counter(12))) == 1
    assert plan_windows(0, counter(12)) == []


def test_counter_is_required():
    with pytest.raises(TypeError):
        plan_windows(60 * MINUTE)


def test_retry_covers_failed_window_and_downshifts_only():
    failed = WindowSpec(20 * MINUTE, 32 * MINUTE, 0, 12)
    retries = plan_retry_windows(failed, counter(12))
    assert_coverage(retries, failed.start_ms, failed.end_ms)
    assert [w.window_minutes for w in retries] == [10, 10]
    smaller = plan_retry_windows(retries[0], counter(12))
    assert_coverage(smaller, retries[0].start_ms, retries[0].end_ms)
    assert all(w.window_minutes == 8 for w in smaller)
    with pytest.raises(RetryExhausted):
        plan_retry_windows(smaller[0], counter(12))


def test_retry_falls_back_to_eight_for_context_then_terminates():
    failed = WindowSpec(0, 12 * MINUTE, 0, 12)
    retries = plan_retry_windows(failed, counter(8))
    assert_coverage(retries, 0, 12 * MINUTE)
    assert all(w.window_minutes == 8 for w in retries)
    with pytest.raises(ContextBudgetExceeded):
        plan_retry_windows(failed, lambda start, end: 10753)


def test_clipped_tail_retry_preserves_coverage_and_exhausts_at_eight_tier():
    failed = WindowSpec(10 * MINUTE, 13 * MINUTE, 0, 12)
    for tier in (10, 8):
        retries = plan_retry_windows(failed, counter(12))
        assert len(retries) == 1
        assert_coverage(retries, 10 * MINUTE, 13 * MINUTE)
        assert retries[0].window_minutes == tier
        failed = retries[0]
    with pytest.raises(RetryExhausted):
        plan_retry_windows(failed, counter(12))
