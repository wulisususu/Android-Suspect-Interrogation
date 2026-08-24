from typing import Any


class ContextBuilder:
    """Build local LLM context from interrogation session data."""

    def build(self, session: dict[str, Any]) -> dict[str, Any]:
        return {
            "session_id": session.get("session_id"),
            "messages": session.get("messages", []),
            "metadata": session.get("metadata", {}),
        }
