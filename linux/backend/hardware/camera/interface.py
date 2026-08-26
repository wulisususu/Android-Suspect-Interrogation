from abc import abstractmethod
from pathlib import Path
from typing import Callable, Optional

from hardware.base import HardwareDevice
from hardware.camera.models import CameraCapture


class CameraDevice(HardwareDevice):
    @abstractmethod
    def capture(self, output_path: Optional[Path] = None) -> CameraCapture:
        raise NotImplementedError

    @abstractmethod
    def start_preview(self, callback: Callable[[CameraCapture], None], interval: float = 0.2) -> None:
        raise NotImplementedError

    @abstractmethod
    def stop_preview(self) -> None:
        raise NotImplementedError
