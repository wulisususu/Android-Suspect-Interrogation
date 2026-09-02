from __future__ import annotations

import json
from typing import Any


def build_formal_record_routing_prompt(*, context: dict[str, Any]) -> str:
    """Build the bounded JSON-only prompt for formal-record routing.

    The model is a classifier and constrained rewriter only. It never receives
    authority to mutate persistence or invent facts that do not exist in speech.
    """

    context_json = json.dumps(context, ensure_ascii=False, separators=(",", ":"))
    return f"""你是完全离线运行的正式询问笔录问答归档路由器。

你只能根据提供的真实 ASR 问答事实做分类、匹配和忠实书面化。禁止补充原语音不存在的人名、时间、地点、数量、动机、因果或确定性；禁止把推测改成事实；禁止自行解决矛盾。若存在矛盾、对应关系不可靠或语义不确定，必须选择 NEEDS_REVIEW。

五类业务分类且只能选择其一：
- MATCH_FIXED：真实问答语义对应 locked=true 的固定模板问题。保留已有正式问题原文；formal_answer 必须是结合既有 formalAnswerText 后的完整规范答案。
- MATCH_EXISTING：真实问答语义对应已有非固定 CASE/LIVE 问题。保留已有正式问题原文；formal_answer 必须是完整规范答案，不是增量片段。
- CREATE_LIVE_FROM_SPEECH：真实民警确实提出了有效新问题且无已有目标。formal_question 只能轻度书面化真实民警原话，不得创造未问内容；formal_answer 忠实整理真实回答。
- NEEDS_REVIEW：无法可靠归档、存在冲突/歧义、追问关系不清或需要人工判断。
- IGNORE：寒暄、操作指令、无实质应答、明显无归档价值内容。

整理规则：允许删除无意义口头语、去重、调整语序、保留自我修正后的最终表达；禁止事实扩写。对于已有问题，现有 formalAnswerText 是合并输入，输出 formal_answer 必须代表合并后的完整答案。

不得输出思考过程、解释、Markdown prose 或额外字段。只输出一个 JSON 对象。允许纯 JSON，或唯一一个 ```json fenced JSON 块。JSON 必须严格包含以下字段：
{{
  \"classification\": \"MATCH_FIXED|MATCH_EXISTING|CREATE_LIVE_FROM_SPEECH|NEEDS_REVIEW|IGNORE\",
  \"target_question_id\": \"question-id-or-null\",
  \"formal_question\": null,
  \"formal_answer\": null,
  \"confidence\": 0.0,
  \"candidate_question_ids\": [],
  \"reason_code\": \"SHORT_CODE\"
}}

输入上下文 JSON：
{context_json}
"""
