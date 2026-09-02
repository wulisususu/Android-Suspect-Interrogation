from __future__ import annotations

import os
import shutil
import sqlite3
from pathlib import Path
from typing import Any

from fastapi import APIRouter, Request

from .ai.speech.calibration import SpeakerCalibration
from .runtime_settings import RuntimeSettings


router = APIRouter(prefix="/health", tags=["health"])
capabilities_router = APIRouter(prefix="/api/v1", tags=["runtime"])


def _result(state: str, *, required: bool, detail: str, **extra: Any) -> dict[str, Any]:
    payload: dict[str, Any] = {"state": state, "required": required, "detail": detail}
    payload.update(extra)
    return payload


def _storage_check(settings: RuntimeSettings) -> dict[str, Any]:
    path = Path(settings.data_dir)
    try:
        probe_root = path if path.exists() else path.parent
        if not probe_root.exists():
            return _result("ERROR", required=True, detail=f"storage parent missing: {probe_root}")
        if not os.access(probe_root, os.R_OK | os.W_OK | os.X_OK):
            return _result("ERROR", required=True, detail=f"storage not writable: {probe_root}")
        usage = shutil.disk_usage(probe_root)
        free_mb = usage.free // (1024 * 1024)
        if free_mb < settings.min_free_mb:
            return _result(
                "LOW_SPACE",
                required=True,
                detail=f"free_mb={free_mb} below minimum={settings.min_free_mb}",
            )
        return _result("READY", required=True, detail=f"free_mb={free_mb}")
    except OSError as exc:
        return _result("ERROR", required=True, detail=f"storage check failed: {exc.__class__.__name__}")


def _database_check(settings: RuntimeSettings) -> dict[str, Any]:
    path = Path(settings.db_path)
    try:
        if not path.exists():
            parent = path.parent
            if parent.exists() and os.access(parent, os.W_OK | os.X_OK):
                return _result("READY", required=True, detail="database will be initialized on first write")
            return _result("ERROR", required=True, detail=f"database parent not writable: {parent}")
        connection = sqlite3.connect(f"file:{path}?mode=ro", uri=True, timeout=1)
        try:
            integrity = connection.execute("PRAGMA quick_check").fetchone()[0]
        finally:
            connection.close()
        if integrity != "ok":
            return _result("ERROR", required=True, detail="sqlite quick_check failed")
        return _result("READY", required=True, detail="sqlite quick_check=ok")
    except (OSError, sqlite3.Error) as exc:
        return _result("ERROR", required=True, detail=f"database check failed: {exc.__class__.__name__}")


def _hardware_capability() -> dict[str, Any]:
    try:
        from hardware.device_manager import DeviceManager

        manager = DeviceManager()
        configured = any(
            device is not None
            for device in (manager.idcard_reader, manager.audio_recorder, manager.signature_device)
        )
        if not configured:
            return _result("UNAVAILABLE", required=False, detail="no physical device configured")
        return _result("READY", required=False, detail="hardware manager configured")
    except Exception as exc:  # capability failure must not kill API readiness
        return _result("UNAVAILABLE", required=False, detail=f"hardware manager unavailable: {exc.__class__.__name__}")


def _ai_capability(settings: RuntimeSettings) -> dict[str, Any]:
    model_path = settings.model_path
    if model_path is None:
        return _result("NOT_INSTALLED", required=False, detail="local model asset path is not configured")

    path = Path(model_path)
    installed = path.is_file()
    if path.is_dir():
        try:
            installed = any(child.is_file() for child in path.rglob("*") if not child.name.startswith("."))
        except OSError:
            installed = False

    if not installed:
        return _result("NOT_INSTALLED", required=False, detail="local model assets are not installed")
    return _result("READY", required=False, detail="local model assets are present")


def _calibration_capability(supervisor: Any | None) -> dict[str, Any]:
    if supervisor is not None:
        threshold = getattr(supervisor, "speaker_accept_threshold", None)
        margin = getattr(supervisor, "speaker_margin", None)
        configured = threshold is not None and margin is not None
    else:
        calibration = SpeakerCalibration.from_env()
        threshold = calibration.accept_threshold
        margin = calibration.margin
        configured = calibration.configured

    return _result(
        "READY" if configured else "NOT_CONFIGURED",
        required=False,
        detail=(
            "speaker threshold and margin are calibrated"
            if configured
            else "speaker threshold and margin require RK3588 microphone calibration"
        ),
        thresholdConfigured=threshold is not None,
        marginConfigured=margin is not None,
    )


def _audio_capture_capability(manager: Any | None) -> dict[str, Any]:
    if manager is None:
        return _result("UNAVAILABLE", required=False, detail="hardware manager is not active")
    recorder = getattr(manager, "audio_recorder", None)
    if recorder is None:
        return _result("UNAVAILABLE", required=False, detail="audio recorder is not configured")
    return _result("READY", required=False, detail="audio recorder is configured")


def _speech_capability(
    name: str,
    *,
    supervisor: Any | None,
    calibration: dict[str, Any],
) -> dict[str, Any]:
    if supervisor is None:
        if name == "speaker" and calibration["state"] == "NOT_CONFIGURED":
            return _result(
                "NOT_CONFIGURED",
                required=False,
                detail="speaker verification is disabled until calibration is configured",
            )
        return _result("UNAVAILABLE", required=False, detail="AI supervisor is not active")

    try:
        capability = dict((supervisor.capabilities() or {}).get(name) or {})
    except Exception as exc:
        return _result(
            "ERROR",
            required=False,
            detail=f"{name} capability check failed: {exc.__class__.__name__}",
        )

    state = str(capability.pop("state", "UNAVAILABLE"))
    detail = str(capability.pop("detail", f"{name} capability reported by AI supervisor"))
    if capability.get("speech_worker") and capability.get("speech_state") == "AVAILABLE":
        state = "AVAILABLE"
    return _result(state, required=False, detail=detail, **capability)


def readiness_snapshot(request: Request | None = None) -> dict[str, Any]:
    settings = RuntimeSettings()
    supervisor = None
    manager = None
    if request is not None:
        supervisor = getattr(request.app.state, "ai_supervisor", None)
        manager = getattr(request.app.state, "hardware_manager", None)

    checks = {
        "storage": _storage_check(settings),
        "database": _database_check(settings),
    }
    calibration = _calibration_capability(supervisor)
    capabilities = {
        "hardware": _hardware_capability(),
        "ai": _ai_capability(settings),
        "asr": _speech_capability("asr", supervisor=supervisor, calibration=calibration),
        "vad": _speech_capability("vad", supervisor=supervisor, calibration=calibration),
        "speaker": _speech_capability("speaker", supervisor=supervisor, calibration=calibration),
        "voiceprintCalibration": calibration,
        "audioCapture": _audio_capture_capability(manager),
    }
    required_ok = all(item["state"] == "READY" for item in checks.values() if item["required"])
    return {
        "status": "ready" if required_ok else "degraded",
        "checks": checks,
        "capabilities": capabilities,
    }


def _runtime_capability_state(raw: object) -> str:
    value = str(raw or "").upper()
    if value in {"READY", "AVAILABLE", "CONNECTED", "OK", "IDLE"}:
        return "AVAILABLE"
    if value in {"NOT_INSTALLED", "MISSING", "MODEL_NOT_INSTALLED"}:
        return "MODEL_NOT_INSTALLED"
    if value in {"ERROR", "LOW_SPACE"}:
        return "ERROR"
    if value == "BUSY":
        return "BUSY"
    return "NOT_CONFIGURED"


def _runtime_capability(capability_state: str, reason: str, **metadata: Any) -> dict[str, Any]:
    return {"state": capability_state, "reason": reason, "metadata": metadata}


@capabilities_router.get("/capabilities")
def runtime_capabilities(request: Request) -> dict[str, Any]:
    """Expose the canonical UI capability contract from the production health state."""
    snapshot = readiness_snapshot(request)
    health = snapshot["capabilities"]
    calibration = health["voiceprintCalibration"]
    asr = health["asr"]
    asr_state = _runtime_capability_state(asr["state"])
    microphone = health["audioCapture"]
    microphone_state = _runtime_capability_state(microphone["state"])
    recording_state = asr_state if asr_state != "AVAILABLE" else (
        "AVAILABLE" if calibration["state"] == "READY" else "NOT_CONFIGURED"
    )
    recording_reason = (
        "offline ASR and calibrated speaker verification are ready"
        if recording_state == "AVAILABLE"
        else (str(calibration["detail"]) if asr_state == "AVAILABLE" else str(asr["detail"]))
    )
    supervisor = getattr(request.app.state, "ai_supervisor", None)
    try:
        ai = dict(supervisor.capabilities() if supervisor is not None else {})
    except Exception:
        ai = {}

    def model(name: str) -> dict[str, Any]:
        detail = dict(ai.get(name) or {})
        installed = detail.get("installed")
        raw_state = detail.get("state")
        state = "MODEL_NOT_INSTALLED" if installed is False else _runtime_capability_state(raw_state)
        return _runtime_capability(state, str(detail.get("detail") or f"{name} runtime capability"), **detail)

    unavailable = lambda reason: _runtime_capability("NOT_CONFIGURED", reason)
    return {
        "identity": unavailable("identity reader is not configured"),
        "camera": unavailable("camera is not configured"),
        "microphone": _runtime_capability(microphone_state, str(microphone["detail"]), **microphone),
        "fingerprint": unavailable("fingerprint device is not configured"),
        "signature": unavailable("signature device is not configured"),
        "recording": _runtime_capability(recording_state, recording_reason, asr=asr, calibration=calibration),
        "asr": _runtime_capability(asr_state, str(asr["detail"]), **asr),
        "ocr": model("ocr"),
        "llm": model("llm"),
        "report": _runtime_capability(_runtime_capability_state(snapshot["checks"]["database"]["state"]), str(snapshot["checks"]["database"]["detail"])),
    }


@router.get("/live")
def live() -> dict[str, str]:
    return {"status": "alive"}


@router.get("/ready")
def ready(request: Request) -> dict[str, Any]:
    return readiness_snapshot(request)
