import json
from pathlib import Path

import pytest

from app.ai.registry import ModelRegistry, RegistryError


def _write_registry(tmp_path: Path, payload: dict) -> Path:
    path = tmp_path / "model-registry.yaml"
    path.write_text(json.dumps(payload), encoding="utf-8")
    return path


def test_registry_reports_missing_required_files_without_crashing(tmp_path: Path):
    root = tmp_path / "models"
    root.mkdir()
    registry_path = _write_registry(
        tmp_path,
        {
            "models": {
                "llm.default": {
                    "kind": "llm",
                    "backend": "rkllm",
                    "path": "llm/default",
                    "architecture": "qwen",
                    "required_files": ["model.rkllm"],
                    "device": "npu",
                    "context": 4096,
                    "memory_mb": 4096,
                }
            }
        },
    )
    registry = ModelRegistry.load(registry_path, root)
    status = registry.installation_status("llm.default")
    assert status.installed is False
    assert status.missing_files == [root / "llm/default/model.rkllm"]


def test_registry_rejects_model_path_escape(tmp_path: Path):
    registry_path = _write_registry(
        tmp_path,
        {
            "models": {
                "llm.default": {
                    "kind": "llm",
                    "backend": "rkllm",
                    "path": "../escape",
                    "architecture": "qwen",
                    "required_files": [],
                    "device": "npu",
                    "context": 4096,
                    "memory_mb": 4096,
                }
            }
        },
    )
    with pytest.raises(RegistryError):
        ModelRegistry.load(registry_path, tmp_path / "models")


def test_checked_in_registry_matches_observed_rk3588_funasr_assets(tmp_path: Path):
    backend_root = Path(__file__).resolve().parents[1]
    registry = ModelRegistry.load(backend_root / "config/model-registry.yaml", tmp_path / "funasr")

    asr = registry.get("asr.default")
    assert asr.backend == "funasr"
    assert asr.path == "paraformer"
    assert asr.architecture == "paraformer"
    assert asr.device == "cpu"
    assert asr.required_files == (
        "model.pt",
        "config.yaml",
        "configuration.json",
        "am.mvn",
        "seg_dict",
        "tokens.json",
    )
    assert "final_result" in asr.capabilities
    assert "partial_result" not in asr.capabilities

    vad = registry.get("vad.default")
    assert vad.backend == "funasr"
    assert vad.path == "fsmn-vad"
    assert vad.architecture == "fsmn-vad"
    assert vad.device == "cpu"
    assert vad.required_files == ("model.pt", "config.yaml", "configuration.json", "am.mvn")

    speaker = registry.get("speaker.default")
    assert speaker.backend == "funasr"
    assert speaker.path == "xvector"
    assert speaker.architecture == "xvector"
    assert speaker.device == "cpu"
    assert speaker.required_files == ("sv.pth", "sv.yaml", "configuration.json")
