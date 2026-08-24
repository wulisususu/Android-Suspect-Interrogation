class LocalModelManager:
    """Manage offline local inference backends."""

    def __init__(self):
        self.backend = None
        self.model_path = None

    def load(self, model_path: str):
        self.model_path = model_path

    def generate(self, prompt: str) -> str:
        raise NotImplementedError("Connect RKLLM or llama.cpp backend")
