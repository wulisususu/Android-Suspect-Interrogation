from datetime import datetime, timezone
from typing import Any

from pydantic import BaseModel, ConfigDict, Field


SUPPORTED_CLIENT_EVENTS = {
    "STATE_SYNC_REQUEST",
    "DEVICE_EVENT",
    "ASR_FRAGMENT",
    "USER_TEXT",
    "RECORDING_STATE",
    "SIGNATURE_STATE",
}


class ClientEnvelope(BaseModel):
    model_config = ConfigDict(extra="ignore")

    session_id: str
    event: str
    seq: int = Field(ge=0)
    timestamp: datetime
    payload: dict[str, Any] = Field(default_factory=dict)


def utc_timestamp() -> str:
    return datetime.now(timezone.utc).isoformat()


def server_envelope(session_id: str, event: str, seq: int, payload: dict | None = None) -> dict:
    return {
        "session_id": session_id,
        "event": event,
        "seq": seq,
        "timestamp": utc_timestamp(),
        "payload": payload or {},
    }
