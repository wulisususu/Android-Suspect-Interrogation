from __future__ import annotations

import math
import os
from dataclasses import dataclass


_ACCEPT_THRESHOLD_ENV = "SUSPECT_SPEAKER_ACCEPT_THRESHOLD"
_MARGIN_ENV = "SUSPECT_SPEAKER_MARGIN"


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

    @classmethod
    def from_env(cls) -> "SpeakerCalibration":
        return cls(
            accept_threshold=_optional_unit_float(_ACCEPT_THRESHOLD_ENV),
            margin=_optional_unit_float(_MARGIN_ENV),
        )

    @property
    def configured(self) -> bool:
        return self.accept_threshold is not None and self.margin is not None

    @property
    def state(self) -> str:
        return "AVAILABLE" if self.configured else "NOT_CONFIGURED"

    def capability_detail(self) -> dict[str, object]:
        return {
            "state": self.state,
            "threshold_configured": self.accept_threshold is not None,
            "margin_configured": self.margin is not None,
        }
