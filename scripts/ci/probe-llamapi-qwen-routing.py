#!/usr/bin/env python3
"""Read-only Qwen formal-record routing probe for the RK3588 LlamaPi runtime.

The probe only performs HTTP reads/inference against the configured local
OpenAI-compatible endpoint and writes JSON evidence inside GitHub Actions
runtime directories. It does not manage services or model files.
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import re
import socket
import sys
import time
from pathlib import Path
from typing import Any
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


DEFAULT_BASE_URL = "http://127.0.0.1:9265/v1"
DEFAULT_MODEL_HINT = "qwen3:4b"
EXPECTED_KEYS = {
    "classification",
    "target_question_id",
    "formal_question",
    "formal_answer",
    "confidence",
    "candidate_question_ids",
    "reason_code",
}
ROUTE_CLASSES = {
    "MATCH_FIXED",
    "MATCH_EXISTING",
    "CREATE_LIVE_FROM_SPEECH",
    "NEEDS_REVIEW",
    "IGNORE",
}
FENCED_JSON = re.compile(r"\A```(?:json)?\s*(\{.*\})\s*```\Z", re.DOTALL | re.IGNORECASE)

_CN_DIGITS = {
    "零": 0,
    "〇": 0,
    "一": 1,
    "二": 2,
    "两": 2,
    "三": 3,
    "四": 4,
    "五": 5,
    "六": 6,
    "七": 7,
    "八": 8,
    "九": 9,
}
_CN_NUMBER = r"[零〇一二两三四五六七八九十百]+"
_NUM_TOKEN = rf"(?:\d+(?:\.\d+)?|{_CN_NUMBER})"
_TIME_RE = re.compile(
    rf"(?P<daypart>凌晨|清晨|早上|上午|中午|下午|傍晚|晚上|夜里|夜间)?\s*"
    rf"(?P<hour>{_NUM_TOKEN})\s*(?:点|时)"
    rf"(?:(?P<minute>{_NUM_TOKEN})\s*分?)?"
)
_COLON_TIME_RE = re.compile(r"(?<!\d)(?P<hour>\d{1,2})\s*[:：]\s*(?P<minute>\d{1,2})(?!\d)")
_QUANTITY_RE = re.compile(
    rf"(?P<number>{_NUM_TOKEN})\s*(?:个)?(?P<unit>人|次|辆|件|元|岁|米|公里|天|年|月|日)"
)


class ProbeError(RuntimeError):
    pass


def safe_output_path(raw: str) -> Path:
    output = Path(raw).expanduser().resolve()
    allowed_roots: list[Path] = []
    for name in ("GITHUB_WORKSPACE", "RUNNER_TEMP"):
        value = os.environ.get(name)
        if value:
            allowed_roots.append(Path(value).expanduser().resolve())
    if not allowed_roots:
        raise ValueError("GITHUB_WORKSPACE or RUNNER_TEMP is required for an allowed runtime directory")
    if not any(output == root or root in output.parents for root in allowed_roots):
        roots = ", ".join(str(root) for root in allowed_roots)
        raise ValueError(f"output must be inside an allowed runtime directory: {roots}")
    return output


def resolve_model_id(model_ids: list[str], hint: str) -> str:
    clean_hint = str(hint or "").strip()
    clean_ids = [str(item).strip() for item in model_ids if str(item).strip()]
    if not clean_hint:
        raise ProbeError("model hint is empty")
    if clean_hint in clean_ids:
        return clean_hint
    matches = [item for item in clean_ids if item.startswith(clean_hint + "@")]
    if not matches:
        raise ProbeError(f"no model matches hint {clean_hint!r}")
    if len(matches) != 1:
        raise ProbeError(f"ambiguous model hint {clean_hint!r}: {matches}")
    return matches[0]


def _json_request(method: str, url: str, *, payload: dict[str, Any] | None, timeout: float) -> dict[str, Any]:
    data = None
    headers = {"Accept": "application/json", "User-Agent": "suspect-interrogation-qwen-probe/1"}
    if payload is not None:
        data = json.dumps(payload, ensure_ascii=False).encode("utf-8")
        headers["Content-Type"] = "application/json"
    request = Request(url, data=data, headers=headers, method=method)
    try:
        with urlopen(request, timeout=timeout) as response:
            raw = response.read().decode("utf-8")
    except HTTPError as exc:
        raise ProbeError(f"HTTP {exc.code} from {url}") from exc
    except (URLError, TimeoutError, socket.timeout, OSError) as exc:
        raise ProbeError(f"request failed for {url}: {type(exc).__name__}: {exc}") from exc
    try:
        parsed = json.loads(raw)
    except json.JSONDecodeError as exc:
        raise ProbeError(f"malformed JSON from {url}") from exc
    if not isinstance(parsed, dict):
        raise ProbeError(f"JSON object required from {url}")
    return parsed


def _parse_decision(raw: str) -> dict[str, Any]:
    text = str(raw or "").strip()
    if text.startswith("```"):
        match = FENCED_JSON.fullmatch(text)
        if match is None:
            raise ProbeError("invalid fenced JSON model output")
        text = match.group(1)
    elif not (text.startswith("{") and text.endswith("}")):
        raise ProbeError("model output must be JSON only")
    try:
        payload = json.loads(text)
    except json.JSONDecodeError as exc:
        raise ProbeError("model output is not valid JSON") from exc
    if not isinstance(payload, dict) or set(payload) != EXPECTED_KEYS:
        raise ProbeError("model output shape mismatch")
    classification = payload["classification"]
    if classification not in ROUTE_CLASSES:
        raise ProbeError(f"invalid classification: {classification!r}")
    target = payload["target_question_id"]
    if target is not None and not isinstance(target, str):
        raise ProbeError("target_question_id must be string or null")
    for field in ("formal_question", "formal_answer"):
        if payload[field] is not None and not isinstance(payload[field], str):
            raise ProbeError(f"{field} must be string or null")
    confidence = payload["confidence"]
    if confidence is not None:
        if isinstance(confidence, bool) or not isinstance(confidence, (int, float)):
            raise ProbeError("confidence must be numeric or null")
        if not 0.0 <= float(confidence) <= 1.0:
            raise ProbeError("confidence out of range")
    candidates = payload["candidate_question_ids"]
    if not isinstance(candidates, list) or not all(isinstance(item, str) for item in candidates):
        raise ProbeError("candidate_question_ids must be a string array")
    if not isinstance(payload["reason_code"], str) or not payload["reason_code"].strip():
        raise ProbeError("reason_code is required")
    return payload


def _parse_number(token: str) -> float | None:
    clean = str(token or "").strip()
    if not clean:
        return None
    try:
        return float(clean)
    except ValueError:
        pass
    if "百" in clean:
        left, right = clean.split("百", 1)
        hundreds = _CN_DIGITS.get(left[-1], 1) if left else 1
        tail = _parse_number(right) if right else 0
        return float(hundreds * 100 + (tail or 0))
    if "十" in clean:
        left, right = clean.split("十", 1)
        tens = _CN_DIGITS.get(left[-1], 1) if left else 1
        ones = _CN_DIGITS.get(right[0], 0) if right else 0
        return float(tens * 10 + ones)
    if all(char in _CN_DIGITS for char in clean):
        value = 0
        for char in clean:
            value = value * 10 + _CN_DIGITS[char]
        return float(value)
    return None


def _normalize_hour(hour: int, daypart: str | None) -> int:
    if daypart in {"下午", "傍晚", "晚上", "夜里", "夜间"} and 1 <= hour < 12:
        return hour + 12
    if daypart == "中午" and 1 <= hour <= 5:
        return hour + 12
    return hour


def _time_facts(text: str) -> set[tuple[int, int | None]]:
    value = str(text or "")
    facts: set[tuple[int, int | None]] = set()
    for match in _COLON_TIME_RE.finditer(value):
        hour = int(match.group("hour"))
        minute = int(match.group("minute"))
        if 0 <= hour <= 23 and 0 <= minute <= 59:
            facts.add((hour, minute))
    for match in _TIME_RE.finditer(value):
        raw_hour = _parse_number(match.group("hour"))
        if raw_hour is None or not raw_hour.is_integer():
            continue
        hour = _normalize_hour(int(raw_hour), match.group("daypart"))
        raw_minute = match.group("minute")
        minute: int | None = None
        if raw_minute:
            parsed_minute = _parse_number(raw_minute)
            if parsed_minute is None or not parsed_minute.is_integer():
                continue
            minute = int(parsed_minute)
        if 0 <= hour <= 23 and (minute is None or 0 <= minute <= 59):
            facts.add((hour, minute))
    return facts


def _quantity_facts(text: str) -> set[tuple[float, str]]:
    facts: set[tuple[float, str]] = set()
    for match in _QUANTITY_RE.finditer(str(text or "")):
        number = _parse_number(match.group("number"))
        if number is not None:
            facts.add((number, match.group("unit")))
    return facts


def _explicit_facts_preserved(raw_answer: str, formal_answer: str) -> bool:
    return _time_facts(raw_answer).issubset(_time_facts(formal_answer)) and _quantity_facts(raw_answer).issubset(
        _quantity_facts(formal_answer)
    )


def _contains_any(text: str | None, alternatives: tuple[str, ...]) -> bool:
    value = str(text or "")
    return any(item in value for item in alternatives)


def _require_facts(text: str | None, groups: tuple[tuple[str, ...], ...], label: str) -> None:
    missing = ["|".join(group) for group in groups if not _contains_any(text, group)]
    if missing:
        raise ProbeError(f"{label} lost required fact anchors: {missing}")


def _validate_case(case: dict[str, Any], decision: dict[str, Any]) -> None:
    expected = case["expected_classification"]
    if decision["classification"] != expected:
        raise ProbeError(f"expected {expected}, got {decision['classification']}")
    expected_target = case.get("expected_target")
    if decision["target_question_id"] != expected_target:
        raise ProbeError(f"expected target {expected_target!r}, got {decision['target_question_id']!r}")
    classification = decision["classification"]
    if classification in {"MATCH_FIXED", "MATCH_EXISTING"}:
        if decision["formal_question"] is not None:
            raise ProbeError("existing-question route must preserve the formal question text")
        if not str(decision["formal_answer"] or "").strip():
            raise ProbeError("existing-question route requires a formal answer")
        _require_facts(decision["formal_answer"], case["answer_fact_groups"], "formal answer")
    elif classification == "CREATE_LIVE_FROM_SPEECH":
        if decision["target_question_id"] is not None:
            raise ProbeError("new LIVE question must not target an existing question")
        if not str(decision["formal_question"] or "").strip() or not str(decision["formal_answer"] or "").strip():
            raise ProbeError("new LIVE route requires formal question and answer")
        _require_facts(decision["formal_question"], case["question_fact_groups"], "formal question")
        _require_facts(decision["formal_answer"], case["answer_fact_groups"], "formal answer")
    elif classification == "NEEDS_REVIEW":
        if decision["formal_question"] is not None or decision["formal_answer"] is not None:
            raise ProbeError("ambiguous route must not manufacture formal text")
        allowed = set(case.get("allowed_candidates", ()))
        returned = set(decision["candidate_question_ids"])
        if allowed and (not returned or not returned.issubset(allowed)):
            raise ProbeError(f"unexpected review candidates: {sorted(returned)}")
    elif classification == "IGNORE":
        if any(value is not None for value in (decision["target_question_id"], decision["formal_question"], decision["formal_answer"])):
            raise ProbeError("ignored operational chatter must not produce formal content")


def _formal_questions() -> list[dict[str, Any]]:
    return [
        {
            "id": "fixed-why",
            "text": "你因何事来公安机关？",
            "source": "FIXED",
            "section": "OPENING",
            "locked": True,
            "formalAnswerText": None,
        },
        {
            "id": "case-time",
            "text": "你什么时候到现场？",
            "source": "CASE",
            "section": "BODY",
            "locked": False,
            "formalAnswerText": "约20时到达现场。",
        },
        {
            "id": "case-leave",
            "text": "你什么时候离开现场？",
            "source": "CASE",
            "section": "BODY",
            "locked": False,
            "formalAnswerText": None,
        },
    ]


def _canonicalize_existing_target_decision(decision: dict[str, Any], *, raw_answer: str | None) -> dict[str, Any]:
    """Mirror production existing-target authority and explicit-fact fallback."""

    effective = dict(decision)
    if decision["classification"] not in {"MATCH_FIXED", "MATCH_EXISTING"}:
        return effective
    target_id = decision.get("target_question_id")
    formal_answer = str(decision.get("formal_answer") or "").strip()
    if not target_id or not formal_answer:
        return effective
    target = next((row for row in _formal_questions() if row["id"] == target_id), None)
    if target is None:
        return effective
    if bool(target.get("locked")):
        effective["classification"] = "MATCH_FIXED"
    elif target.get("source") in {"CASE", "LIVE"}:
        effective["classification"] = "MATCH_EXISTING"
    else:
        return effective
    effective["formal_question"] = None
    raw = str(raw_answer or "").strip()
    if raw and not _explicit_facts_preserved(raw, formal_answer):
        effective["formal_answer"] = raw
        effective["reason_code"] = "FACT_LOSS_RAW_FALLBACK"
    return effective


def _cases() -> list[dict[str, Any]]:
    return [
        {
            "case": "A",
            "expected_classification": "MATCH_FIXED",
            "expected_target": "fixed-why",
            "question": "今天为什么过来的？",
            "answer": "昨天晚上和别人发生了一点冲突，今天派出所通知我过来。",
            "answer_fact_groups": (("昨天晚上", "昨晚"), ("冲突",), ("通知",)),
            "previous": [],
        },
        {
            "case": "B",
            "expected_classification": "MATCH_EXISTING",
            "expected_target": "case-time",
            "question": "那你准确几点到现场的？",
            "answer": "大概晚上八点十五分。",
            "answer_fact_groups": (("八点十五", "20时15", "20:15"),),
            "previous": [
                {
                    "id": "prev-time",
                    "question": "你什么时候到现场？",
                    "answer": "大概晚上八点。",
                    "classification": "MATCH_EXISTING",
                    "targetQuestionId": "case-time",
                }
            ],
        },
        {
            "case": "C",
            "expected_classification": "CREATE_LIVE_FROM_SPEECH",
            "expected_target": None,
            "question": "你离开以后有没有又回来？",
            "answer": "回来过一次，手机落里面了。",
            "question_fact_groups": (("离开",), ("回来", "返回")),
            "answer_fact_groups": (("回来", "返回"), ("一次", "1次"), ("手机",)),
            "previous": [],
        },
        {
            "case": "D",
            "expected_classification": "NEEDS_REVIEW",
            "expected_target": None,
            "question": "那个时间你再说准确一点。",
            "answer": "大概八点多。",
            "allowed_candidates": ("case-time", "case-leave"),
            "previous": [
                {
                    "id": "prev-leave",
                    "question": "你什么时候离开现场？",
                    "answer": "八点多。",
                    "classification": "MATCH_EXISTING",
                    "targetQuestionId": "case-leave",
                },
                {
                    "id": "prev-time-2",
                    "question": "你什么时候到现场？",
                    "answer": "八点左右。",
                    "classification": "MATCH_EXISTING",
                    "targetQuestionId": "case-time",
                },
            ],
        },
        {
            "case": "E",
            "expected_classification": "IGNORE",
            "expected_target": None,
            "question": "声音大一点。",
            "answer": "好。",
            "previous": [],
        },
    ]


def _prompt(case: dict[str, Any]) -> str:
    context = {
        "qaUnit": {
            "id": f"probe-{case['case'].lower()}",
            "rawQuestion": case["question"],
            "rawAnswer": case["answer"],
            "startedAt": "2026-09-01T00:00:00+00:00",
            "endedAt": "2026-09-01T00:00:02+00:00",
            "fragments": [
                {"id": "q", "role": "QUESTION", "speaker": "INTERROGATOR", "text": case["question"]},
                {"id": "a", "role": "ANSWER", "speaker": "SUSPECT", "text": case["answer"]},
            ],
        },
        "previousQaUnits": case.get("previous", []),
        "formalQuestions": _formal_questions(),
        "recentTargetQuestionId": case.get("previous", [{}])[-1].get("targetQuestionId") if case.get("previous") else None,
    }
    context_json = json.dumps(context, ensure_ascii=False, separators=(",", ":"))
    return f"""你是完全离线运行的正式询问笔录问答归档路由器。
只能根据真实 ASR 问答事实进行分类、匹配和忠实书面化，禁止补充不存在的人名、时间、地点、数量、动机、因果或确定性。存在歧义、冲突或对应关系不可靠时必须选择 NEEDS_REVIEW。
分类只能为 MATCH_FIXED、MATCH_EXISTING、CREATE_LIVE_FROM_SPEECH、NEEDS_REVIEW、IGNORE 之一。
MATCH_FIXED/MATCH_EXISTING 必须保留已有正式问题原文，只返回合并后的完整 formal_answer。CREATE_LIVE_FROM_SPEECH 只允许轻度书面化真实民警问题。IGNORE 不得产生正式内容。
禁止输出思考过程或解释，只输出严格 JSON，且字段只能是 classification、target_question_id、formal_question、formal_answer、confidence、candidate_question_ids、reason_code。
输入上下文 JSON：
{context_json}
"""


def _model_ids(base_url: str, timeout: float) -> list[str]:
    payload = _json_request("GET", base_url.rstrip("/") + "/models", payload=None, timeout=timeout)
    rows = payload.get("data")
    if not isinstance(rows, list):
        raise ProbeError("/models response must contain data array")
    ids = [row.get("id") for row in rows if isinstance(row, dict)]
    return [str(item) for item in ids if isinstance(item, str) and item.strip()]


def _complete(base_url: str, model_id: str, prompt: str, timeout: float) -> tuple[dict[str, Any], float]:
    request_payload = {
        "model": model_id,
        "messages": [{"role": "user", "content": prompt}],
        "stream": False,
        "temperature": 0.1,
        "top_p": 0.8,
        "max_tokens": 512,
        "enable_thinking": False,
    }
    started = time.perf_counter()
    response = _json_request("POST", base_url.rstrip("/") + "/chat/completions", payload=request_payload, timeout=timeout)
    elapsed_ms = (time.perf_counter() - started) * 1000.0
    choices = response.get("choices")
    if not isinstance(choices, list) or not choices or not isinstance(choices[0], dict):
        raise ProbeError("chat completion response has no first choice")
    message = choices[0].get("message")
    if not isinstance(message, dict) or not isinstance(message.get("content"), str):
        raise ProbeError("chat completion response has no message content")
    return _parse_decision(message["content"]), elapsed_ms


def _percentile(values: list[float], quantile: float) -> float:
    if not values:
        raise ValueError("percentile requires at least one value")
    ordered = sorted(float(value) for value in values)
    if len(ordered) == 1:
        return ordered[0]
    position = (len(ordered) - 1) * float(quantile)
    lower = int(position)
    upper = min(lower + 1, len(ordered) - 1)
    fraction = position - lower
    return ordered[lower] + (ordered[upper] - ordered[lower]) * fraction


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Read-only LlamaPi Qwen formal-routing acceptance probe")
    parser.add_argument("--base-url", default=os.environ.get("LLAMAPI_BASE_URL", DEFAULT_BASE_URL), help="OpenAI-compatible LlamaPi base URL")
    parser.add_argument("--model-hint", default=os.environ.get("LLAMAPI_MODEL_HINT", DEFAULT_MODEL_HINT), help="Exact model ID or qwen3:4b base hint")
    parser.add_argument("--output", required=True, help="JSON result path under GITHUB_WORKSPACE or RUNNER_TEMP")
    parser.add_argument("--timeout", type=float, default=60.0, help="HTTP timeout seconds per request")
    parser.add_argument("--repetitions", type=int, default=1, help="Number of A/B/C/D/E cycles; use 4 for the 20-request RK3588 acceptance sample")
    args = parser.parse_args(argv)
    if args.timeout <= 0:
        raise ValueError("--timeout must be positive")
    if args.repetitions <= 0:
        raise ValueError("--repetitions must be positive")
    output = safe_output_path(args.output)
    base_url = str(args.base_url).rstrip("/")
    if not base_url:
        raise ProbeError("base URL is empty")

    report: dict[str, Any] = {
        "success": False,
        "base_url": base_url,
        "model_hint": args.model_hint,
        "model_id": None,
        "host": socket.gethostname(),
        "machine": platform.machine(),
        "python": sys.version.split()[0],
        "repetitions": args.repetitions,
        "cases": [],
        "samples": [],
        "latency_ms": {"count": 0, "p50": None, "p95": None, "max": None},
    }
    try:
        model_id = resolve_model_id(_model_ids(base_url, args.timeout), args.model_hint)
        report["model_id"] = model_id
        latency_values: list[float] = []
        cases = _cases()
        for iteration in range(1, args.repetitions + 1):
            for case in cases:
                row: dict[str, Any] = {"case": case["case"], "iteration": iteration, "passed": False}
                try:
                    raw_decision, latency_ms = _complete(base_url, model_id, _prompt(case), args.timeout)
                    decision = _canonicalize_existing_target_decision(raw_decision, raw_answer=case.get("answer"))
                    rounded_latency = round(latency_ms, 3)
                    row["latency_ms"] = rounded_latency
                    latency_values.append(rounded_latency)
                    row["raw_decision"] = raw_decision
                    row["classification"] = decision["classification"]
                    row["decision"] = decision
                    _validate_case(case, decision)
                    row["passed"] = True
                except Exception as exc:
                    row["error"] = f"{type(exc).__name__}: {exc}"
                report["samples"].append(row)
                if iteration == 1:
                    report["cases"].append(row)
        if latency_values:
            report["latency_ms"] = {
                "count": len(latency_values),
                "p50": round(_percentile(latency_values, 0.50), 3),
                "p95": round(_percentile(latency_values, 0.95), 3),
                "max": round(max(latency_values), 3),
            }
        expected_samples = args.repetitions * len(cases)
        report["success"] = len(report["samples"]) == expected_samples and all(row["passed"] for row in report["samples"])
    except Exception as exc:
        report["error"] = f"{type(exc).__name__}: {exc}"

    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if report["success"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
