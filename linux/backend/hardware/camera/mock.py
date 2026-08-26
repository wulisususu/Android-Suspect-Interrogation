from pathlib import Path
from typing import Callable, Optional

from hardware.base import DeviceInfo, DeviceState, HealthReport
from hardware.camera.interface import CameraDevice
from hardware.camera.models import CameraCapture


class MockCameraDevice(CameraDevice):
    def __init__(self):
        self._state = DeviceState.CLOSED
        self._previewing = False

    def open(self) -> None:
        self._state = DeviceState.READY

    def close(self) -> None:
        self._previewing = False
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        return HealthReport(self._state in {DeviceState.READY, DeviceState.ACTIVE}, self._state, "mock camera")

    def device_info(self) -> DeviceInfo:
        return DeviceInfo("camera", "mock-camera-001", "Mock Camera", source="mock")

    def capture(self, output_path: Optional[Path] = None) -> CameraCapture:
        if self._state == DeviceState.CLOSED:
            self.open()
        data = b"mock-camera-frame"
        path = None
        if output_path is not None:
            target = Path(output_path)
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
            path = str(target)
            data = b""
        return CameraCapture(data=data, source="mock", device_id="mock-camera-001", format="mock", path=path)

    def start_preview(self, callback: Callable[[CameraCapture], None], interval: float = 0.2) -> None:
        if self._state == DeviceState.CLOSED:
            self.open()
        self._previewing = True
        self._state = DeviceState.ACTIVE
        callback(self.capture())

    def stop_preview(self) -> None:
        self._previewing = False
        if self._state == DeviceState.ACTIVE:
            self._state = DeviceState.READY
