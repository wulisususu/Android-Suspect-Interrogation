from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import asdict, dataclass, field
from enum import Enum
from typing import Any, Dict, Optional


class DeviceState(str, Enum):
    CLOSED = "closed"
    READY = "ready"
    ACTIVE = "active"
    UNAVAILABLE = "unavailable"
    ERROR = "error"


class HardwareError(RuntimeError):
    def __init__(self, code: str, message: str, *, details: Optional[Dict[str, Any]] = None):
        super().__init__(message)
        self.code = code
        self.message = message
        self.details = details or {}

    def to_dict(self) -> Dict[str, Any]:
        return {"code": self.code, "message": self.message, "details": self.details}


@dataclass(frozen=True)
class DeviceInfo:
    device_type: str
    device_id: str
    name: str
    source: str = "real"
    path: Optional[str] = None
    metadata: Dict[str, Any] = field(default_factory=dict)

    def to_dict(self) -> Dict[str, Any]:
        return asdict(self)


@dataclass(frozen=True)
class HealthReport:
    healthy: bool
    status: DeviceState
    message: str = ""
    details: Dict[str, Any] = field(default_factory=dict)

    def to_dict(self) -> Dict[str, Any]:
        data = asdict(self)
        data["status"] = self.status.value
        return data


class HardwareDevice(ABC):
    @abstractmethod
    def open(self) -> None:
        raise NotImplementedError

    @abstractmethod
    def close(self) -> None:
        raise NotImplementedError

    @abstractmethod
    def status(self) -> DeviceState:
        raise NotImplementedError

    @abstractmethod
    def health(self) -> HealthReport:
        raise NotImplementedError

    @abstractmethod
    def device_info(self) -> DeviceInfo:
        raise NotImplementedError
