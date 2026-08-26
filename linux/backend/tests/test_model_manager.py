from pathlib import Path
from app.ai.inference.model_manager import LocalModelManager
from app.ai.registry import ModelRegistry
from app.ai.supervisor import AISupervisor

def test_legacy_model_manager_delegates_to_supervisor(tmp_path: Path):
    config=tmp_path/"registry.yaml"; config.write_text('{"models":{"llm.default":{"kind":"llm","backend":"rkllm","path":"llm/default","architecture":"qwen","required_files":["model.rkllm"],"device":"npu","context":4096,"memory_mb":1024}}}',encoding="utf-8"); supervisor=AISupervisor(ModelRegistry.load(config,tmp_path/"models"),mode="mock")
    try:
        manager=LocalModelManager(supervisor=supervisor); manager.load("/legacy/path"); assert manager.model_path=="/legacy/path"; assert manager.generate("hello",session_id="s")=="[mock-llm] hello"
    finally: supervisor.shutdown()
