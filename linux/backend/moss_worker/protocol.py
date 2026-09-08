"""Length-prefixed JSON framing for the MOSS worker Unix socket API."""
from __future__ import annotations

import json
import socket
import struct
from typing import Any


MAX_MESSAGE_BYTES = 16 * 1024 * 1024
_HEADER = struct.Struct("!I")


class ProtocolError(RuntimeError):
    pass


class ProtocolMessageTooLarge(ProtocolError):
    pass


def encode_frame(payload: dict[str, Any], *, max_message_bytes: int = MAX_MESSAGE_BYTES) -> bytes:
    try:
        body = json.dumps(payload, ensure_ascii=False, separators=(",", ":")).encode("utf-8")
    except (TypeError, ValueError) as exc:
        raise ProtocolError("moss protocol payload is not JSON serializable") from exc
    if len(body) > max_message_bytes:
        raise ProtocolMessageTooLarge(
            f"moss protocol message is {len(body)} bytes; maximum is {max_message_bytes}"
        )
    return _HEADER.pack(len(body)) + body


def send_frame(
    sock: socket.socket,
    payload: dict[str, Any],
    *,
    max_message_bytes: int = MAX_MESSAGE_BYTES,
) -> None:
    sock.sendall(encode_frame(payload, max_message_bytes=max_message_bytes))


def recv_frame(sock: socket.socket, *, max_message_bytes: int = MAX_MESSAGE_BYTES) -> dict[str, Any]:
    header = _recv_exact(sock, _HEADER.size)
    (body_length,) = _HEADER.unpack(header)
    if body_length > max_message_bytes:
        raise ProtocolMessageTooLarge(
            f"moss protocol peer announced {body_length} bytes; maximum is {max_message_bytes}"
        )
    body = _recv_exact(sock, body_length)
    try:
        payload = json.loads(body.decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise ProtocolError("moss protocol message is not valid UTF-8 JSON") from exc
    if not isinstance(payload, dict):
        raise ProtocolError("moss protocol message must be a JSON object")
    return payload


def _recv_exact(sock: socket.socket, size: int) -> bytes:
    chunks: list[bytes] = []
    remaining = size
    while remaining:
        chunk = sock.recv(remaining)
        if not chunk:
            raise ProtocolError("moss protocol peer disconnected before frame completed")
        chunks.append(chunk)
        remaining -= len(chunk)
    return b"".join(chunks)
