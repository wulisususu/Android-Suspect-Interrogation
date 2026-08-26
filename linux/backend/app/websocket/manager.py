from typing import Any, Dict

from fastapi import APIRouter, WebSocket

router = APIRouter()
connections: Dict[str, WebSocket] = {}


async def broadcast_hardware_event(event: Dict[str, Any]) -> None:
    """Broadcast a normalized HAL event to every active interrogation socket."""
    stale = []
    message = {"type": "hardware_event", "event": event}
    for session_id, websocket in tuple(connections.items()):
        try:
            await websocket.send_json(message)
        except Exception:
            stale.append(session_id)
    for session_id in stale:
        connections.pop(session_id, None)


@router.websocket("/ws/interrogation/{session_id}")
async def interrogation_socket(websocket: WebSocket, session_id: str):
    await websocket.accept()
    connections[session_id] = websocket

    try:
        while True:
            data = await websocket.receive_json()
            await websocket.send_json({
                "type": "ack",
                "session_id": session_id,
                "received": data,
            })
    finally:
        connections.pop(session_id, None)
