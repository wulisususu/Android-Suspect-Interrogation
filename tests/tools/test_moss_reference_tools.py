import hashlib
import importlib
import json
import subprocess
import sys
from pathlib import Path
from types import SimpleNamespace

import numpy as np
import pytest
import torch


def capture_module():
    return importlib.import_module("tools.moss_rk3588.capture_input_embeds")


def test_manifest_binds_audio_and_shape(tmp_path):
    wav = tmp_path / "test.wav"
    wav.write_bytes(b"audio fixture")
    manifest = capture_module().build_reference_manifest(wav, "sha256:weights", (1, 42, 1024), "hello")
    assert manifest["audio_sha256"] == hashlib.sha256(wav.read_bytes()).hexdigest()
    assert manifest["input_shape"] == [1, 42, 1024]
    assert manifest["model_fingerprint"] == "sha256:weights"
    assert manifest["output_text"] == "hello"


def test_classify_state_key():
    classify = importlib.import_module("tools.moss_rk3588.repack_moss_qwen").classify_state_key
    assert classify("model.language_model.layers.0.self_attn.q_proj.weight") == "model.layers.0.self_attn.q_proj.weight"
    assert classify("lm_head.weight") == "lm_head.weight"
    assert classify("model.audio_encoder.conv1.weight") is None
    assert classify("model.audio_projector.weight") is None


class LanguageModel(torch.nn.Module):
    def forward(self, inputs_embeds=None, **kwargs):
        return inputs_embeds


class FakeMoss(torch.nn.Module):
    def __init__(self, fail=False):
        super().__init__()
        self.anchor = torch.nn.Parameter(torch.zeros(1))
        self.model = SimpleNamespace(language_model=LanguageModel())
        self.fail = fail
        self.generation_config = SimpleNamespace()
        self.prefill = torch.arange(24, dtype=torch.float16).reshape(1, 4, 6).transpose(1, 2)

    def generate(self, **kwargs):
        assert kwargs["generation_config"].do_sample is False
        self.model.language_model(inputs_embeds=self.prefill)
        if self.fail:
            raise RuntimeError("generation failed")
        self.prefill.fill_(-1)  # A saved reference must own its storage.
        self.model.language_model(inputs_embeds=torch.zeros(1, 1, 4))
        return torch.tensor([[1, 2, 3, 4, 5, 6, 9]])


def setup_capture(monkeypatch, tmp_path, fail=False):
    mod = capture_module()
    model_dir = tmp_path / "model"
    model_dir.mkdir()
    (model_dir / "config.json").write_text("{}")
    (model_dir / "model.safetensors").write_bytes(b"test weights")
    wav = tmp_path / "fixture.wav"
    wav.write_bytes(b"test wav")
    model = FakeMoss(fail)
    processor = SimpleNamespace(tokenizer=SimpleNamespace(decode=lambda ids, **kw: "transcript"))
    monkeypatch.setattr(mod, "load_local_moss", lambda path: (model, processor))
    monkeypatch.setattr(mod, "prepare_inputs", lambda processor, wav: {
        "input_ids": torch.tensor([[1, 2, 3, 4, 5, 6]]),
        "attention_mask": torch.ones(1, 6, dtype=torch.long),
    })
    return mod, model_dir, wav, model


def test_capture_keeps_full_prefill_and_matching_artifacts(monkeypatch, tmp_path):
    mod, model_dir, wav, model = setup_capture(monkeypatch, tmp_path)
    expected = model.prefill.float().numpy().copy()
    output = tmp_path / "output"
    manifest = mod.capture_reference(model_dir, wav, output)
    stored = np.load(output / "input_embeds.npy")
    np.testing.assert_array_equal(stored, expected)
    assert stored.dtype == np.dtype("<f4") and stored.flags.c_contiguous
    assert (output / "input_embeds.f32").read_bytes() == stored.tobytes(order="C")
    np.testing.assert_array_equal(np.load(output / "input_ids.npy"), [[1, 2, 3, 4, 5, 6]])
    np.testing.assert_array_equal(np.load(output / "attention_mask.npy"), [[1] * 6])
    assert (output / "output.txt").read_text() == "transcript"
    assert json.loads((output / "manifest.json").read_text(encoding="utf-8")) == manifest
    assert manifest["dtype"] == "float32"
    assert manifest["versions"].keys() >= {"python", "torch", "transformers"}
    for filename, digest in manifest["artifacts"].items():
        assert hashlib.sha256((output / filename).read_bytes()).hexdigest() == digest
    assert not model.model.language_model._forward_pre_hooks


def test_capture_removes_hook_on_failure(monkeypatch, tmp_path):
    mod, model_dir, wav, model = setup_capture(monkeypatch, tmp_path, fail=True)
    with pytest.raises(RuntimeError, match="generation failed"):
        mod.capture_reference(model_dir, wav, tmp_path / "output")
    assert not model.model.language_model._forward_pre_hooks


def test_output_guard_and_force_preserve_unrelated_files(monkeypatch, tmp_path):
    mod, model_dir, wav, model = setup_capture(monkeypatch, tmp_path)
    output = tmp_path / "output"
    output.mkdir()
    keep = output / "unrelated.txt"
    keep.write_text("keep")
    with pytest.raises(FileExistsError):
        mod.capture_reference(model_dir, wav, output)
    mod.capture_reference(model_dir, wav, output, force=True)
    assert keep.read_text() == "keep"


def test_fingerprint_changes_when_weights_change(tmp_path):
    mod = capture_module()
    (tmp_path / "config.json").write_text("{}")
    weights = tmp_path / "model.safetensors"
    weights.write_bytes(b"first")
    before = mod.fingerprint_model(tmp_path)
    weights.write_bytes(b"other")
    assert mod.fingerprint_model(tmp_path) != before


def test_missing_weights_does_not_create_capture(tmp_path):
    model = tmp_path / "missing"
    output = tmp_path / "output"
    with pytest.raises(FileNotFoundError):
        capture_module().capture_reference(model, tmp_path / "audio.wav", output)
    assert not output.exists()


def test_repack_roundtrip_preserves_exact_weights_and_tokenizer(monkeypatch, tmp_path):
    from tokenizers import Tokenizer
    from tokenizers.models import WordLevel
    from transformers import PreTrainedTokenizerFast, Qwen3Config, Qwen3ForCausalLM

    mod = importlib.import_module("tools.moss_rk3588.repack_moss_qwen")
    config = Qwen3Config(vocab_size=8, hidden_size=8, intermediate_size=16,
                        num_hidden_layers=1, num_attention_heads=2, num_key_value_heads=1,
                        head_dim=4, tie_word_embeddings=True)
    source = Qwen3ForCausalLM(config).to(torch.bfloat16).eval()
    moss_state = {("model.language_model." + key[6:] if key.startswith("model.") else key): value
                  for key, value in source.state_dict().items()}
    moss_state["model.whisper_encoder.conv1.weight"] = torch.zeros(1)
    moss_state["model.vq_adaptor.weight"] = torch.zeros(1)
    tokenizer = PreTrainedTokenizerFast(tokenizer_object=Tokenizer(WordLevel({"[UNK]": 0, "hi": 1}, unk_token="[UNK]")), unk_token="[UNK]")
    processor = SimpleNamespace(tokenizer=tokenizer, chat_template="{{ messages[0]['content'] }}")
    moss = SimpleNamespace(config=SimpleNamespace(text_config=config), state_dict=lambda: moss_state,
                           generation_config=source.generation_config)
    model_dir = tmp_path / "moss"
    model_dir.mkdir()
    (model_dir / "config.json").write_text("{}")
    (model_dir / "model.safetensors").write_bytes(b"test weights")
    monkeypatch.setattr(mod, "load_local_moss", lambda path: (moss, processor))
    output = tmp_path / "qwen"
    manifest = mod.repack_moss_qwen(model_dir, output)
    restored = Qwen3ForCausalLM.from_pretrained(output, local_files_only=True, dtype="auto")
    for key, tensor in source.state_dict().items():
        assert restored.state_dict()[key].dtype == tensor.dtype
        assert torch.equal(restored.state_dict()[key], tensor)
    assert restored.lm_head.weight.data_ptr() == restored.model.embed_tokens.weight.data_ptr()
    assert PreTrainedTokenizerFast.from_pretrained(output).chat_template == processor.chat_template
    assert (output / "generation_config.json").is_file()
    assert list(output.glob("*.safetensors"))
    assert manifest["mapped_tensor_count"] == len(source.state_dict())
    assert json.loads((output / "repack_manifest.json").read_text(encoding="utf-8")) == manifest


def test_repack_strict_weight_checks():
    from transformers import Qwen3Config, Qwen3ForCausalLM

    mod = importlib.import_module("tools.moss_rk3588.repack_moss_qwen")
    config = Qwen3Config(vocab_size=8, hidden_size=8, intermediate_size=16, num_hidden_layers=1,
                        num_attention_heads=2, num_key_value_heads=1, head_dim=4, tie_word_embeddings=True)
    model = Qwen3ForCausalLM(config)
    state = {("model.language_model." + key[6:] if key.startswith("model.") else key): value
             for key, value in model.state_dict().items()}
    with pytest.raises(ValueError, match="tied"):
        mod.map_and_validate_weights({**state, "lm_head.weight": torch.ones(8, 8)}, model)
    with pytest.raises(ValueError, match="missing"):
        mod.map_and_validate_weights({key: value for key, value in state.items() if "q_proj" not in key}, model)
    with pytest.raises(ValueError, match="shape"):
        mod.map_and_validate_weights({**state, "model.language_model.norm.weight": torch.ones(1)}, model)
    with pytest.raises(ValueError, match="Unexpected"):
        mod.map_and_validate_weights({**state, "model.unrecognized.weight": torch.ones(1)}, model)


def test_repack_direct_file_cli():
    script = Path(__file__).resolve().parents[2] / "tools" / "moss_rk3588" / "repack_moss_qwen.py"
    result = subprocess.run([sys.executable, str(script), "--help"], capture_output=True, text=True)
    assert result.returncode == 0, result.stderr
    assert "--model" in result.stdout and "--output" in result.stdout
