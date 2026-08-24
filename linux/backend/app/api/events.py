from enum import Enum


class EventType(str, Enum):
    IDENTITY_REQUIRED = "identity_required"
    IDENTITY_SUCCESS = "identity_success"
    SIGNATURE_REQUIRED = "signature_required"
    SIGNATURE_COMPLETE = "signature_complete"
    RECORDING_START = "recording_start"
    RECORDING_STOP = "recording_stop"
    AI_THINKING = "ai_thinking"
    AI_RESPONSE = "ai_response"
    WORKFLOW_UPDATE = "workflow_update"


class Event:
    def __init__(self, event_type: EventType, payload: dict | None = None):
        self.type = event_type
        self.payload = payload or {}

    def to_dict(self):
        return {
            "type": self.type,
            "payload": self.payload,
        }
