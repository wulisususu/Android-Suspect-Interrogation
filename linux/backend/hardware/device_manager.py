from __future__ import annotations

from typing import Any, Dict

from hardware.base import HardwareError


class DeviceManager:
    """Single entry point for all Linux hardware capabilities."""

    def __init__(
        self,
        *,
        identity_reader=None,
        camera=None,
        audio_recorder=None,
        signature_device=None,
        device_monitor=None,
        mode: str = "real",
    ):
        self.identity_reader = identity_reader
        self.idcard_reader = identity_reader  # compatibility alias
        self.camera = camera
        self.audio_recorder = audio_recorder
        self.signature_device = signature_device
        self.device_monitor = device_monitor
        self.monitor = device_monitor
        self.mode = mode

    def _devices(self):
        return {
            "identity": self.identity_reader,
            "camera": self.camera,
            "audio": self.audio_recorder,
            "signature": self.signature_device,
            "monitor": self.device_monitor,
        }

    def open_all(self, *, strict: bool = False) -> Dict[str, Dict[str, Any]]:
        errors: Dict[str, Dict[str, Any]] = {}
        for name, device in self._devices().items():
            if device is None:
                errors[name] = {"code": "NOT_CONFIGURED", "message": f"{name} device is not configured", "details": {}}
                continue
            try:
                device.open()
            except HardwareError as exc:
                errors[name] = exc.to_dict()
                if strict:
                    raise
        return errors

    def close_all(self) -> None:
        for device in reversed(tuple(self._devices().values())):
            if device is not None:
                try:
                    device.close()
                except Exception:
                    pass

    def _require(self, name: str):
        device = self._devices().get(name)
        if device is None:
            raise HardwareError("DEVICE_NOT_CONFIGURED", f"{name} device is not configured")
        return device

    def read_identity(self):
        return self._require("identity").read()

    def capture_image(self, output_path=None):
        return self._require("camera").capture(output_path)

    def start_record(self, output_path=None):
        return self._require("audio").start(output_path)

    def read_audio_frames(self, timeout: float = 0.5):
        return self._require("audio").read_frames(timeout)

    def stop_record(self):
        return self._require("audio").stop()

    def start_signature_capture(self):
        return self._require("signature").start_capture()

    def submit_signature(self, data):
        return self._require("signature").submit(data)

    def capture_signature(self, data):
        """Backward-compatible alias; the formal protocol is submit_signature()."""
        return self.submit_signature(data)

    def cancel_signature(self):
        return self._require("signature").cancel()

    def start_monitor(self):
        return self._require("monitor").start()

    def stop_monitor(self):
        return self._require("monitor").stop()

    def capability_report(self) -> Dict[str, Any]:
        devices = {}
        for name, device in self._devices().items():
            if device is None:
                devices[name] = {"status": "unconfigured", "health": {"healthy": False}, "device_info": None}
                continue
            try:
                info = device.device_info().to_dict()
            except Exception as exc:
                info = {"error": str(exc)}
            try:
                health = device.health().to_dict()
            except Exception as exc:
                health = {"healthy": False, "message": str(exc)}
            status = device.status()
            devices[name] = {"status": getattr(status, "value", str(status)), "health": health, "device_info": info}
        return {"mode": self.mode, "devices": devices}
