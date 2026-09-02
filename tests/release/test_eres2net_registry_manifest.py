from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
REGISTRY = ROOT / "linux" / "backend" / "config" / "model-registry.yaml"
MODEL_SLUG = "speech_eres2net_large_200k_sv_zh-cn_16k-common"


def test_registry_locks_real_rk3588_eres2net_package_contract():
    payload = json.loads(REGISTRY.read_text(encoding="utf-8"))
    spec = payload["models"]["speaker.eres2net_large"]

    assert spec["kind"] == "speaker"
    assert spec["path"] == MODEL_SLUG
    assert spec["architecture"] == "eres2net_large"
    assert spec["required_files"] == [
        "configuration.json",
        "pretrained_eres2net.pt",
    ]
    assert spec["device"] == "cpu"
    assert "embedding" in spec["capabilities"]


def test_registry_does_not_require_non_runtime_modelscope_assets():
    payload = json.loads(REGISTRY.read_text(encoding="utf-8"))
    required = set(payload["models"]["speaker.eres2net_large"]["required_files"])

    assert "README.md" not in required
    assert ".gitattributes" not in required
    assert not any(item.startswith("examples/") for item in required)
    assert not any(item.startswith("images/") for item in required)
