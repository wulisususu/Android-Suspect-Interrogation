from __future__ import annotations

import math
import os
from dataclasses import dataclass


_ACCEPT_THRESHOLD_ENV = "SUSPECT_SPEAKER_ACCEPT_THRESHOLD"
_MARGIN_ENV = "SUSPECT_SPEAKER_MARGIN"
_BASELINE_THRESHOLD_ENV = "SUSPECT_SPEAKER_BASELINE_THRESHOLD"
MODEL_BASELINE_THRESHOLD = 0.70


def _optional_unit_float(name: str) -> float | None:
    raw = os.getenv(name)
    if raw is None or not raw.strip():
        return None
    try:
        value = float(raw)
    except ValueError as exc:
        raise ValueError(f"{name} must be a decimal between 0.0 and 1.0") from exc
    if not math.isfinite(value) or not 0.0 <= value <= 1.0:
        raise ValueError(f"{name} must be between 0.0 and 1.0")
    return value


@dataclass(frozen=True)
class SpeakerCalibration:
    accept_threshold: float | None
    margin: float | None
    baseline_threshold: float = MODEL_BASELINE_THRESHOLD

    @classmethod
    def from_env(cls) -> "SpeakerCalibration":
        baseline = _optional_unit_float(_BASELINE_THRESHOLD_ENV)
        return cls(
            accept_threshold=_optional_unit_float(_ACCEPT_THRESHOLD_ENV),
            margin=_optional_unit_float(_MARGIN_ENV),
            baseline_threshold=MODEL_BASELINE_THRESHOLD if baseline is None else baseline,
        )

    @property
    def effective_threshold(self) -> float:
        return self.accept_threshold if self.accept_threshold is not None else self.baseline_threshold

    @property
    def threshold_source(self) -> str:
        return "DEVICE_CALIBRATED" if self.accept_threshold is not None else "MODEL_BASELINE"

    @property
    def device_calibrated(self) -> bool:
        return self.accept_threshold is not None

    @property
    def configured(self) -> bool:
        # Backward-compatible meaning: both device-specific multi-speaker values exist.
        return self.accept_threshold is not None and self.margin is not None

    @property
    def state(self) -> str:
        return "AVAILABLE" if self.configured else "NOT_CONFIGURED"

    def capability_detail(self) -> dict[str, object]:
        return {
            "state": self.state,
            "threshold_configured": self.accept_threshold is not None,
            "margin_configured": self.margin is not None,
            "effective_threshold": self.effective_threshold,
            "thresholdSource": self.threshold_source,
            "device_calibrated": self.device_calibrated,
        }
