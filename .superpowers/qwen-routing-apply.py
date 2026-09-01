# commit: feat: connect qwen3 through llamapi
from __future__ import annotations

from pathlib import Path


def replace_once(path: str, old: str, new: str) -> None:
    target = Path(path)
    text = target.read_text(encoding="utf-8")
    if old not in text:
        raise SystemExit(f"expected source block missing in {path}: {old[:180]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def write_new(path: str, content: str) -> None:
    target = Path(path)
    if target.exists():
        raise SystemExit(f"refusing to overwrite existing file: {path}")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content, encoding="utf-8")


write_new(
    "linux/backend/app/ai/engines/llamapi.py",
    '''from __future__ import annotations

import json
import socket
from collections.abc import Iterable
from typing import Any
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

from ..errors import BackendUnavailableError
from ..interfaces import LLMEngine
from ..registry import ModelSpec
from ..types import AIStreamChunk, AITextResult, EngineState


_ALLOWED_GENERATION_OPTIONS = {
    "temperature",
    "top_p",
    "top_k",
    "repeat_penalty",
    "frequency_penalty",
    "presence_penalty",
    "max_tokens",
    "max_completion_tokens",
    "stop",
    "enable_thinking",
}


class LlamaPiLLMEngine(LLMEngine):
    """OpenAI-compatible LlamaPi adapter for the local RK3588 Qwen runtime."""

    def __init__(
        self,
        spec: ModelSpec,
        *,
        base_url: str = "http://127.0.0.1:9265/v1",
        model_hint: str = "qwen3:4b",
        timeout: float = 30.0,
    ) -> None:
        self.spec = spec
        self.model_id = spec.model_id
        self.base_url = str(base_url or "").strip().rstrip("/")
        self.model_hint = str(model_hint or "").strip()
        self.timeout = max(0.05, float(timeout))
        self.resolved_model_id: str | None = None
        self._state = EngineState.STOPPED
        if not self.base_url:
            raise ValueError("LlamaPi base_url is required")
        if not self.model_hint:
            raise ValueError("LlamaPi model_hint is required")

    def load(self) -> None:
        self._state = EngineState.LOADING
        try:
            payload = self._request_json("GET", "/models")
            raw_models = payload.get("data")
            if not isinstance(raw_models, list):
                raise BackendUnavailableError("LlamaPi /models response is malformed")

            chat_ids: list[str] = []
            for item in raw_models:
                if not isinstance(item, dict):
                    continue
                model_id = item.get("id")
                model_kind = str(item.get("model_kind") or "chat").strip().lower()
                if isinstance(model_id, str) and model_id.strip() and model_kind == "chat":
                    chat_ids.append(model_id.strip())

            hint = self.model_hint.casefold()
            exact = [item for item in chat_ids if item.casefold() == hint]
            if len(exact) == 1:
                resolved = exact[0]
            elif len(exact) > 1:
                raise BackendUnavailableError(
                    f"LlamaPi model hint {self.model_hint!r} is ambiguous",
                    details={"matches": exact},
                )
            else:
                variants = [item for item in chat_ids if item.split("@", 1)[0].casefold() == hint]
                if not variants:
                    raise BackendUnavailableError(
                        f"LlamaPi chat model matching {self.model_hint!r} is unavailable",
                        details={"available_chat_models": chat_ids},
                    )
                if len(variants) != 1:
                    raise BackendUnavailableError(
                        f"LlamaPi model hint {self.model_hint!r} is ambiguous",
                        details={"matches": variants},
                    )
                resolved = variants[0]

            self.resolved_model_id = resolved
            self._state = EngineState.READY
        except Exception:
            self.resolved_model_id = None
            self._state = EngineState.ERROR
            raise

    def health(self) -> EngineState:
        return self._state

    def cancel(self) -> None:
        # LlamaPi's OpenAI-compatible endpoint has no per-request cancellation
        # handle for this synchronous urllib client. Supervisor cancellation
        # terminates the worker process, which closes any in-flight socket.
        return None

    def unload(self) -> None:
        self.resolved_model_id = None
        self._state = EngineState.STOPPED

    def generate(
        self,
        prompt: str,
        *,
        session_id: str,
        options: dict[str, Any] | None = None,
    ) -> AITextResult:
        resolved = self._require_ready_model()
        request_options = dict(options or {})
        payload: dict[str, Any] = {
            "model": resolved,
            "messages": [{"role": "user", "content": str(prompt)}],
            "stream": False,
        }
        for key in _ALLOWED_GENERATION_OPTIONS:
            if key in request_options:
                payload[key] = request_options[key]
        # Formal-record routing must never expose Qwen thinking text. Callers
        # may explicitly pass false; defaulting false keeps other structured
        # appliance calls deterministic as well.
        payload.setdefault("enable_thinking", False)

        response = self._request_json("POST", "/chat/completions", payload)
        try:
            choices = response["choices"]
            message = choices[0]["message"]
            content = message["content"]
        except (KeyError, IndexError, TypeError) as exc:
            raise BackendUnavailableError("LlamaPi chat completion response is malformed") from exc
        if not isinstance(content, str):
            raise BackendUnavailableError("LlamaPi chat completion response is malformed")

        returned_model = response.get("model")
        if isinstance(returned_model, str) and returned_model.strip() and returned_model.strip() != resolved:
            raise BackendUnavailableError(
                "LlamaPi returned a different model than requested",
                details={"requested_model": resolved, "returned_model": returned_model.strip()},
            )
        return AITextResult(text=content, model_id=resolved, session_id=session_id, source="llamapi")

    def stream(
        self,
        prompt: str,
        *,
        session_id: str,
        options: dict[str, Any] | None = None,
    ) -> Iterable[AIStreamChunk]:
        # Formal routing uses generate(). Preserve the LLMEngine streaming
        # contract without introducing a second SSE parser in v1.
        result = self.generate(prompt, session_id=session_id, options=options)
        yield AIStreamChunk(
            text=result.text,
            model_id=result.model_id,
            session_id=result.session_id,
            final=True,
            source=result.source,
        )

    def _require_ready_model(self) -> str:
        if self._state is not EngineState.READY or not self.resolved_model_id:
            raise BackendUnavailableError("LlamaPi LLM engine is not loaded")
        return self.resolved_model_id

    def _request_json(
        self,
        method: str,
        path: str,
        payload: dict[str, Any] | None = None,
    ) -> dict[str, Any]:
        url = f"{self.base_url}{path}"
        body = None if payload is None else json.dumps(payload, ensure_ascii=False).encode("utf-8")
        request = Request(
            url,
            data=body,
            method=method,
            headers={"Accept": "application/json", "Content-Type": "application/json"},
        )
        try:
            with urlopen(request, timeout=self.timeout) as response:
                raw = response.read()
        except HTTPError as exc:
            raise BackendUnavailableError(
                f"LlamaPi HTTP {exc.code} for {path}",
                details={"status": int(exc.code), "path": path},
            ) from exc
        except (URLError, socket.timeout, TimeoutError, OSError) as exc:
            raise BackendUnavailableError(
                f"LlamaPi request failed for {path}: {exc}",
                details={"path": path},
            ) from exc
        try:
            decoded = json.loads(raw.decode("utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError) as exc:
            raise BackendUnavailableError(f"LlamaPi returned malformed JSON for {path}") from exc
        if not isinstance(decoded, dict):
            raise BackendUnavailableError(f"LlamaPi returned malformed JSON for {path}")
        return decoded
''',
)

# Runtime settings are resolved in the API process and explicitly forwarded to
# spawned workers. Child processes do not secretly re-read these values.
settings_path = "linux/backend/app/ai/settings.py"
replace_once(
    settings_path,
    "    llm_backend: str | None\n",
    "    llm_backend: str | None\n    llamapi_base_url: str\n    llamapi_model_hint: str\n",
)
replace_once(
    settings_path,
    "            llm_backend=os.getenv(\"LLM_BACKEND\"),\n",
    "            llm_backend=os.getenv(\"LLM_BACKEND\"),\n            llamapi_base_url=os.getenv(\"LLAMAPI_BASE_URL\", \"http://127.0.0.1:9265/v1\").strip().rstrip(\"/\"),\n            llamapi_model_hint=os.getenv(\"LLAMAPI_MODEL_HINT\", \"qwen3:4b\").strip(),\n",
)

worker_path = "linux/backend/app/ai/worker.py"
replace_once(
    worker_path,
    "from .engines.mock import MockASR, MockLLM, MockOCR\nfrom .engines.real import RealASREngine, RealLLMEngine, RealOCREngine\n",
    "from .engines.llamapi import LlamaPiLLMEngine\nfrom .engines.mock import MockASR, MockLLM, MockOCR\nfrom .engines.real import RealASREngine, RealLLMEngine, RealOCREngine\n",
)
replace_once(
    worker_path,
    '''def _make_engine(kind: str, mode: str, spec: ModelSpec, model_root: str):
    if mode == "mock":
        return {"llm": MockLLM, "asr": MockASR, "ocr": MockOCR}[kind](model_id=spec.model_id)
    model_dir = str((Path(model_root) / spec.path).resolve())
    return {"llm": RealLLMEngine, "asr": RealASREngine, "ocr": RealOCREngine}[kind](spec, model_dir)


def worker_main(conn: Connection, *, kind: str, mode: str, spec: ModelSpec, model_root: str) -> None:
''',
    '''def _make_engine(
    kind: str,
    mode: str,
    spec: ModelSpec,
    model_root: str,
    *,
    llamapi_base_url: str = "http://127.0.0.1:9265/v1",
    llamapi_model_hint: str = "qwen3:4b",
    request_timeout: float = 30.0,
):
    if mode == "mock":
        return {"llm": MockLLM, "asr": MockASR, "ocr": MockOCR}[kind](model_id=spec.model_id)
    if kind == "llm" and spec.backend.strip().lower() == "llamapi":
        return LlamaPiLLMEngine(
            spec,
            base_url=llamapi_base_url,
            model_hint=llamapi_model_hint,
            timeout=request_timeout,
        )
    model_dir = str((Path(model_root) / spec.path).resolve())
    return {"llm": RealLLMEngine, "asr": RealASREngine, "ocr": RealOCREngine}[kind](spec, model_dir)


def worker_main(
    conn: Connection,
    *,
    kind: str,
    mode: str,
    spec: ModelSpec,
    model_root: str,
    llamapi_base_url: str = "http://127.0.0.1:9265/v1",
    llamapi_model_hint: str = "qwen3:4b",
    request_timeout: float = 30.0,
) -> None:
''',
)
replace_once(
    worker_path,
    "        engine = _make_engine(kind, mode, spec, model_root)\n",
    "        engine = _make_engine(\n            kind,\n            mode,\n            spec,\n            model_root,\n            llamapi_base_url=llamapi_base_url,\n            llamapi_model_hint=llamapi_model_hint,\n            request_timeout=request_timeout,\n        )\n",
)

supervisor_path = "linux/backend/app/ai/supervisor.py"
replace_once(
    supervisor_path,
    "    def __init__(self, *, kind: str, spec: ModelSpec, registry: ModelRegistry, mode: str, timeout: float):\n",
    "    def __init__(self, *, kind: str, spec: ModelSpec, registry: ModelRegistry, mode: str, timeout: float, llamapi_base_url: str = \"http://127.0.0.1:9265/v1\", llamapi_model_hint: str = \"qwen3:4b\"):\n",
)
replace_once(
    supervisor_path,
    "        self.timeout = timeout\n        self.state = EngineState.STOPPED\n",
    "        self.timeout = timeout\n        self.llamapi_base_url = llamapi_base_url\n        self.llamapi_model_hint = llamapi_model_hint\n        self.state = EngineState.STOPPED\n",
)
replace_once(
    supervisor_path,
    "            process = ctx.Process(target=worker_main, kwargs={\"conn\": child_conn, \"kind\": self.kind, \"mode\": self.mode, \"spec\": self.spec, \"model_root\": str(self.registry.model_root)}, daemon=True, name=f\"ai-{self.kind}-worker\")\n",
    "            process = ctx.Process(target=worker_main, kwargs={\"conn\": child_conn, \"kind\": self.kind, \"mode\": self.mode, \"spec\": self.spec, \"model_root\": str(self.registry.model_root), \"llamapi_base_url\": self.llamapi_base_url, \"llamapi_model_hint\": self.llamapi_model_hint, \"request_timeout\": self.timeout}, daemon=True, name=f\"ai-{self.kind}-worker\")\n",
)
replace_once(
    supervisor_path,
    "    def __init__(self, registry: ModelRegistry, *, mode: str = \"mock\", request_timeout: float = 30.0, idle_unload_seconds: float = 300.0, memory_budget_mb: int = 6144, speech_socket: str | Path = \"/run/suspect-interrogation/speech.sock\", speaker_accept_threshold: float | None = None, speaker_margin: float | None = None, speech_client: Any | None = None):\n",
    "    def __init__(self, registry: ModelRegistry, *, mode: str = \"mock\", request_timeout: float = 30.0, idle_unload_seconds: float = 300.0, memory_budget_mb: int = 6144, speech_socket: str | Path = \"/run/suspect-interrogation/speech.sock\", speaker_accept_threshold: float | None = None, speaker_margin: float | None = None, speech_client: Any | None = None, llamapi_base_url: str = \"http://127.0.0.1:9265/v1\", llamapi_model_hint: str = \"qwen3:4b\"):\n",
)
replace_once(
    supervisor_path,
    "        self._workers = {kind: _Worker(kind=kind, spec=registry.default_for(kind), registry=registry, mode=mode, timeout=request_timeout) for kind in (\"asr\", \"ocr\", \"llm\") if self._has_kind(kind)}\n",
    "        self._workers = {kind: _Worker(kind=kind, spec=registry.default_for(kind), registry=registry, mode=mode, timeout=request_timeout, llamapi_base_url=llamapi_base_url, llamapi_model_hint=llamapi_model_hint) for kind in (\"asr\", \"ocr\", \"llm\") if self._has_kind(kind)}\n",
)

main_path = "linux/backend/app/main.py"
replace_once(
    main_path,
    "        speaker_accept_threshold=settings.speaker_effective_threshold,\n        speaker_margin=settings.speaker_margin,\n",
    "        speaker_accept_threshold=settings.speaker_effective_threshold,\n        speaker_margin=settings.speaker_margin,\n        llamapi_base_url=settings.llamapi_base_url,\n        llamapi_model_hint=settings.llamapi_model_hint,\n",
)

registry_path = "linux/backend/config/model-registry.yaml"
replace_once(
    registry_path,
    '''    "llm.default": {
      "kind": "llm",
      "backend": "rkllm",
      "path": "llm/default",
      "architecture": "qwen",
      "required_files": ["model.rkllm"],
      "device": "npu",
      "context": 4096,
      "memory_mb": 4096,
      "capabilities": ["generate", "stream", "cancel"]
    },
''',
    '''    "llm.default": {
      "kind": "llm",
      "backend": "llamapi",
      "path": "external/llamapi",
      "architecture": "qwen3",
      "required_files": [],
      "device": "npu",
      "context": 4096,
      "memory_mb": 4096,
      "capabilities": ["generate", "stream", "cancel"]
    },
''',
)

# Add an integration seam assertion to the RED adapter tests: selection must use
# explicit process parameters rather than environment lookups in the adapter.
test_path = "linux/backend/tests/test_llamapi_llm_engine.py"
replace_once(
    test_path,
    "from app.ai.types import EngineState\n",
    "from app.ai.types import EngineState\nfrom app.ai.worker import _make_engine\n",
)
replace_once(
    test_path,
    "def test_default_runtime_settings_keep_llamapi_on_loopback(monkeypatch):\n",
    '''def test_worker_factory_selects_llamapi_adapter_with_explicit_settings():
    engine = _make_engine(
        "llm",
        "real",
        llm_spec(),
        "/tmp/unused-model-root",
        llamapi_base_url="http://127.0.0.1:9999/v1",
        llamapi_model_hint="qwen3:4b",
        request_timeout=2.5,
    )
    assert isinstance(engine, LlamaPiLLMEngine)
    assert engine.base_url == "http://127.0.0.1:9999/v1"
    assert engine.model_hint == "qwen3:4b"
    assert engine.timeout == 2.5


def test_default_runtime_settings_keep_llamapi_on_loopback(monkeypatch):
''',
)
