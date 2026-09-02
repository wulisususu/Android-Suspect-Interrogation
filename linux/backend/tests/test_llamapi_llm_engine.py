from __future__ import annotations

import json
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from typing import Any

import pytest

from app.ai.engines.llamapi import LlamaPiLLMEngine
from app.ai.errors import BackendUnavailableError
from app.ai.registry import ModelSpec
from app.ai.types import EngineState
from app.ai.worker import _make_engine


def llm_spec() -> ModelSpec:
    return ModelSpec(
        model_id="llm.default",
        kind="llm",
        backend="llamapi",
        path="external/llamapi",
        architecture="qwen3",
        required_files=(),
        device="npu",
        context=4096,
        memory_mb=4096,
        capabilities=("generate", "stream", "cancel"),
    )


class FakeLlamaPiServer:
    def __init__(self, *, models: list[dict[str, Any]], completion: dict[str, Any] | None = None):
        self.models = models
        self.completion = completion or {
            "id": "chatcmpl-test",
            "object": "chat.completion",
            "model": "qwen3:4b@rkllm-rk3588",
            "choices": [{"index": 0, "message": {"role": "assistant", "content": '{"classification":"IGNORE"}'}, "finish_reason": "stop"}],
        }
        self.requests: list[tuple[str, str, dict[str, Any] | None]] = []
        owner = self

        class Handler(BaseHTTPRequestHandler):
            def log_message(self, _format: str, *_args):
                return

            def _json(self, status: int, payload: dict[str, Any]):
                body = json.dumps(payload, ensure_ascii=False).encode("utf-8")
                self.send_response(status)
                self.send_header("Content-Type", "application/json")
                self.send_header("Content-Length", str(len(body)))
                self.end_headers()
                self.wfile.write(body)

            def do_GET(self):
                owner.requests.append(("GET", self.path, None))
                if self.path == "/v1/models":
                    self._json(200, {"object": "list", "data": owner.models})
                    return
                self._json(404, {"error": {"message": "not found"}})

            def do_POST(self):
                length = int(self.headers.get("Content-Length", "0"))
                raw = self.rfile.read(length) if length else b"{}"
                payload = json.loads(raw.decode("utf-8"))
                owner.requests.append(("POST", self.path, payload))
                if self.path == "/v1/chat/completions":
                    self._json(200, owner.completion)
                    return
                self._json(404, {"error": {"message": "not found"}})

        self.httpd = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
        self.thread = threading.Thread(target=self.httpd.serve_forever, daemon=True)

    @property
    def base_url(self) -> str:
        return f"http://127.0.0.1:{self.httpd.server_port}/v1"

    def __enter__(self):
        self.thread.start()
        return self

    def __exit__(self, *_exc):
        self.httpd.shutdown()
        self.thread.join(timeout=2)
        self.httpd.server_close()


def model(model_id: str, *, kind: str = "chat") -> dict[str, Any]:
    return {
        "id": model_id,
        "object": "model",
        "created": 0,
        "owned_by": "llamapi/rkllm",
        "platform": "rkllm/rk3588",
        "instance_count": 1,
        "model_kind": kind,
    }


def test_load_discovers_qwen3_variant_and_generate_uses_exact_resolved_id():
    with FakeLlamaPiServer(models=[model("qwen3:4b@rkllm-rk3588")]) as server:
        engine = LlamaPiLLMEngine(
            llm_spec(),
            base_url=server.base_url,
            model_hint="qwen3:4b",
            timeout=1.0,
        )
        engine.load()
        assert engine.health() is EngineState.READY
        assert engine.resolved_model_id == "qwen3:4b@rkllm-rk3588"

        result = engine.generate(
            "route this qa",
            session_id="route-1",
            options={"temperature": 0.1, "top_p": 0.8, "max_tokens": 512, "enable_thinking": False},
        )
        assert result.text == '{"classification":"IGNORE"}'
        assert result.model_id == "qwen3:4b@rkllm-rk3588"
        assert result.session_id == "route-1"

        assert server.requests[0] == ("GET", "/v1/models", None)
        method, path, payload = server.requests[1]
        assert method == "POST"
        assert path == "/v1/chat/completions"
        assert payload == {
            "model": "qwen3:4b@rkllm-rk3588",
            "messages": [{"role": "user", "content": "route this qa"}],
            "stream": False,
            "temperature": 0.1,
            "top_p": 0.8,
            "max_tokens": 512,
            "enable_thinking": False,
        }


def test_load_prefers_exact_model_id_over_platform_variant():
    with FakeLlamaPiServer(models=[model("qwen3:4b@rkllm-rk3588"), model("qwen3:4b")]) as server:
        engine = LlamaPiLLMEngine(llm_spec(), base_url=server.base_url, model_hint="qwen3:4b", timeout=1.0)
        engine.load()
        assert engine.resolved_model_id == "qwen3:4b"


def test_load_rejects_zero_or_ambiguous_qwen3_matches():
    with FakeLlamaPiServer(models=[model("other:4b@rkllm-rk3588")]) as server:
        engine = LlamaPiLLMEngine(llm_spec(), base_url=server.base_url, model_hint="qwen3:4b", timeout=1.0)
        with pytest.raises(BackendUnavailableError, match="qwen3:4b"):
            engine.load()

    with FakeLlamaPiServer(models=[model("qwen3:4b@rkllm-rk3588"), model("qwen3:4b@cpu")]) as server:
        engine = LlamaPiLLMEngine(llm_spec(), base_url=server.base_url, model_hint="qwen3:4b", timeout=1.0)
        with pytest.raises(BackendUnavailableError, match="ambiguous"):
            engine.load()


def test_load_ignores_non_chat_models_even_when_id_matches():
    with FakeLlamaPiServer(models=[model("qwen3:4b@rkllm-rk3588", kind="embedding")]) as server:
        engine = LlamaPiLLMEngine(llm_spec(), base_url=server.base_url, model_hint="qwen3:4b", timeout=1.0)
        with pytest.raises(BackendUnavailableError):
            engine.load()


def test_generate_rejects_malformed_response_and_stream_preserves_interface():
    malformed = {"object": "chat.completion", "model": "qwen3:4b@rkllm-rk3588", "choices": []}
    with FakeLlamaPiServer(models=[model("qwen3:4b@rkllm-rk3588")], completion=malformed) as server:
        engine = LlamaPiLLMEngine(llm_spec(), base_url=server.base_url, model_hint="qwen3:4b", timeout=1.0)
        engine.load()
        with pytest.raises(BackendUnavailableError, match="malformed"):
            engine.generate("x", session_id="bad")

    with FakeLlamaPiServer(models=[model("qwen3:4b@rkllm-rk3588")]) as server:
        engine = LlamaPiLLMEngine(llm_spec(), base_url=server.base_url, model_hint="qwen3:4b", timeout=1.0)
        engine.load()
        chunks = list(engine.stream("x", session_id="stream-1", options={"enable_thinking": False}))
        assert len(chunks) == 1
        assert chunks[0].final is True
        assert chunks[0].model_id == "qwen3:4b@rkllm-rk3588"


def test_worker_factory_selects_llamapi_adapter_with_explicit_settings():
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
    monkeypatch.delenv("LLAMAPI_BASE_URL", raising=False)
    monkeypatch.delenv("LLAMAPI_MODEL_HINT", raising=False)
    from app.ai.settings import AISettings

    settings = AISettings.from_env()
    assert settings.llamapi_base_url == "http://127.0.0.1:9265/v1"
    assert settings.llamapi_model_hint == "qwen3:4b"
