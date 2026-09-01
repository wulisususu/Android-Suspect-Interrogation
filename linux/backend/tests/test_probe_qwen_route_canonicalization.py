from __future__ import annotations

import importlib.util
import json
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[3]
SCRIPT = REPO_ROOT / "scripts" / "ci" / "probe-llamapi-qwen-routing.py"


def load_probe_module():
    spec = importlib.util.spec_from_file_location("probe_llamapi_qwen_routing_canonical", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class RealisticFourBHandler(BaseHTTPRequestHandler):
    requests: list[dict] = []
    decisions = [
        {
            "classification": "MATCH_EXISTING",
            "target_question_id": "fixed-why",
            "formal_question": "你因何事来公安机关？",
            "formal_answer": "昨天晚上和别人发生了一点冲突，今天派出所通知我过来。",
            "confidence": 0.95,
            "candidate_question_ids": ["fixed-why"],
            "reason_code": "MODEL_LABEL_MISMATCH",
        },
        {
            "classification": "MATCH_FIXED",
            "target_question_id": "case-time",
            "formal_question": "你什么时候到现场？",
            "formal_answer": "约20时到达现场。",
            "confidence": 0.95,
            "candidate_question_ids": ["case-time"],
            "reason_code": "MODEL_LABEL_MISMATCH",
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

    def log_message(self, *_args):
        return

    def do_GET(self):
        body = json.dumps({"data": [{"id": "qwen3:4b@rkllm-rk3588"}]}).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        length = int(self.headers.get("Content-Length", "0"))
        self.__class__.requests.append(json.loads(self.rfile.read(length)))
        decision = self.__class__.decisions[(len(self.__class__.requests) - 1) % 5]
        body = json.dumps(
            {
                "model": "qwen3:4b@rkllm-rk3588",
                "choices": [{"message": {"content": json.dumps(decision, ensure_ascii=False)}}],
            },
            ensure_ascii=False,
        ).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def test_probe_preserves_raw_model_output_but_validates_backend_effective_route(tmp_path, monkeypatch):
    probe = load_probe_module()
    RealisticFourBHandler.requests = []
    server = ThreadingHTTPServer(("127.0.0.1", 0), RealisticFourBHandler)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        monkeypatch.setenv("RUNNER_TEMP", str(tmp_path))
        output = tmp_path / "effective-route.json"
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
    a, b = report["cases"][:2]

    assert a["raw_decision"]["classification"] == "MATCH_EXISTING"
    assert a["raw_decision"]["formal_question"] == "你因何事来公安机关？"
    assert a["decision"]["classification"] == "MATCH_FIXED"
    assert a["decision"]["formal_question"] is None
    assert a["passed"] is True

    assert b["raw_decision"]["classification"] == "MATCH_FIXED"
    assert b["raw_decision"]["formal_question"] == "你什么时候到现场？"
    assert b["raw_decision"]["formal_answer"] == "约20时到达现场。"
    assert b["decision"]["classification"] == "MATCH_EXISTING"
    assert b["decision"]["formal_question"] is None
    assert b["decision"]["formal_answer"] == "大概晚上八点十五分。"
    assert b["decision"]["reason_code"] == "FACT_LOSS_RAW_FALLBACK"
    assert b["passed"] is True
