from __future__ import annotations

from typing import Any


class ContextBuilder:
    """Build bounded interrogation context for a local model.

    The builder never mutates the supplied session and intentionally keeps the
    context finite so long interviews cannot grow the prompt without bound.
    """

    def __init__(self, *, max_recent_qa: int = 8, max_facts: int = 32, max_timeline: int = 32):
        self.max_recent_qa = max(1, max_recent_qa)
        self.max_facts = max(1, max_facts)
        self.max_timeline = max(1, max_timeline)

    def build(self, session: dict[str, Any]) -> dict[str, Any]:
        messages = list(session.get("messages", []))
        return {
            "session_id": session.get("session_id"),
            "case_metadata": dict(session.get("case_metadata") or session.get("metadata") or {}),
            "identity": dict(session.get("identity") or {}),
            "facts": list(session.get("facts", []))[-self.max_facts :],
            "recent_qa": messages[-(self.max_recent_qa * 2) :],
            "timeline": list(session.get("timeline", []))[-self.max_timeline :],
            "current_stage": session.get("current_stage"),
        }
