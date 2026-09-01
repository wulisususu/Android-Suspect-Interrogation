from __future__ import annotations

import importlib.util
import json
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

import pytest


REPO_ROOT = Path(__file__).resolve().parents[3]
SCRIPT = REPO_ROOT / "scripts" / "ci" / "probe-llamapi-qwen-routing.py"


def load_probe_module():
    assert SCRIPT.is_file(), "RK3588 Qwen routing probe script is missing"
    spec = importlib.util.spec_from_file_location("probe_llamapi_qwen_routing", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class FakeLlamaPiHandler(BaseHTTPRequestHandler):
    decisions = [
        {
            "classification": "MATCH_FIXED",
            "target_question_id": "fixed-why",
            "formal_question": None,
            "formal_answer": "昨天晚上和别人发生了一点冲突，今天派出所通知我过来。",
            "confidence": 0.98,
            "candidate_question_ids": [],
            "reason_code": "SEMANTIC_MATCH",
        },
        {
            "classification": "MATCH_EXISTING",
            "target_question_id": "case-time",
            "formal_question": None,
            "formal_answer": "约20时15分到达现场。",
            "confidence": 0.95,
            "candidate_question_ids": [],
            "reason_code": "FOLLOW_UP_MATCH",
        },
        {
            "classification": "CREATE_LIVE_FROM_SPEECH",
            "target_question_id": None,
            "formal_question": "你离开现场后是否再次返回？",
            "formal_answer": "返回过一次，因为手机遗留在现场。",
            "confidence": 0.96,
            "candidate_question_ids": [],
            "reason_code": "NEW_SPOKEN_QUESTION",
        },
        {
            "classification": "NEEDS_REVIEW",
            "target_question_id": None,
            "formal_question": None,
            "formal_answer": None,
            "confidence": 0.55,
            "candidate_question_ids": ["case-time", "case-leave"],
            "reason_code": "AMBIGUOUS_REFERENCE",
        },
        {
            "classification": "IGNORE",
            "target_question_id": None,
            "formal_question": None,
            "formal_answer": None,
            "confidence": 0.99,
            "candidate_question_ids": [],
            "reason_code": "OPERATIONAL_CHATTER",
        },
    ]
    requests: list[dict] = []

    def log_message(self, *_args):
        return

    def do_GET(self):
        if self.path != "/v1/models":
            self.send_error(404)
            return
        body = json.dumps({"data": [{"id": "qwen3:4b@rk3588"}]}).encode()
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
        decision = self.__class__.decisions[len(self.__class__.requests) - 1]
        body = json.dumps(
            {
                "model": "qwen3:4b@rk3588",
                "choices": [{"message": {"content": json.dumps(decision, ensure_ascii=False)}}],
            },
            ensure_ascii=False,
        ).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def test_probe_runs_all_five_classes_with_thinking_disabled(tmp_path, monkeypatch):
    probe = load_probe_module()
    FakeLlamaPiHandler.requests = []
    server = ThreadingHTTPServer(("127.0.0.1", 0), FakeLlamaPiHandler)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        monkeypatch.setenv("GITHUB_WORKSPACE", str(tmp_path))
        output = tmp_path / "qwen-routing-probe.json"
        rc = probe.main(
            [
                "--base-url",
                f"http://127.0.0.1:{server.server_port}/v1",
                "--model-hint",
                "qwen3:4b",
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
    assert report["model_id"] == "qwen3:4b@rk3588"
    assert [row["case"] for row in report["cases"]] == ["A", "B", "C", "D", "E"]
    assert [row["classification"] for row in report["cases"]] == [
        "MATCH_FIXED",
        "MATCH_EXISTING",
        "CREATE_LIVE_FROM_SPEECH",
        "NEEDS_REVIEW",
        "IGNORE",
    ]
    assert all(row["passed"] for row in report["cases"])
    assert all(isinstance(row["latency_ms"], (int, float)) and row["latency_ms"] >= 0 for row in report["cases"])

    assert len(FakeLlamaPiHandler.requests) == 5
    for request in FakeLlamaPiHandler.requests:
        assert request["model"] == "qwen3:4b@rk3588"
        assert request["stream"] is False
        assert request["enable_thinking"] is False
        assert request["temperature"] <= 0.2


def test_probe_rejects_ambiguous_model_and_unsafe_output(tmp_path, monkeypatch):
    probe = load_probe_module()
    with pytest.raises(probe.ProbeError, match="ambiguous"):
        probe.resolve_model_id(["qwen3:4b@rk3588", "qwen3:4b@cpu"], "qwen3:4b")

    monkeypatch.setenv("GITHUB_WORKSPACE", str(tmp_path / "workspace"))
    (tmp_path / "workspace").mkdir()
    with pytest.raises(ValueError, match="allowed runtime directory"):
        probe.safe_output_path(str(tmp_path / "outside.json"))


def test_probe_source_is_read_only_and_never_targets_unrelated_port_8000():
    assert SCRIPT.is_file(), "RK3588 Qwen routing probe script is missing"
    source = SCRIPT.read_text(encoding="utf-8").lower()
    assert "http://127.0.0.1:9265/v1" in source
    for forbidden in (
        "systemctl restart",
        "systemctl stop",
        ":8000",
        "pip install",
        "wget ",
        "curl ",
        "subprocess.",
    ):
        assert forbidden not in source
