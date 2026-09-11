"""Speaker-turn segmentation for a single VAD utterance.

Responsibility: answer exactly one question per utterance — "did the speaker change inside
this speech segment?" The answer is a list of :class:`TurnSpan`. This module never touches a
database, never receives a case id and never decides who the suspect is; role assignment stays
in ``AsrCaptureService`` where the accept threshold, margin and audit trail live.

Design (see ``docs/release/task17-speaker-turn-splitter-design.md``; every threshold below was
derived from RK3588 ERes2Net measurements on the dual-QA corpus):

Stage 1 — whole-utterance gate, zero extra cost
    The whole utterance is embedded **once** and compared with ``reference`` (the enrolled
    biometric vector, when the caller has one):

        cos >= band_high (0.70)  -> certain single speaker (observed suspect min 0.725)
        cos <= band_low  (0.29)  -> certain single *other* speaker (observed officer max 0.268)
        in between               -> suspicious, run stage 2

    Using the whole-segment embedding is mandatory: a 5 s mixed window measures 0.4732 whole
    but only 0.228 as the mean of its sliding windows, so a window mean would silently turn a
    mixed utterance into "certainly another speaker".

Stage 2 — windowed change point, paid only for suspicious utterances
    1.5 s window / 0.5 s hop, with ``cosPrev`` (neighbouring windows) and ``cosRef``
    (window vs ``reference``):

      rule A  : ``cosPrev < t_fire`` (0.50) for at least two consecutive windows
      deep dip: a single ``cosPrev < t_deep`` (0.30). On the corpus a single dip below 0.30
                finds 20/28 annotated speaker changes with zero false fires on 32 interior
                stretches (mixed dip 0.243 vs interior minimum 0.349); demanding two
                consecutive dips would miss the real production failure, whose 5 s utterance
                holds exactly one dip pair.
      rule B  : a single dip whose sides carry *opposing* decisive role evidence
                (left mean cosRef <= band_low and right mean >= band_high, or the reverse).
                Available only when a reference exists.

    Every produced turn must reach ``min_turn_ms``. Anything else — no dip, a dip whose turns
    are too short, competing change points — returns a single span flagged ``ambiguous=True``
    so the caller can emit ``overlap=True`` and let ``SpeakerPolicy`` answer UNKNOWN. In a
    forensic system UNKNOWN beats a confident wrong attribution.

Without ``reference`` — which is how the live speech worker must call this, because biometric
references never enter the worker — stage 1 and rule B cannot run. Rule A and the deep-dip rule
still work, since they only need neighbouring-window similarity, and roles are then decided
downstream one turn at a time by ``AsrCaptureService``.
"""
from __future__ import annotations

import math
from dataclasses import dataclass
from typing import Callable, Sequence


SAMPLE_WIDTH_BYTES = 2

STAGE_WHOLE_UTTERANCE = "WHOLE_UTTERANCE"
STAGE_WINDOWED = "WINDOWED"

REASON_SINGLE_SPEAKER = "whole_utterance_single_speaker"
REASON_RULE_A = "rule_a_consecutive_dips"
REASON_DEEP_DIP = "deep_single_dip"
REASON_RULE_B = "rule_b_opposing_roles"
REASON_NO_DIP = "no_change_point"
REASON_NO_ROLE_SUPPORT = "dip_without_role_support"
REASON_MIN_TURN = "turn_shorter_than_min_turn_ms"
REASON_TOO_SHORT = "utterance_shorter_than_two_windows"
REASON_COMPETING = "competing_change_points"


@dataclass(frozen=True)
class TurnSpan:
    """One speaker turn inside the utterance, in utterance-relative milliseconds."""

    start_ms: int
    end_ms: int
    ambiguous: bool = False


@dataclass(frozen=True)
class SplitMetrics:
    """Cost accounting and provenance for the last :meth:`SpeakerTurnSplitter.split` call."""

    stage: str
    windows: int
    reason: str
    whole_cos_ref: float | None = None
    dip_starts_ms: tuple[int, ...] = ()
    change_points_ms: tuple[int, ...] = ()
    embedded_windows: int = 0


def _cosine(left: Sequence[float], right: Sequence[float]) -> float:
    dot = 0.0
    norm_left = 0.0
    norm_right = 0.0
    for a, b in zip(left, right):
        dot += a * b
        norm_left += a * a
        norm_right += b * b
    if norm_left <= 0.0 or norm_right <= 0.0:
        return 0.0
    return dot / (math.sqrt(norm_left) * math.sqrt(norm_right))


class SpeakerTurnSplitter:
    """Split one VAD utterance into speaker turns (see the module docstring)."""

    def __init__(
        self,
        *,
        window_ms: int = 1500,
        hop_ms: int = 500,
        t_fire: float = 0.50,
        t_deep: float = 0.30,
        band_low: float = 0.29,
        band_high: float = 0.70,
        min_turn_ms: int = 1000,
    ) -> None:
        if window_ms <= 0 or hop_ms <= 0 or hop_ms > window_ms:
            raise ValueError("window_ms and hop_ms must be positive, with hop_ms <= window_ms")
        if min_turn_ms < 0:
            raise ValueError("min_turn_ms must not be negative")
        self.window_ms = window_ms
        self.hop_ms = hop_ms
        self.t_fire = t_fire
        self.t_deep = t_deep
        self.band_low = band_low
        self.band_high = band_high
        self.min_turn_ms = min_turn_ms
        self.last_metrics: SplitMetrics | None = None

    # ------------------------------------------------------------------ helpers
    def _slice_ms(self, pcm: bytes, sample_rate: int, start_ms: int, end_ms: int) -> bytes:
        bytes_per_ms = sample_rate * SAMPLE_WIDTH_BYTES / 1000.0
        start = max(0, int(round(start_ms * bytes_per_ms)))
        end = min(len(pcm), int(round(end_ms * bytes_per_ms)))
        return pcm[start:max(start, end)]

    def _total_ms(self, pcm: bytes, sample_rate: int) -> int:
        return int(len(pcm) / (sample_rate * SAMPLE_WIDTH_BYTES) * 1000)

    def _role(self, cos_ref: float) -> str:
        if cos_ref >= self.band_high:
            return "REFERENCE"
        if cos_ref <= self.band_low:
            return "OTHER"
        return "UNKNOWN"

    def _window_starts(self, total_ms: int) -> list[int]:
        if total_ms < self.window_ms:
            return []
        return list(range(0, total_ms - self.window_ms + 1, self.hop_ms))

    # --------------------------------------------------------------------- split
    def split(
        self,
        pcm: bytes,
        sample_rate: int,
        embed: Callable[[bytes], Sequence[float]],
        reference: Sequence[float] | None = None,
        *,
        whole_embedding: Sequence[float] | None = None,
    ) -> list[TurnSpan]:
        """Return the turn spans of ``pcm``.

        ``embed`` maps a PCM slice to its speaker embedding. ``whole_embedding`` lets a caller
        that already embedded the whole utterance (the production session does, for its
        speaker-policy decision) hand it over instead of paying for it twice.
        """
        total_ms = self._total_ms(pcm, sample_rate)
        if total_ms <= 0:
            self.last_metrics = SplitMetrics(STAGE_WHOLE_UTTERANCE, 0, REASON_TOO_SHORT)
            return [TurnSpan(0, max(0, total_ms), True)]

        embedded_windows = 0
        whole_cos_ref: float | None = None

        # ---- stage 1: one whole-utterance embedding decides whether to split at all
        if reference is not None:
            whole_vector = whole_embedding
            if whole_vector is None:
                whole_vector = embed(pcm)
                embedded_windows += 1
            whole_cos_ref = _cosine(reference, whole_vector)
            if whole_cos_ref >= self.band_high or whole_cos_ref <= self.band_low:
                self.last_metrics = SplitMetrics(
                    STAGE_WHOLE_UTTERANCE, 0, REASON_SINGLE_SPEAKER,
                    whole_cos_ref=whole_cos_ref, embedded_windows=embedded_windows,
                )
                return [TurnSpan(0, total_ms)]

        # ---- stage 2: windowed change point
        starts = self._window_starts(total_ms)
        if len(starts) < 2:
            self.last_metrics = SplitMetrics(
                STAGE_WINDOWED, len(starts), REASON_TOO_SHORT,
                whole_cos_ref=whole_cos_ref, embedded_windows=embedded_windows,
            )
            return [TurnSpan(0, total_ms, True)]

        cos_prev: list[float | None] = []
        cos_ref: list[float | None] = []
        previous_vector: Sequence[float] | None = None
        for start in starts:
            vector = embed(self._slice_ms(pcm, sample_rate, start, start + self.window_ms))
            embedded_windows += 1
            cos_prev.append(None if previous_vector is None else _cosine(previous_vector, vector))
            cos_ref.append(None if reference is None else _cosine(reference, vector))
            previous_vector = vector

        dip_positions = [
            position for position, value in enumerate(cos_prev)
            if value is not None and value < self.t_fire
        ]
        dip_starts = tuple(starts[position] for position in dip_positions)
        if not dip_positions:
            self.last_metrics = SplitMetrics(
                STAGE_WINDOWED, len(starts), REASON_NO_DIP,
                whole_cos_ref=whole_cos_ref, embedded_windows=embedded_windows,
            )
            return [TurnSpan(0, total_ms, True)]

        accepted: dict[int, str] = {}
        for position in dip_positions:
            value = cos_prev[position]
            assert value is not None
            rule = None
            if self._has_consecutive_dip(cos_prev, position):
                rule = REASON_RULE_A
            elif value < self.t_deep:
                rule = REASON_DEEP_DIP
            elif self._opposing_roles(cos_ref, position):
                rule = REASON_RULE_B
            if rule is not None:
                accepted[starts[position]] = rule

        merged: list[int] = []
        for start in sorted(accepted):
            if merged and start - merged[-1] <= self.hop_ms:
                # neighbouring dips describe one transition: keep the earliest
                continue
            merged.append(start)

        usable = [
            start for start in merged
            if start >= self.min_turn_ms and total_ms - start >= self.min_turn_ms
        ]
        if not usable:
            reason = REASON_MIN_TURN if merged else REASON_NO_ROLE_SUPPORT
            self.last_metrics = SplitMetrics(
                STAGE_WINDOWED, len(starts), reason,
                whole_cos_ref=whole_cos_ref, dip_starts_ms=dip_starts,
                change_points_ms=tuple(merged), embedded_windows=embedded_windows,
            )
            return [TurnSpan(0, total_ms, True)]

        spans: list[TurnSpan] = []
        cursor = 0
        for start in usable:
            spans.append(TurnSpan(cursor, start))
            cursor = start
        spans.append(TurnSpan(cursor, total_ms))

        reasons = {accepted[start] for start in usable}
        if REASON_RULE_A in reasons:
            reason = REASON_RULE_A
        elif REASON_DEEP_DIP in reasons:
            reason = REASON_DEEP_DIP
        else:
            reason = REASON_RULE_B
        self.last_metrics = SplitMetrics(
            STAGE_WINDOWED, len(starts), reason,
            whole_cos_ref=whole_cos_ref, dip_starts_ms=dip_starts,
            change_points_ms=tuple(usable), embedded_windows=embedded_windows,
        )
        return spans

    # -------------------------------------------------------------- stage-2 rules
    def _has_consecutive_dip(self, cos_prev: Sequence[float | None], position: int) -> bool:
        """Rule A: another sub-threshold window immediately before or after this one."""
        for neighbour in (position - 1, position + 1):
            if 0 <= neighbour < len(cos_prev):
                value = cos_prev[neighbour]
                if value is not None and value < self.t_fire:
                    return True
        return False

    def _opposing_roles(self, cos_ref: Sequence[float | None], position: int) -> bool:
        """Rule B: the two sides of the dip look like different people."""
        left = [value for value in cos_ref[:position] if value is not None]
        right = [value for value in cos_ref[position:] if value is not None]
        if not left or not right:
            return False
        left_role = self._role(sum(left) / len(left))
        right_role = self._role(sum(right) / len(right))
        return {left_role, right_role} == {"REFERENCE", "OTHER"}
