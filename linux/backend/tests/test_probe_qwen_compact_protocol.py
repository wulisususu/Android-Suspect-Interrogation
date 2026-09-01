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


class CompactMainHandler(BaseHTTPRequestHandler):
    requests: list[dict] = []
    decisions = [
        {"c": "A", "t": "fixed-why", "a": "昨天晚上和别人发生了一点冲突，今天派出所通知我过来。"},
        {"c": "B", "t": "case-time", "a": "大概晚上八点十五分。"},
        {"c": "C", "q": "你离开以后有没有又回来？", "a": "回来过一次，手机落里面了。"},
    ]

    def log_message(self, *_args):
        return

    def do_GET(self):
        if self.path != "/v1/models":
            self.send_error(404)
            return
        body = json.dumps({"data": [{"id": "qwen3:4b@rk3588"}]}).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        if self.path != "/v1/chat/completions":
            self.send_error(404)
            return
        length = int(self.headers.get("Content-Length", "0"))
        payload = json.loads(self.rfile.read(length))
        self.__class__.requests.append(payload)
        index = len(self.__class__.requests) - 1
        decision = self.__class__.decisions[index]
        body = json.dumps(
            {
                "model": "qwen3:4b@rk3588",
                "choices": [{"message": {"content": json.dumps(decision, ensure_ascii=False)}}],
                "usage": {"prompt_tokens": 300, "completion_tokens": 40, "total_tokens": 340},
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


def test_probe_cli_compact_protocol_keeps_safety_context_and_reports_protocol(tmp_path, monkeypatch):
    probe = load_probe_module()
    CompactMainHandler.requests = []
    server = ThreadingHTTPServer(("127.0.0.1", 0), CompactMainHandler)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        monkeypatch.setenv("GITHUB_WORKSPACE", str(tmp_path))
        output = tmp_path / "compact-probe.json"
        rc = probe.main(
            [
                "--base-url",
                f"http://127.0.0.1:{server.server_port}/v1",
                "--model-hint",
                "qwen3:4b",
                "--protocol",
                "compact",
                "--output",
                str(output),
            ]
        )
    finally:
        server.shutdown()
        server.server_close()
        thread.join(timeout=2)

    assert rc == 0
    report = json.loads(output.read_text(encoding="utf-8"))
    assert report["success"] is True
    assert report["protocol"] == "compact"
    assert report["effective_decision_count"] == 5
    assert report["model_inference_count"] == 3
    assert [row["classification"] for row in report["cases"]] == [
        "MATCH_FIXED",
        "MATCH_EXISTING",
        "CREATE_LIVE_FROM_SPEECH",
        "NEEDS_REVIEW",
        "IGNORE",
    ]

    assert len(CompactMainHandler.requests) == 3
    for request in CompactMainHandler.requests:
        assert request["enable_thinking"] is False
        assert request["max_tokens"] <= 96
        prompt = request["messages"][0]["content"]
        assert "禁止补充" in prompt
        assert "输入上下文 JSON" in prompt
        assert "candidate_question_ids" not in prompt
        assert '"c"' in prompt

    compact_prompt = probe._prompt(probe._cases()[0], protocol="compact")
    full_prompt = probe._prompt(probe._cases()[0], protocol="full")
    assert len(compact_prompt) < len(full_prompt)
