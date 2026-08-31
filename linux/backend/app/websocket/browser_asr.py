from __future__ import annotations

from fastapi import APIRouter, WebSocket
from starlette.websockets import WebSocketDisconnect


router = APIRouter()
_MAX_FRAME_BYTES = 64 * 1024


def _browser_input(websocket: WebSocket):
    return getattr(websocket.app.state, "browser_audio_input", None)


async def _stream_browser_pcm(websocket: WebSocket) -> None:
    browser_input = _browser_input(websocket)
    if browser_input is None:
        await websocket.close(code=4403)
        return
    if not browser_input.active:
        await websocket.close(code=4409)
        return

    await websocket.accept()
    try:
        while True:
            message = await websocket.receive()
            if message.get("type") == "websocket.disconnect":
                break
            pcm = message.get("bytes")
            if pcm is None:
                await websocket.close(code=1003)
                return
            if not pcm or len(pcm) % 2:
                await websocket.close(code=1008)
                return
            if len(pcm) > _MAX_FRAME_BYTES:
                await websocket.close(code=1009)
                return
            try:
                browser_input.push_pcm(pcm)
            except (RuntimeError, ValueError):
                await websocket.close(code=1008)
                return
    except WebSocketDisconnect:
        pass


@router.websocket("/ws/asr/cases/{case_id}/capture/{capture_id}")
async def browser_asr_capture_socket(
    websocket: WebSocket,
    case_id: str,
    capture_id: str,
):
    # case_id/capture_id are intentionally part of the URL so browser traffic is
    # traceable to the active UI flow. The queue itself is single-owner and is
    # activated only by AsrCaptureService.start().
    del case_id, capture_id
    await _stream_browser_pcm(websocket)


@router.websocket("/ws/asr/cases/{case_id}/question-preparation/{capture_id}")
async def browser_question_preparation_socket(
    websocket: WebSocket,
    case_id: str,
    capture_id: str,
):
    del case_id, capture_id
    await _stream_browser_pcm(websocket)
