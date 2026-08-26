from abc import abstractmethod

from hardware.base import HardwareDevice
from hardware.idcard.models import IdentityResult


class IdentityReader(HardwareDevice):
    """Normalized identity-reader contract. Vendor structs never leave adapters."""

    @abstractmethod
    def read(self) -> IdentityResult:
        raise NotImplementedError


IDCardReader = IdentityReader
