from __future__ import annotations

from fastapi import APIRouter, WebSocket
from starlette.websockets import WebSocketDisconnect

from app.domain.errors import DomainError


router = APIRouter()
_MAX_FRAME_BYTES = 64 * 1024


def _capture_service(websocket: WebSocket):
    return getattr(websocket.app.state, "voiceprint_capture", None)


def _clear_matching_context(websocket: WebSocket, capture_id: str) -> None:
    context = getattr(websocket.app.state, "voiceprint_enrollment_context", None)
    if isinstance(context, dict) and context.get("capture_id") == capture_id:
        context.clear()


@router.websocket("/ws/voiceprints/enrollment/{capture_id}")
async def voiceprint_enrollment_socket(websocket: WebSocket, capture_id: str):
    service = _capture_service(websocket)
    if service is None:
        await websocket.close(code=1011)
        return

    status = service.status()
    if (
        not status.get("active")
        or status.get("source") != "BROWSER"
        or status.get("captureId") != capture_id
    ):
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
                service.push_browser_pcm(capture_id, pcm)
            except DomainError:
                await websocket.close(code=1008)
                return
    except WebSocketDisconnect:
        pass
    finally:
        try:
            current = service.status()
        except Exception:
            current = {}
        if (
            current.get("active")
            and current.get("source") == "BROWSER"
            and current.get("captureId") == capture_id
            and not current.get("complete")
        ):
            try:
                service.cancel(capture_id)
            except Exception:
                pass
            _clear_matching_context(websocket, capture_id)
