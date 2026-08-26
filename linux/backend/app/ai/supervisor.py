from __future__ import annotations

import multiprocessing as mp
import threading
import time
from typing import Any, Iterator

from .errors import AIError, BackendUnavailableError, ModelNotInstalledError, ResourceBusyError, WorkerCancelledError, WorkerCrashedError, WorkerTimeoutError
from .registry import ModelRegistry, ModelSpec
from .types import AIStreamChunk, AITextResult, ASRResult, EngineState, OCRResult
from .worker import worker_main


_ERROR_TYPES = {"MODEL_NOT_INSTALLED": ModelNotInstalledError, "BACKEND_UNAVAILABLE": BackendUnavailableError, "WORKER_TIMEOUT": WorkerTimeoutError, "WORKER_CANCELLED": WorkerCancelledError, "WORKER_CRASHED": WorkerCrashedError, "RESOURCE_BUSY": ResourceBusyError}


class _Worker:
    def __init__(self, *, kind: str, spec: ModelSpec, registry: ModelRegistry, mode: str, timeout: float):
        self.kind = kind
        self.spec = spec
        self.registry = registry
        self.mode = mode
        self.timeout = timeout
        self.state = EngineState.STOPPED
        self.pid: int | None = None
        self.restart_count = 0
        self.last_used = 0.0
        self.last_error: str | None = None
        self._process = None
        self._conn = None
        self._request_lock = threading.Lock()
        self._lifecycle_lock = threading.RLock()
        self._cancel_epoch = 0
        self._ever_started = False

    def is_alive(self) -> bool:
        return bool(self._process is not None and self._process.is_alive())

    def _raise_message_error(self, message: dict[str, Any]) -> None:
        code = message.get("code", "AI_ERROR")
        exc_type = _ERROR_TYPES.get(code, AIError)
        raise exc_type(message.get("message", code), details=message.get("details") or {})

    def start(self) -> None:
        with self._lifecycle_lock:
            if self.is_alive(): return
            if self.mode == "real":
                install = self.registry.installation_status(self.spec.model_id)
                if not install.installed:
                    self.state = EngineState.NOT_INSTALLED; self.pid = None; self.last_error = "missing model files"; return
            if self._ever_started: self.restart_count += 1
            self._ever_started = True
            self.state = EngineState.LOADING
            ctx = mp.get_context("spawn")
            parent_conn, child_conn = ctx.Pipe(duplex=True)
            process = ctx.Process(target=worker_main, kwargs={"conn": child_conn, "kind": self.kind, "mode": self.mode, "spec": self.spec, "model_root": str(self.registry.model_root)}, daemon=True, name=f"ai-{self.kind}-worker")
            process.start(); child_conn.close()
            self._process = process; self._conn = parent_conn; self.pid = process.pid
            deadline = time.monotonic() + 5.0
            while time.monotonic() < deadline:
                if not process.is_alive() and not parent_conn.poll(): self.state = EngineState.ERROR; self.last_error = "worker exited during startup"; return
                if parent_conn.poll(0.05):
                    message = parent_conn.recv()
                    if message.get("type") == "startup" and message.get("state") == EngineState.READY.value:
                        self.state = EngineState.READY; self.last_error = None; self.last_used = time.monotonic(); return
                    if message.get("type") == "startup_error":
                        self.state = EngineState.ERROR; self.last_error = message.get("message"); self._raise_message_error(message)
            self._terminate_unlocked(); self.state = EngineState.ERROR
            raise WorkerTimeoutError(f"{self.kind} worker startup timed out")

    def _terminate_unlocked(self) -> None:
        process, conn = self._process, self._conn
        self._process = None; self._conn = None; self.pid = None
        if process is not None and process.is_alive():
            process.terminate(); process.join(timeout=1.0)
            if process.is_alive(): process.kill(); process.join(timeout=1.0)
        if conn is not None:
            try: conn.close()
            except Exception: pass

    def stop(self) -> None:
        with self._lifecycle_lock: self._terminate_unlocked(); self.state = EngineState.STOPPED

    def cancel(self) -> None:
        with self._lifecycle_lock: self._cancel_epoch += 1; self._terminate_unlocked(); self.state = EngineState.STOPPED

    def debug_terminate(self) -> None:
        with self._lifecycle_lock: self._terminate_unlocked(); self.state = EngineState.STOPPED

    def _ensure_available(self) -> None:
        self.start()
        if self.state == EngineState.NOT_INSTALLED:
            install = self.registry.installation_status(self.spec.model_id)
            raise ModelNotInstalledError(f"Model {self.spec.model_id} is not installed", details={"missing_files": [str(p) for p in install.missing_files]})
        if not self.is_alive():
            if self.state == EngineState.ERROR: raise WorkerCrashedError(self.last_error or f"{self.kind} worker unavailable")
            self.start()

    def request(self, op: str, payload: dict[str, Any], timeout: float | None = None):
        timeout = self.timeout if timeout is None else timeout
        with self._request_lock:
            self._ensure_available(); conn = self._conn
            if conn is None: raise WorkerCrashedError(f"{self.kind} worker has no IPC connection")
            cancel_epoch = self._cancel_epoch; self.state = EngineState.BUSY
            try:
                conn.send({"op": op, "payload": payload})
                if not conn.poll(timeout):
                    with self._lifecycle_lock: self._terminate_unlocked(); self.state = EngineState.STOPPED
                    raise WorkerTimeoutError(f"{self.kind} operation {op} timed out after {timeout}s")
                message = conn.recv()
                if message.get("type") == "error": self._raise_message_error(message)
                if message.get("type") != "result": raise WorkerCrashedError(f"Unexpected IPC response: {message.get('type')}")
                self.last_used = time.monotonic(); return message.get("data")
            except (EOFError, OSError, BrokenPipeError) as exc:
                if self._cancel_epoch != cancel_epoch: raise WorkerCancelledError(f"{self.kind} request cancelled") from exc
                with self._lifecycle_lock: self._terminate_unlocked(); self.state = EngineState.STOPPED
                raise WorkerCrashedError(f"{self.kind} worker crashed") from exc
            finally:
                if self.is_alive() and self._cancel_epoch == cancel_epoch: self.state = EngineState.READY; self.last_used = time.monotonic()

    def stream(self, op: str, payload: dict[str, Any], timeout: float | None = None) -> Iterator[Any]:
        timeout = self.timeout if timeout is None else timeout
        with self._request_lock:
            self._ensure_available(); conn = self._conn
            if conn is None: raise WorkerCrashedError(f"{self.kind} worker has no IPC connection")
            cancel_epoch = self._cancel_epoch; self.state = EngineState.BUSY; deadline = time.monotonic() + timeout
            try:
                conn.send({"op": op, "payload": payload})
                while True:
                    remaining = deadline - time.monotonic()
                    if remaining <= 0 or not conn.poll(max(0.0, remaining)):
                        with self._lifecycle_lock: self._terminate_unlocked(); self.state = EngineState.STOPPED
                        raise WorkerTimeoutError(f"{self.kind} stream timed out after {timeout}s")
                    message = conn.recv(); msg_type = message.get("type")
                    if msg_type == "chunk": self.last_used = time.monotonic(); yield message["data"]
                    elif msg_type == "done": return
                    elif msg_type == "error": self._raise_message_error(message)
                    else: raise WorkerCrashedError(f"Unexpected stream response: {msg_type}")
            except (EOFError, OSError, BrokenPipeError) as exc:
                if self._cancel_epoch != cancel_epoch: raise WorkerCancelledError(f"{self.kind} request cancelled") from exc
                with self._lifecycle_lock: self._terminate_unlocked(); self.state = EngineState.STOPPED
                raise WorkerCrashedError(f"{self.kind} worker crashed") from exc
            finally:
                if self.is_alive() and self._cancel_epoch == cancel_epoch: self.state = EngineState.READY; self.last_used = time.monotonic()

    def health(self) -> dict[str, Any]:
        if self._process is not None and not self._process.is_alive() and self.state not in {EngineState.NOT_INSTALLED, EngineState.STOPPED}:
            self.state = EngineState.ERROR; self.last_error = "worker exited"
        return {"kind": self.kind, "model_id": self.spec.model_id, "backend": self.spec.backend, "state": self.state.value, "pid": self.pid if self.is_alive() else None, "restart_count": self.restart_count, "last_error": self.last_error, "memory_mb": self.spec.memory_mb}


class AISupervisor:
    def __init__(self, registry: ModelRegistry, *, mode: str = "mock", request_timeout: float = 30.0, idle_unload_seconds: float = 300.0, memory_budget_mb: int = 6144):
        if mode not in {"mock", "real"}: raise ValueError("mode must be mock or real")
        self.registry = registry; self.mode = mode; self.request_timeout = request_timeout; self.idle_unload_seconds = idle_unload_seconds; self.memory_budget_mb = memory_budget_mb
        self._resource_lock = threading.RLock()
        self._workers = {kind: _Worker(kind=kind, spec=registry.default_for(kind), registry=registry, mode=mode, timeout=request_timeout) for kind in ("asr", "ocr", "llm") if self._has_kind(kind)}

    def _has_kind(self, kind: str) -> bool:
        try: self.registry.default_for(kind); return True
        except Exception: return False

    def _prepare(self, kind: str) -> _Worker:
        worker = self._workers[kind]
        with self._resource_lock:
            if worker.is_alive() or self.memory_budget_mb <= 0: return worker
            needed = worker.spec.memory_mb; running = [w for w in self._workers.values() if w.is_alive() and w is not worker]; total = sum(w.spec.memory_mb for w in running)
            if total + needed <= self.memory_budget_mb: return worker
            idle = sorted((w for w in running if w.state != EngineState.BUSY), key=lambda w: w.last_used)
            for candidate in idle:
                candidate.stop(); total -= candidate.spec.memory_mb
                if total + needed <= self.memory_budget_mb: return worker
            raise ResourceBusyError(f"Insufficient AI memory budget for {kind}", details={"budget_mb": self.memory_budget_mb, "needed_mb": needed, "active_mb": total})

    def generate(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> AITextResult:
        return self._prepare("llm").request("generate", {"prompt": prompt, "session_id": session_id, "options": options or {}})
    def stream_llm(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> Iterator[AIStreamChunk]:
        yield from self._prepare("llm").stream("stream_llm", {"prompt": prompt, "session_id": session_id, "options": options or {}})
    def transcribe(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> ASRResult:
        return self._prepare("asr").request("transcribe", {"audio": audio, "session_id": session_id, "options": options or {}})
    def stream_asr(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> Iterator[ASRResult]:
        yield from self._prepare("asr").stream("stream_asr", {"audio": audio, "session_id": session_id, "options": options or {}})
    def recognize(self, image: bytes, *, capability: str, session_id: str, options: dict[str, Any] | None = None) -> OCRResult:
        return self._prepare("ocr").request("ocr", {"image": image, "capability": capability, "session_id": session_id, "options": options or {}})
    def cancel(self, kind: str) -> None: self._workers[kind].cancel()
    def debug_terminate_worker(self, kind: str) -> None: self._workers[kind].debug_terminate()
    def sweep_idle(self) -> list[str]:
        if self.idle_unload_seconds <= 0: return []
        now = time.monotonic(); unloaded = []
        for kind, worker in self._workers.items():
            if worker.is_alive() and worker.state == EngineState.READY and now - worker.last_used >= self.idle_unload_seconds: worker.stop(); unloaded.append(kind)
        return unloaded
    def health(self) -> dict[str, Any]: return {"mode": self.mode, "memory_budget_mb": self.memory_budget_mb, "workers": {kind: worker.health() for kind, worker in self._workers.items()}}
    def capabilities(self) -> dict[str, Any]:
        by_kind = {}
        for kind, worker in self._workers.items():
            spec = worker.spec; install = self.registry.installation_status(spec.model_id)
            by_kind[kind] = {"model_id": spec.model_id, "backend": spec.backend, "architecture": spec.architecture, "device": spec.device, "context": spec.context, "memory_mb": spec.memory_mb, "capabilities": list(spec.capabilities), "installed": True if self.mode == "mock" else install.installed, "model_files_present": install.installed, "state": worker.health()["state"]}
        return by_kind
    def shutdown(self) -> None:
        for worker in self._workers.values(): worker.stop()
