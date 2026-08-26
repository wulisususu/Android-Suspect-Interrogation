import json
from pathlib import Path
import pytest
from app.ai.registry import ModelRegistry, RegistryError

def _write_registry(tmp_path: Path, payload: dict) -> Path:
    path = tmp_path / "model-registry.yaml"; path.write_text(json.dumps(payload), encoding="utf-8"); return path

def test_registry_reports_missing_required_files_without_crashing(tmp_path: Path):
    root=tmp_path/"models"; root.mkdir(); registry_path=_write_registry(tmp_path,{"models":{"llm.default":{"kind":"llm","backend":"rkllm","path":"llm/default","architecture":"qwen","required_files":["model.rkllm"],"device":"npu","context":4096,"memory_mb":4096}}}); registry=ModelRegistry.load(registry_path,root); status=registry.installation_status("llm.default"); assert status.installed is False; assert status.missing_files == [root/"llm/default/model.rkllm"]

def test_registry_rejects_model_path_escape(tmp_path: Path):
    registry_path=_write_registry(tmp_path,{"models":{"llm.default":{"kind":"llm","backend":"rkllm","path":"../escape","architecture":"qwen","required_files":[],"device":"npu","context":4096,"memory_mb":4096}}});
    with pytest.raises(RegistryError): ModelRegistry.load(registry_path,tmp_path/"models")
