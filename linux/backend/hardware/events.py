from __future__ import annotations

from dataclasses import asdict, dataclass, field
from datetime import datetime, timezone
from enum import Enum
from threading import RLock
from typing import Any, Callable, Dict, List, Optional


class DeviceEventType(str, Enum):
    DEVICE_CONNECTED = "DEVICE_CONNECTED"
    DEVICE_DISCONNECTED = "DEVICE_DISCONNECTED"
    DEVICE_ERROR = "DEVICE_ERROR"
    DEVICE_READY = "DEVICE_READY"


@dataclass(frozen=True)
class DeviceEvent:
    event_type: DeviceEventType
    subsystem: str
    device_id: str
    source: str = "real"
    details: Dict[str, Any] = field(default_factory=dict)
    occurred_at: str = field(default_factory=lambda: datetime.now(timezone.utc).isoformat())

    def to_dict(self) -> Dict[str, Any]:
        data = asdict(self)
        data["event_type"] = self.event_type.value
        return data


class EventBus:
    def __init__(self, sink: Optional[Callable[[DeviceEvent], Any]] = None):
        self._subscribers: List[Callable[[DeviceEvent], Any]] = []
        self._lock = RLock()
        if sink is not None:
            self.subscribe(sink)

    def subscribe(self, subscriber: Callable[[DeviceEvent], Any]) -> None:
        with self._lock:
            if subscriber not in self._subscribers:
                self._subscribers.append(subscriber)

    def unsubscribe(self, subscriber: Callable[[DeviceEvent], Any]) -> None:
        with self._lock:
            if subscriber in self._subscribers:
                self._subscribers.remove(subscriber)

    def publish(self, event: DeviceEvent) -> None:
        with self._lock:
            subscribers = tuple(self._subscribers)
        for subscriber in subscribers:
            subscriber(event)
