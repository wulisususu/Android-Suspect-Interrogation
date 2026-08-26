from __future__ import annotations

import os
import shutil
import sqlite3
from pathlib import Path
from typing import Any

from fastapi import APIRouter

from .runtime_settings import RuntimeSettings


router = APIRouter(prefix="/health", tags=["health"])


def _result(state: str, *, required: bool, detail: str) -> dict[str, Any]:
    return {"state": state, "required": required, "detail": detail}


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
    except sqlite3.Error as exc:
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
    if model_path is None or not Path(model_path).exists():
        return _result("NOT_INSTALLED", required=False, detail="local model asset is not installed")
    return _result("READY", required=False, detail="local model asset path exists")


def readiness_snapshot() -> dict[str, Any]:
    settings = RuntimeSettings()
    checks = {
        "storage": _storage_check(settings),
        "database": _database_check(settings),
    }
    capabilities = {
        "hardware": _hardware_capability(),
        "ai": _ai_capability(settings),
    }
    required_ok = all(item["state"] == "READY" for item in checks.values() if item["required"])
    return {
        "status": "ready" if required_ok else "degraded",
        "checks": checks,
        "capabilities": capabilities,
    }


@router.get("/live")
def live() -> dict[str, str]:
    return {"status": "alive"}


@router.get("/ready")
def ready() -> dict[str, Any]:
    return readiness_snapshot()
