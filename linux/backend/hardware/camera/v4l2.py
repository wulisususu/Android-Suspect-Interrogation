from __future__ import annotations

import shutil
import subprocess
import tempfile
import threading
from pathlib import Path
from typing import Callable, List, Optional

from hardware.base import DeviceInfo, DeviceState, HardwareError, HealthReport
from hardware.camera.interface import CameraDevice
from hardware.camera.models import CameraCapture, CameraDescriptor


def enumerate_cameras(dev_root: Path = Path("/dev")) -> List[CameraDescriptor]:
    devices: List[CameraDescriptor] = []
    for node in sorted(Path(dev_root).glob("video*"), key=lambda p: p.name):
        sys_name = Path("/sys/class/video4linux") / node.name / "name"
        name = node.name
        try:
            name = sys_name.read_text(encoding="utf-8").strip() or name
        except OSError:
            pass
        devices.append(CameraDescriptor(path=str(node), name=name))
    return devices


class V4L2Camera(CameraDevice):
    def __init__(
        self,
        device: str = "/dev/video0",
        *,
        which: Callable[[str], Optional[str]] = shutil.which,
        run_cmd: Callable[..., object] = subprocess.run,
    ):
        self.device = str(device)
        self._which = which
        self._run_cmd = run_cmd
        self._state = DeviceState.CLOSED
        self._last_error: Optional[str] = None
        self._preview_thread: Optional[threading.Thread] = None
        self._preview_stop = threading.Event()

    def open(self) -> None:
        if not Path(self.device).exists():
            self._state = DeviceState.UNAVAILABLE
            raise HardwareError("DEVICE_NOT_CONNECTED", f"camera device is not connected: {self.device}")
        if not self._which("v4l2-ctl"):
            self._state = DeviceState.UNAVAILABLE
            raise HardwareError("V4L2_TOOL_NOT_FOUND", "v4l2-ctl is required for V4L2 capture")
        self._state = DeviceState.READY
        self._last_error = None

    def close(self) -> None:
        self.stop_preview()
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        connected = Path(self.device).exists()
        healthy = connected and self._state in {DeviceState.READY, DeviceState.ACTIVE}
        details = {"path": self.device, "connected": connected}
        if self._last_error:
            details["last_error"] = self._last_error
        return HealthReport(healthy, self._state, "camera ready" if healthy else "camera unavailable", details)

    def device_info(self) -> DeviceInfo:
        node = Path(self.device)
        name = node.name
        sys_name = Path("/sys/class/video4linux") / node.name / "name"
        try:
            name = sys_name.read_text(encoding="utf-8").strip() or name
        except OSError:
            pass
        return DeviceInfo("camera", f"v4l2:{node.name}", name, source="real", path=self.device)

    def capture(self, output_path: Optional[Path] = None) -> CameraCapture:
        if self._state == DeviceState.CLOSED:
            self.open()
        if not Path(self.device).exists():
            self._state = DeviceState.UNAVAILABLE
            raise HardwareError("DEVICE_NOT_CONNECTED", f"camera disconnected: {self.device}")
        executable = self._which("v4l2-ctl")
        if not executable:
            raise HardwareError("V4L2_TOOL_NOT_FOUND", "v4l2-ctl is required for capture")
        owned_temp = output_path is None
        if owned_temp:
            handle = tempfile.NamedTemporaryFile(prefix="v4l2-", suffix=".raw", delete=False)
            target = Path(handle.name)
            handle.close()
        else:
            target = Path(output_path)
            target.parent.mkdir(parents=True, exist_ok=True)
        command = [
            executable,
            "--device", self.device,
            "--stream-mmap=3",
            "--stream-count=1",
            f"--stream-to={target}",
        ]
        try:
            result = self._run_cmd(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=10, check=False)
            return_code = int(getattr(result, "returncode", 0))
            if return_code != 0:
                stderr = getattr(result, "stderr", b"")
                if isinstance(stderr, bytes):
                    stderr = stderr.decode(errors="replace")
                raise HardwareError("CAMERA_CAPTURE_FAILED", "v4l2 capture failed", details={"return_code": return_code, "stderr": str(stderr)})
            data = target.read_bytes()
            capture = CameraCapture(data=data if owned_temp else b"", source="real", device_id=self.device_info().device_id, format="raw", path=None if owned_temp else str(target))
            return capture
        finally:
            if owned_temp:
                try:
                    target.unlink(missing_ok=True)
                except OSError:
                    pass

    def start_preview(self, callback: Callable[[CameraCapture], None], interval: float = 0.2) -> None:
        if self._preview_thread and self._preview_thread.is_alive():
            raise HardwareError("DEVICE_BUSY", "camera preview is already running")
        if self._state == DeviceState.CLOSED:
            self.open()
        self._preview_stop.clear()
        self._state = DeviceState.ACTIVE

        def loop() -> None:
            while not self._preview_stop.is_set():
                try:
                    callback(self.capture())
                except HardwareError as exc:
                    self._last_error = exc.message
                    self._state = DeviceState.ERROR
                    break
                self._preview_stop.wait(interval)

        self._preview_thread = threading.Thread(target=loop, name="v4l2-preview", daemon=True)
        self._preview_thread.start()

    def stop_preview(self) -> None:
        self._preview_stop.set()
        if self._preview_thread and self._preview_thread.is_alive():
            self._preview_thread.join(timeout=2)
        self._preview_thread = None
        if self._state == DeviceState.ACTIVE:
            self._state = DeviceState.READY
