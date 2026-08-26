from typing import Protocol


class AIGateway(Protocol):
    def generate(self, text: str) -> dict: ...
