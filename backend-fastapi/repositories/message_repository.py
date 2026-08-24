from time import time
from uuid import uuid4

MESSAGES = {}


def list_messages(case_id: str):
    return MESSAGES.get(case_id, [])


def add_message(case_id: str, payload: dict):
    items = MESSAGES.setdefault(case_id, [])
    item = {
        "id": str(uuid4()),
        "seq": len(items) + 1,
        "speaker": payload.get("from", ""),
        "text": payload.get("text", ""),
        "mark": payload.get("mark", ""),
        "confirmed": payload.get("confirmed", True),
        "createdAt": int(time() * 1000)
    }
    items.append(item)
    return item
