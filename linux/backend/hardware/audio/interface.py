from abc import abstractmethod
from pathlib import Path
from typing import List, Optional

from hardware.base import HardwareDevice


class AudioRecorder(HardwareDevice):
    @abstractmethod
    def enumerate_devices(self) -> List[str]:
        raise NotImplementedError

    @abstractmethod
    def start(self, output_path: Optional[Path] = None) -> None:
        raise NotImplementedError

    @abstractmethod
    def read_frames(self, timeout: float = 0.5) -> bytes:
        raise NotImplementedError

    @abstractmethod
    def stop(self) -> None:
        raise NotImplementedError
