"""Temporary prototype of the expected SpeakerTurnSplitter API (board-only, /tmp).

Implements exactly the rules validated in docs/release/task17-speaker-turn-splitter-design.md
so the acceptance harness can be proven to PASS on a correct implementation before the real
module exists. NOT to be committed: this file lives under /tmp on the RK3588.
"""
from __future__ import annotations

import math
from dataclasses import dataclass
from typing import Callable, Sequence


@dataclass(frozen=True)
class TurnSpan:
    start_ms: int
    end_ms: int
    ambiguous: bool = False


def _cos(a: Sequence[float], b: Sequence[float]) -> float:
    dot = sum(x * y for x, y in zip(a, b))
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(y * y for y in b))
    return dot / (na * nb) if na and nb else 0.0


class SpeakerTurnSplitter:
    def __init__(self, *, window_ms: int = 1500, hop_ms: int = 500, t_fire: float = 0.50,
                 band_low: float = 0.29, band_high: float = 0.70, min_turn_ms: int = 1000):
        self.window_ms = window_ms
        self.hop_ms = hop_ms
        self.t_fire = t_fire
        self.band_low = band_low
        self.band_high = band_high
        self.min_turn_ms = min_turn_ms

    def _slice(self, pcm: bytes, rate: int, start_ms: int, end_ms: int) -> bytes:
        bps = rate * 2
        a, b = int(start_ms * bps / 1000), int(end_ms * bps / 1000)
        return pcm[max(0, a):max(0, min(len(pcm), b))]

    def split(self, pcm: bytes, sample_rate: int, embed: Callable[[bytes], Sequence[float]],
              reference: Sequence[float] | None) -> list[TurnSpan]:
        total_ms = int(len(pcm) / (sample_rate * 2) * 1000)
        if total_ms <= 0:
            return [TurnSpan(0, 0, True)]

        # stage 1: ONE whole-utterance embedding decides whether splitting is needed at all
        whole_cos = _cos(reference, embed(pcm)) if reference is not None else None
        if whole_cos is not None and (whole_cos >= self.band_high or whole_cos <= self.band_low):
            return [TurnSpan(0, total_ms)]

        # stage 2: sliding windows
        win_ms, hop_ms = self.window_ms, self.hop_ms
        if total_ms < win_ms * 2:
            return [TurnSpan(0, total_ms, ambiguous=True)]
        windows = []
        pos = 0
        while pos + win_ms <= total_ms:
            chunk = self._slice(pcm, sample_rate, pos, pos + win_ms)
            vec = embed(chunk)
            windows.append({"startMs": pos, "endMs": pos + win_ms, "vec": vec,
                            "cosRef": _cos(reference, vec) if reference is not None else None})
            pos += hop_ms
        for i in range(1, len(windows)):
            windows[i]["cosPrev"] = _cos(windows[i - 1]["vec"], windows[i]["vec"])

        dips = [(w["startMs"], w["cosPrev"]) for w in windows[1:] if w["cosPrev"] is not None and w["cosPrev"] < self.t_fire]
        if not dips:
            return [TurnSpan(0, total_ms)]

        cuts = []
        for ms, c in dips:
            # rule A: neighbouring window also below the fire threshold
            idx = next(i for i, w in enumerate(windows) if w["startMs"] == ms)
            prev_c = windows[idx - 1].get("cosPrev")
            next_c = windows[idx + 1].get("cosPrev") if idx + 1 < len(windows) else None
            rule_a = (prev_c is not None and prev_c < self.t_fire) or (next_c is not None and next_c < self.t_fire)
            # rule B: single dip with opposing role evidence on both sides
            left = [w["cosRef"] for w in windows if w["startMs"] < ms and w["cosRef"] is not None]
            right = [w["cosRef"] for w in windows if w["startMs"] >= ms and w["cosRef"] is not None]
            rule_b = False
            if left and right:
                lm, rm = sum(left) / len(left), sum(right) / len(right)
                rule_b = (lm <= self.band_low and rm >= self.band_high) or (lm >= self.band_high and rm <= self.band_low)
            if rule_a or rule_b:
                cuts.append(ms)

        cuts = sorted(set(cuts))
        # keep only cuts that leave turns >= min_turn_ms and are far enough apart
        accepted: list[int] = []
        for c in cuts:
            if c < self.min_turn_ms or total_ms - c < self.min_turn_ms:
                continue
            if accepted and c - accepted[-1] < self.min_turn_ms:
                continue
            accepted.append(c)
        if not accepted:
            return [TurnSpan(0, total_ms, ambiguous=True)]

        spans, prev = [], 0
        for c in accepted:
            spans.append(TurnSpan(prev, c))
            prev = c
        spans.append(TurnSpan(prev, total_ms))
        return spans
