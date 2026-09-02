from __future__ import annotations

from dataclasses import dataclass
from typing import Any

from app.ai.speech.calibration import SpeakerCalibration


@dataclass(frozen=True)
class ResolvedSpeakerCalibration:
    calibration_id: str | None
    threshold: float
    margin: float | None
    source: str
    status: str
    speaker_model_fingerprint: str | None
    microphone_fingerprint: str | None
    speaker_backend_key: str | None = None


def resolve_speaker_calibration(lifecycle: Any, legacy: SpeakerCalibration) -> ResolvedSpeakerCalibration:
    state = lifecycle.status()
    status = str(state.get("status") or "NOT_CALIBRATED")
    calibration = state.get("calibration") if isinstance(state, dict) else None
    model = state.get("currentModel") if isinstance(state, dict) else None
    microphone = state.get("currentMicrophone") if isinstance(state, dict) else None
    model_fp = model.get("fingerprint") if isinstance(model, dict) else None
    backend_key = model.get("backendKey") if isinstance(model, dict) else None
    mic_fp = microphone.get("fingerprint") if isinstance(microphone, dict) else None

    if status in {"VALID", "RECOMPUTE_RECOMMENDED"} and isinstance(calibration, dict):
        return ResolvedSpeakerCalibration(
            calibration_id=str(calibration.get("calibrationId")) if calibration.get("calibrationId") else None,
            threshold=float(calibration["threshold"]),
            margin=None if calibration.get("margin") is None else float(calibration["margin"]),
            source="DEVICE_CALIBRATED",
            status=status,
            speaker_model_fingerprint=None if model_fp is None else str(model_fp),
            microphone_fingerprint=None if mic_fp is None else str(mic_fp),
            speaker_backend_key=None if backend_key is None else str(backend_key),
        )

    # Once DB calibration history exists, stale/insufficient lifecycle state must
    # not be bypassed by old env values. The status payload keeps the historical
    # calibration object even when it is no longer usable.
    if isinstance(calibration, dict):
        return ResolvedSpeakerCalibration(
            calibration_id=None,
            threshold=float(legacy.baseline_threshold),
            margin=None,
            source="MODEL_BASELINE",
            status=status,
            speaker_model_fingerprint=None if model_fp is None else str(model_fp),
            microphone_fingerprint=None if mic_fp is None else str(mic_fp),
            speaker_backend_key=None if backend_key is None else str(backend_key),
        )

    if legacy.accept_threshold is not None:
        return ResolvedSpeakerCalibration(
            calibration_id=None,
            threshold=float(legacy.accept_threshold),
            margin=None if legacy.margin is None else float(legacy.margin),
            source="LEGACY_ENV",
            status=status,
            speaker_model_fingerprint=None if model_fp is None else str(model_fp),
            microphone_fingerprint=None if mic_fp is None else str(mic_fp),
            speaker_backend_key=None if backend_key is None else str(backend_key),
        )

    return ResolvedSpeakerCalibration(
        calibration_id=None,
        threshold=float(legacy.baseline_threshold),
        margin=None,
        source="MODEL_BASELINE",
        status=status,
        speaker_model_fingerprint=None if model_fp is None else str(model_fp),
        microphone_fingerprint=None if mic_fp is None else str(mic_fp),
        speaker_backend_key=None if backend_key is None else str(backend_key),
    )
