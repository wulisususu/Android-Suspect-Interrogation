"""Task 17B-1: one authoritative rule for the effective speaker recognition mode.

The UI declares a recognition mode from the officer voiceprint bindings, while the
runtime silently narrows multi-reference comparison to suspect-only when the device
has no calibrated margin. Both sides must be derived from the same rule so that
"what the UI declares" and "what the runtime enforces" can never diverge silently.
"""

from app.services.speaker_mode import (
    DEGRADED_REASON_MARGIN_CALIBRATION_MISSING,
    DEGRADED_REASON_THRESHOLD_NOT_CONFIGURED,
    FULL,
    MODE_DECISION_KEY,
    MODE_DEGRADED_KEY,
    SUSPECT_ONLY,
    SUSPECT_PLUS_INTERROGATOR,
    SUSPECT_PLUS_RECORDER,
    SpeakerModeConfig,
    decision_roles,
    mode_decision_detail,
    narrow_decision_roles,
    resolve_effective_recognition_mode,
)
from app.services.speaker_policy import SpeakerRole


def _candidate(role: SpeakerRole, score: float) -> dict:
    return {"role": role, "score": score, "speaker_id": role.value, "speaker_name": role.value}


# --- pure rule: margin present/absent x threshold present/absent -----------------


def test_declared_mode_is_reported_effective_when_margin_and_threshold_exist():
    assert resolve_effective_recognition_mode(
        declared_mode=SUSPECT_PLUS_INTERROGATOR,
        margin=0.08,
        threshold=0.372,
    ) == (SUSPECT_PLUS_INTERROGATOR, None)


def test_missing_margin_degrades_any_multi_reference_mode_to_suspect_only():
    effective, reason = resolve_effective_recognition_mode(
        declared_mode=SUSPECT_PLUS_INTERROGATOR,
        margin=None,
        threshold=0.372,
    )
    assert effective == SUSPECT_ONLY
    assert reason == DEGRADED_REASON_MARGIN_CALIBRATION_MISSING


def test_missing_threshold_is_reported_even_when_margin_exists():
    effective, reason = resolve_effective_recognition_mode(
        declared_mode=FULL,
        margin=0.08,
        threshold=None,
    )
    assert effective == SUSPECT_ONLY
    assert reason == DEGRADED_REASON_THRESHOLD_NOT_CONFIGURED


def test_missing_margin_and_threshold_reports_the_margin_channel():
    effective, reason = resolve_effective_recognition_mode(
        declared_mode=SUSPECT_PLUS_RECORDER,
        margin=None,
        threshold=None,
    )
    assert effective == SUSPECT_ONLY
    assert reason == DEGRADED_REASON_MARGIN_CALIBRATION_MISSING


def test_suspect_only_declaration_is_returned_unchanged_without_a_reason():
    for margin, threshold in ((None, None), (None, 0.372), (0.08, None), (0.08, 0.372)):
        assert resolve_effective_recognition_mode(
            declared_mode=SUSPECT_ONLY,
            margin=margin,
            threshold=threshold,
        ) == (SUSPECT_ONLY, None)


def test_unknown_declared_mode_is_rejected_loudly():
    import pytest

    with pytest.raises(ValueError):
        resolve_effective_recognition_mode(declared_mode="WHATEVER", margin=0.08, threshold=0.372)


# --- narrowing predicate (the rule the runtime actually enforces) ---------------


def test_narrowing_keeps_every_bound_role_only_when_the_mode_is_effective():
    candidates = [
        _candidate(SpeakerRole.SUSPECT, 0.9),
        _candidate(SpeakerRole.INTERROGATOR, 0.8),
    ]
    roles = {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR}

    kept_roles, kept_candidates = narrow_decision_roles(
        declared_mode=SUSPECT_PLUS_INTERROGATOR,
        margin=0.08,
        threshold=0.372,
        enabled_roles=roles,
        candidates=candidates,
    )
    assert kept_roles == roles
    assert kept_candidates == candidates
    assert decision_roles(
        declared_mode=SUSPECT_PLUS_INTERROGATOR, margin=0.08, threshold=0.372
    ) == roles


def test_narrowing_drops_unbound_officer_candidates_when_margin_is_missing():
    candidates = [
        _candidate(SpeakerRole.SUSPECT, 0.9),
        _candidate(SpeakerRole.INTERROGATOR, 0.8),
    ]

    kept_roles, kept_candidates = narrow_decision_roles(
        declared_mode=SUSPECT_PLUS_INTERROGATOR,
        margin=None,
        threshold=0.372,
        enabled_roles={SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR},
        candidates=candidates,
    )
    assert kept_roles == {SpeakerRole.SUSPECT}
    assert [item["role"] for item in kept_candidates] == [SpeakerRole.SUSPECT]


def test_narrowing_is_a_no_op_for_a_declared_suspect_only_session():
    candidates = [_candidate(SpeakerRole.SUSPECT, 0.9)]
    kept_roles, kept_candidates = narrow_decision_roles(
        declared_mode=SUSPECT_ONLY,
        margin=None,
        threshold=None,
        enabled_roles={SpeakerRole.SUSPECT},
        candidates=candidates,
    )
    assert kept_roles == {SpeakerRole.SUSPECT}
    assert kept_candidates == candidates


def test_decision_detail_marks_degradation_for_audit_readers():
    degraded = mode_decision_detail(
        declared_mode=SUSPECT_PLUS_INTERROGATOR, margin=None, threshold=0.372
    )
    assert degraded[MODE_DECISION_KEY] == SUSPECT_ONLY
    assert degraded[MODE_DEGRADED_KEY] is True
    assert degraded["declaredRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert degraded["recognitionModeDegradedReason"] == DEGRADED_REASON_MARGIN_CALIBRATION_MISSING

    intact = mode_decision_detail(declared_mode=FULL, margin=0.08, threshold=0.372)
    assert intact[MODE_DECISION_KEY] == FULL
    assert intact[MODE_DEGRADED_KEY] is False
    assert intact["recognitionModeDegradedReason"] is None


# --- runtime configuration source ----------------------------------------------


def test_config_prefers_the_active_capture_runtime_over_the_supervisor():
    config = SpeakerModeConfig.from_sources(
        [
            {"threshold": 0.372, "margin": None, "thresholdSource": "DEVICE_CALIBRATED"},
            {"speaker_accept_threshold": 0.372, "speaker_margin": 0.08, "speaker_threshold_source": "DEVICE_CALIBRATED"},
        ]
    )
    assert config.threshold == 0.372
    assert config.margin is None
    assert config.threshold_source == "DEVICE_CALIBRATED"
    assert config.margin_configured is False
    assert config.threshold_configured is True


def test_config_skips_sources_that_expose_no_speaker_setting_at_all():
    config = SpeakerModeConfig.from_sources([None, {}, object()])
    assert config == SpeakerModeConfig(margin=None, threshold=None, threshold_source=None)


def test_config_resolution_honours_the_single_authoritative_rule():
    configured = SpeakerModeConfig.from_sources(
        [{"speaker_accept_threshold": 0.372, "speaker_margin": 0.08, "speaker_threshold_source": "DEVICE_CALIBRATED"}]
    )
    assert configured.resolve(SUSPECT_PLUS_INTERROGATOR) == (SUSPECT_PLUS_INTERROGATOR, None)

    uncalibrated = SpeakerModeConfig.from_sources([{"speaker_accept_threshold": 0.372, "speaker_margin": None}])
    assert uncalibrated.resolve(SUSPECT_PLUS_INTERROGATOR) == (
        SUSPECT_ONLY,
        DEGRADED_REASON_MARGIN_CALIBRATION_MISSING,
    )
