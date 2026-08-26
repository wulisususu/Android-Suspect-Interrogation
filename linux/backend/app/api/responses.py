from typing import Any


def envelope(data: Any = None, message: str = "OK", code: str = "OK") -> dict:
    return {"ok": True, "code": code, "message": message, "data": data}
