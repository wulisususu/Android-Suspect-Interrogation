from __future__ import annotations

import json
import socket
import struct

import pytest

from moss_worker.protocol import (
    MAX_MESSAGE_BYTES,
    ProtocolError,
    ProtocolMessageTooLarge,
    encode_frame,
    recv_frame,
    send_frame,
)


@pytest.fixture
def socket_pair():
    left, right = socket.socketpair()
    try:
        yield left, right
    finally:
        left.close()
        right.close()


def test_frame_round_trip(socket_pair):
    a, b = socket_pair
    send_frame(a, {"request_id": "1", "op": "health"})
    assert recv_frame(b) == {"request_id": "1", "op": "health"}


def test_frame_is_four_byte_big_endian_length_prefixed_utf8_json(socket_pair):
    a, b = socket_pair
    payload = {"request_id": "req-1", "op": "submit_job", "audio_path": "案件.wav"}
    send_frame(a, payload)

    (body_length,) = struct.unpack("!I", b.recv(4))
    body = b""
    while len(body) < body_length:
        body += b.recv(body_length - len(body))

    assert body_length == len(body)
    assert json.loads(body.decode("utf-8")) == payload


def test_max_message_bytes_is_16_mib():
    assert MAX_MESSAGE_BYTES == 16 * 1024 * 1024


def test_encode_rejects_oversized_payload():
    with pytest.raises(ProtocolMessageTooLarge):
        encode_frame({"payload": "x" * MAX_MESSAGE_BYTES})


def test_encode_rejects_non_serializable_payload():
    with pytest.raises(ProtocolError):
        encode_frame({"bad": object()})


def test_recv_rejects_oversized_announced_length_before_body_read(socket_pair):
    a, b = socket_pair
    try:
        a.sendall(struct.pack("!I", MAX_MESSAGE_BYTES + 1))
        with pytest.raises(ProtocolMessageTooLarge):
            recv_frame(b)
    finally:
        a.close()
        b.close()


def test_recv_rejects_truncated_frame_when_peer_disconnects(socket_pair):
    a, b = socket_pair
    body = json.dumps({"op": "health"}).encode("utf-8")
    a.sendall(struct.pack("!I", len(body)) + body[: len(body) // 2])
    a.close()
    with pytest.raises(ProtocolError, match="disconnected before frame completed"):
        recv_frame(b)


def test_recv_rejects_non_object_json(socket_pair):
    a, b = socket_pair
    body = b"[1, 2, 3]"
    a.sendall(struct.pack("!I", len(body)) + body)
    with pytest.raises(ProtocolError, match="JSON object"):
        recv_frame(b)


def test_recv_rejects_invalid_utf8_json(socket_pair):
    a, b = socket_pair
    body = b"\xff\xfe{"
    a.sendall(struct.pack("!I", len(body)) + body)
    with pytest.raises(ProtocolError, match="UTF-8"):
        recv_frame(b)
