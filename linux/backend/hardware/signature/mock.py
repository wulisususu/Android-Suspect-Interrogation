from datetime import datetime, timezone
from typing import Any, Dict

from hardware.base import DeviceInfo, DeviceState, HardwareError, HealthReport
from hardware.signature.interface import SignatureDevice


class MockSignatureDevice(SignatureDevice):
    def __init__(self):
        self._state = DeviceState.CLOSED
        self._capturing = False

    def open(self) -> None:
        self._state = DeviceState.READY

    def close(self) -> None:
        self._capturing = False
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        return HealthReport(self._state in {DeviceState.READY, DeviceState.ACTIVE}, self._state, "mock signature device")

    def device_info(self) -> DeviceInfo:
        return DeviceInfo("signature", "mock-signature-001", "Mock Signature Device", source="mock")

    def start_capture(self) -> Dict[str, Any]:
        if self._state == DeviceState.CLOSED:
            self.open()
        self._capturing = True
        self._state = DeviceState.ACTIVE
        return {"status": "capturing", "source": "mock", "device_info": self.device_info().to_dict()}

    def submit(self, data: Any) -> Dict[str, Any]:
        if not self._capturing:
            raise HardwareError("SIGNATURE_NOT_CAPTURING", "signature capture has not been started")
        self._capturing = False
        self._state = DeviceState.READY
        return {
            "status": "submitted",
            "source": "mock",
            "payload": data,
            "captured_at": datetime.now(timezone.utc).isoformat(),
            "device_info": self.device_info().to_dict(),
        }

    def cancel(self) -> Dict[str, Any]:
        self._capturing = False
        if self._state != DeviceState.CLOSED:
            self._state = DeviceState.READY
        return {"status": "cancelled", "source": "mock", "device_info": self.device_info().to_dict()}
