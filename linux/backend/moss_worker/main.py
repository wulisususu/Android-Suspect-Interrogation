"""Unix socket server exposing the MOSS supervisor ops to the application."""
from __future__ import annotations

import errno
import hashlib
import json
import os
import re
import signal
import socket
import stat
import sys
import threading
import wave
from pathlib import Path
from typing import Any

from app.ai.errors import AIError, ResourceBusyError
from .protocol import ProtocolError, recv_frame, send_frame
from .storage import MossSpool
from .supervisor import MossSupervisor


DEFAULT_SOCKET_PATH = Path("/run/suspect-interrogation/moss.sock")
DEFAULT_SPOOL_ROOT = Path("/var/lib/suspect-interrogation/moss")
DEFAULT_MODEL_BUNDLE = Path("/opt/suspect-interrogation/models/moss-rk3588")

_MOSS_CODE = re.compile(r"^(MOSS_[A-Z0-9_]+|GENERATION_LIMIT_REACHED)(?::|$)")


class MossWorkerOpError(AIError):
    """AIError carrying the exact MOSS wire code determined at runtime."""

    code = "MOSS_ERROR"

    def __init__(self, code: str, message: str, *, details: dict | None = None) -> None:
        super().__init__(message, details=details)
        self.code = code


def _moss_coded_error(exc: Exception) -> MossWorkerOpError | None:
    """Surface supervisor MOSS_* failure strings as exact wire codes."""
    match = _MOSS_CODE.match(str(exc))
    if match is None:
        return None
    return MossWorkerOpError(match.group(1), str(exc))


def _sha256_file(path: str | Path) -> str:
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


class MossWorkerServer:
    """One scheduler thread drains the supervisor; requests are served serially."""

    def __init__(self, socket_path: str | Path, supervisor: Any, *, run_pending_interval: float = 0.05) -> None:
        self.socket_path = Path(socket_path)
        self.supervisor = supervisor
        self.run_pending_interval = max(0.001, float(run_pending_interval))
        self._server: socket.socket | None = None
        self._owned_socket: tuple[int, int] | None = None
        self._stop = threading.Event()
        self._scheduler: threading.Thread | None = None
        self._last_run_failures: dict[str, str] = {}
        self._last_scheduler_error: str | None = None

    def bind(self) -> None:
        if self._server is not None:
            return
        self.socket_path.parent.mkdir(parents=True, exist_ok=True)
        self._prepare_socket_path()
        server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        try:
            server.bind(os.fspath(self.socket_path))
            os.chmod(self.socket_path, 0o660)
            server.listen(16)
            server.settimeout(0.2)
            info = self.socket_path.lstat()
            self._owned_socket = (info.st_dev, info.st_ino)
            self._server = server
            self._stop.clear()
        except Exception:
            server.close()
            self._cleanup_socket_path()
            raise

    def serve_forever(self) -> None:
        server = self._server
        if server is None:
            raise RuntimeError("moss worker server is not bound")
        self._start_scheduler()
        try:
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
            self._close_listener()
            self._join_scheduler()
            self._cleanup_socket_path()

    def stop(self) -> None:
        self._stop.set()
        self._close_listener()
        self._join_scheduler()
        self._cleanup_socket_path()

    def _prepare_socket_path(self) -> None:
        try:
            info = self.socket_path.lstat()
        except FileNotFoundError:
            return
        if not stat.S_ISSOCK(info.st_mode):
            raise ResourceBusyError("moss worker path exists and is not a Unix socket", details={"socket": str(self.socket_path)})
        probe = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        probe.settimeout(0.2)
        try:
            probe.connect(os.fspath(self.socket_path))
        except OSError as exc:
            if exc.errno not in {errno.ECONNREFUSED, errno.ENOENT}:
                raise ResourceBusyError("cannot prove existing moss worker socket is stale", details={"socket": str(self.socket_path), "errno": exc.errno}) from exc
        else:
            raise ResourceBusyError("an active moss worker is already listening on the Unix socket", details={"socket": str(self.socket_path)})
        finally:
            probe.close()
        self.socket_path.unlink(missing_ok=True)

    def _handle_connection(self, conn: socket.socket) -> None:
        request_id = ""
        try:
            request = recv_frame(conn)
            request_id = str(request.get("request_id") or "")
            result = self._dispatch(request)
            response = {"request_id": request_id, "ok": True, "result": result}
        except AIError as exc:
            response = {"request_id": request_id, "ok": False, "error": {"code": exc.code, "message": exc.message, "details": dict(exc.details)}}
        except ProtocolError as exc:
            response = self._error_response(request_id, "WORKER_CRASHED", str(exc), {})
        except (KeyError, TypeError, ValueError) as exc:
            response = self._error_response(request_id, "AI_ERROR", str(exc), {"error_type": type(exc).__name__})
        except Exception as exc:
            response = self._error_response(request_id, "WORKER_CRASHED", "moss worker request failed unexpectedly", {"error_type": type(exc).__name__})
        try:
            send_frame(conn, response)
        except OSError:
            return

    def _dispatch(self, request: dict[str, Any]) -> Any:
        try:
            return self._route(str(request.get("op") or ""), request)
        except (ValueError, KeyError, TypeError) as exc:
            coded = _moss_coded_error(exc)
            if coded is not None:
                raise coded from exc
            raise AIError(str(exc), details={"error_type": type(exc).__name__}) from exc

    def _route(self, op: str, request: dict[str, Any]) -> Any:
        if op == "health":
            # Design §22: queue_depth counts jobs not yet started (QUEUED) and
            # active_job names the job the scheduler is draining (else None);
            # both derive from the same supervisor state the ops read.
            queue_depth, active_job = self.supervisor.queue_status()
            return {
                "status": "ok",
                "manifest_sha256": str(self.supervisor.manifest_sha256),
                "runtime_versions": dict(self.supervisor.runtime_versions),
                "queue_depth": int(queue_depth),
                "active_job": None if active_job is None else str(active_job),
                "run_failures": dict(self._last_run_failures),
                "scheduler_error": self._last_scheduler_error,
            }

        if op == "submit_job":
            audio_path = str(request.get("audio_path") or "")
            if not audio_path:
                raise AIError("audio_path is required")
            return self._submit(audio_path, str(request.get("audio_sha256") or ""))

        if op == "get_job":
            job_id = self._required_job_id(request)
            return self._job_payload(self._job_op(job_id, lambda: self.supervisor.get_job(job_id)))

        if op == "get_result":
            job_id = self._required_job_id(request)
            result = self._job_op(job_id, lambda: self.supervisor.get_result(job_id))
            payload = self._job_payload(self._job_op(job_id, lambda: self.supervisor.get_job(job_id)))
            payload["result"] = result.to_dict() if result is not None else None
            return payload

        if op == "cancel_job":
            job_id = self._required_job_id(request)
            return self._job_payload(self._job_op(job_id, lambda: self.supervisor.cancel(job_id)))

        raise AIError(f"unknown moss operation: {op}", details={"op": op})

    def _submit(self, audio_path: str, audio_sha256: str) -> dict[str, Any]:
        if audio_sha256:
            try:
                actual = _sha256_file(audio_path)
            except OSError as exc:
                raise AIError(f"audio file is unavailable: {exc}", details={"audio_path": audio_path}) from exc
            if actual != audio_sha256.strip().lower():
                raise MossWorkerOpError(
                    "MOSS_AUDIO_CHANGED",
                    "submitted audio does not match the declared SHA256",
                    details={"audio_path": audio_path, "expected": audio_sha256, "actual": actual},
                )
        try:
            snapshot = self.supervisor.submit(audio_path)
        except (wave.Error, EOFError) as exc:
            raise MossWorkerOpError("MOSS_AUDIO_CORRUPT", f"audio file is not a readable WAV file: {exc}", details={"audio_path": audio_path}) from exc
        except OSError as exc:
            raise AIError(f"audio file is unavailable: {exc}", details={"audio_path": audio_path}) from exc
        return self._job_payload(snapshot)

    def _job_op(self, job_id: str, action):
        try:
            return action()
        except FileNotFoundError as exc:
            raise MossWorkerOpError("MOSS_JOB_NOT_FOUND", f"moss job is not found: {job_id}", details={"job_id": job_id}) from exc
        except ValueError as exc:
            if str(exc) == "invalid job id":
                raise MossWorkerOpError("MOSS_JOB_NOT_FOUND", f"moss job is not found: {job_id}", details={"job_id": job_id}) from exc
            raise

    def _job_payload(self, snapshot) -> dict[str, Any]:
        payload = snapshot.to_dict()
        payload["windows"] = self._window_statuses(snapshot.job_id)
        return payload

    def _window_statuses(self, job_id: str) -> list[dict[str, Any]]:
        statuses = []
        for result in self.supervisor.spool.load_window_results(job_id):
            statuses.append({
                "window_id": result.window_id,
                "start_ms": result.window.start_ms,
                "end_ms": result.window.end_ms,
                "window_minutes": result.window.window_minutes,
                "state": result.state.value,
                "parse_status": result.parse_status.value,
                "error": result.error,
                "token_count": result.token_count,
                "normal_termination": result.normal_termination,
            })
        return statuses

    @staticmethod
    def _required_job_id(request: dict[str, Any]) -> str:
        job_id = str(request.get("job_id") or "")
        if not job_id:
            raise AIError("job_id is required")
        return job_id

    @staticmethod
    def _error_response(request_id: str, code: str, message: str, details: dict[str, Any]) -> dict[str, Any]:
        return {"request_id": request_id, "ok": False, "error": {"code": code, "message": message, "details": details}}

    def _start_scheduler(self) -> None:
        if self._scheduler is not None and self._scheduler.is_alive():
            return
        self._stop.clear()
        self._scheduler = threading.Thread(target=self._scheduler_loop, name="moss-scheduler", daemon=True)
        self._scheduler.start()

    def _join_scheduler(self) -> None:
        thread = self._scheduler
        if thread is not None and thread is not threading.current_thread():
            thread.join(timeout=2.0)

    def _scheduler_loop(self) -> None:
        while not self._stop.wait(self.run_pending_interval):
            self._run_pending_once()

    def _run_pending_once(self) -> None:
        try:
            failures = self.supervisor.run_pending()
        except Exception as exc:
            self._last_scheduler_error = f"{type(exc).__name__}: {exc}"
            return
        self._last_scheduler_error = None
        self._last_run_failures = dict(failures or {})

    def _close_listener(self) -> None:
        server = self._server
        self._server = None
        if server is not None:
            try:
                server.close()
            except OSError:
                pass

    def _cleanup_socket_path(self) -> None:
        owned = self._owned_socket
        if owned is None:
            return
        try:
            info = self.socket_path.lstat()
        except FileNotFoundError:
            self._owned_socket = None
            return
        if stat.S_ISSOCK(info.st_mode) and (info.st_dev, info.st_ino) == owned:
            self.socket_path.unlink(missing_ok=True)
        self._owned_socket = None


def main() -> int:
    socket_path = Path(os.environ.get("SUSPECT_MOSS_SOCKET", str(DEFAULT_SOCKET_PATH)))
    spool_root = Path(os.environ.get("MOSS_SPOOL_ROOT", str(DEFAULT_SPOOL_ROOT)))
    bundle = Path(os.environ.get("MOSS_MODEL_BUNDLE", str(DEFAULT_MODEL_BUNDLE)))
    manifest_sha256 = os.environ.get("MOSS_MODEL_MANIFEST_SHA256", "")
    if not manifest_sha256:
        raise SystemExit("MOSS_MODEL_MANIFEST_SHA256 is required")
    runtime_versions = json.loads(os.environ.get("MOSS_RUNTIME_VERSIONS", "{}"))
    if not isinstance(runtime_versions, dict) or not runtime_versions:
        raise SystemExit("MOSS_RUNTIME_VERSIONS must be a JSON object describing the pinned child runtime")
    rknn_library = os.environ.get("MOSS_RKNN_LIBRARY", "")
    rkllm_library = os.environ.get("MOSS_RKLLM_LIBRARY", "")
    if not rknn_library or not rkllm_library:
        raise SystemExit("MOSS_RKNN_LIBRARY and MOSS_RKLLM_LIBRARY are required")
    cancel_grace = float(os.environ.get("MOSS_CANCEL_GRACE", "10"))
    # Native inference must run in the isolated Python 3.10 deployment env;
    # production systemd units set MOSS_CHILD_PYTHON explicitly.
    child_python = os.environ.get("MOSS_CHILD_PYTHON", sys.executable)

    supervisor = MossSupervisor(
        MossSpool(spool_root),
        bundle=bundle,
        manifest_sha256=manifest_sha256,
        runtime_versions=runtime_versions,
        cancel_grace=cancel_grace,
        python_executable=child_python,
        rknn_library=rknn_library,
        rkllm_library=rkllm_library,
    )
    server = MossWorkerServer(socket_path, supervisor)

    def handle_signal(signum: int, frame: Any) -> None:
        del signum, frame
        server.stop()

    signal.signal(signal.SIGTERM, handle_signal)
    signal.signal(signal.SIGINT, handle_signal)
    server.bind()
    try:
        server.serve_forever()
    finally:
        server.stop()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
