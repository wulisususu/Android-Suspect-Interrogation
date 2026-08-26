from __future__ import annotations

from dataclasses import asdict, dataclass
from datetime import datetime, timezone
from typing import Any, Dict, Optional


@dataclass(frozen=True)
class IdentityResult:
    name: str
    gender: str
    nation: str
    birth: str
    id_number: str
    address: str
    issuer: str
    valid_from: str
    valid_to: str
    portrait: Optional[str]
    source: str
    device_id: str
    read_at: str

    @classmethod
    def create(cls, **kwargs: Any) -> "IdentityResult":
        kwargs.setdefault("read_at", datetime.now(timezone.utc).isoformat())
        return cls(**kwargs)

    def to_dict(self) -> Dict[str, Any]:
        return asdict(self)
