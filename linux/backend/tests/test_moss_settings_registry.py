from __future__ import annotations

import json
from pathlib import Path

import pytest

from app.ai.registry import ModelRegistry, RegistryError
from app.ai.settings import AISettings


# Task 4 production bundle layout: the REQUIRED artifact set enforced by
# tools/moss_rk3588/validate_bundle.py (exact layout, plan Task 4 Step 5).
_MOSS_BUNDLE_FILES = (
    "moss_audio_encoder_fp16_rk3588.rknn",
    "moss_qwen3_0.6b_w8a8_rk3588.rkllm",
    "moss_token_embedding_fp16.bin",
    "token_embedding.json",
    "tokenizer.json",
    "tokenizer_config.json",
    "special_tokens_map.json",
    "generation_config.json",
    "processor_config.json",
    "selftest/encoder_input.npy",
    "selftest/encoder_expected.json",
    "selftest/decoder_input.f32",
    "selftest/decoder_expected.json",
)

_MOSS_ENV_KEYS = (
    "MOSS_ENABLED",
    "SUSPECT_MOSS_SOCKET",
    "MOSS_SPOOL_ROOT",
    "MOSS_MODEL_ID",
    "MOSS_REQUEST_TIMEOUT",
    "MOSS_SUBMIT_TIMEOUT",
)


def _clear_moss_env(monkeypatch: pytest.MonkeyPatch) -> None:
    for key in _MOSS_ENV_KEYS:
        monkeypatch.delenv(key, raising=False)


def test_moss_defaults(monkeypatch: pytest.MonkeyPatch):
    _clear_moss_env(monkeypatch)
    s = AISettings.from_env()
    assert s.moss_enabled is False
    assert s.moss_socket.as_posix() == "/run/suspect-interrogation/moss.sock"
    assert s.moss_spool_root.as_posix() == "/var/lib/suspect-interrogation/moss"
    assert s.moss_model_id == "moss.default"


def test_moss_env_overrides(monkeypatch: pytest.MonkeyPatch):
    _clear_moss_env(monkeypatch)
    monkeypatch.setenv("MOSS_ENABLED", "1")
    monkeypatch.setenv("SUSPECT_MOSS_SOCKET", "/tmp/custom/moss.sock")
    monkeypatch.setenv("MOSS_SPOOL_ROOT", "/tmp/custom/spool")
    monkeypatch.setenv("MOSS_MODEL_ID", "moss.staging")

    s = AISettings.from_env()

    assert s.moss_enabled is True
    assert s.moss_socket.as_posix() == "/tmp/custom/moss.sock"
    assert s.moss_spool_root.as_posix() == "/tmp/custom/spool"
    assert s.moss_model_id == "moss.staging"


def test_moss_submit_timeout_is_an_independent_long_budget(monkeypatch: pytest.MonkeyPatch):
    _clear_moss_env(monkeypatch)
    s = AISettings.from_env()
    assert s.moss_submit_timeout > s.moss_request_timeout

    monkeypatch.setenv("MOSS_REQUEST_TIMEOUT", "2.5")
    monkeypatch.setenv("MOSS_SUBMIT_TIMEOUT", "900")
    tuned = AISettings.from_env()
    assert tuned.moss_request_timeout == 2.5
    assert tuned.moss_submit_timeout == 900.0


def test_checked_in_registry_registers_moss_default_from_task4_bundle():
    backend_root = Path(__file__).resolve().parents[1]
    registry = ModelRegistry.load(
        backend_root / "config/model-registry.yaml", Path("models-root-unused")
    )

    moss = registry.default_for("moss")

    assert moss.model_id == "moss.default"
    assert moss.kind == "moss"
    assert moss.device == "npu"
    assert moss.context == 16384
    assert moss.capabilities == ("transcription", "diarization", "timestamps", "long_audio")
    assert moss.required_files == _MOSS_BUNDLE_FILES
    assert moss.path == "moss-rk3588"


def test_moss_default_installation_status_tracks_bundle_files(tmp_path: Path):
    backend_root = Path(__file__).resolve().parents[1]
    registry = ModelRegistry.load(
        backend_root / "config/model-registry.yaml", tmp_path / "models"
    )

    missing = registry.installation_status("moss.default")
    assert missing.installed is False
    assert len(missing.missing_files) == len(_MOSS_BUNDLE_FILES)

    model_dir = tmp_path / "models" / "moss-rk3588"
    for name in _MOSS_BUNDLE_FILES:
        target = model_dir / name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(b"placeholder")

    installed = registry.installation_status("moss.default")
    assert installed.installed is True
    assert installed.missing_files == []


def test_registry_still_rejects_unknown_kinds(tmp_path: Path):
    config = tmp_path / "registry.yaml"
    config.write_text(
        json.dumps(
            {
                "models": {
                    "transcribe.default": {
                        "kind": "transcribe",
                        "path": "moss",
                        "required_files": [],
                        "device": "npu",
                        "context": 16384,
                    }
                }
            }
        ),
        encoding="utf-8",
    )

    with pytest.raises(RegistryError):
        ModelRegistry.load(config, tmp_path / "models")
