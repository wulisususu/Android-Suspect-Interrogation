from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Optional

from hardware.base import DeviceInfo, DeviceState, HardwareError, HealthReport
from hardware.signature.interface import SignatureDevice


class LinuxSignatureDevice(SignatureDevice):
    """Generic Linux signature-pad session adapter.

    Vendor-specific transport belongs behind this class. The HAL preserves the
    raw strokes/image payload plus device metadata and does not perform legal
    freezing or evidentiary signing.
    """

    def __init__(self, device_path: Optional[str] = None):
        self.device_path = device_path
        self._state = DeviceState.CLOSED
        self._capturing = False

    def open(self) -> None:
        if not self.device_path or not Path(self.device_path).exists():
            self._state = DeviceState.UNAVAILABLE
            raise HardwareError("DEVICE_NOT_CONNECTED", "signature device is not connected", details={"path": self.device_path})
        self._state = DeviceState.READY

    def close(self) -> None:
        self._capturing = False
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        present = bool(self.device_path and Path(self.device_path).exists())
        return HealthReport(present and self._state in {DeviceState.READY, DeviceState.ACTIVE}, self._state, "signature device ready" if present else "signature device unavailable", {"path": self.device_path, "present": present})

    def device_info(self) -> DeviceInfo:
        path = self.device_path or "unconfigured"
        return DeviceInfo("signature", f"signature:{path}", "Linux Signature Device", source="real", path=self.device_path)

    def start_capture(self) -> Dict[str, Any]:
        if self._state == DeviceState.CLOSED:
            self.open()
        if self._state != DeviceState.READY:
            raise HardwareError("DEVICE_NOT_CONNECTED", "signature device is unavailable")
        self._capturing = True
        self._state = DeviceState.ACTIVE
        return {"status": "capturing", "source": "real", "device_info": self.device_info().to_dict()}

    def submit(self, data: Any) -> Dict[str, Any]:
        if not self._capturing:
            raise HardwareError("SIGNATURE_NOT_CAPTURING", "signature capture has not been started")
        self._capturing = False
        self._state = DeviceState.READY
        return {
            "status": "submitted",
            "source": "real",
            "payload": data,
            "captured_at": datetime.now(timezone.utc).isoformat(),
            "device_info": self.device_info().to_dict(),
        }

    def cancel(self) -> Dict[str, Any]:
        self._capturing = False
        if self._state == DeviceState.ACTIVE:
            self._state = DeviceState.READY
        return {"status": "cancelled", "source": "real", "device_info": self.device_info().to_dict()}
