import hashlib


class DeterministicAIGateway:
    def generate(self, text: str) -> dict:
        normalized = " ".join(str(text or "").split())
        digest = hashlib.sha256(normalized.encode("utf-8")).hexdigest()[:8]
        return {"text": f"离线模拟回复：{normalized}", "mock": True, "digest": digest}
