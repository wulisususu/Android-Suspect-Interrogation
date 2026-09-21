"""Dev-only LLM judge for the solo-testing BOT interrogator.

This endpoint exists purely for the test rig where one person plays both roles.
It is never part of the offline production interrogation flow; production must
not depend on any cloud LLM.
"""

from __future__ import annotations

import json
import os
from typing import Any

import httpx
from fastapi import APIRouter, Request
from pydantic import BaseModel, Field

from app.api.responses import envelope
from app.domain.errors import DomainError
from app.repositories import cases as case_repo
from app.repositories import facts as fact_repo


router = APIRouter(tags=["dev-bot"])

_DEEPSEEK_URL = "https://api.deepseek.com/chat/completions"
_DEEPSEEK_MODEL = "deepseek-chat"


class BotJudgeRequest(BaseModel):
    question: str = Field(min_length=1, max_length=2000)
    reply: str = Field(default="", max_length=4000)


def _api_key() -> str:
    return os.environ.get("DEV_LLM_API_KEY", "")


def _build_messages(question: str, reply: str) -> list[dict[str, str]]:
    system = (
        "你是审讯测试台的判定器。给定民警的问题和被讯问人的回复文本，"
        "判断回复是否构成对问题的有效回答（简短、口语化也算，只要语义相关且非纯寒暄）。"
        '只输出一个 JSON 对象：{"is_answer": true/false, "reason": "一句话理由"}'
    )
    user = f"问题：{question}\n回复：{reply.strip() or '（无文字）'}"
    return [
        {"role": "system", "content": system},
        {"role": "user", "content": user},
    ]


async def _post_messages(messages: list[dict[str, str]], *, temperature: float, max_tokens: int, json_mode: bool = False) -> str:
    key = _api_key()
    if not key:
        raise DomainError("DEV_LLM_UNCONFIGURED", "未配置 DEV_LLM_API_KEY，云端判定不可用", 503)
    request_body: dict[str, Any] = {
        "model": _DEEPSEEK_MODEL,
        "messages": messages,
        "temperature": temperature,
        "max_tokens": max_tokens,
    }
    if json_mode:
        request_body["response_format"] = {"type": "json_object"}
    try:
        async with httpx.AsyncClient(timeout=25) as client:
            resp = await client.post(
                _DEEPSEEK_URL,
                json=request_body,
                headers={"Authorization": f"Bearer {key}"},
            )
            resp.raise_for_status()
            payload = resp.json()
    except httpx.HTTPError as exc:
        raise DomainError("DEV_LLM_UNAVAILABLE", f"云端判定调用失败：{exc}", 502) from exc
    try:
        return str(payload["choices"][0]["message"]["content"])
    except (KeyError, IndexError, TypeError) as exc:
        raise DomainError("DEV_LLM_UNAVAILABLE", "云端判定返回了意外结构", 502) from exc


async def _post_chat(question: str, reply: str) -> str:
    return await _post_messages(
        _build_messages(question, reply),
        temperature=0,
        max_tokens=200,
        json_mode=True,
    )


def parse_verdict(content: str) -> dict[str, Any]:
    text = content.strip()
    if text.startswith("```"):
        text = text.strip("`")
        if text.startswith("json"):
            text = text[4:]
    try:
        data = json.loads(text)
    except json.JSONDecodeError:
        data = {}
    is_answer = bool(data.get("is_answer")) if isinstance(data, dict) else False
    reason = str(data.get("reason") or "") if isinstance(data, dict) else ""
    return {"isAnswer": is_answer, "comment": reason}


class BotAskRequest(BaseModel):
    case_id: str = Field(min_length=1, max_length=64)
    text: str = Field(min_length=1, max_length=2000)
    role: str = Field(default="INTERROGATOR", pattern="^(INTERROGATOR|SUSPECT)$")


@router.post("/dev/bot/ask")
def bot_ask(body: BotAskRequest, request: Request):
    """DEV-ONLY: insert the BOT question as a real interrogator fragment so the
    suspect answer can flow through the normal formal-record matching pipeline."""
    service = getattr(request.app.state, "asr_capture_service", None)
    if service is None:
        raise DomainError("DEV_BOT_UNAVAILABLE", "录音服务未配置", 503)
    payload = service.inject_officer_text(body.case_id, body.text, body.role)
    return envelope(payload)


@router.post("/dev/bot/judge")
async def bot_judge(body: BotJudgeRequest):
    content = await _post_chat(body.question, body.reply)
    return envelope(parse_verdict(content))


class BotNextQuestionRequest(BaseModel):
    case_id: str = Field(min_length=1, max_length=64)
    asked: list[str] = Field(default_factory=list, max_length=50)
    answers: list[str] = Field(default_factory=list, max_length=50)


def _clean_generated_question(content: str) -> str:
    text = str(content or "").strip().splitlines()[0].strip() if str(content or "").strip() else ""
    for prefix in ("问：", "问题：", "问题:", "Q:", "Q："):
        if text.startswith(prefix):
            text = text[len(prefix):].strip()
    text = text.strip("「」『』“”\"' ")
    return text[:80]


@router.post("/dev/bot/next-question")
async def bot_next_question(body: BotNextQuestionRequest, request: Request):
    """DEV-ONLY: generate the next dynamic follow-up question from the case."""
    case_type = "刑事案件"
    suspect_name = "嫌疑人"
    facts_lines: list[str] = []
    session_factory = getattr(request.app.state, "session_factory", None)
    if session_factory is not None:
        try:
            with session_factory() as db:
                case = case_repo.get(db, body.case_id)
                case_type = str(getattr(case, "case_type", "") or case_type)
                suspect_name = str(getattr(case, "suspect_name", "") or suspect_name)
                for fact in fact_repo.list_for_case(db, body.case_id):
                    value = str(getattr(fact, "value", "") or "").strip()
                    label = str(getattr(fact, "label", "") or getattr(fact, "fact_key", "") or "")
                    if value and value not in {"—", "-"}:
                        facts_lines.append(f"{label}：{value}")
        except Exception:
            pass

    asked_text = "；".join(item.strip() for item in body.asked[-12:] if item and item.strip()) or "（暂无）"
    answers_text = "；".join(item.strip() for item in body.answers[-6:] if item and item.strip()) or "（暂无）"
    if case_type.strip() in {"", "suspect_interrogation"}:
        case_type = "普通刑事案件讯问"
    system = (
        "你是市级公安局办案民警，正在对嫌疑人做讯问。"
        "请根据案件情况提出下一个简短、具体、口语化的追问。"
        "只输出一个问题本身，不要解释、不要编号、不要引号，不超过40个字。"
    )
    user = (
        f"案件性质：{case_type}\n嫌疑人：{suspect_name}\n"
        f"已知案情：{'；'.join(facts_lines) or '（暂未填写）'}\n"
        f"已经问过的问题：{asked_text}\n嫌疑人最近的回答：{answers_text}\n"
        "下一个最值得追问的问题："
    )
    content = await _post_messages(
        [{"role": "system", "content": system}, {"role": "user", "content": user}],
        temperature=1.0,
        max_tokens=120,
    )
    question = _clean_generated_question(content)
    if not question:
        raise DomainError("DEV_BOT_GENERATION_EMPTY", "云端未生成有效问题", 502)
    return envelope({"question": question})
