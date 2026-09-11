"""Tests for the speaker-turn splitter.

Fixture geometry (5-dim unit vectors, so every expected cosine below is exact):

    REFERENCE  = e0
    SUSPECT    = 0.86 REFERENCE + 0.5103 e1                cos(ref, suspect) = 0.86
    OFFICER    = 0.05 REFERENCE + 0.4056 e1 + 0.9127 e2    cos(ref, officer) = 0.05
                                                           cos(officer, suspect) = 0.25
    MIXED_FAR  = unit vector orthogonal to OFFICER and SUSPECT
                                                           cos(ref, mixed) = 0.481
                                                           cos(mixed, officer) = cos(mixed, suspect) = 0
    MIXED_NEAR = 0.6 REFERENCE + 0.8 e1                    cos(ref, mixed) = 0.60
                                                           cos(mixed, suspect) = 0.92
    SHALLOW    = unit(0.75 REFERENCE - 0.4 e1 + 0.5 e2)    cos(ref, shallow) = 0.76 (same role
                                                           as the suspect); cos(shallow,
                                                           suspect) = 0.447: a sub-threshold,
                                                           non-deep dip
    ROLE_NEAR  = 0.8 REFERENCE + 0.6 e2                    cos(ref, role_near) = 0.80,
                                                           cos(role_near, shallow) = 0.91,
                                                           cos(role_near, suspect) = 0.69

The PCM carries a unique sample pattern, and the fake embedder maps *exact slices* to vectors.
Windows overlap (1.5 s window, 0.5 s hop), so per-block speaker labels cannot describe them;
keying on the slice bytes keeps every expectation exact. The geometry self-check pins the
numbers above so the fixtures cannot rot silently.
"""
from __future__ import annotations

import math
import struct

import pytest

from speech_worker.speaker_turn_splitter import (
    REASON_DEEP_DIP,
    REASON_MIN_TURN,
    REASON_NO_DIP,
    REASON_NO_ROLE_SUPPORT,
    REASON_RULE_A,
    REASON_SINGLE_SPEAKER,
    REASON_TOO_SHORT,
    STAGE_WHOLE_UTTERANCE,
    STAGE_WINDOWED,
    SpeakerTurnSplitter,
    TurnSpan,
)

SAMPLE_RATE = 16000
WINDOW_MS = 1500
HOP_MS = 500


def _unit(vector):
    norm = math.sqrt(sum(value * value for value in vector))
    return [value / norm for value in vector]


def _cos(left, right):
    dot = sum(a * b for a, b in zip(left, right))
    nl = math.sqrt(sum(a * a for a in left))
    nr = math.sqrt(sum(b * b for b in right))
    return dot / (nl * nr)


REFERENCE = [1.0, 0.0, 0.0, 0.0, 0.0]
SUSPECT = [0.86, 0.5103, 0.0, 0.0, 0.0]
OFFICER = [0.05, 0.4056, 0.9127, 0.0, 0.0]
MIXED_FAR = _unit([0.5103, -0.86, 0.3542, 0.0, 0.0])
MIXED_NEAR = _unit([0.6, 0.8, 0.0, 0.0, 0.0])
SHALLOW = _unit([0.75, -0.4, 0.5, 0.0, 0.0])
ROLE_NEAR = [0.8, 0.0, 0.6, 0.0, 0.0]

VECTORS = {
    "REFERENCE": REFERENCE,
    "SUSPECT": SUSPECT,
    "OFFICER": OFFICER,
    "MIXED_FAR": MIXED_FAR,
    "MIXED_NEAR": MIXED_NEAR,
    "SHALLOW": SHALLOW,
    "ROLE_NEAR": ROLE_NEAR,
}


def test_fixture_geometry_matches_the_documented_cosines():
    assert _cos(REFERENCE, SUSPECT) == pytest.approx(0.86, abs=2e-3)
    assert _cos(REFERENCE, OFFICER) == pytest.approx(0.05, abs=2e-3)
    assert _cos(OFFICER, SUSPECT) == pytest.approx(0.25, abs=2e-3)
    assert _cos(REFERENCE, MIXED_FAR) == pytest.approx(0.481, abs=2e-3)
    assert abs(_cos(OFFICER, MIXED_FAR)) < 1e-3
    assert abs(_cos(SUSPECT, MIXED_FAR)) < 1e-3
    assert _cos(REFERENCE, MIXED_NEAR) == pytest.approx(0.60, abs=2e-3)
    assert _cos(SUSPECT, MIXED_NEAR) > 0.90
    assert _cos(REFERENCE, SHALLOW) == pytest.approx(0.761, abs=3e-3)
    assert 0.30 < _cos(SHALLOW, SUSPECT) < 0.50
    assert _cos(REFERENCE, ROLE_NEAR) == pytest.approx(0.80, abs=2e-3)
    assert _cos(ROLE_NEAR, SHALLOW) > 0.50
    assert _cos(ROLE_NEAR, SUSPECT) > 0.50


class FixtureEmbedder:
    """Maps exact PCM slices to class vectors; records every slice it is handed."""

    def __init__(self, table: dict[bytes, list[float]]):
        self.table = table
        self.calls: list[bytes] = []

    def __call__(self, pcm: bytes) -> list[float]:
        self.calls.append(pcm)
        try:
            return list(self.table[pcm])
        except KeyError as exc:  # pragma: no cover
            raise AssertionError(f"splitter embedded an unexpected slice of {len(pcm)} bytes") from exc


def _pattern_pcm(total_ms: int) -> bytes:
    samples = total_ms * SAMPLE_RATE // 1000
    return struct.pack(f"<{samples}h", *(((index * 37) % 30001) - 15000 for index in range(samples)))


class Utterance:
    """A synthetic utterance: per-window classes, exact slice embeddings, and one whole vector."""

    def __init__(self, window_classes, *, whole_class="MIXED_FAR", reference=REFERENCE,
                 total_ms: int | None = None):
        self.window_classes = list(window_classes)
        self.reference = None if reference is None else list(reference)
        self.total_ms = (
            total_ms if total_ms is not None
            else (len(self.window_classes) - 1) * HOP_MS + WINDOW_MS
        )
        self.starts = list(range(0, self.total_ms - WINDOW_MS + 1, HOP_MS))
        assert len(self.starts) == len(self.window_classes), (
            "declare one window class per window the splitter will slice"
        )
        self.pcm = _pattern_pcm(self.total_ms)

        table: dict[bytes, list[float]] = {}
        for index, start in enumerate(self.starts):
            span = self._slice(start, start + WINDOW_MS)
            assert len(span) == WINDOW_MS * SAMPLE_RATE // 1000 * 2, "window runs past the utterance"
            table[span] = list(VECTORS[self.window_classes[index]])
        table[self.pcm] = list(VECTORS[whole_class])
        self.embedder = FixtureEmbedder(table)
        self.whole_embedding = list(VECTORS[whole_class])

    def _slice(self, start_ms: int, end_ms: int) -> bytes:
        per_ms = SAMPLE_RATE * 2 // 1000
        return self.pcm[start_ms * per_ms:end_ms * per_ms]


def split(utterance: Utterance, *, reference: bool = True, whole: bool = True,
          engine: SpeakerTurnSplitter | None = None):
    engine = engine or SpeakerTurnSplitter()
    return engine.split(
        utterance.pcm,
        SAMPLE_RATE,
        utterance.embedder,
        utterance.reference if reference else None,
        whole_embedding=utterance.whole_embedding if whole else None,
    )


# --------------------------------------------------------------------------- stage 1
def test_whole_utterance_matching_the_reference_is_a_single_unambiguous_turn():
    utterance = Utterance(["SUSPECT"] * 6, whole_class="SUSPECT")
    engine = SpeakerTurnSplitter()
    spans = split(utterance, whole=False, engine=engine)
    assert spans == [TurnSpan(0, utterance.total_ms)]
    assert utterance.embedder.calls == [utterance.pcm], "stage 1 embeds the whole utterance once"


def test_whole_utterance_matching_another_person_is_a_single_unambiguous_turn():
    utterance = Utterance(["OFFICER"] * 6, whole_class="OFFICER")
    spans = split(utterance)
    assert spans == [TurnSpan(0, utterance.total_ms)]


@pytest.mark.parametrize("cos_ref", [0.70, 0.92, 0.29, 0.10])
def test_band_boundaries_are_inclusive(cos_ref):
    utterance = Utterance(["MIXED_FAR"] * 4)
    vector = [cos_ref, math.sqrt(max(0.0, 1.0 - cos_ref ** 2)), 0.0, 0.0, 0.0]
    engine = SpeakerTurnSplitter()
    spans = engine.split(utterance.pcm, SAMPLE_RATE, utterance.embedder, REFERENCE,
                         whole_embedding=vector)
    assert spans == [TurnSpan(0, utterance.total_ms)]
    assert engine.last_metrics is not None
    assert engine.last_metrics.stage == STAGE_WHOLE_UTTERANCE
    assert engine.last_metrics.reason == REASON_SINGLE_SPEAKER
    assert utterance.embedder.calls == []


def test_inside_the_band_enters_the_windowed_stage():
    utterance = Utterance(["MIXED_FAR"] * 6)
    engine = SpeakerTurnSplitter()
    split(utterance, engine=engine)
    assert engine.last_metrics is not None
    assert engine.last_metrics.stage == STAGE_WINDOWED
    assert engine.last_metrics.whole_cos_ref == pytest.approx(0.481, abs=2e-3)


def test_precomputed_whole_utterance_embedding_is_not_recomputed():
    utterance = Utterance(["SUSPECT"] * 6, whole_class="SUSPECT")
    engine = SpeakerTurnSplitter()
    split(utterance, engine=engine)
    assert utterance.embedder.calls == [], "a caller-supplied whole embedding must be reused"


# --------------------------------------------------------------------------- stage 2
def test_production_shape_splits_into_officer_then_suspect_turns():
    """The real failure: an officer turn followed by a suspect turn inside one VAD utterance."""
    utterance = Utterance(["OFFICER"] * 3 + ["SUSPECT"] * 3)
    engine = SpeakerTurnSplitter()
    spans = split(utterance, engine=engine)
    assert spans == [TurnSpan(0, 1500), TurnSpan(1500, utterance.total_ms)]
    assert engine.last_metrics is not None
    assert engine.last_metrics.reason == REASON_DEEP_DIP


def test_change_region_splits_without_any_reference():
    """The live worker has no biometric reference: the deep dip must still split."""
    utterance = Utterance(["OFFICER"] * 3 + ["SUSPECT"] * 3, reference=None)
    engine = SpeakerTurnSplitter()
    spans = split(utterance, reference=False, whole=False, engine=engine)
    assert spans == [TurnSpan(0, 1500), TurnSpan(1500, utterance.total_ms)]
    assert engine.last_metrics is not None
    assert engine.last_metrics.reason == REASON_DEEP_DIP
    assert engine.last_metrics.whole_cos_ref is None


def test_two_consecutive_dips_are_rule_a():
    utterance = Utterance(["SUSPECT"] * 3 + ["SHALLOW", "MIXED_NEAR"] + ["SUSPECT"] * 2)
    engine = SpeakerTurnSplitter()
    spans = split(utterance, engine=engine)
    assert len(spans) == 2
    assert engine.last_metrics is not None
    assert engine.last_metrics.reason == REASON_RULE_A


def test_flat_utterance_without_any_dip_is_a_single_ambiguous_turn():
    utterance = Utterance(["MIXED_FAR"] * 6)
    engine = SpeakerTurnSplitter()
    spans = split(utterance, engine=engine)
    assert spans == [TurnSpan(0, utterance.total_ms, True)]
    assert engine.last_metrics is not None
    assert engine.last_metrics.reason == REASON_NO_DIP


def test_isolated_shallow_dip_without_role_support_is_not_split():
    utterance = Utterance(["SUSPECT", "SHALLOW", "ROLE_NEAR", "SUSPECT"])
    engine = SpeakerTurnSplitter()
    spans = split(utterance, engine=engine)
    assert spans == [TurnSpan(0, utterance.total_ms, True)]
    assert engine.last_metrics is not None
    assert engine.last_metrics.reason == REASON_NO_ROLE_SUPPORT


def test_change_point_too_close_to_the_start_is_rejected():
    utterance = Utterance(["OFFICER", "SUSPECT", "SUSPECT", "SUSPECT"])
    engine = SpeakerTurnSplitter()
    spans = split(utterance, engine=engine)
    assert spans == [TurnSpan(0, utterance.total_ms, True)]
    assert engine.last_metrics is not None
    assert engine.last_metrics.reason == REASON_MIN_TURN


def test_same_change_point_is_accepted_when_min_turn_ms_allows_it():
    utterance = Utterance(["OFFICER", "SUSPECT", "SUSPECT", "SUSPECT"])
    engine = SpeakerTurnSplitter(min_turn_ms=500)
    spans = split(utterance, engine=engine)
    assert spans == [TurnSpan(0, 500), TurnSpan(500, utterance.total_ms)]


def test_spans_cover_the_utterance_without_gaps_or_overlaps():
    utterance = Utterance(["OFFICER"] * 3 + ["SUSPECT"] * 3)
    spans = split(utterance)
    assert spans[0].start_ms == 0
    assert spans[-1].end_ms == utterance.total_ms
    for left, right in zip(spans, spans[1:]):
        assert left.end_ms == right.start_ms
    assert all(span.end_ms > span.start_ms for span in spans)


def test_utterance_shorter_than_two_windows_is_ambiguous():
    utterance = Utterance(["SUSPECT"], total_ms=1600)
    engine = SpeakerTurnSplitter()
    spans = split(utterance, engine=engine)
    assert spans == [TurnSpan(0, utterance.total_ms, True)]
    assert engine.last_metrics is not None
    assert engine.last_metrics.reason == REASON_TOO_SHORT


# --------------------------------------------------------------------------- cost
def test_metrics_report_the_embedded_window_count():
    utterance = Utterance(["OFFICER"] * 3 + ["SUSPECT"] * 3)
    engine = SpeakerTurnSplitter()
    split(utterance, engine=engine)
    assert engine.last_metrics is not None
    # the whole-utterance embedding comes from the caller, so only windows are embedded
    assert engine.last_metrics.embedded_windows == len(utterance.starts)
    assert len(utterance.embedder.calls) == len(utterance.starts)


def test_gated_utterance_never_embeds_windows():
    utterance = Utterance(["SUSPECT"] * 6, whole_class="SUSPECT")
    engine = SpeakerTurnSplitter()
    split(utterance, engine=engine)
    assert engine.last_metrics is not None
    assert engine.last_metrics.embedded_windows == 0
    assert utterance.embedder.calls == []
