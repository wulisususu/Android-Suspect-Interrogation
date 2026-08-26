from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_websocket_can_reconnect_same_session_after_disconnect():
    with client.websocket_connect('/ws/interrogation/reconnect-session') as first:
        first.send_json({'sequence': 1})
        assert first.receive_json() == {
            'type': 'ack',
            'session_id': 'reconnect-session',
            'received': {'sequence': 1},
        }

    # Closing the first socket must remove the stale entry so the same session
    # can establish a fresh connection and continue exchanging messages.
    with client.websocket_connect('/ws/interrogation/reconnect-session') as second:
        second.send_json({'sequence': 2})
        assert second.receive_json() == {
            'type': 'ack',
            'session_id': 'reconnect-session',
            'received': {'sequence': 2},
        }
