from __future__ import annotations

import importlib.util
import json
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[3]
PROBE_SCRIPT = REPO_ROOT / "scripts" / "ci" / "probe-llamapi-qwen-routing.py"
MEMORY_SCRIPT = REPO_ROOT / "scripts" / "ci" / "sample-process-memory.py"
WORKFLOW = REPO_ROOT / ".github" / "workflows" / "rk3588-qwen-formal-routing-acceptance.yml"


def _load(path: Path, name: str):
    assert path.is_file(), f"missing required script: {path}"
    spec = importlib.util.spec_from_file_location(name, path)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_probe_records_prompt_response_and_usage_telemetry(monkeypatch):
    probe = _load(PROBE_SCRIPT, "qwen_probe_runtime_metrics")
    decision = {
        "classification": "MATCH_FIXED",
        "target_question_id": "fixed-why",
        "formal_question": None,
        "formal_answer": "配合调查。",
        "confidence": 0.98,
        "candidate_question_ids": [],
        "reason_code": "SEMANTIC_MATCH",
    }
    content = json.dumps(decision, ensure_ascii=False)

    def fake_request(_method, _url, *, payload, timeout):
        assert payload["max_tokens"] == 192
        assert timeout == 12.0
        return {
            "choices": [{"message": {"content": content}}],
            "usage": {
                "prompt_tokens": 123,
                "completion_tokens": 45,
                "total_tokens": 168,
            },
        }

    monkeypatch.setattr(probe, "_json_request", fake_request)
    parsed, latency_ms, telemetry = probe._complete(
        "http://127.0.0.1:9265/v1",
        "qwen3:4b@rkllm-rk3588",
        "测试 prompt",
        12.0,
    )

    assert parsed == decision
    assert latency_ms >= 0
    assert telemetry["prompt_chars"] == len("测试 prompt")
    assert telemetry["response_chars"] == len(content)
    assert telemetry["usage"] == {
        "prompt_tokens": 123,
        "completion_tokens": 45,
        "total_tokens": 168,
    }


def test_memory_sampler_parses_proc_rss_and_cgroup_bytes():
    sampler = _load(MEMORY_SCRIPT, "qwen_process_memory_sampler")
    status = "Name:\tllamapi-server\nVmSize:\t9000000 kB\nVmRSS:\t7340032 kB\nThreads:\t8\n"
    assert sampler.parse_proc_status_kb(status) == 7_340_032
    assert sampler.parse_proc_status_kb("Name:\ttest\n") is None
    assert sampler.parse_cgroup_bytes_to_kb("7516192768\n") == 7_340_032
    assert sampler.parse_cgroup_bytes_to_kb("max\n") is None


def test_final_rk3588_workflow_runs_twenty_decisions_and_reliable_memory_sampler():
    source = WORKFLOW.read_text(encoding="utf-8")
    assert "--repetitions 4" in source
    assert "sample-process-memory.py" in source
    assert "ps -o rss=" not in source
    assert "llamapi_peak_process_rss_kb" in source
    assert "llamapi_peak_cgroup_memory_kb" in source
    assert "semantic-final-20" in source
