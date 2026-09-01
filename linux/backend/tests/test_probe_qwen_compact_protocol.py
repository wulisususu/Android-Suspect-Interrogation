from __future__ import annotations

import importlib.util
import json
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[3]
SCRIPT = REPO_ROOT / "scripts" / "ci" / "probe-llamapi-qwen-routing.py"


def load_probe_module():
    spec = importlib.util.spec_from_file_location("probe_llamapi_qwen_routing_compact", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class CompactHandler(BaseHTTPRequestHandler):
    requests: list[dict] = []

    def log_message(self, *_args):
        return

    def do_POST(self):
        assert self.path == "/v1/chat/completions"
        length = int(self.headers.get("Content-Length", "0"))
        payload = json.loads(self.rfile.read(length))
        self.__class__.requests.append(payload)
        compact = {"c": "B", "t": "case-time", "a": "大概晚上八点十五分。"}
        body = json.dumps(
            {
                "model": "qwen3:4b@rk3588",
                "choices": [{"message": {"content": json.dumps(compact, ensure_ascii=False)}}],
                "usage": {"prompt_tokens": 240, "completion_tokens": 36, "total_tokens": 276},
            },
            ensure_ascii=False,
        ).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def test_compact_protocol_rehydrates_existing_route_and_uses_small_output_budget():
    probe = load_probe_module()
    CompactHandler.requests = []
    server = ThreadingHTTPServer(("127.0.0.1", 0), CompactHandler)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        decision, _latency_ms, telemetry = probe._complete(
            f"http://127.0.0.1:{server.server_port}/v1",
            "qwen3:4b@rk3588",
            "compact prompt",
            5.0,
            protocol="compact",
        )
    finally:
        server.shutdown()
        server.server_close()
        thread.join(timeout=2)

    assert decision == {
        "classification": "MATCH_EXISTING",
        "target_question_id": "case-time",
        "formal_question": None,
        "formal_answer": "大概晚上八点十五分。",
        "confidence": None,
        "candidate_question_ids": ["case-time"],
        "reason_code": "COMPACT_B",
    }
    assert telemetry["usage"]["completion_tokens"] == 36
    assert len(CompactHandler.requests) == 1
    request = CompactHandler.requests[0]
    assert request["enable_thinking"] is False
    assert request["max_tokens"] <= 96
