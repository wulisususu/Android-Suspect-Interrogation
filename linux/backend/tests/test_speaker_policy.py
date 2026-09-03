from __future__ import annotations

import pytest

from app.ai.speech.calibration import (
    ERES2NET_LARGE_BASELINE_THRESHOLD,
    LEGACY_XVECTOR_BASELINE_THRESHOLD,
)
from app.services.speaker_policy import (
    SpeakerRole,
    SpeakerSource,
    decide_speaker,
)


def candidate(role: SpeakerRole, score: float, speaker_id: str | None = None, name: str | None = None) -> dict:
    return {
        "role": role,
        "score": score,
        "speaker_id": speaker_id,
        "speaker_name": name,
    }


def decide(candidates, enabled_roles, *, duration=1800, overlap=False, threshold=0.70, margin=0.10):
    return decide_speaker(
        candidates=candidates,
        enabled_roles=enabled_roles,
        threshold=threshold,
        margin=margin,
        usable_duration_ms=duration,
        overlap=overlap,
    )


def test_legacy_xvector_provenance_value_remains_readable():
    assert SpeakerSource("X_VECTOR") is SpeakerSource.X_VECTOR
    assert SpeakerSource.X_VECTOR.value == "X_VECTOR"


def test_suspect_only_legacy_xvector_baseline_leaves_high_impostor_score_for_manual_confirmation():
    result = decide_speaker(
        candidates=[candidate(SpeakerRole.SUSPECT, 0.90, "suspect-1", "张某")],
        enabled_roles={SpeakerRole.SUSPECT},
        threshold=LEGACY_XVECTOR_BASELINE_THRESHOLD,
        margin=0.0,
        usable_duration_ms=1800,
        overlap=False,
    )

    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED
    assert result.voiceprint_verified is False
    assert result.score == pytest.approx(0.90)
    assert result.low_confidence is True


def test_suspect_only_eres2net_baseline_accepts_score_above_vendor_threshold():
    result = decide_speaker(
        candidates=[candidate(SpeakerRole.SUSPECT, 0.68, "suspect-1", "张某")],
        enabled_roles={SpeakerRole.SUSPECT},
        threshold=ERES2NET_LARGE_BASELINE_THRESHOLD,
        margin=0.0,
        usable_duration_ms=1800,
        overlap=False,
    )

    assert result.role is SpeakerRole.SUSPECT
    assert result.source is SpeakerSource.SPEAKER_EMBEDDING
    assert result.voiceprint_verified is True


def test_suspect_only_accepts_verified_suspect():
    result = decide(
        [candidate(SpeakerRole.SUSPECT, 0.84, "suspect-1", "张某")],
        {SpeakerRole.SUSPECT},
    )
    assert result.role is SpeakerRole.SUSPECT
    assert result.source is SpeakerSource.SPEAKER_EMBEDDING
    assert result.voiceprint_verified is True
    assert result.score == pytest.approx(0.84)
    assert result.second_best_score is None
    assert result.speaker_id == "suspect-1"
    assert result.speaker_name == "张某"
    assert result.low_confidence is False


def test_suspect_only_leaves_nonmatching_speech_for_manual_confirmation():
    result = decide(
        [candidate(SpeakerRole.SUSPECT, 0.42, "suspect-1", "张某")],
        {SpeakerRole.SUSPECT},
    )
    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED
    assert result.voiceprint_verified is False
    assert result.score == pytest.approx(0.42)
    assert result.speaker_id is None
    assert result.speaker_name is None
    assert result.low_confidence is True


def test_partial_mode_accepts_registered_officer_when_threshold_and_margin_pass():
    result = decide(
        [
            candidate(SpeakerRole.SUSPECT, 0.35, "suspect-1", "张某"),
            candidate(SpeakerRole.INTERROGATOR, 0.88, "officer-1", "李警官"),
        ],
        {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR},
    )
    assert result.role is SpeakerRole.INTERROGATOR
    assert result.source is SpeakerSource.SPEAKER_EMBEDDING
    assert result.voiceprint_verified is True
    assert result.score == pytest.approx(0.88)
    assert result.second_best_score == pytest.approx(0.35)
    assert result.speaker_id == "officer-1"
    assert result.speaker_name == "李警官"


def test_partial_mode_keeps_unmatched_speech_for_manual_confirmation():
    result = decide(
        [
            candidate(SpeakerRole.SUSPECT, 0.40),
            candidate(SpeakerRole.INTERROGATOR, 0.52, "officer-1", "李警官"),
        ],
        {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR},
    )
    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED
    assert result.voiceprint_verified is False
    assert result.speaker_id is None
    assert result.speaker_name is None
    assert result.low_confidence is True


def test_partial_mode_keeps_near_threshold_suspect_as_unknown_instead_of_forcing_fallback():
    result = decide(
        [
            candidate(SpeakerRole.SUSPECT, 0.66),
            candidate(SpeakerRole.INTERROGATOR, 0.48, "officer-1", "李警官"),
        ],
        {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR},
    )
    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED
    assert result.voiceprint_verified is False
    assert result.low_confidence is True


def test_full_mode_accepts_best_candidate_only_when_threshold_and_margin_pass():
    result = decide(
        [
            candidate(SpeakerRole.SUSPECT, 0.31, "suspect-1", "张某"),
            candidate(SpeakerRole.INTERROGATOR, 0.82, "officer-1", "李警官"),
            candidate(SpeakerRole.RECORDER, 0.59, "officer-2", "王警官"),
        ],
        {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR, SpeakerRole.RECORDER},
    )
    assert result.role is SpeakerRole.INTERROGATOR
    assert result.source is SpeakerSource.SPEAKER_EMBEDDING
    assert result.voiceprint_verified is True
    assert result.score == pytest.approx(0.82)
    assert result.second_best_score == pytest.approx(0.59)


def test_full_mode_returns_unknown_when_best_score_is_below_threshold():
    result = decide(
        [
            candidate(SpeakerRole.SUSPECT, 0.58),
            candidate(SpeakerRole.INTERROGATOR, 0.63),
            candidate(SpeakerRole.RECORDER, 0.44),
        ],
        {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR, SpeakerRole.RECORDER},
    )
    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED
    assert result.low_confidence is True


def test_full_mode_returns_unknown_when_top_two_fail_margin():
    result = decide(
        [
            candidate(SpeakerRole.SUSPECT, 0.79),
            candidate(SpeakerRole.INTERROGATOR, 0.76),
            candidate(SpeakerRole.RECORDER, 0.41),
        ],
        {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR, SpeakerRole.RECORDER},
    )
    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED
    assert result.score == pytest.approx(0.79)
    assert result.second_best_score == pytest.approx(0.76)
    assert result.low_confidence is True


@pytest.mark.parametrize("duration,overlap", [(999, False), (1800, True)])
def test_short_or_overlapping_utterance_is_never_forced_to_identity(duration, overlap):
    result = decide(
        [candidate(SpeakerRole.SUSPECT, 0.99, "suspect-1", "张某")],
        {SpeakerRole.SUSPECT},
        duration=duration,
        overlap=overlap,
    )
    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED
    assert result.voiceprint_verified is False
    assert result.low_confidence is True


def test_policy_ignores_candidates_for_roles_not_enabled_in_session():
    result = decide(
        [
            candidate(SpeakerRole.SUSPECT, 0.39),
            candidate(SpeakerRole.INTERROGATOR, 0.98, "officer-1", "李警官"),
        ],
        {SpeakerRole.SUSPECT},
    )
    assert result.role is SpeakerRole.UNKNOWN
    assert result.source is SpeakerSource.UNASSIGNED


def test_policy_rejects_invalid_calibration_values():
    with pytest.raises(ValueError):
        decide([], {SpeakerRole.SUSPECT}, threshold=1.01)
    with pytest.raises(ValueError):
        decide([], {SpeakerRole.SUSPECT}, margin=-0.01)


def test_policy_requires_suspect_role_and_rejects_duplicate_candidates():
    with pytest.raises(ValueError):
        decide([], {SpeakerRole.INTERROGATOR})
    with pytest.raises(ValueError):
        decide(
            [candidate(SpeakerRole.SUSPECT, 0.8), candidate(SpeakerRole.SUSPECT, 0.7)],
            {SpeakerRole.SUSPECT},
        )
