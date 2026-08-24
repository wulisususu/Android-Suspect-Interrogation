class PromptBuilder:
    """Create prompts for local offline inference."""

    def build(self, context: dict, instruction: str) -> str:
        return f"""System: You are an offline interrogation assistant.

Context:
{context}

Instruction:
{instruction}
"""
