from __future__ import annotations

import pytest

from app.services.speaker_calibration_math import (
    CalibrationProbe,
    CalibrationSample,
    build_trials,
    choose_operating_point,
    compute_eer,
    evaluate_operating_point,
)


def test_leave_one_out_trials_build_genuine_and_all_impostor_scores():
    samples = [
        CalibrationSample("A", (1.0, 0.0, 0.0)),
        CalibrationSample("A", (0.99, 0.10, 0.0)),
        CalibrationSample("A", (0.98, -0.10, 0.0)),
        CalibrationSample("B", (0.0, 1.0, 0.0)),
        CalibrationSample("B", (0.10, 0.99, 0.0)),
        CalibrationSample("B", (-0.10, 0.98, 0.0)),
        CalibrationSample("C", (0.0, 0.0, 1.0)),
        CalibrationSample("C", (0.0, 0.10, 0.99)),
        CalibrationSample("C", (0.0, -0.10, 0.98)),
    ]

    probes = build_trials(samples)

    assert len(probes) == 9
    assert all(len(item.impostor_scores) == 2 for item in probes)
    assert all(item.genuine_score > 0.97 for item in probes)
    assert sum(len(item.impostor_scores) for item in probes) == 18


def test_far_and_frr_use_genuine_and_all_impostor_trials():
    probes = [
        CalibrationProbe("A", genuine_score=0.90, impostor_scores=(0.40, 0.30)),
        CalibrationProbe("B", genuine_score=0.80, impostor_scores=(0.70, 0.20)),
    ]

    conservative = evaluate_operating_point(probes, threshold=0.85, margin=0.0)
    assert conservative.frr == pytest.approx(0.5)
    assert conservative.far == pytest.approx(0.0)
    assert conservative.genuine_trial_count == 2
    assert conservative.impostor_trial_count == 4

    permissive = evaluate_operating_point(probes, threshold=0.65, margin=0.0)
    assert permissive.frr == pytest.approx(0.0)
    assert permissive.far == pytest.approx(0.25)


def test_eer_sweep_prefers_higher_threshold_when_error_gap_ties():
    probes = [
        CalibrationProbe("A", genuine_score=0.60, impostor_scores=(0.70,)),
        CalibrationProbe("B", genuine_score=0.80, impostor_scores=(0.40,)),
    ]

    result = compute_eer(probes)

    assert result.eer == pytest.approx(0.5)
    assert result.far == pytest.approx(0.5)
    assert result.frr == pytest.approx(0.5)
    assert result.threshold == pytest.approx(0.70)


def test_operating_point_prioritizes_zero_observed_far_then_low_frr():
    probes = [
        CalibrationProbe("A", genuine_score=0.90, impostor_scores=(0.65, 0.20)),
        CalibrationProbe("B", genuine_score=0.85, impostor_scores=(0.62, 0.10)),
        CalibrationProbe("C", genuine_score=0.80, impostor_scores=(0.60, 0.15)),
    ]

    chosen = choose_operating_point(probes)

    assert chosen.far == pytest.approx(0.0)
    assert chosen.frr == pytest.approx(0.0)
    assert 0.65 < chosen.threshold <= 0.80
    assert chosen.margin >= 0.0
