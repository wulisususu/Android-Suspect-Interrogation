"""Long-audio window ladder and 60-minute logical chunking.

User-approved final tiering (2026-09-09): target_window == 10 minutes and
fallback_window == minimum_window == 8 minutes. A failed 8-minute attempt is
a terminal failure (``RetryExhausted``): there is no automatic down-scaling
below the minimum, and adding smaller tiers (6m/4m/...) is forbidden.
"""
from dataclasses import dataclass
from typing import Callable

from .context_budget import ContextBudget


class ContextBudgetExceeded(ValueError):
    pass


class RetryExhausted(ValueError):
    pass


@dataclass(frozen=True)
class WindowSpec:
    start_ms: int
    end_ms: int
    logical_chunk_index: int
    window_minutes: int


MINUTE_MS = 60000
LOGICAL_CHUNK_MS = 60 * MINUTE_MS
OVERLAP_MS = 2 * MINUTE_MS
# User-approved final tiering (2026-09-09): target 10 minutes;
# fallback_window == minimum_window == 8. A failed 8-minute attempt raises
# RetryExhausted — terminal, no automatic down-scaling, and adding smaller
# tiers (6m/4m/...) below the minimum is forbidden.
WINDOW_LADDER_MINUTES = (10, 8)
ExpandedInputCounter = Callable[[int, int], int]


def _select(start, end, logical_index, candidates, counter, budget):
    # A short candidate is only produced by clipping to an actual interval boundary.
    checked_end = None
    for minutes in candidates:
        candidate_end = min(start + minutes * MINUTE_MS, end)
        if candidate_end == checked_end:
            continue
        checked_end = candidate_end
        if budget.fits(counter(start, candidate_end)):
            return WindowSpec(start, candidate_end, logical_index, minutes)
    raise ContextBudgetExceeded(f'No permitted window fits at {start} ms')


def plan_windows(
    duration_ms: int, expanded_input_tokens: ExpandedInputCounter,
    budget: ContextBudget = ContextBudget(),
) -> list[WindowSpec]:
    """Plan recording coverage; the required callback must count real expansion.

    The callback must run the actual tokenizer/processor for the specified audio
    interval. Duration-based token estimates cannot authorize an execution window.
    """
    windows = []
    covered_until = 0
    while covered_until < duration_ms:
        logical_index = covered_until // LOGICAL_CHUNK_MS
        boundary = min(duration_ms, (logical_index + 1) * LOGICAL_CHUNK_MS)
        start = max(0, covered_until - OVERLAP_MS) if windows else 0
        window = _select(start, boundary, logical_index, WINDOW_LADDER_MINUTES,
                         expanded_input_tokens, budget)
        windows.append(window)
        covered_until = window.end_ms
    return windows


def plan_retry_windows(
    failed: WindowSpec, expanded_input_tokens: ExpandedInputCounter,
    budget: ContextBudget = ContextBudget(),
) -> list[WindowSpec]:
    """Replace only the failed interval; caller retains other committed windows.

    Carry window_minutes into subsequent failure retries, including clipped tails,
    so retry progression is bounded by 10 -> 8 -> terminal failure. Because
    fallback == minimum == 8 minutes, a failing 8-minute window has no next
    tier and raises RetryExhausted.
    """
    candidates = tuple(m for m in WINDOW_LADDER_MINUTES[1:] if m < failed.window_minutes)
    if not candidates:
        # fallback == minimum == 8m: an 8-minute failure is terminal. There is
        # deliberately no tier below the minimum to fall back to.
        raise RetryExhausted('Generation failed at the minimum eight-minute policy')
    windows = []
    start = failed.start_ms
    while start < failed.end_ms:
        window = _select(start, failed.end_ms, failed.logical_chunk_index,
                         candidates, expanded_input_tokens, budget)
        windows.append(window)
        if window.end_ms == failed.end_ms:
            break
        candidates = tuple(m for m in candidates if m <= window.window_minutes)
        start = window.end_ms - OVERLAP_MS
    return windows
