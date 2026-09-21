from __future__ import annotations

import logging
from collections.abc import Callable

from fastapi import APIRouter, WebSocket
from starlette.websockets import WebSocketDisconnect


router = APIRouter()
_MAX_FRAME_BYTES = 64 * 1024
logger = logging.getLogger("suspect.browser_asr")


async def _close(websocket: WebSocket, capture_id: str, code: int, reason: str) -> None:
    # Every server-side close is logged: a silent audio-channel death leaves the
    # client streaming into a dead socket with no trace to diagnose.
    logger.warning("browser asr ws %s closing code=%s: %s", capture_id, code, reason)
    await websocket.close(code=code)


def _browser_input(websocket: WebSocket):
    return getattr(websocket.app.state, "browser_audio_input", None)


def _is_active_browser_capture(websocket: WebSocket, case_id: str, capture_id: str) -> bool:
    service = getattr(websocket.app.state, "asr_capture_service", None)
    if service is None:
        return False
    status = service.status(case_id)
    return (
        bool(status.get("active"))
        and status.get("captureSessionId") == capture_id
        and status.get("source") == "BROWSER"
    )


async def _stream_browser_pcm(
    websocket: WebSocket,
    *,
    capture_id: str = "-",
    accepts_pcm: Callable[[], bool] | None = None,
) -> None:
    browser_input = _browser_input(websocket)
    if browser_input is None:
        await _close(websocket, capture_id, 4403, "browser audio input unavailable")
        return
    if not browser_input.active:
        await _close(websocket, capture_id, 4409, "capture is not active")
        return
    if accepts_pcm is not None and not accepts_pcm():
        await _close(websocket, capture_id, 4409, "capture session is not the active browser capture")
        return

    await websocket.accept()
    logger.info("browser asr ws %s accepted", capture_id)
    try:
        while True:
            message = await websocket.receive()
            if message.get("type") == "websocket.disconnect":
                logger.info("browser asr ws %s client disconnected", capture_id)
                break
            pcm = message.get("bytes")
            if pcm is None:
                await _close(websocket, capture_id, 1003, "non-binary frame")
                return
            if not pcm or len(pcm) % 2:
                await _close(websocket, capture_id, 1008, "pcm16 alignment violation")
                return
            if len(pcm) > _MAX_FRAME_BYTES:
                await _close(websocket, capture_id, 1009, "frame too large")
                return
            if accepts_pcm is not None and not accepts_pcm():
                await _close(websocket, capture_id, 4409, "capture session stopped being the active browser capture")
                return
            try:
                browser_input.push_pcm(pcm)
            except (RuntimeError, ValueError) as exc:
                await _close(websocket, capture_id, 1008, f"speech worker rejected audio: {exc}")
                return
    except WebSocketDisconnect:
        pass


@router.websocket("/ws/asr/cases/{case_id}/capture/{capture_id}")
async def browser_asr_capture_socket(
    websocket: WebSocket,
    case_id: str,
    capture_id: str,
):
    await _stream_browser_pcm(
        websocket,
        capture_id=capture_id,
        accepts_pcm=lambda: _is_active_browser_capture(websocket, case_id, capture_id),
    )


@router.websocket("/ws/asr/cases/{case_id}/question-preparation/{capture_id}")
async def browser_question_preparation_socket(
    websocket: WebSocket,
    case_id: str,
    capture_id: str,
):
    del case_id
    await _stream_browser_pcm(websocket, capture_id=capture_id)
