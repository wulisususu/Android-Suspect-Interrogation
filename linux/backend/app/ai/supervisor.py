from __future__ import annotations

import multiprocessing as mp
import threading
import time
from pathlib import Path
from typing import Any, Iterator

from .errors import AIError, BackendUnavailableError, ModelNotInstalledError, ResourceBusyError, WorkerCancelledError, WorkerCrashedError, WorkerTimeoutError
from .registry import ModelRegistry, ModelSpec
from .speech.client import SpeechWorkerClient
from .speech.types import SpeechEvent, SpeechEventType
from .types import AIStreamChunk, AITextResult, ASRResult, EngineState, OCRResult
from .worker import worker_main


_ERROR_TYPES = {"MODEL_NOT_INSTALLED": ModelNotInstalledError, "BACKEND_UNAVAILABLE": BackendUnavailableError, "WORKER_TIMEOUT": WorkerTimeoutError, "WORKER_CANCELLED": WorkerCancelledError, "WORKER_CRASHED": WorkerCrashedError, "RESOURCE_BUSY": ResourceBusyError}


class _InProcessSpeechClient:
    """Deterministic speech pipeline used only by AI_MODE=mock.

    This deliberately avoids AF_UNIX/systemd so the regular test suite does not
    depend on the RK3588 speech worker. It mirrors the public SpeechWorkerClient
    operations used by AISupervisor without pretending to perform biometrics.
    """

    def __init__(self) -> None:
        self._sessions: dict[str, dict[str, int]] = {}
        self._lock = threading.RLock()

    def health(self) -> dict[str, Any]:
        with self._lock:
            return {"status": "ok", "sessions": len(self._sessions)}

    def open_session(
        self,
        session_id: str,
        sample_rate: int = 16000,
        speaker_backend: str = "xvector",
        authoritative_backend: str | None = None,
    ) -> dict[str, Any]:
        session_id = str(session_id).strip()
        sample_rate = int(sample_rate)
        speaker_backend = str(speaker_backend or "xvector").strip().lower()
        authority_key = (
            None
            if authoritative_backend is None
            else str(authoritative_backend).strip().lower()
        )
        concrete = {"xvector", "eres2net_large"}
        if not session_id:
            raise AIError("session_id is required")
        if sample_rate <= 0:
            raise AIError("sample_rate must be positive")
        if speaker_backend not in {*concrete, "compare"}:
            raise AIError("unsupported speaker backend", details={"speaker_backend": speaker_backend})
        if speaker_backend == "compare":
            if authority_key not in concrete:
                raise AIError("authoritative speaker backend is required in compare mode")
        elif authority_key is not None and authority_key != speaker_backend:
            raise AIError("authoritative speaker backend must match single backend")
        with self._lock:
            self._sessions[session_id] = {
                "sample_rate": sample_rate,
                "bytes_received": 0,
                "speaker_backend": speaker_backend,
                "authoritative_backend": authority_key or speaker_backend,
            }
        result = {
            "session_id": session_id,
            "sample_rate": sample_rate,
            "speaker_backend": speaker_backend,
        }
        if authority_key is not None:
            result["authoritative_backend"] = authority_key
        return result

    def push_pcm(self, session_id: str, pcm: bytes) -> list[SpeechEvent]:
        with self._lock:
            session = self._sessions.get(session_id)
            if session is None:
                raise AIError("speech session is not open", details={"session_id": session_id})
            session["bytes_received"] += len(pcm)
            received = session["bytes_received"]
        return [
            SpeechEvent(
                type=SpeechEventType.VAD_START,
                session_id=session_id,
                start_ms=0,
                model_id="mock-fsmn-vad",
                details={"mock": True},
            ),
            SpeechEvent(
                type=SpeechEventType.ASR_PARTIAL,
                session_id=session_id,
                text=f"mock:{received}",
                confidence=1.0,
                model_id="mock-paraformer",
                details={"mock": True},
            ),
        ]

    def finalize_session(self, session_id: str) -> list[SpeechEvent]:
        with self._lock:
            if session_id not in self._sessions:
                raise AIError("speech session is not open", details={"session_id": session_id})
        return [
            SpeechEvent(
                type=SpeechEventType.VAD_END,
                session_id=session_id,
                start_ms=0,
                end_ms=1000,
                model_id="mock-fsmn-vad",
                details={"mock": True},
            ),
            SpeechEvent(
                type=SpeechEventType.ASR_FINAL,
                session_id=session_id,
                start_ms=0,
                end_ms=1000,
                text="mock final",
                confidence=1.0,
                model_id="mock-paraformer",
                details={"mock": True},
            ),
            SpeechEvent(
                type=SpeechEventType.SPEAKER_RESULT,
                session_id=session_id,
                start_ms=0,
                end_ms=1000,
                embedding=[1.0, 0.0, 0.0],
                model_id="mock-xvector",
                details={"mock": True},
            ),
        ]

    def close_session(self, session_id: str) -> None:
        with self._lock:
            self._sessions.pop(session_id, None)

    def extract_embedding(self, pcm: bytes, sample_rate: int = 16000) -> dict[str, Any]:
        del pcm
        return {
            "embedding": [1.0, 0.0, 0.0],
            "model_id": "mock-xvector",
            "sample_rate": int(sample_rate),
        }


class _Worker:
    def __init__(self, *, kind: str, spec: ModelSpec, registry: ModelRegistry, mode: str, timeout: float, llamapi_base_url: str = "http://127.0.0.1:9265/v1", llamapi_model_hint: str = "qwen3:4b"):
        self.kind = kind
        self.spec = spec
        self.registry = registry
        self.mode = mode
        self.timeout = timeout
        self.llamapi_base_url = llamapi_base_url
        self.llamapi_model_hint = llamapi_model_hint
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
            process = ctx.Process(target=worker_main, kwargs={"conn": child_conn, "kind": self.kind, "mode": self.mode, "spec": self.spec, "model_root": str(self.registry.model_root), "llamapi_base_url": self.llamapi_base_url, "llamapi_model_hint": self.llamapi_model_hint, "request_timeout": self.timeout}, daemon=True, name=f"ai-{self.kind}-worker")
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
    def __init__(self, registry: ModelRegistry, *, mode: str = "mock", request_timeout: float = 30.0, idle_unload_seconds: float = 300.0, memory_budget_mb: int = 6144, speech_socket: str | Path = "/run/suspect-interrogation/speech.sock", speaker_accept_threshold: float | None = None, speaker_margin: float | None = None, speech_client: Any | None = None, llamapi_base_url: str = "http://127.0.0.1:9265/v1", llamapi_model_hint: str = "qwen3:4b"):
        if mode not in {"mock", "real"}: raise ValueError("mode must be mock or real")
        self.registry = registry; self.mode = mode; self.request_timeout = request_timeout; self.idle_unload_seconds = idle_unload_seconds; self.memory_budget_mb = memory_budget_mb
        self.speaker_accept_threshold = speaker_accept_threshold
        self.speaker_margin = speaker_margin
        self._resource_lock = threading.RLock()
        self._workers = {kind: _Worker(kind=kind, spec=registry.default_for(kind), registry=registry, mode=mode, timeout=request_timeout, llamapi_base_url=llamapi_base_url, llamapi_model_hint=llamapi_model_hint) for kind in ("asr", "ocr", "llm") if self._has_kind(kind)}
        if speech_client is not None:
            self._speech_client = speech_client
            self._speech_backend = "injected"
        elif mode == "mock":
            self._speech_client = _InProcessSpeechClient()
            self._speech_backend = "in-process-mock"
        else:
            self._speech_client = SpeechWorkerClient(speech_socket, timeout=request_timeout)
            self._speech_backend = "af-unix"
        self._speech_sessions: set[str] = set()

    @property
    def speech_client(self) -> Any:
        return self._speech_client

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

    def open_speech_session(
        self,
        session_id: str,
        *,
        sample_rate: int = 16000,
        speaker_backend: str | None = None,
        authoritative_backend: str | None = None,
    ) -> dict[str, Any]:
        explicit_backend = speaker_backend is not None
        if explicit_backend:
            kwargs: dict[str, Any] = {
                "sample_rate": sample_rate,
                "speaker_backend": speaker_backend,
            }
            if authoritative_backend is not None:
                kwargs["authoritative_backend"] = authoritative_backend
            result = self._speech_client.open_session(session_id, **kwargs)
        else:
            if authoritative_backend is not None:
                raise ValueError("authoritative_backend requires an explicit speaker_backend")
            result = self._speech_client.open_session(
                session_id,
                sample_rate=sample_rate,
            )
            # In-process mock historically returned no backend discriminator.
            # Normalize the omitted-backend call even if an internal client adds it.
            result = dict(result)
            result.pop("speaker_backend", None)
            result.pop("authoritative_backend", None)
        self._speech_sessions.add(session_id)
        return result

    def push_speech_pcm(self, session_id: str, pcm: bytes) -> list[SpeechEvent]:
        return self._speech_client.push_pcm(session_id, pcm)

    def finalize_speech_session(self, session_id: str) -> list[SpeechEvent]:
        return self._speech_client.finalize_session(session_id)

    def close_speech_session(self, session_id: str) -> None:
        try:
            self._speech_client.close_session(session_id)
        finally:
            self._speech_sessions.discard(session_id)

    def extract_speaker_embedding(self, pcm: bytes, *, sample_rate: int = 16000) -> dict[str, Any]:
        return self._speech_client.extract_embedding(pcm, sample_rate=sample_rate)

    def cancel(self, kind: str) -> None: self._workers[kind].cancel()
    def debug_terminate_worker(self, kind: str) -> None: self._workers[kind].debug_terminate()
    def sweep_idle(self) -> list[str]:
        if self.idle_unload_seconds <= 0: return []
        now = time.monotonic(); unloaded = []
        for kind, worker in self._workers.items():
            if worker.is_alive() and worker.state == EngineState.READY and now - worker.last_used >= self.idle_unload_seconds: worker.stop(); unloaded.append(kind)
        return unloaded

    def _speech_health(self) -> dict[str, Any]:
        try:
            detail = self._speech_client.health()
        except AIError as exc:
            return {
                "state": "ERROR",
                "backend": self._speech_backend,
                "error": {"code": exc.code, "message": str(exc)},
            }
        return {
            "state": "READY",
            "backend": self._speech_backend,
            "detail": detail,
            "open_sessions": len(self._speech_sessions),
        }

    def health(self) -> dict[str, Any]:
        return {
            "mode": self.mode,
            "memory_budget_mb": self.memory_budget_mb,
            "workers": {kind: worker.health() for kind, worker in self._workers.items()},
            "speech": self._speech_health(),
        }

    @staticmethod
    def _speech_model_available(speech: dict[str, Any], model: str) -> bool:
        if speech.get("state") != "READY":
            return False
        detail = speech.get("detail")
        if not isinstance(detail, dict):
            return True
        models = detail.get("models")
        if not isinstance(models, dict) or model not in models:
            # Mock/older compatible clients may not expose per-model health.
            return True
        return bool(models.get(model))

    def capabilities(self) -> dict[str, Any]:
        by_kind = {}
        for kind, worker in self._workers.items():
            spec = worker.spec; install = self.registry.installation_status(spec.model_id)
            by_kind[kind] = {"model_id": spec.model_id, "backend": spec.backend, "architecture": spec.architecture, "device": spec.device, "context": spec.context, "memory_mb": spec.memory_mb, "capabilities": list(spec.capabilities), "installed": True if self.mode == "mock" else install.installed, "model_files_present": install.installed, "state": worker.health()["state"]}

        speech = self._speech_health()
        asr_available = self._speech_model_available(speech, "asr")
        vad_available = self._speech_model_available(speech, "vad")
        speaker_available = self._speech_model_available(speech, "speaker")
        if "asr" in by_kind:
            by_kind["asr"] = {
                **by_kind["asr"],
                "speech_worker": True,
                "speech_state": "AVAILABLE" if asr_available else "ERROR",
            }
        else:
            by_kind["asr"] = {
                "state": "AVAILABLE" if asr_available else "ERROR",
                "speech_worker": True,
                "backend": self._speech_backend,
            }
        by_kind["vad"] = {
            "state": "AVAILABLE" if vad_available else "ERROR",
            "speech_worker": True,
            "backend": self._speech_backend,
        }
        speaker_configured = self.speaker_accept_threshold is not None and self.speaker_margin is not None
        by_kind["speaker"] = {
            "state": "AVAILABLE" if speaker_available and speaker_configured else "NOT_CONFIGURED" if not speaker_configured else "ERROR",
            "speech_worker": True,
            "backend": self._speech_backend,
            "threshold_configured": self.speaker_accept_threshold is not None,
            "margin_configured": self.speaker_margin is not None,
        }
        return by_kind

    def shutdown(self) -> None:
        for session_id in list(self._speech_sessions):
            try:
                self.close_speech_session(session_id)
            except AIError:
                self._speech_sessions.discard(session_id)
        for worker in self._workers.values(): worker.stop()
