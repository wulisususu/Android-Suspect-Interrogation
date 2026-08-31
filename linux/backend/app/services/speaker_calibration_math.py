from __future__ import annotations

import math
from dataclasses import dataclass
from typing import Iterable, Sequence


@dataclass(frozen=True)
class CalibrationSample:
    identity: str
    embedding: tuple[float, ...]

    def __init__(self, identity: str, embedding: Sequence[float]):
        object.__setattr__(self, "identity", str(identity))
        object.__setattr__(self, "embedding", tuple(float(value) for value in embedding))


@dataclass(frozen=True)
class CalibrationProbe:
    identity: str
    genuine_score: float
    impostor_scores: tuple[float, ...]

    def __init__(self, identity: str, genuine_score: float, impostor_scores: Sequence[float]):
        object.__setattr__(self, "identity", str(identity))
        object.__setattr__(self, "genuine_score", float(genuine_score))
        object.__setattr__(self, "impostor_scores", tuple(float(value) for value in impostor_scores))


@dataclass(frozen=True)
class OperatingPoint:
    threshold: float
    margin: float
    far: float
    frr: float
    false_accept_count: int
    false_reject_count: int
    genuine_trial_count: int
    impostor_trial_count: int
    robustness: float


@dataclass(frozen=True)
class EERResult:
    eer: float
    threshold: float
    far: float
    frr: float


def normalize(vector: Iterable[float]) -> tuple[float, ...]:
    values = tuple(float(value) for value in vector)
    if not values or not all(math.isfinite(value) for value in values):
        raise ValueError("embedding must contain finite values")
    norm = math.sqrt(sum(value * value for value in values))
    if norm <= 0.0:
        raise ValueError("embedding norm must be positive")
    return tuple(value / norm for value in values)


def cosine(left: Sequence[float], right: Sequence[float]) -> float:
    a = normalize(left)
    b = normalize(right)
    if len(a) != len(b):
        raise ValueError("embedding dimensions do not match")
    return max(-1.0, min(1.0, float(sum(x * y for x, y in zip(a, b)))))


def centroid(vectors: Sequence[Sequence[float]]) -> tuple[float, ...]:
    if not vectors:
        raise ValueError("centroid requires at least one vector")
    normalized = [normalize(vector) for vector in vectors]
    dimension = len(normalized[0])
    if dimension <= 0 or any(len(vector) != dimension for vector in normalized):
        raise ValueError("embedding dimensions do not match")
    mean = tuple(sum(vector[index] for vector in normalized) / len(normalized) for index in range(dimension))
    return normalize(mean)


def build_trials(samples: Sequence[CalibrationSample]) -> list[CalibrationProbe]:
    grouped: dict[str, list[tuple[float, ...]]] = {}
    for sample in samples:
        grouped.setdefault(sample.identity, []).append(normalize(sample.embedding))
    if len(grouped) < 2:
        raise ValueError("calibration requires at least two identities")
    if any(len(vectors) < 2 for vectors in grouped.values()):
        raise ValueError("each calibration identity requires at least two samples")

    full_references = {identity: centroid(vectors) for identity, vectors in grouped.items()}
    probes: list[CalibrationProbe] = []
    for identity in sorted(grouped):
        vectors = grouped[identity]
        for index, held_out in enumerate(vectors):
            own_reference = centroid([vector for offset, vector in enumerate(vectors) if offset != index])
            genuine_score = cosine(held_out, own_reference)
            impostor_scores = tuple(
                cosine(held_out, full_references[other])
                for other in sorted(full_references)
                if other != identity
            )
            probes.append(CalibrationProbe(identity, genuine_score, impostor_scores))
    return probes


def _impostor_margin(scores: Sequence[float], index: int) -> float | None:
    if len(scores) <= 1:
        return None
    other_best = max(score for offset, score in enumerate(scores) if offset != index)
    return float(scores[index] - other_best)


def evaluate_operating_point(
    probes: Sequence[CalibrationProbe],
    *,
    threshold: float,
    margin: float,
) -> OperatingPoint:
    if not probes:
        raise ValueError("calibration requires scored probes")
    threshold = float(threshold)
    margin = float(margin)
    if not math.isfinite(threshold) or not 0.0 <= threshold <= 1.0:
        raise ValueError("threshold must be within [0, 1]")
    if not math.isfinite(margin) or not 0.0 <= margin <= 2.0:
        raise ValueError("margin must be within [0, 2]")

    false_rejects = 0
    false_accepts = 0
    impostor_trials = 0
    buffers: list[float] = []

    for probe in probes:
        wrong = tuple(float(score) for score in probe.impostor_scores)
        top_wrong = max(wrong) if wrong else -1.0
        genuine_gap = probe.genuine_score - top_wrong
        genuine_pass = probe.genuine_score >= threshold and genuine_gap >= margin
        if not genuine_pass:
            false_rejects += 1
        else:
            buffers.extend((probe.genuine_score - threshold, genuine_gap - margin))

        for index, score in enumerate(wrong):
            impostor_trials += 1
            wrong_gap = _impostor_margin(wrong, index)
            margin_pass = wrong_gap is None or wrong_gap >= margin
            accepted = score >= threshold and margin_pass
            if accepted:
                false_accepts += 1
            else:
                rejection_buffers: list[float] = []
                if score < threshold:
                    rejection_buffers.append(threshold - score)
                if wrong_gap is not None and wrong_gap < margin:
                    rejection_buffers.append(margin - wrong_gap)
                if rejection_buffers:
                    buffers.append(max(rejection_buffers))

    genuine_trials = len(probes)
    far = false_accepts / impostor_trials if impostor_trials else 0.0
    frr = false_rejects / genuine_trials
    robustness = min(buffers) if buffers else 0.0
    return OperatingPoint(
        threshold=threshold,
        margin=margin,
        far=far,
        frr=frr,
        false_accept_count=false_accepts,
        false_reject_count=false_rejects,
        genuine_trial_count=genuine_trials,
        impostor_trial_count=impostor_trials,
        robustness=robustness,
    )


def _candidate_values(values: Iterable[float], *, low: float, high: float) -> list[float]:
    points = {low, high}
    for value in values:
        numeric = float(value)
        if math.isfinite(numeric):
            points.add(max(low, min(high, numeric)))
    ordered = sorted(points)
    points.update((left + right) / 2.0 for left, right in zip(ordered, ordered[1:]) if right > left)
    return sorted(points)


def _threshold_rates(probes: Sequence[CalibrationProbe], threshold: float) -> tuple[float, float]:
    genuine = [probe.genuine_score for probe in probes]
    impostors = [score for probe in probes for score in probe.impostor_scores]
    if not genuine or not impostors:
        raise ValueError("EER requires genuine and impostor trials")
    frr = sum(score < threshold for score in genuine) / len(genuine)
    far = sum(score >= threshold for score in impostors) / len(impostors)
    return far, frr


def compute_eer(probes: Sequence[CalibrationProbe]) -> EERResult:
    if not probes:
        raise ValueError("EER requires scored probes")
    score_values = [probe.genuine_score for probe in probes]
    score_values.extend(score for probe in probes for score in probe.impostor_scores)
    candidates = _candidate_values(score_values, low=0.0, high=1.0)

    evaluated: list[EERResult] = []
    for threshold in candidates:
        far, frr = _threshold_rates(probes, threshold)
        evaluated.append(EERResult(eer=(far + frr) / 2.0, threshold=threshold, far=far, frr=frr))
    return min(evaluated, key=lambda item: (abs(item.far - item.frr), -item.threshold))


def choose_operating_point(probes: Sequence[CalibrationProbe]) -> OperatingPoint:
    if not probes:
        raise ValueError("calibration requires scored probes")
    score_values = [probe.genuine_score for probe in probes]
    score_values.extend(score for probe in probes for score in probe.impostor_scores)

    margin_values: list[float] = [0.0]
    for probe in probes:
        wrong = tuple(probe.impostor_scores)
        top_wrong = max(wrong) if wrong else -1.0
        margin_values.append(probe.genuine_score - top_wrong)
        for index in range(len(wrong)):
            gap = _impostor_margin(wrong, index)
            if gap is not None:
                margin_values.append(gap)

    thresholds = _candidate_values(score_values, low=0.0, high=1.0)
    margins = _candidate_values(margin_values, low=0.0, high=2.0)
    evaluated = [
        evaluate_operating_point(probes, threshold=threshold, margin=margin)
        for threshold in thresholds
        for margin in margins
    ]

    zero_far = [item for item in evaluated if item.false_accept_count == 0]
    if zero_far:
        return min(
            zero_far,
            key=lambda item: (
                item.frr,
                -item.robustness,
                -item.threshold,
                -item.margin,
            ),
        )

    return min(
        evaluated,
        key=lambda item: (
            10.0 * item.far + item.frr,
            -item.robustness,
            -item.threshold,
            -item.margin,
        ),
    )
