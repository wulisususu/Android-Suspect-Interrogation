from __future__ import annotations

import base64
import socket
import threading
from pathlib import Path
from typing import Any

from .protocol import ProtocolError, recv_frame, send_frame


class MockSpeechWorker:
    def __init__(self, socket_path: str | Path) -> None:
        self.socket_path = Path(socket_path)
        self.last_request: dict[str, Any] = {}
        self.last_response: dict[str, Any] = {}
        self._sessions: dict[str, dict[str, Any]] = {}
        self._failures: dict[str, dict[str, Any]] = {}
        self._stop = threading.Event()
        self._ready = threading.Event()
        self._thread: threading.Thread | None = None
        self._server: socket.socket | None = None
        self._lock = threading.Lock()

    def __enter__(self) -> "MockSpeechWorker":
        self.start()
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        self.stop()

    def start(self) -> None:
        if self._thread is not None and self._thread.is_alive():
            return
        self.socket_path.parent.mkdir(parents=True, exist_ok=True)
        self.socket_path.unlink(missing_ok=True)
        self._sessions = {}
        self.last_request = {}
        self.last_response = {}
        self._stop.clear()
        self._ready.clear()
        self._thread = threading.Thread(target=self._run, daemon=True)
        self._thread.start()
        if not self._ready.wait(timeout=1.0):
            raise RuntimeError("mock speech worker failed to start")

    def stop(self) -> None:
        self._stop.set()
        server = self._server
        if server is not None:
            try:
                server.close()
            except OSError:
                pass
        thread = self._thread
        if thread is not None:
            thread.join(timeout=1.0)
        self._thread = None
        self._server = None
        self.socket_path.unlink(missing_ok=True)

    def fail_next(
        self,
        op: str,
        *,
        code: str,
        message: str,
        details: dict[str, Any] | None = None,
    ) -> None:
        with self._lock:
            self._failures[op] = {
                "code": code,
                "message": message,
                "details": dict(details or {}),
            }

    def _run(self) -> None:
        server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self._server = server
        try:
            server.bind(str(self.socket_path))
            server.listen(8)
            server.settimeout(0.1)
            self._ready.set()
            while not self._stop.is_set():
                try:
                    conn, _ = server.accept()
                except socket.timeout:
                    continue
                except OSError:
                    if self._stop.is_set():
                        break
                    raise
                with conn:
                    self._handle_connection(conn)
        finally:
            try:
                server.close()
            except OSError:
                pass
            self.socket_path.unlink(missing_ok=True)
            self._ready.set()

    def _handle_connection(self, conn: socket.socket) -> None:
        try:
            request = recv_frame(conn)
            response = self._dispatch(request)
        except ProtocolError as exc:
            response = self._error_response("", "WORKER_CRASHED", str(exc), {})
        self.last_request = request if "request" in locals() else {}
        self.last_response = response
        try:
            send_frame(conn, response)
        except OSError:
            return

    def _dispatch(self, request: dict[str, Any]) -> dict[str, Any]:
        request_id = str(request.get("request_id") or "")
        op = str(request.get("op") or "")
        with self._lock:
            failure = self._failures.pop(op, None)
        if failure is not None:
            return self._error_response(
                request_id,
                str(failure["code"]),
                str(failure["message"]),
                dict(failure["details"]),
            )

        if op == "health":
            return self._ok_response(request_id, {"status": "ok", "sessions": len(self._sessions)})
        if op == "open_session":
            session_id = str(request.get("session_id") or "")
            sample_rate = int(request.get("sample_rate") or 16000)
            if not session_id:
                return self._error_response(request_id, "AI_ERROR", "session_id is required", {})
            self._sessions[session_id] = {"sample_rate": sample_rate, "bytes_received": 0}
            return self._ok_response(
                request_id,
                {"session_id": session_id, "sample_rate": sample_rate},
            )
        if op == "push_pcm":
            session_id = str(request.get("session_id") or "")
            session = self._sessions.get(session_id)
            if session is None:
                return self._error_response(
                    request_id,
                    "AI_ERROR",
                    "speech session is not open",
                    {"session_id": session_id},
                )
            try:
                pcm = base64.b64decode(str(request.get("pcm_b64") or ""), validate=True)
            except (ValueError, TypeError) as exc:
                return self._error_response(request_id, "AI_ERROR", f"invalid pcm_b64: {exc}", {})
            session["bytes_received"] += len(pcm)
            events = [
                {
                    "type": "VAD_START",
                    "session_id": session_id,
                    "start_ms": 0,
                    "details": {"mock": True},
                },
                {
                    "type": "ASR_PARTIAL",
                    "session_id": session_id,
                    "text": f"mock:{session['bytes_received']}",
                    "model_id": "mock-paraformer",
                    "details": {"mock": True},
                },
            ]
            return self._ok_response(request_id, {"events": events})
        if op == "finalize_session":
            session_id = str(request.get("session_id") or "")
            session = self._sessions.get(session_id)
            if session is None:
                return self._error_response(
                    request_id,
                    "AI_ERROR",
                    "speech session is not open",
                    {"session_id": session_id},
                )
            events = [
                {
                    "type": "VAD_END",
                    "session_id": session_id,
                    "end_ms": 1,
                    "details": {"mock": True},
                },
                {
                    "type": "ASR_FINAL",
                    "session_id": session_id,
                    "text": "mock final",
                    "model_id": "mock-paraformer",
                    "details": {"mock": True},
                },
            ]
            return self._ok_response(request_id, {"events": events})
        if op == "close_session":
            session_id = str(request.get("session_id") or "")
            self._sessions.pop(session_id, None)
            return self._ok_response(request_id, {})
        if op == "speech_segments":
            try:
                base64.b64decode(str(request.get("pcm_b64") or ""), validate=True)
            except (ValueError, TypeError) as exc:
                return self._error_response(request_id, "AI_ERROR", f"invalid pcm_b64: {exc}", {})
            return self._ok_response(
                request_id,
                {
                    "segments": [[100, 900]],
                    "sample_rate": int(request.get("sample_rate") or 16000),
                },
            )
        if op == "extract_embedding":
            try:
                base64.b64decode(str(request.get("pcm_b64") or ""), validate=True)
            except (ValueError, TypeError) as exc:
                return self._error_response(request_id, "AI_ERROR", f"invalid pcm_b64: {exc}", {})
            return self._ok_response(
                request_id,
                {
                    "embedding": [1.0, 0.0, 0.0],
                    "model_id": "mock-xvector",
                    "sample_rate": int(request.get("sample_rate") or 16000),
                },
            )
        return self._error_response(request_id, "AI_ERROR", f"unknown speech operation: {op}", {})

    @staticmethod
    def _ok_response(request_id: str, result: Any) -> dict[str, Any]:
        return {"request_id": request_id, "ok": True, "result": result}

    @staticmethod
    def _error_response(
        request_id: str,
        code: str,
        message: str,
        details: dict[str, Any],
    ) -> dict[str, Any]:
        return {
            "request_id": request_id,
            "ok": False,
            "error": {"code": code, "message": message, "details": details},
        }
