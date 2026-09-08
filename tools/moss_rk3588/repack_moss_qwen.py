"""Repack the exact MOSS text weights as standard Qwen3ForCausalLM."""

import argparse
import copy
import json
from pathlib import Path

import torch

if __package__:
    from .capture_input_embeds import fingerprint_model, guard_output, load_local_moss, sha256_file
else:
    from capture_input_embeds import fingerprint_model, guard_output, load_local_moss, sha256_file


def classify_state_key(key: str) -> str | None:
    if key.startswith("model.language_model."):
        return "model." + key.removeprefix("model.language_model.")
    if key == "lm_head.weight":
        return key
    return None


def map_and_validate_weights(source: dict, target) -> dict:
    mapped = {}
    for key, tensor in source.items():
        destination = classify_state_key(key)
        if destination is not None:
            mapped[destination] = tensor.detach().cpu().contiguous()
        elif not key.startswith(("model.whisper_encoder.", "model.vq_adaptor.")):
            raise ValueError(f"Unexpected MOSS state key: {key}")
    if target.config.tie_word_embeddings:
        embedding = mapped.get("model.embed_tokens.weight")
        head = mapped.get("lm_head.weight")
        if embedding is not None and head is not None and not torch.equal(embedding, head):
            raise ValueError("MOSS tied embedding and lm_head tensors differ")
        if embedding is not None:
            mapped["lm_head.weight"] = embedding
    expected = target.state_dict()
    missing, unexpected = sorted(expected.keys() - mapped.keys()), sorted(mapped.keys() - expected.keys())
    if missing or unexpected:
        raise ValueError(f"Qwen weight mismatch: missing={missing}, unexpected={unexpected}")
    for key, tensor in mapped.items():
        if tensor.shape != expected[key].shape:
            raise ValueError(f"Qwen weight shape mismatch for {key}: {tensor.shape} != {expected[key].shape}")
    return mapped


def repack_moss_qwen(model_dir: Path, output_dir: Path) -> dict:
    from transformers import Qwen3Config, Qwen3ForCausalLM

    model_dir, output_dir = Path(model_dir), Path(output_dir)
    guard_output(model_dir, output_dir)
    fingerprint = fingerprint_model(model_dir)
    moss, processor = load_local_moss(model_dir)
    text_config = moss.config.text_config.to_dict()
    if text_config.get("model_type") != "qwen3":
        raise ValueError("MOSS text_config must describe Qwen3")
    config = Qwen3Config.from_dict(text_config)
    with torch.device("meta"):
        qwen = Qwen3ForCausalLM(config)
    mapped = map_and_validate_weights(moss.state_dict(), qwen)
    qwen.load_state_dict(mapped, strict=True, assign=True)
    qwen.tie_weights()
    qwen.eval()
    for key, value in qwen.state_dict().items():
        if value.dtype != mapped[key].dtype or not torch.equal(value, mapped[key]):
            raise ValueError(f"Qwen weight changed during repack: {key}")
    qwen.generation_config = copy.deepcopy(moss.generation_config)
    tokenizer = processor.tokenizer
    if getattr(processor, "chat_template", None):
        tokenizer.chat_template = copy.deepcopy(processor.chat_template)
    output_dir.mkdir(parents=True, exist_ok=True)
    qwen.save_pretrained(output_dir, safe_serialization=True)
    tokenizer.save_pretrained(output_dir)
    qwen.generation_config.save_pretrained(output_dir)
    manifest = {"model_fingerprint": fingerprint, "source_model": str(model_dir.resolve()),
                "architecture": "Qwen3ForCausalLM", "mapped_tensor_count": len(mapped),
                "tie_word_embeddings": config.tie_word_embeddings,
                "tensor_dtypes": sorted({str(tensor.dtype) for tensor in mapped.values()}),
                "artifacts": {path.name: sha256_file(path) for path in sorted(output_dir.iterdir()) if path.is_file()}}
    (output_dir / "repack_manifest.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False), encoding="utf-8")
    return manifest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(repack_moss_qwen(args.model, args.output), indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
