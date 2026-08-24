from fastapi import APIRouter, WebSocket

router = APIRouter()

connections = {}


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
                "received": data
            })
    finally:
        connections.pop(session_id, None)
