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
from fastapi import APIRouter
from pydantic import BaseModel, Field

from app.api.responses import envelope
from app.domain.errors import DomainError


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


async def _post_chat(question: str, reply: str) -> dict[str, Any]:
    key = _api_key()
    if not key:
        raise DomainError("DEV_LLM_UNCONFIGURED", "未配置 DEV_LLM_API_KEY，云端判定不可用", 503)
    request_body = {
        "model": _DEEPSEEK_MODEL,
        "messages": _build_messages(question, reply),
        "temperature": 0,
        "max_tokens": 200,
        "response_format": {"type": "json_object"},
    }
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


@router.post("/dev/bot/judge")
async def bot_judge(body: BotJudgeRequest):
    content = await _post_chat(body.question, body.reply)
    return envelope(parse_verdict(content))
