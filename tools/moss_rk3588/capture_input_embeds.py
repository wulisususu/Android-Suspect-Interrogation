"""Capture the actual audio-conditioned Qwen prefill from a local MOSS model.

Run: python -m tools.moss_rk3588.capture_input_embeds --model MODEL --wav WAV --output OUT
Loading and prompt semantics follow OpenMOSS's inference_utils.py and the
checkpoint's processing_moss_transcribe_diarize.py. No checkpoints are downloaded.
The WAV must already be mono at the processor's sampling rate (normally 16 kHz).
"""

import argparse
import copy
import hashlib
import json
import platform
from pathlib import Path

import numpy as np
import torch


DEFAULT_PROMPT = (
    "请将音频转写为文本，每一段需以起始时间戳和说话人编号"
    "（[S01]、[S02]、[S03]…）开头，正文为对应的语音内容，"
    "并在段末标注结束时间戳，以清晰标明该段语音范围。"
)


def sha256_file(path: Path) -> str:
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def fingerprint_model(model_dir: Path) -> str:
    """Hash filenames and contents, including checkpoint weights and remote code."""
    paths = sorted(p for p in model_dir.rglob("*") if p.is_file()
                   and not any(part.startswith(".") or part == "__pycache__"
                               for part in p.relative_to(model_dir).parts))
    if not (model_dir / "config.json").is_file() or not any(
        p.suffix in {".safetensors", ".bin"} for p in paths
    ):
        raise FileNotFoundError("Local model requires config.json and checkpoint weights")
    digest = hashlib.sha256()
    for path in paths:
        digest.update(path.relative_to(model_dir).as_posix().encode("utf-8") + b"\0")
        digest.update(bytes.fromhex(sha256_file(path)))
    return "sha256:" + digest.hexdigest()


def build_reference_manifest(wav_path: Path, model_fingerprint: str,
                             input_shape: tuple[int, ...], output_text: str) -> dict:
    return {"audio_sha256": sha256_file(wav_path), "model_fingerprint": model_fingerprint,
            "input_shape": list(input_shape), "dtype": "float32", "output_text": output_text}


def guard_output(model_dir: Path, output_dir: Path, force: bool = False) -> None:
    model_path, output_path = model_dir.resolve(), output_dir.resolve()
    if output_path == model_path or output_path.is_relative_to(model_path) or model_path.is_relative_to(output_path):
        raise ValueError("Model and output directories must not overlap")
    if output_dir.exists() and (not output_dir.is_dir() or any(output_dir.iterdir())) and not force:
        raise FileExistsError(f"Output is not empty: {output_dir}; use --force to replace capture files")


def load_local_moss(model_dir: Path):
    from transformers import AutoModelForCausalLM, AutoProcessor

    if not model_dir.is_dir():
        raise FileNotFoundError(f"Local model directory does not exist: {model_dir}")
    model, loading = AutoModelForCausalLM.from_pretrained(
        str(model_dir), trust_remote_code=True, local_files_only=True,
        dtype="auto", attn_implementation="sdpa", output_loading_info=True,
    )
    if any(loading.get(key) for key in ("missing_keys", "unexpected_keys", "mismatched_keys", "error_msgs")):
        raise ValueError(f"MOSS checkpoint did not load exactly: {loading}")
    processor = AutoProcessor.from_pretrained(str(model_dir), trust_remote_code=True, local_files_only=True)
    return model.cpu().eval(), processor


def prepare_inputs(processor, wav_path: Path):
    import soundfile as sf

    audio, sample_rate = sf.read(wav_path, dtype="float32")
    if audio.ndim != 1 or not audio.size or sample_rate != processor.feature_extractor.sampling_rate:
        raise ValueError("WAV must be nonempty mono audio at the processor sampling rate")
    messages = [{"role": "user", "content": [
        {"type": "audio", "audio": str(wav_path)}, {"type": "text", "text": DEFAULT_PROMPT},
    ]}]
    text = processor.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)
    return processor(text=text, audio=[audio], max_length=131072, return_tensors="pt")


def capture_reference(model_dir: Path, wav_path: Path, output_dir: Path, force: bool = False) -> dict:
    import transformers

    model_dir, wav_path, output_dir = Path(model_dir), Path(wav_path), Path(output_dir)
    guard_output(model_dir, output_dir, force)
    fingerprint = fingerprint_model(model_dir)
    model, processor = load_local_moss(model_dir)
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = model.to(device=device, dtype=torch.float32).eval()
    inputs = prepare_inputs(processor, wav_path)
    inputs = {name: value.to(device) for name, value in inputs.items()}
    captured = None

    def capture_prefill(module, args, kwargs):
        nonlocal captured
        if captured is not None:
            return
        embeds = kwargs.get("inputs_embeds")
        if embeds is None or embeds.ndim != 3 or embeds.shape[:2] != inputs["input_ids"].shape:
            raise RuntimeError("First language model call did not contain the full prefill inputs_embeds")
        captured = embeds.detach().to(device="cpu", dtype=torch.float32).contiguous().clone()

    config = copy.deepcopy(model.generation_config)
    config.do_sample, config.num_beams = False, 1
    config.max_new_tokens = 2048
    config.return_dict_in_generate = False
    handle = model.model.language_model.register_forward_pre_hook(capture_prefill, with_kwargs=True)
    try:
        with torch.inference_mode():
            outputs = model.generate(**inputs, generation_config=config)
    finally:
        handle.remove()
    if captured is None:
        raise RuntimeError("No language model prefill was captured")
    prompt_length = inputs["input_ids"].shape[1]
    generated_ids = outputs[0, prompt_length:].detach().cpu()
    text = processor.tokenizer.decode(generated_ids, skip_special_tokens=True).strip()
    array = np.ascontiguousarray(captured.numpy(), dtype="<f4")
    manifest = build_reference_manifest(wav_path, fingerprint, array.shape, text)
    manifest.update({"versions": {"python": platform.python_version(), "torch": torch.__version__,
                                  "transformers": transformers.__version__},
                     "model_path": str(model_dir.resolve()), "audio_path": str(wav_path.resolve()),
                     "byte_order": "little", "order": "C", "generation": {
                         "do_sample": False, "num_beams": 1, "max_new_tokens": 2048},
                     "model_compute_dtype": "float32", "model_device": str(device)})
    output_dir.mkdir(parents=True, exist_ok=True)
    np.save(output_dir / "input_embeds.npy", array, allow_pickle=False)
    array.tofile(output_dir / "input_embeds.f32")
    for name in ("input_ids", "attention_mask"):
        np.save(output_dir / f"{name}.npy", inputs[name].detach().cpu().numpy(), allow_pickle=False)
    np.save(output_dir / "generated_ids.npy", generated_ids.numpy(), allow_pickle=False)
    (output_dir / "output.txt").write_text(text, encoding="utf-8")
    manifest["artifacts"] = {name: sha256_file(output_dir / name) for name in (
        "input_embeds.npy", "input_embeds.f32", "input_ids.npy", "attention_mask.npy",
        "generated_ids.npy", "output.txt")}
    (output_dir / "manifest.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False), encoding="utf-8")
    return manifest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", type=Path, required=True)
    parser.add_argument("--wav", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--force", action="store_true")
    args = parser.parse_args()
    print(json.dumps(capture_reference(args.model, args.wav, args.output, args.force), indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
