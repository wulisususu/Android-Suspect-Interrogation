from fastapi import APIRouter, WebSocket, WebSocketDisconnect

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
    except WebSocketDisconnect:
        # A client closing a WebSocket normally is expected control flow, not an
        # application failure. Cleanup below makes the same session reconnectable.
        pass
    finally:
        if connections.get(session_id) is websocket:
            connections.pop(session_id, None)
