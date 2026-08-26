from abc import abstractmethod
from typing import Any, Dict

from hardware.base import HardwareDevice


class SignatureDevice(HardwareDevice):
    @abstractmethod
    def start_capture(self) -> Dict[str, Any]:
        raise NotImplementedError

    @abstractmethod
    def submit(self, data: Any) -> Dict[str, Any]:
        raise NotImplementedError

    @abstractmethod
    def cancel(self) -> Dict[str, Any]:
        raise NotImplementedError
