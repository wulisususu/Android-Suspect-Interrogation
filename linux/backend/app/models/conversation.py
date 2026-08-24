from dataclasses import dataclass, field
from datetime import datetime


@dataclass
class Conversation:
    session_id: str
    messages: list = field(default_factory=list)
    created_at: datetime = datetime.now()

    def append(self, role: str, content: str):
        self.messages.append({
            "role": role,
            "content": content,
            "time": datetime.now().isoformat()
        })
