from __future__ import annotations

from app.ai.speech.calibration import SpeakerCalibration
from app.services.speaker_calibration_runtime import resolve_speaker_calibration


class FakeLifecycle:
    def __init__(self, state):
        self.state = state

    def status(self):
        return self.state


def test_valid_database_calibration_wins_over_legacy_env():
    state = {
        "status": "VALID",
        "calibration": {"calibrationId": "CAL-1", "threshold": 0.81, "margin": 0.09},
        "currentModel": {"fingerprint": "a" * 64},
        "currentMicrophone": {"fingerprint": "b" * 64},
    }
    result = resolve_speaker_calibration(FakeLifecycle(state), SpeakerCalibration(0.55, 0.01))
    assert result.threshold == 0.81
    assert result.margin == 0.09
    assert result.source == "DEVICE_CALIBRATED"
    assert result.calibration_id == "CAL-1"


def test_stale_database_history_cannot_be_bypassed_by_legacy_env():
    state = {
        "status": "STALE_MODEL",
        "calibration": {"calibrationId": "CAL-1", "threshold": 0.81, "margin": 0.09},
        "currentModel": {"fingerprint": "c" * 64},
        "currentMicrophone": {"fingerprint": "b" * 64},
    }
    result = resolve_speaker_calibration(FakeLifecycle(state), SpeakerCalibration(0.55, 0.01, baseline_threshold=0.70))
    assert result.threshold == 0.70
    assert result.margin is None
    assert result.source == "MODEL_BASELINE"
    assert result.calibration_id is None


def test_no_database_history_keeps_legacy_env_backward_compatibility():
    state = {
        "status": "NOT_CALIBRATED",
        "calibration": None,
        "currentModel": {"fingerprint": "a" * 64},
        "currentMicrophone": {"fingerprint": "b" * 64},
    }
    result = resolve_speaker_calibration(FakeLifecycle(state), SpeakerCalibration(0.74, 0.07))
    assert result.threshold == 0.74
    assert result.margin == 0.07
    assert result.source == "LEGACY_ENV"


def test_no_database_or_env_uses_model_baseline():
    state = {
        "status": "NOT_CALIBRATED",
        "calibration": None,
        "currentModel": {"fingerprint": "a" * 64},
        "currentMicrophone": {"fingerprint": "b" * 64},
    }
    result = resolve_speaker_calibration(FakeLifecycle(state), SpeakerCalibration(None, None, baseline_threshold=0.72))
    assert result.threshold == 0.72
    assert result.margin is None
    assert result.source == "MODEL_BASELINE"
