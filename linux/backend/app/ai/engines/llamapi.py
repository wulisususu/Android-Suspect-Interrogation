from __future__ import annotations

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
