from dataclasses import asdict, dataclass, field
from datetime import datetime, timezone
from typing import Any, Dict, Optional


@dataclass(frozen=True)
class CameraDescriptor:
    path: str
    name: str
    driver: Optional[str] = None
    bus: Optional[str] = None
    metadata: Dict[str, Any] = field(default_factory=dict)


@dataclass(frozen=True)
class CameraCapture:
    data: bytes
    source: str
    device_id: str
    format: str = "raw"
    path: Optional[str] = None
    captured_at: str = field(default_factory=lambda: datetime.now(timezone.utc).isoformat())

    def to_dict(self) -> Dict[str, Any]:
        data = asdict(self)
        data["data"] = None if self.path else self.data
        return data
