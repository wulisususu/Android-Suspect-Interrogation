# MOSS-RK3588 NPU Backend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a standalone, fully offline MOSS-Transcribe-Diarize backend on one RK3588 32 GB device, using RKNN for Whisper-Medium + VQAdaptor, RKLLM for the MOSS-tuned Qwen3-0.6B decoder, and durable long-audio windowing with anonymous global speaker continuity.

**Architecture:** Keep the existing realtime `speech_worker` unchanged. Add a separate `moss_worker` supervisor behind `/run/suspect-interrogation/moss.sock`, with native RKNN/RKLLM inference isolated in a child process. Prove the critical `inputs_embeds -> RKLLM_INPUT_EMBED` bridge first, prove acoustic RKNN parity second, then build the long-audio worker, overlap merger, persistence, application integration, and RK3588 production deployment.

**Tech Stack:** Python 3.11/3.12, NumPy, `tokenizers`, Hugging Face Transformers/PyTorch only in the PC conversion environment, RKNN Toolkit2 / RKNN Runtime, RKLLM Toolkit **1.3.0** / RKLLM Runtime **1.3.0**, Unix domain sockets, FastAPI, systemd, GitHub Actions self-hosted RK3588 runner.

**Spec:** `docs/superpowers/specs/2026-09-08-moss-rk3588-npu-backend-design.md`

## Global Constraints

- Target hardware: one RK3588, 32 GB RAM.
- Production inference works with network disabled. No cloud API, model download, telemetry, or runtime update check is permitted.
- Phase 1 is MOSS-only. Paraformer, FSMN-VAD, ERes2Net, and real-person identity binding are not dependencies of this backend.
- Existing `speech_worker` remains unchanged in Phase 1. TCP/8000 must not be stopped, rebound, proxied, or reconfigured.
- Acoustic path: MOSS Whisper-Medium + 4x temporal merge + VQAdaptor, RKNN FP16, three RK3588 NPU cores available to the active call.
- Decoder path: **MOSS-tuned** Qwen3-0.6B weights, RKLLM W8A8. Never substitute stock Qwen3 weights.
- Decoder input is `RKLLM_INPUT_EMBED`; host code reproduces MOSS text/audio embedding injection exactly.
- Logical progress unit: 60 minutes. Target model window: 35 minutes. Adjacent model windows overlap by 5 minutes.
- `ContextBudgetPlanner` fallback ladder: 35 -> 30 -> 25 -> 20 minutes. Failure at 20 minutes is terminal for that window.
- Acoustic micro-chunk size: 30 seconds, fixed RKNN input `[1,80,3000]`; only valid adapted tokens from the last padded chunk are retained.
- Initial acoustic precision is FP16. Do not add acoustic INT8 in this plan.
- Initial decoder precision is W8A8.
- `max_concurrent_moss_jobs=1`, `max_concurrent_rknn_runs=1`, `max_concurrent_rkllm_runs=1`.
- Raw WAV + SHA-256 is the immutable source of truth. All features, embeddings, generations, and transcripts are derived artifacts.
- Local MOSS speakers are `Sxx`; cross-window anonymous speakers are `GSxx`. No `GSxx` is automatically bound to a named person in Phase 1.
- Only speaker correspondence confidence `>=0.85` inherits an existing `GSxx`. Weaker evidence allocates a new `GSxx` and records candidate evidence.
- Native RKNN/RKLLM calls run in a child process. A native crash must not kill the supervisor or FastAPI.
- Generated `.rknn`, `.rkllm`, token embedding tables, calibration tensors, checkpoint weights, and real/large audio fixtures must never be committed to Git.
- Follow `AGENTS.md`: source pushed to `linux-adaptation` must pass relevant CI and the exact final commit must complete RK3588 production redeploy/verification before implementation is reported complete.
- Production service account is exactly `suspect-interrogation:suspect-interrogation`, matching `systemd/ai-worker.service`.
- Every task uses TDD or an explicit failing hardware gate, reruns focused tests, and commits independently.

---

## File Structure Map

```text
tools/moss_rk3588/
├─ __init__.py
├─ requirements.txt
├─ capture_input_embeds.py
├─ repack_moss_qwen.py
├─ build_calibration_set.py
├─ build_rkllm.py
├─ export_audio_encoder.py
├─ build_rknn.py
├─ export_token_embedding.py
├─ build_manifest.py
├─ validate_bundle.py
├─ compare_pytorch_rknn.py
├─ compare_pytorch_rkllm.py
└─ native/rkllm_embed_probe.cpp

linux/backend/moss_worker/
├─ __init__.py
├─ types.py
├─ context_budget.py
├─ windowing.py
├─ embedding_builder.py
├─ parser.py
├─ speaker_remap.py
├─ merger.py
├─ storage.py
├─ audio_frontend.py
├─ rknn_audio_encoder.py
├─ rkllm_decoder.py
├─ runtime.py
├─ child.py
├─ supervisor.py
├─ protocol.py
└─ main.py

linux/backend/app/ai/moss/
├─ __init__.py
├─ types.py
└─ client.py

linux/backend/app/services/moss_transcription.py
linux/backend/requirements-moss-rk3588.txt
systemd/moss-worker.service
```

---

## Task 1: Capture a PyTorch MOSS golden reference and repack the MOSS Qwen3 weights

**Files:**
- Create: `tools/moss_rk3588/__init__.py`
- Create: `tools/moss_rk3588/requirements.txt`
- Create: `tools/moss_rk3588/capture_input_embeds.py`
- Create: `tools/moss_rk3588/repack_moss_qwen.py`
- Create: `tests/tools/test_moss_reference_tools.py`

**Interfaces:**
- `build_reference_manifest(wav_path: Path, model_fingerprint: str, input_shape: tuple[int,...], output_text: str) -> dict[str, object]`
- `capture_reference(model_dir: Path, wav_path: Path, output_dir: Path, force: bool=False) -> dict[str, object]`
- `classify_state_key(key: str) -> str | None`
- `repack_moss_qwen(model_dir: Path, output_dir: Path) -> dict[str, object]`
- Reference artifacts: `input_embeds.npy`, **raw C-contiguous `input_embeds.f32`**, `input_ids.npy`, `attention_mask.npy`, `generation.txt`, `reference.json`.

- [ ] **Step 1: Write failing helper tests.**

```python
from pathlib import Path
from tools.moss_rk3588.capture_input_embeds import build_reference_manifest
from tools.moss_rk3588.repack_moss_qwen import classify_state_key


def test_reference_manifest_records_sha_and_shape(tmp_path: Path):
    wav = tmp_path / "sample.wav"
    wav.write_bytes(b"RIFFtest")
    result = build_reference_manifest(wav, "moss-sha", (1, 912, 1024), "[0.0][S01]你好[0.8]")
    assert len(result["audio_sha256"]) == 64
    assert result["input_shape"] == [1, 912, 1024]


def test_repack_selects_only_language_model_and_head():
    assert classify_state_key("model.language_model.layers.0.self_attn.q_proj.weight") == "model.layers.0.self_attn.q_proj.weight"
    assert classify_state_key("lm_head.weight") == "lm_head.weight"
    assert classify_state_key("model.whisper_encoder.layers.0.self_attn.q_proj.weight") is None
    assert classify_state_key("model.vq_adaptor.layers.0.weight") is None
```

- [ ] **Step 2: Run the test and verify failure.**

```bash
python3 -m pytest tests/tools/test_moss_reference_tools.py -q
```

Expected: import failure because the tools do not exist.

- [ ] **Step 3: Add conversion-only dependencies.**

`tools/moss_rk3588/requirements.txt`:

```text
numpy>=1.26,<3
soundfile>=0.12,<1
transformers>=5.0,<6
huggingface-hub>=0.27,<1
torch>=2.5,<3
safetensors>=0.4,<1
onnx>=1.18,<2
onnxruntime>=1.20,<2
```

Rockchip toolkit wheels remain separately installed on the conversion workstation; scripts fail with a clear `RuntimeError` when a required Rockchip module is absent.

- [ ] **Step 4: Implement the reference capture.**

Register a `forward_pre_hook(..., with_kwargs=True)` on `model.model.language_model`, copy `kwargs["inputs_embeds"]` to CPU FP32, run `model.generate(..., do_sample=False)`, then save both `.npy` and raw `.f32` from the same C-contiguous array. `reference.json` stores shape, dtype, audio SHA-256, model fingerprint, Python/Torch/Transformers versions, and generated text. Refuse to overwrite a non-empty output directory unless `force=True`.

- [ ] **Step 5: Implement the Qwen repack.**

Use exactly:

```python
def classify_state_key(key: str) -> str | None:
    prefix = "model.language_model."
    if key.startswith(prefix):
        return "model." + key[len(prefix):]
    if key == "lm_head.weight":
        return key
    return None
```

Create a standard `Qwen3ForCausalLM` from `model.config.text_config`, load only mapped MOSS language/head tensors, save with safetensors, copy MOSS tokenizer/chat-template files, and write `repack_manifest.json` with source checkpoint SHA-256/fingerprint.

- [ ] **Step 6: Run software tests.**

```bash
python3 -m pytest tests/tools/test_moss_reference_tools.py -q
```

Expected: PASS.

- [ ] **Step 7: Create one real 30-60 second 2-speaker reference on the conversion workstation.**

```bash
python3 tools/moss_rk3588/capture_input_embeds.py \
  --model /opt/moss-build/source/MOSS-Transcribe-Diarize \
  --wav /opt/moss-build/fixtures/zh_2spk_45s.wav \
  --output /opt/moss-build/reference-zh-2spk-45s

python3 tools/moss_rk3588/repack_moss_qwen.py \
  --model /opt/moss-build/source/MOSS-Transcribe-Diarize \
  --output /opt/moss-build/moss-qwen3-repacked
```

Expected: `input_embeds.npy` final dimension is 1024; `.f32` byte count equals `n_tokens*1024*4`; generation contains timestamps and at least `S01`/`S02` for this fixture.

- [ ] **Step 8: Commit.**

```bash
git add tools/moss_rk3588 tests/tools/test_moss_reference_tools.py
git commit -m "feat: add MOSS reference and Qwen repack tools"
```

---

## Task 2: Gate A — prove `RKLLM_INPUT_EMBED` with real MOSS embeddings on RK3588

**Files:**
- Create: `tools/moss_rk3588/build_calibration_set.py`
- Create: `tools/moss_rk3588/build_rkllm.py`
- Create: `tools/moss_rk3588/compare_pytorch_rkllm.py`
- Create: `tools/moss_rk3588/native/rkllm_embed_probe.cpp`
- Create: `.github/workflows/rk3588-moss-embed-probe.yml`
- Create: `tests/release/test_rk3588_moss_embed_probe_workflow.py`

**Interfaces:**
- Input: Task 1 repacked model + reference directories.
- Output outside Git: `/opt/moss-build/moss_qwen3_0.6b_w8a8_rk3588.rkllm`.
- Native CLI: `rkllm_embed_probe MODEL INPUT_F32 N_TOKENS 1024 MAX_NEW_TOKENS`.
- **Hard gate:** do not begin Task 3 until this passes.

- [ ] **Step 1: Write a failing workflow contract test.**

```python
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
WORKFLOW = ROOT / ".github/workflows/rk3588-moss-embed-probe.yml"


def test_probe_is_manual_offline_and_rk3588_only():
    text = WORKFLOW.read_text(encoding="utf-8")
    assert "workflow_dispatch" in text
    assert "self-hosted" in text
    assert "rk3588" in text.lower()
    assert "RKLLM_INPUT_EMBED" in text
    assert "curl " not in text
    assert "wget " not in text
```

- [ ] **Step 2: Verify it fails.**

```bash
python3 -m pytest tests/release/test_rk3588_moss_embed_probe_workflow.py -q
```

- [ ] **Step 3: Build calibration data from captured MOSS embeddings.**

`build_calibration_set.py` accepts multiple reference directories, rejects tensors whose last dimension is not 1024, and writes the exact input-embedding dataset format expected by RKLLM Toolkit 1.3.0. Do not calibrate on pure text only.

- [ ] **Step 4: Convert the repacked MOSS Qwen3 to RKLLM W8A8.**

Use:

```python
from rkllm.api import RKLLM
llm = RKLLM()
assert llm.load_huggingface(model=args.model, device="cpu") == 0
assert llm.build(
    do_quantization=True,
    optimization_level=0,
    quantized_dtype="w8a8",
    quantized_algorithm="normal",
    target_platform="rk3588",
    num_npu_core=3,
    dataset=args.dataset,
) == 0
assert llm.export_rkllm(args.output) == 0
```

Abort unless `repack_manifest.json` identifies the source as MOSS.

- [ ] **Step 5: Implement the external-embedding C++ probe.**

Core call:

```cpp
RKLLMInput input{};
input.input_type = RKLLM_INPUT_EMBED;
input.role = "user";
input.enable_thinking = false;
input.embed_input.embed = embeds.data();
input.embed_input.n_tokens = n_tokens;

RKLLMInferParam infer{};
infer.mode = RKLLM_INFER_GENERATE;
infer.keep_history = 0;
infer.max_new_tokens = max_new_tokens;
int rc = rkllm_run(handle, &input, &infer, nullptr);
```

Validate raw file byte size before calling native code. Accumulate UTF-8 callback text and fail on `RKLLM_RUN_ERROR` or non-zero return.

- [ ] **Step 6: Add and run the manual hardware workflow.**

The runner requires these pre-staged files:

```text
/opt/moss-build/moss_qwen3_0.6b_w8a8_rk3588.rkllm
/opt/moss-build/reference-zh-2spk-45s/input_embeds.f32
/opt/moss-build/reference-zh-2spk-45s/reference.json
/lib/librkllmrt.so
```

Compile the probe against the RKLLM 1.3.0 header and `/lib/librkllmrt.so`. No package/model download step is allowed.

- [ ] **Step 7: Enforce Gate A.**

`compare_pytorch_rkllm.py` fails unless:

```text
- at least one timestamped segment parses;
- at least two speaker labels appear for the chosen 2-speaker fixture;
- normalized text character similarity to the PyTorch reference is >= 0.80;
- parsed speaker count differs from PyTorch by <= 1;
- output is valid UTF-8.
```

If Gate A fails, stop here and diagnose conversion/input semantics. Do not switch to stock Qwen3 or CPU Transformers as a hidden fallback.

- [ ] **Step 8: Commit after Gate A passes.**

```bash
python3 -m pytest tests/release/test_rk3588_moss_embed_probe_workflow.py -q
git add tools/moss_rk3588 .github/workflows/rk3588-moss-embed-probe.yml tests/release/test_rk3588_moss_embed_probe_workflow.py
git commit -m "test: prove MOSS embeddings on RKLLM"
```

---

## Task 3: Gate B — convert Whisper-Medium + merge + VQAdaptor to RKNN FP16

**Files:**
- Create: `tools/moss_rk3588/export_audio_encoder.py`
- Create: `tools/moss_rk3588/build_rknn.py`
- Create: `tools/moss_rk3588/compare_pytorch_rknn.py`
- Create: `tests/tools/test_moss_audio_export.py`
- Modify: `.github/workflows/rk3588-moss-embed-probe.yml`

**Interfaces:**
- ONNX input: float32 `[1,80,3000]`.
- ONNX/RKNN output: `[1,375,1024]`.
- Output outside Git: `/opt/moss-build/moss_audio_encoder_fp16_rk3588.rknn`.
- **Hard gate:** no worker implementation before numerical parity passes.

- [ ] **Step 1: Write the failing merge-shape test.**

```python
import torch
from tools.moss_rk3588.export_audio_encoder import MossAudioEncoderExport


def test_export_wrapper_merges_time_by_four(fake_whisper, fake_adaptor):
    model = MossAudioEncoderExport(fake_whisper, fake_adaptor, merge_size=4)
    out = model(torch.zeros(1, 80, 3000))
    assert out.shape[1] == 375
```

- [ ] **Step 2: Verify failure.**

```bash
python3 -m pytest tests/tools/test_moss_audio_export.py -q
```

- [ ] **Step 3: Implement export wrapper.**

```python
class MossAudioEncoderExport(torch.nn.Module):
    def __init__(self, whisper, adaptor, merge_size: int = 4):
        super().__init__()
        self.whisper = whisper
        self.adaptor = adaptor
        self.merge_size = merge_size

    def forward(self, input_features):
        feat = self.whisper(input_features, return_dict=True).last_hidden_state
        b, t, d = feat.shape
        t_trim = (t // self.merge_size) * self.merge_size
        merged = feat[:, :t_trim, :].reshape(b, t_trim // self.merge_size, d * self.merge_size)
        return self.adaptor(merged)
```

Export static ONNX and run ONNX Runtime once before reporting success.

- [ ] **Step 4: Build RKNN FP16.**

Use RKNN Toolkit2 with `target_platform="rk3588"` and `do_quantization=False`. Print model input/output metadata after build.

- [ ] **Step 5: Extend the RK3588 workflow and enforce Gate B.**

On the board, run one fixed 30-second fixture through RKNN Lite on `NPU_CORE_0_1_2`; compare to PyTorch adapted audio embeddings. Require:

```text
shape == [1,375,1024]
all values finite
flattened cosine similarity >= 0.995
mean absolute error <= 0.03
```

If Gate B fails, diagnose FP16/export/operator differences. Do not introduce INT8 acoustic quantization.

- [ ] **Step 6: Commit after Gate B passes.**

```bash
python3 -m pytest tests/tools/test_moss_audio_export.py tests/release/test_rk3588_moss_embed_probe_workflow.py -q
git add tools/moss_rk3588 .github/workflows/rk3588-moss-embed-probe.yml tests/tools/test_moss_audio_export.py
git commit -m "feat: convert MOSS audio encoder to RKNN"
```

---

## Task 4: Build a reproducible runtime bundle and self-test assets

**Files:**
- Create: `tools/moss_rk3588/export_token_embedding.py`
- Create: `tools/moss_rk3588/build_manifest.py`
- Create: `tools/moss_rk3588/validate_bundle.py`
- Create: `tests/tools/test_moss_bundle_manifest.py`
- Modify: `.gitignore`

**Interfaces:**
- Bundle root: `/opt/suspect-interrogation/models/moss-rk3588` in production.
- `manifest.json` contains exact toolkit/runtime/model fingerprints and hashes.
- Self-test assets are generated from non-case fixture data and stay outside Git.

- [ ] **Step 1: Write the failing validator test.**

```python
from tools.moss_rk3588.validate_bundle import validate_manifest


def test_manifest_requires_core_models_and_selftests():
    errors = validate_manifest({"artifacts": {}}, existing_files=set())
    text = "\n".join(errors)
    assert "moss_audio_encoder_fp16_rk3588.rknn" in text
    assert "moss_qwen3_0.6b_w8a8_rk3588.rkllm" in text
    assert "selftest/encoder_input.npy" in text
    assert "selftest/decoder_input.f32" in text
```

- [ ] **Step 2: Export token embeddings as little-endian FP16.**

```python
weight = model.model.language_model.embed_tokens.weight.detach().cpu().to(torch.float16)
weight.numpy().astype("<f2", copy=False).tofile(output_path)
```

Write `token_embedding.json` with `rows`, `hidden_size=1024`, `dtype=fp16`, byte order, source fingerprint, and SHA-256.

- [ ] **Step 3: Build the manifest from measured values, not literals copied from examples.**

The script obtains the MOSS source Git SHA via `git -C SOURCE rev-parse HEAD`, refuses a dirty source checkout unless `--allow-dirty` is explicitly supplied, reads the selected checkpoint config for context/token settings, records RKNN Toolkit2 and RKLLM Toolkit 1.3.0 versions, and hashes every runtime artifact.

- [ ] **Step 4: Generate self-test inputs.**

Create from a fixed non-case fixture:

```text
selftest/encoder_input.npy       # [1,80,3000] float32
selftest/encoder_expected.json  # shape/finite-check metadata
selftest/decoder_input.f32       # short [n,1024] float32 embedding input
selftest/decoder_expected.json   # minimum structural generation checks
```

- [ ] **Step 5: Validate exact bundle layout.**

```text
moss-rk3588/
├─ moss_audio_encoder_fp16_rk3588.rknn
├─ moss_qwen3_0.6b_w8a8_rk3588.rkllm
├─ moss_token_embedding_fp16.bin
├─ token_embedding.json
├─ tokenizer.json
├─ tokenizer_config.json
├─ special_tokens_map.json
├─ generation_config.json
├─ processor_config.json
├─ manifest.json
└─ selftest/
   ├─ encoder_input.npy
   ├─ encoder_expected.json
   ├─ decoder_input.f32
   └─ decoder_expected.json
```

Validate hashes, embedding file byte count `rows*1024*2`, required audio token, time-marker config, decoder context, and self-test metadata.

- [ ] **Step 6: Ignore generated assets, run tests, commit.**

```bash
python3 -m pytest tests/tools/test_moss_bundle_manifest.py -q
git add tools/moss_rk3588 tests/tools/test_moss_bundle_manifest.py .gitignore
git commit -m "feat: define MOSS RK3588 model bundle"
```

---

## Task 5: Define job types, exact context budgeting, and the long-audio window chain

**Files:**
- Create: `linux/backend/moss_worker/__init__.py`
- Create: `linux/backend/moss_worker/types.py`
- Create: `linux/backend/moss_worker/context_budget.py`
- Create: `linux/backend/moss_worker/windowing.py`
- Create: `linux/backend/tests/test_moss_windowing.py`

**Interfaces:**
- `ContextBudgetPlanner(max_context_len=40960, generation_reserve_tokens=8192, safety_margin_tokens=512, prompt_token_count=512)`.
- `estimate_expanded_input_tokens(duration_ms: int) -> int` reproduces audio token + digit-marker counts.
- `plan_window(start_ms: int, remaining_ms: int, index: int) -> WindowSpec`.
- `build_window_chain(total_ms: int, planner: ContextBudgetPlanner) -> list[WindowSpec]`.
- For non-first windows, `logical_chunk_index = (start_ms + overlap_ms) // 3_600_000`; this makes bridge window `55-90m` belong to logical chunk 1 because its non-overlap ownership begins at 60m.

- [ ] **Step 1: Write failing exact-count and chain tests.**

```python
from moss_worker.context_budget import ContextBudgetPlanner
from moss_worker.windowing import build_window_chain


def test_35_minute_default_input_count_matches_moss_markers():
    p = ContextBudgetPlanner(prompt_token_count=0)
    assert p.estimate_expanded_input_tokens(35 * 60_000) == 26_250 + 3_648


def test_nominal_two_hour_chain_has_cross_hour_overlap():
    p = ContextBudgetPlanner(prompt_token_count=512)
    w = build_window_chain(120 * 60_000, p)
    assert [(x.start_ms // 60_000, x.duration_ms // 60_000) for x in w[:4]] == [(0,35),(30,30),(55,35),(85,35)]
    assert w[2].logical_chunk_index == 1


def test_small_context_uses_only_approved_fallback_durations():
    p = ContextBudgetPlanner(max_context_len=34_000, prompt_token_count=512)
    spec = p.plan_window(0, 60 * 60_000, 0)
    assert spec.duration_ms // 60_000 in {30,25,20}
    assert spec.duration_ms >= 20 * 60_000
```

Note: the second nominal window ends at the 60-minute recording boundary and is therefore 30 minutes long; later bridge windows resume the 35-minute target.

- [ ] **Step 2: Verify failure.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_windowing.py -q
```

- [ ] **Step 3: Define types.**

`types.py` defines `JobState`, `WindowState`, `ParseStatus`, `MergeStatus`, `WindowSpec`, `RawSegment`, `NormalizedSegment`, `WindowResult`, `JobSnapshot`, and `JobResult`, each with deterministic `to_dict()`/`from_dict()` methods.

- [ ] **Step 4: Implement context accounting exactly.**

For checkpoint defaults, audio placeholders are `ceil(duration_seconds*12.5)`. For every integer marker second `2,4,...,floor(duration_seconds)` add `len(str(second))` digit-token positions. Total input count = audio placeholders + digit tokens + prompt tokens. Fit iff input + 8192 generation reserve + 512 safety <= context.

- [ ] **Step 5: Implement the chain.**

The next window starts at `previous.end_ms - 5min`. Clip final window to recording end. Do not use a fixed stride when a window has been shrunk.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_windowing.py -q
cd ../..
git add linux/backend/moss_worker linux/backend/tests/test_moss_windowing.py
git commit -m "feat: plan MOSS long-audio windows"
```

---

## Task 6: Reproduce MOSS processor semantics and construct external embeddings

**Files:**
- Create: `linux/backend/requirements-moss-rk3588.txt`
- Create: `linux/backend/moss_worker/embedding_builder.py`
- Create: `linux/backend/tests/test_moss_embedding_builder.py`

**Interfaces:**
- `TokenEmbeddingTable(path: Path, metadata_path: Path)` memory-maps FP16 weights.
- `MossEmbeddingBuilder.build_audio_span_ids(audio_seq_len: int) -> list[int]`.
- `MossEmbeddingBuilder.build(prompt: str, audio_embeds: np.ndarray) -> BuiltEmbeddings`.

- [ ] **Step 1: Add board-only dependencies.**

```text
numpy>=1.26,<3
tokenizers>=0.20,<1
```

Do not add PyTorch or Transformers to the production backend environment.

- [ ] **Step 2: Write failing tests for marker insertion and masked replacement.**

```python
def test_markers_do_not_consume_audio_features(fake_builder):
    ids = fake_builder.build_audio_span_ids(50)
    assert ids.count(fake_builder.audio_token_id) == 50
    assert fake_builder.digit_token_ids["2"] in ids
    assert fake_builder.digit_token_ids["4"] in ids


def test_only_audio_positions_are_replaced(fake_builder):
    audio = np.arange(32, dtype=np.float32).reshape(4, 8)
    built = fake_builder.build_from_ids([10,99,11,99,99,99,12], audio)
    np.testing.assert_allclose(built.embeds[built.audio_positions], audio)
```

- [ ] **Step 3: Implement FP16 mmap lookup.**

Reject out-of-range token IDs; gather only requested rows; convert selected rows to C-contiguous FP32.

- [ ] **Step 4: Port MOSS audio-span insertion exactly.**

Load `audio_tokens_per_second`, `time_marker_every_seconds`, `audio_token_id`, and digit-token IDs from bundle configs. Number marker token positions must not reduce the number of audio placeholders.

- [ ] **Step 5: Build final embeddings and enforce context guard.**

Tokenize the MOSS chat prompt, expand the audio span, lookup normal/digit embeddings, replace only audio placeholder positions in order, and reject if `n_tokens + generation_reserve + safety_margin > max_context_len` with `MOSS_CONTEXT_OVERFLOW` details.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_embedding_builder.py tests/test_moss_windowing.py -q
cd ../..
git add linux/backend/requirements-moss-rk3588.txt linux/backend/moss_worker/embedding_builder.py linux/backend/tests/test_moss_embedding_builder.py
git commit -m "feat: construct MOSS RKLLM embeddings"
```

---

## Task 7: Parse MOSS generations into absolute-time normalized segments

**Files:**
- Create: `linux/backend/moss_worker/parser.py`
- Create: `linux/backend/tests/test_moss_parser.py`

**Interfaces:**
- `parse_generation(raw: str, window: WindowSpec) -> ParsedGeneration`.
- `ParsedGeneration` contains `valid_segments`, `invalid_fragments`, and raw text.

- [ ] **Step 1: Write failing parser tests.**

```python
def test_parser_offsets_time(window_30m):
    out = parse_generation("[12.0][S01]你好[13.5]", window_30m)
    s = out.valid_segments[0]
    assert s.start_ms == 30 * 60_000 + 12_000
    assert s.end_ms == 30 * 60_000 + 13_500
    assert s.parse_status is ParseStatus.VALID


def test_missing_end_repairs_from_next_start(window_30m):
    out = parse_generation("[1.0][S01]第一句[2.5][S02]第二句[3.0]", window_30m)
    assert out.valid_segments[0].end_ms == 30 * 60_000 + 2_500
    assert out.valid_segments[0].parse_status is ParseStatus.REPAIRED
```

- [ ] **Step 2: Verify failure.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_parser.py -q
```

- [ ] **Step 3: Implement strict parsing.**

Accept `S` plus at least two digits, non-negative monotonic timestamps, non-empty Unicode-trimmed text, and `end>=start`. Convert to absolute milliseconds immediately.

- [ ] **Step 4: Implement only deterministic repair.**

A missing end may use the next segment start. A final segment with no reliable end is `INVALID`; retain its raw fragment and exclude it from the authoritative timeline.

- [ ] **Step 5: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_parser.py -q
cd ../..
git add linux/backend/moss_worker/parser.py linux/backend/tests/test_moss_parser.py
git commit -m "feat: parse MOSS diarized output"
```

---

## Task 8: Preserve anonymous speakers across windows and deduplicate overlap

**Files:**
- Create: `linux/backend/moss_worker/speaker_remap.py`
- Create: `linux/backend/moss_worker/merger.py`
- Create: `linux/backend/tests/test_moss_speaker_remap.py`
- Create: `linux/backend/tests/test_moss_merger.py`

**Interfaces:**
- `SpeakerRemapper.map_adjacent(previous: WindowResult, current: WindowResult, state: GlobalSpeakerState) -> SpeakerMappingResult`.
- `merge_adjacent(previous: list[NormalizedSegment], current: list[NormalizedSegment], mapping: SpeakerMappingResult) -> MergeResult`.

- [ ] **Step 1: Write failing one-to-one correspondence tests.**

Create scripted overlap where previous `S01` matches current `S03` repeatedly and previous `S02` matches current `S01`. Assert distinct current speakers cannot map to the same prior `GSxx`.

- [ ] **Step 2: Implement segment scoring.**

```python
score = (
    0.45 * time_iou
    + 0.35 * text_similarity
    + 0.10 * duration_similarity
    + 0.10 * order_similarity
)
```

Normalize text with Unicode NFKC, whitespace collapse, and punctuation removal; use `difflib.SequenceMatcher` for text similarity.

- [ ] **Step 3: Implement deterministic maximum-weight one-to-one assignment.**

Enumerate permutations of the smaller speaker set; maximize total correspondence score; lexicographic local-speaker order is the tie breaker. Do not add SciPy.

- [ ] **Step 4: Implement confidence policy.**

`>=0.85` inherits existing `GSxx`; lower scores allocate a new `GSxx` and store candidate evidence. Never retroactively rewrite earlier segment speaker labels.

- [ ] **Step 5: Write and implement overlap merger tests.**

For overlap `30:00-35:00`, midpoint ownership is `32:30`. Never split a segment crossing that boundary. Prefer the complete segment farther from its source-window edge. Materially different matched text stores `alternate_text` and `merge_conflict=True`.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_speaker_remap.py tests/test_moss_merger.py -q
cd ../..
git add linux/backend/moss_worker/speaker_remap.py linux/backend/moss_worker/merger.py linux/backend/tests/test_moss_speaker_remap.py linux/backend/tests/test_moss_merger.py
git commit -m "feat: merge MOSS speakers across windows"
```

---

## Task 9: Add durable spool storage and crash-safe checkpoints

**Files:**
- Create: `linux/backend/moss_worker/storage.py`
- Create: `linux/backend/tests/test_moss_storage.py`

**Interfaces:**
- `MossSpool(root: Path)`.
- Methods: `create_job`, `load_job`, `save_job`, `save_window_result`, `load_completed_windows`, `save_speaker_state`, `save_merged_segments`.

- [ ] **Step 1: Write failing atomic-write tests.**

Assert writes use a temporary sibling file, flush + `os.fsync`, then `os.replace`; if serialization fails before replace, the previous destination remains valid.

- [ ] **Step 2: Implement exact job layout.**

```text
/var/lib/suspect-interrogation/moss/jobs/<job_id>/
├─ job.json
├─ windows.json
├─ speaker_state.json
├─ merged_segments.jsonl
├─ raw_generations/<window_id>.txt
├─ checkpoints/<window_id>.json
└─ logs/events.jsonl
```

- [ ] **Step 3: Enforce audio integrity.**

Hash original WAV on creation and again on resume. If it changes, fail with `MOSS_AUDIO_CHANGED`.

- [ ] **Step 4: Preserve revisions.**

A rerun under a different manifest always gets a new job ID/directory even when audio SHA matches.

- [ ] **Step 5: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_storage.py -q
cd ../..
git add linux/backend/moss_worker/storage.py linux/backend/tests/test_moss_storage.py
git commit -m "feat: persist MOSS checkpoints"
```

---

## Task 10: Implement RKNN/RKLLM wrappers and one-window child-process inference

**Files:**
- Create: `linux/backend/moss_worker/audio_frontend.py`
- Create: `linux/backend/moss_worker/rknn_audio_encoder.py`
- Create: `linux/backend/moss_worker/rkllm_decoder.py`
- Create: `linux/backend/moss_worker/runtime.py`
- Create: `linux/backend/moss_worker/child.py`
- Create: `linux/backend/tests/test_moss_runtime_contract.py`

**Interfaces:**
- `AudioFrontend.micro_chunks(wav_path: Path, start_ms: int, end_ms: int) -> Iterator[AudioMicroChunk]`.
- Phase 1 accepted source format: **PCM16, mono, 16,000 Hz WAV only**. Any other format fails with `MOSS_AUDIO_UNSUPPORTED_FORMAT`; no implicit resampler is added in this plan.
- `RknnAudioEncoder.encode(input_features: np.ndarray, valid_tokens: int) -> np.ndarray`.
- `RkllmDecoder.generate(embeds: np.ndarray, max_new_tokens: int) -> DecodeResult`.
- `MossRuntime.infer_window(window: WindowSpec, wav_path: Path) -> WindowResult`.

- [ ] **Step 1: Write a failing fake-runtime ordering test.**

```python
def test_window_runtime_orders_stages(fake_runtime, window, wav):
    result = fake_runtime.infer_window(window, wav)
    assert fake_runtime.trace == ["ENCODING", "BUILDING_EMBEDS", "DECODING", "PARSING"]
    assert result.segments[0].global_speaker is None
```

- [ ] **Step 2: Implement exact audio contract and 30-second slicing.**

Use Python `wave`; require sample width 2, one channel, 16000 Hz. Convert PCM16 to float32 `[-1,1]`. Use Whisper preprocessing constants copied into `processor_config.json` by Task 4. Pad the last acoustic micro-chunk to 30 seconds and compute `valid_tokens` from real sample count.

- [ ] **Step 3: Implement the RKNN wrapper.**

Load once with `RKNNLite`, initialize `NPU_CORE_0_1_2`, require output last dimension 1024, reject NaN/Inf, and return only `output[:, :valid_tokens, :]`.

- [ ] **Step 4: Implement an RKLLM 1.3.0 ctypes wrapper.**

Bind only functions/structures used by the pinned header. Require C-contiguous float32 `[n_tokens,1024]`, `RKLLM_INPUT_EMBED`, `role="user"`, `enable_thinking=False`, `keep_history=0`. Raise `MOSS_RKLLM_INFERENCE_FAILED` with native return code/state on failure.

- [ ] **Step 5: Implement `infer_window`.**

Serially encode all 30-second micro-chunks, concatenate valid audio embeddings, build Task 6 input, decode with RKLLM, parse Task 7 output, and record per-stage durations plus RKLLM performance counters.

- [ ] **Step 6: Implement child startup self-test using Task 4 assets.**

Run `selftest/encoder_input.npy` through RKNN and require expected shape/finite values. Run `selftest/decoder_input.f32` through RKLLM and apply structural checks from `decoder_expected.json`. Failure returns `NOT_READY` and exits non-zero.

- [ ] **Step 7: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_runtime_contract.py tests/test_moss_embedding_builder.py tests/test_moss_parser.py -q
cd ../..
git add linux/backend/moss_worker linux/backend/tests/test_moss_runtime_contract.py
git commit -m "feat: add isolated MOSS NPU runtime"
```

---

## Task 11: Add job supervisor, queueing, retry ladder, cancellation, and native-crash recovery

**Files:**
- Create: `linux/backend/moss_worker/supervisor.py`
- Create: `linux/backend/tests/test_moss_supervisor.py`

**Interfaces:**
- `submit(JobRequest) -> JobSnapshot`
- `get_job(job_id: str) -> JobSnapshot`
- `get_result(job_id: str) -> JobResult`
- `cancel(job_id: str) -> JobSnapshot`

- [ ] **Step 1: Write failing queue/crash tests.**

Use a fake child that exits on `w0002`. Assert `w0001` stays DONE, child restart occurs, and a second job stays QUEUED while the first is active.

- [ ] **Step 2: Implement allowed job transitions.**

```text
QUEUED -> PREPARING -> ENCODING -> BUILDING_EMBEDS -> DECODING -> PARSING -> REMAPPING -> MERGING -> COMPLETED
```

Any non-terminal state may enter FAILED or CANCELLED when policy allows. Reject transitions out of COMPLETED/FAILED/CANCELLED.

- [ ] **Step 3: Implement retry ladder.**

Only `MOSS_CONTEXT_OVERFLOW` and recoverable `MOSS_OOM` trigger 35->30->25->20 minute replanning. Recompute following starts as `successful_end - 5min`.

- [ ] **Step 4: Implement native-crash recovery.**

Record exit status/signal, reap child, start a clean child, reload/self-test models, retry the current window once. A second native crash on the same window fails the job.

- [ ] **Step 5: Implement cancellation.**

QUEUED jobs cancel immediately. Running jobs set `cancel_requested` and stop at the next safe boundary; if the native call exceeds the configured 10-second cancel grace, terminate/restart the child and mark job CANCELLED while preserving completed checkpoints.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_supervisor.py tests/test_moss_storage.py -q
cd ../..
git add linux/backend/moss_worker/supervisor.py linux/backend/tests/test_moss_supervisor.py
git commit -m "feat: supervise durable MOSS jobs"
```

---

## Task 12: Expose the MOSS job API over a local Unix socket

**Files:**
- Create: `linux/backend/moss_worker/protocol.py`
- Create: `linux/backend/moss_worker/main.py`
- Create: `linux/backend/app/ai/moss/__init__.py`
- Create: `linux/backend/app/ai/moss/types.py`
- Create: `linux/backend/app/ai/moss/client.py`
- Create: `linux/backend/tests/test_moss_protocol.py`
- Create: `linux/backend/tests/test_moss_client_server.py`

**Interfaces:**
- Socket: `/run/suspect-interrogation/moss.sock`.
- Ops: `health`, `submit_job`, `get_job`, `get_result`, `cancel_job`.
- Wire envelope matches existing speech worker: `request_id`, `ok`, `result` or structured `error`.

- [ ] **Step 1: Write failing framing tests.**

Use 4-byte big-endian JSON length prefix; `MAX_MESSAGE_BYTES=16*1024*1024`; reject truncated, oversized, and non-object JSON messages.

- [ ] **Step 2: Define exact worker errors.**

```text
MOSS_MODEL_LOAD_FAILED
MOSS_RKNN_INFERENCE_FAILED
MOSS_RKLLM_INFERENCE_FAILED
MOSS_CONTEXT_OVERFLOW
MOSS_OOM
MOSS_INVALID_GENERATION
MOSS_AUDIO_CORRUPT
MOSS_AUDIO_UNSUPPORTED_FORMAT
MOSS_AUDIO_CHANGED
MOSS_CANCELLED
MOSS_JOB_NOT_FOUND
MOSS_WORKER_CRASHED
```

- [ ] **Step 3: Implement stale-socket-safe server binding.**

Refuse to unlink a non-socket path; probe existing socket before removing stale socket; chmod the new socket `0660`; never remove an active listener.

- [ ] **Step 4: Implement `MossWorkerClient`.**

```python
class MossWorkerClient:
    def health(self) -> dict[str, object]: ...
    def submit_job(self, audio_path: str, audio_sha256: str | None = None) -> MossJobSnapshot: ...
    def get_job(self, job_id: str) -> MossJobSnapshot: ...
    def get_result(self, job_id: str) -> MossJobResult: ...
    def cancel_job(self, job_id: str) -> MossJobSnapshot: ...
```

Validate request IDs and structured errors exactly as `app/ai/speech/client.py` does.

- [ ] **Step 5: Add fake-supervisor integration tests.**

Start server on a temporary Unix socket, exercise all five ops, malformed responses, and two concurrent clients.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_protocol.py tests/test_moss_client_server.py -q
cd ../..
git add linux/backend/moss_worker/protocol.py linux/backend/moss_worker/main.py linux/backend/app/ai/moss linux/backend/tests/test_moss_protocol.py linux/backend/tests/test_moss_client_server.py
git commit -m "feat: expose MOSS worker socket API"
```

---

## Task 13: Integrate settings, model registry, service layer, and optional health capability

**Files:**
- Modify: `linux/backend/app/ai/settings.py`
- Modify: `linux/backend/app/ai/registry.py`
- Modify: `linux/backend/config/model-registry.yaml`
- Create: `linux/backend/app/services/moss_transcription.py`
- Modify: `linux/backend/app/health.py`
- Create: `linux/backend/tests/test_moss_settings_registry.py`
- Create: `linux/backend/tests/test_moss_service.py`
- Modify: `linux/backend/tests/test_health_contract.py`
- Modify: `linux/backend/tests/test_capability_health.py`

**Interfaces:**
- Settings: `moss_enabled`, `moss_socket`, `moss_spool_root`, `moss_model_id`.
- `MossTranscriptionService` exposes submit/status/result/cancel; it never maps `GSxx` to a named person.

- [ ] **Step 1: Write failing settings/registry tests.**

Assert defaults:

```text
MOSS_ENABLED=0
SUSPECT_MOSS_SOCKET=/run/suspect-interrogation/moss.sock
MOSS_SPOOL_ROOT=/var/lib/suspect-interrogation/moss
MOSS_MODEL_ID=moss.default
```

Add `moss` to allowed registry kinds; do not repurpose `asr.default` or `llm.default`.

- [ ] **Step 2: Register `moss.default`.**

Use the verified Task 4 bundle metadata. Required files include both NPU models, token embedding metadata/data, tokenizer, processor config, and manifest. Capabilities: `transcription`, `diarization`, `timestamps`, `long_audio`. Device: `npu`.

- [ ] **Step 3: Implement `MossTranscriptionService`.**

Resolve/check the audio path, hash it when no hash is supplied, submit through `MossWorkerClient`, and return typed job/result snapshots only.

- [ ] **Step 4: Add optional MOSS health.**

When `MOSS_ENABLED=0`, `/health/ready` remains ready/degraded according to existing checks and reports MOSS disabled. When enabled, add a non-required `moss` capability containing worker state, model readiness, manifest SHA, queue depth, active job, runtime versions, and last error. MOSS failure must not silently disable realtime ASR.

- [ ] **Step 5: Run exact tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_settings_registry.py tests/test_moss_service.py tests/test_health_contract.py tests/test_capability_health.py -q
cd ../..
git add linux/backend/app/ai/settings.py linux/backend/app/ai/registry.py linux/backend/config/model-registry.yaml linux/backend/app/services/moss_transcription.py linux/backend/app/health.py linux/backend/tests/test_moss_settings_registry.py linux/backend/tests/test_moss_service.py linux/backend/tests/test_health_contract.py linux/backend/tests/test_capability_health.py
git commit -m "feat: integrate MOSS backend capability"
```

---

## Task 14: Add systemd deployment and offline RK3588 health probe

**Files:**
- Create: `systemd/moss-worker.service`
- Modify: `.github/workflows/rk3588-service-bootstrap.yml`
- Modify: `.github/workflows/rk3588-production-redeploy.yml`
- Modify: `.github/workflows/linux-ai-runtime-rk3588.yml`
- Create: `scripts/ci/probe-moss-rk3588.py`
- Create: `tests/release/test_moss_systemd_and_deploy.py`
- Modify: `docs/release/RK3588-EVIDENCE.md`

**Interfaces:**
- Service user/group: `suspect-interrogation`.
- Model root: `/opt/suspect-interrogation/models/moss-rk3588`.
- Spool: `/var/lib/suspect-interrogation/moss`.
- Native libs: `/lib/librknnrt.so`, `/lib/librkllmrt.so`.
- Environment: `/etc/suspect-interrogation/moss-worker.env`.

- [ ] **Step 1: Write failing systemd/deploy contract tests.**

Assert `User=suspect-interrogation`, `Group=suspect-interrogation`, `RuntimeDirectory=suspect-interrogation`, `Restart=on-failure`, no TCP/8000 binding, read/write access only to `/run/suspect-interrogation`, `/var/lib/suspect-interrogation`, `/var/log/suspect-interrogation`, and read-only model/runtime paths.

- [ ] **Step 2: Create `moss-worker.service`.**

Required service body includes:

```text
User=suspect-interrogation
Group=suspect-interrogation
WorkingDirectory=/opt/suspect-interrogation/current/linux/backend
EnvironmentFile=/etc/suspect-interrogation/runtime.env
EnvironmentFile=-/etc/suspect-interrogation/moss-worker.env
Environment=SUSPECT_MOSS_SOCKET=/run/suspect-interrogation/moss.sock
Environment=MOSS_MODEL_ROOT=/opt/suspect-interrogation/models/moss-rk3588
RuntimeDirectory=suspect-interrogation
ExecStart=/opt/suspect-interrogation/current/.venv/bin/python -m moss_worker.main
Restart=on-failure
RestartSec=5s
ReadWritePaths=/run/suspect-interrogation /var/lib/suspect-interrogation /var/log/suspect-interrogation
ReadOnlyPaths=-/opt/suspect-interrogation/models/moss-rk3588 -/lib/librknnrt.so -/lib/librkllmrt.so
```

Retain the same hardening directives used by `ai-worker.service` (`NoNewPrivileges`, `PrivateTmp`, `ProtectSystem=strict`, kernel/control-group protections, empty capability bounding set).

- [ ] **Step 3: Implement read-only probe.**

`probe-moss-rk3588.py` verifies bundle hashes, both `/lib` native libraries, socket health, architecture `aarch64`, model state, queue depth, manifest SHA, and runtime versions. It never submits case audio and never downloads anything.

- [ ] **Step 4: Integrate bootstrap.**

Create spool directory owned by `suspect-interrogation`, install the service, daemon-reload, and enable it. Install `requirements-moss-rk3588.txt` only from the repository/runner's pre-staged offline wheel source; workflow must not call public package indexes.

- [ ] **Step 5: Integrate production redeploy.**

Restart `moss-worker.service` during the atomic release transition when MOSS is enabled; preserve shared model and spool directories across releases. Do not touch the service/process owning TCP/8000.

- [ ] **Step 6: Run tests and commit.**

```bash
python3 -m pytest tests/release/test_moss_systemd_and_deploy.py -q
git add systemd/moss-worker.service .github/workflows/rk3588-service-bootstrap.yml .github/workflows/rk3588-production-redeploy.yml .github/workflows/linux-ai-runtime-rk3588.yml scripts/ci/probe-moss-rk3588.py tests/release/test_moss_systemd_and_deploy.py docs/release/RK3588-EVIDENCE.md
git commit -m "ops: deploy MOSS worker on RK3588"
```

---

## Task 15: Add end-to-end long-audio acceptance and complete production verification

**Files:**
- Create: `linux/backend/tests/fixtures/moss/README.md`
- Create: `linux/backend/tests/test_moss_e2e_mock.py`
- Create: `scripts/ci/moss-rk3588-acceptance.py`
- Create: `.github/workflows/rk3588-moss-acceptance.yml`
- Create: `tests/release/test_rk3588_moss_acceptance_workflow.py`
- Modify: `docs/release/RK3588-EVIDENCE.md`

**Interfaces:**
- Real acceptance audio lives outside Git at `/opt/moss-acceptance/audio`.
- Acceptance output is JSON with audio SHA, manifest SHA, duration, window count, RTF, GS speaker stats, mapping confidence, conflicts, retries, and terminal status.

- [ ] **Step 1: Write deterministic mock long-audio tests.**

Use a fake runtime for a virtual 125-minute recording and assert: cross-hour overlap, local-speaker relabeling but stable strong-evidence `GSxx`, overlap deduplication, alternate text preservation, crash resume without recomputing prior windows, and cancellation preserving checkpoints.

- [ ] **Step 2: Define the fixed external hardware corpus.**

```text
/opt/moss-acceptance/audio/
├─ 01_single_speaker_05m.wav
├─ 02_two_speaker_30m.wav
├─ 03_two_speaker_60m.wav
├─ 04_three_speaker_65m.wav
├─ 05_overlap_boundary_70m.wav
├─ 06_silence_noise_30m.wav
└─ 07_two_speaker_120m.wav
```

Each file is PCM16 mono 16 kHz and has a same-basename `.json` sidecar recording expected minimum speaker count, language, duration, and whether cross-hour continuity is required. Workflow fails clearly when corpus is absent; it does not download substitutes.

- [ ] **Step 3: Implement hardware acceptance runner.**

For each fixture: submit through MOSS socket, poll to terminal state, calculate `RTF=processing_seconds/audio_seconds`, verify timestamps are finite/monotonic/in range, record `GSxx` count, mapping-confidence distribution, parse repairs/invalids, conflicts, retries, and manifest SHA.

- [ ] **Step 4: Enforce Phase 1 acceptance gates.**

```text
30-minute two-speaker fixture: RTF <= 1.0
60-minute fixture: completes without crash/OOM and yields one merged timeline
65/70-minute fixtures: demonstrate speaker continuity across hour boundary
120-minute fixture: completes through chained windows
all completed segments: absolute timestamps monotonic and in range
all completed segments: source window_id and model_manifest_sha256 present
workflow: no network download command
```

`RTF<=0.5` is recorded as the next optimization target, not a Phase 1 gate.

- [ ] **Step 5: Run software suites.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_*.py -q
cd ../..
python3 -m pytest tests/tools/test_moss_*.py tests/release/test_moss_*.py tests/release/test_rk3588_moss_*.py -q
```

Expected: PASS.

- [ ] **Step 6: Commit acceptance coverage.**

```bash
git add linux/backend/tests/fixtures/moss linux/backend/tests/test_moss_e2e_mock.py scripts/ci/moss-rk3588-acceptance.py .github/workflows/rk3588-moss-acceptance.yml tests/release/test_rk3588_moss_acceptance_workflow.py docs/release/RK3588-EVIDENCE.md
git commit -m "test: add MOSS RK3588 acceptance coverage"
```

- [ ] **Step 7: Run the real RK3588 MOSS acceptance workflow.**

Gate A and Gate B must still pass for the exact model artifacts used by the final source revision. Save workflow run ID and acceptance JSON reference in `docs/release/RK3588-EVIDENCE.md`.

- [ ] **Step 8: Complete the exact production Definition of Done from `AGENTS.md`.**

For the exact final commit SHA:

```text
1. Relevant CI gates are green.
2. RK3588 Production Redeploy ran for that exact SHA.
3. Frontend/backend release is atomically installed from that SHA.
4. https://192.168.0.9:18080 validates with the project LAN CA; do not use -k.
5. /health/live and /health/ready validate with TLS verification.
6. MOSS capability reports ready and the expected manifest SHA.
7. A short production-host offline MOSS fixture returns timestamped GSxx output.
8. Browser audio endpoints still derive wss:// from HTTPS origin.
9. Deployed release SHA equals GitHub final commit SHA.
10. TCP/8000 remains listening and owned by the pre-existing FunASR service.
```

Do not report complete before all ten checks pass. If source is committed but production deployment fails, report exactly: **code committed, production deployment incomplete**.

---

## Execution Gates

```text
Task 1  PyTorch golden reference + MOSS Qwen repack
  -> Task 2 Gate A: real MOSS external embeddings on RKLLM
  -> Task 3 Gate B: MOSS acoustic graph parity on RKNN
  -> Task 4 reproducible model bundle
  -> Tasks 5-12 worker correctness/durability/IPC
  -> Tasks 13-14 app + system deployment
  -> Task 15 long-audio acceptance + production verification
```

**Stop after Task 2** if `RKLLM_INPUT_EMBED` cannot reproduce structurally valid MOSS diarized output. Do not hide the failure with stock Qwen or CPU inference.

**Stop after Task 3** if RKNN FP16 cannot meet acoustic parity. Do not use INT8 as a workaround.

**Do not add ERes2Net identity binding in this plan.** That is a separately reviewed fusion phase after the standalone MOSS path is proven.
