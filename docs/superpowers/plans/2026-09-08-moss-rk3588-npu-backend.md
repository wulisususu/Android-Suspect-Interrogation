# MOSS-RK3588 NPU Backend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a standalone, fully offline MOSS-Transcribe-Diarize backend on one RK3588 32 GB device, using RKNN for the Whisper-Medium + VQAdaptor acoustic path, RKLLM for the MOSS-tuned Qwen3-0.6B decoder, and durable long-audio windowing with anonymous global speaker continuity.

**Architecture:** Keep the existing realtime `speech_worker` unchanged and introduce a separate `moss_worker` supervisor plus native inference child behind `/run/suspect-interrogation/moss.sock`. Convert model assets on a PC, prove the `inputs_embeds -> RKLLM_INPUT_EMBED` bridge before building the full worker, then add 30-second RKNN acoustic micro-chunks, MOSS-compatible embedding construction, 35-minute target windows with 5-minute overlap, global `GSxx` remapping, durable checkpoints, and production deployment.

**Tech Stack:** Python 3.11/3.12, NumPy, Hugging Face Transformers only in the PC conversion environment, `tokenizers` on the board runtime, RKNN Toolkit2 / RKNN Runtime, RKLLM Toolkit 1.3.x / RKLLM Runtime, Unix domain sockets, FastAPI, SQLAlchemy/Alembic only for business-level job linkage, systemd, GitHub Actions self-hosted RK3588 runner.

**Spec:** `docs/superpowers/specs/2026-09-08-moss-rk3588-npu-backend-design.md`

## Global Constraints

- Target hardware is one RK3588 with 32 GB RAM.
- Production inference must work with the device network disabled; no cloud API, model download, telemetry, or runtime update checks are allowed.
- Phase 1 is MOSS-only. Do not require Paraformer, FSMN-VAD, ERes2Net, or any real-person identity mapping to produce a transcript.
- The existing `speech_worker` and TCP/8000 service remain untouched and must stay available throughout development and deployment.
- MOSS heavy compute runs on the NPU: Whisper-Medium + 4x merge + VQAdaptor as RKNN FP16; MOSS-tuned Qwen3-0.6B as RKLLM W8A8.
- Do not substitute stock Qwen3-0.6B weights for the MOSS language-model weights.
- Runtime input to RKLLM is `RKLLM_INPUT_EMBED`; the board constructs the full `n_tokens x 1024` embedding sequence and reproduces MOSS audio-placeholder replacement semantics.
- The user-facing scheduling unit is 60 minutes. Model windows target 35 minutes with 5 minutes overlap, but `ContextBudgetPlanner` may shrink a window to 30, 25, then 20 minutes. A window that cannot run at 20 minutes fails explicitly.
- Acoustic inference uses fixed 30-second micro-chunks. The last partial micro-chunk is padded, and only its valid adapted-token prefix is retained.
- First production acoustic quantization is FP16. Do not add INT8 acoustic quantization in this plan.
- First production decoder quantization is W8A8.
- `max_concurrent_moss_jobs = 1`, `max_concurrent_rknn_runs = 1`, and `max_concurrent_rkllm_runs = 1`.
- Raw WAV plus SHA-256 is the immutable source of truth. Window WAVs, features, embeddings, generations, and transcripts are derived artifacts and may be regenerated.
- Every normalized segment must retain provenance: source window, absolute timestamps, local speaker, global speaker, parse status, merge status, and model manifest SHA-256.
- Weak speaker correspondence never silently collapses two global speakers. Only `mapping_confidence >= 0.85` inherits an existing `GSxx`; weaker evidence allocates a new global label and records candidate evidence.
- Native RKNN/RKLLM execution runs in a child process. A native crash must not terminate the MOSS supervisor or FastAPI process.
- Model binaries, tokenizer embeddings, calibration tensors, test recordings containing real case audio, and generated `.rknn`/`.rkllm` files must never be committed to Git.
- Follow `AGENTS.md`: every source push to `linux-adaptation` must pass relevant CI, trigger RK3588 production redeploy, verify `https://192.168.0.9:18080`, verify `/health/live` and `/health/ready` with trusted TLS, verify deployed SHA, and prove TCP/8000 is preserved before reporting completion.
- Each task starts with a failing test or failing hardware verification, implements the smallest change that passes it, reruns focused tests, then commits.

---

## File Structure Map

The implementation should converge on this structure; tasks below create files only when their interface is needed.

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
├─ audio_frontend.py
├─ embedding_builder.py
├─ parser.py
├─ speaker_remap.py
├─ merger.py
├─ storage.py
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

## Task 1: Capture a PyTorch MOSS reference and repack the MOSS-tuned Qwen checkpoint

**Files:**
- Create: `tools/moss_rk3588/__init__.py`
- Create: `tools/moss_rk3588/requirements.txt`
- Create: `tools/moss_rk3588/capture_input_embeds.py`
- Create: `tools/moss_rk3588/repack_moss_qwen.py`
- Create: `tests/tools/test_moss_reference_tools.py`

**Interfaces:**
- Produces `capture_input_embeds.capture_reference(model_dir: Path, wav_path: Path, output_dir: Path) -> dict[str, object]`.
- Produces `repack_moss_qwen.repack_moss_qwen(model_dir: Path, output_dir: Path) -> dict[str, object]`.
- Reference directory contains `input_embeds.npy`, `input_ids.npy`, `attention_mask.npy`, `generation.txt`, `normalized_generation.json`, and `reference.json`.
- Repacked decoder directory contains standard Qwen3 config/weights, tokenizer files copied from MOSS, and `repack_manifest.json`.

- [ ] **Step 1: Write failing unit tests for deterministic manifest construction and MOSS key selection.**

Create `tests/tools/test_moss_reference_tools.py`:

```python
from pathlib import Path

from tools.moss_rk3588.capture_input_embeds import build_reference_manifest
from tools.moss_rk3588.repack_moss_qwen import classify_state_key


def test_reference_manifest_records_audio_and_tensor_shapes(tmp_path: Path):
    wav = tmp_path / "sample.wav"
    wav.write_bytes(b"RIFFtest")
    manifest = build_reference_manifest(
        wav_path=wav,
        model_fingerprint="moss-sha",
        input_shape=(1, 912, 1024),
        output_text="[0.0][S01]你好[0.8]",
    )
    assert manifest["audio_sha256"]
    assert manifest["input_shape"] == [1, 912, 1024]
    assert manifest["model_fingerprint"] == "moss-sha"


def test_repack_key_classifier_keeps_language_model_and_lm_head_only():
    assert classify_state_key("model.language_model.layers.0.self_attn.q_proj.weight") == "model.layers.0.self_attn.q_proj.weight"
    assert classify_state_key("lm_head.weight") == "lm_head.weight"
    assert classify_state_key("model.whisper_encoder.layers.0.self_attn.q_proj.weight") is None
    assert classify_state_key("model.vq_adaptor.layers.0.weight") is None
```

Run:

```bash
python3 -m pytest tests/tools/test_moss_reference_tools.py -q
```

Expected: FAIL because the tool modules do not exist.

- [ ] **Step 2: Add the PC-only conversion requirements.**

`tools/moss_rk3588/requirements.txt`:

```text
numpy>=1.26,<3
soundfile>=0.12,<1
transformers>=5.0,<6
huggingface-hub>=0.27,<1
torch>=2.5,<3
safetensors>=0.4,<1
onnx>=1.18,<2
```

Do not add RKNN/RKLLM Toolkit wheels to this text file because Rockchip distributes platform-specific wheels separately. The scripts in Tasks 2 and 3 must fail with a clear import error when those toolkits are absent.

- [ ] **Step 3: Implement the pure helpers and the reference-capture hook.**

The capture path must hook the input to the MOSS language model before generation and save the complete injected embeddings:

```python
captured: dict[str, object] = {}


def pre_hook(module, args, kwargs):
    embeds = kwargs["inputs_embeds"].detach().float().cpu().numpy()
    captured["inputs_embeds"] = embeds


handle = model.model.language_model.register_forward_pre_hook(pre_hook, with_kwargs=True)
try:
    output_ids = model.generate(**inputs, do_sample=False)
finally:
    handle.remove()
```

`build_reference_manifest()` must compute WAV SHA-256, record tensor shape/dtype, MOSS model directory fingerprint, Python/Torch/Transformers versions, and generated text. `capture_reference()` must refuse to overwrite an existing non-empty output directory unless the caller passes `--force`.

- [ ] **Step 4: Repack only the MOSS language model into a standard Qwen3-compatible directory.**

`classify_state_key()` implements exactly these mappings:

```python
def classify_state_key(key: str) -> str | None:
    prefix = "model.language_model."
    if key.startswith(prefix):
        return "model." + key[len(prefix):]
    if key == "lm_head.weight":
        return key
    return None
```

The CLI loads the MOSS checkpoint with `trust_remote_code=True`, writes a standard `Qwen3ForCausalLM` config using `model.config.text_config`, copies the selected state into the new model, saves with safetensors, copies tokenizer/chat-template files from the MOSS checkpoint, and asserts the repacked `lm_head.weight` matches the MOSS tensor shape.

- [ ] **Step 5: Run the focused tests.**

```bash
python3 -m pytest tests/tools/test_moss_reference_tools.py -q
```

Expected: PASS.

- [ ] **Step 6: Run one PC reference capture on a 30-60 second, 2-3 speaker Chinese fixture.**

```bash
python3 tools/moss_rk3588/capture_input_embeds.py \
  --model /srv/models/MOSS-Transcribe-Diarize \
  --wav /srv/moss-fixtures/zh_2spk_45s.wav \
  --output /srv/moss-build/reference-zh-2spk-45s

python3 tools/moss_rk3588/repack_moss_qwen.py \
  --model /srv/models/MOSS-Transcribe-Diarize \
  --output /srv/moss-build/moss-qwen3-repacked
```

Expected: both commands exit 0; `reference.json` records a 1024-wide embedding tensor and `generation.txt` contains timestamp and `[Sxx]` fields.

- [ ] **Step 7: Commit.**

```bash
git add tools/moss_rk3588 tests/tools/test_moss_reference_tools.py
git commit -m "feat: add MOSS reference capture and Qwen repack tools"
```

---

## Task 2: Prove the critical `inputs_embeds -> RKLLM_INPUT_EMBED` bridge on RK3588

**Files:**
- Create: `tools/moss_rk3588/build_calibration_set.py`
- Create: `tools/moss_rk3588/build_rkllm.py`
- Create: `tools/moss_rk3588/compare_pytorch_rkllm.py`
- Create: `tools/moss_rk3588/native/rkllm_embed_probe.cpp`
- Create: `.github/workflows/rk3588-moss-embed-probe.yml`
- Create: `tests/release/test_rk3588_moss_embed_probe_workflow.py`

**Interfaces:**
- Consumes the Task 1 repacked Qwen directory and captured `input_embeds.npy` samples.
- Produces `moss_qwen3_0.6b_w8a8_rk3588.rkllm` outside Git.
- `rkllm_embed_probe` CLI accepts `<model.rkllm> <input_embeds.f32> <n_tokens> <n_embed> <max_new_tokens>` and prints generated UTF-8 text to stdout.
- **Gate A:** later runtime tasks do not proceed until the board generates a structurally valid MOSS transcript from Task 1 embeddings.

- [ ] **Step 1: Write a failing workflow contract test.**

```python
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WORKFLOW = ROOT / ".github" / "workflows" / "rk3588-moss-embed-probe.yml"


def test_moss_embed_probe_is_manual_offline_and_uses_rk3588():
    text = WORKFLOW.read_text(encoding="utf-8")
    assert "workflow_dispatch" in text
    assert "self-hosted" in text
    assert "rk3588" in text.lower()
    assert "RKLLM_INPUT_EMBED" in text
    assert "curl " not in text
    assert "wget " not in text
```

Run and expect failure because the workflow does not exist.

- [ ] **Step 2: Build calibration input from real MOSS `inputs_embeds`.**

`build_calibration_set.py` reads one or more Task 1 reference directories and writes the RKLLM dataset format with the actual `inputs_embeds`, never pure-text-only calibration. Reject any sample whose final dimension is not 1024.

- [ ] **Step 3: Build the MOSS-tuned Qwen RKLLM model.**

`build_rkllm.py` uses:

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

The script aborts if the repack manifest does not identify a MOSS source checkpoint.

- [ ] **Step 4: Implement the minimal C++ external-embedding probe.**

The core invocation in `rkllm_embed_probe.cpp` must be:

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
if (rc != 0) {
    std::cerr << "rkllm_run failed: " << rc << "\n";
    return 4;
}
```

The callback appends `RKLLMResult.text` while state is `RKLLM_RUN_NORMAL` or `RKLLM_RUN_WAITING`, prints the final text on `RKLLM_RUN_FINISH`, and returns non-zero on `RKLLM_RUN_ERROR`.

- [ ] **Step 5: Add the manual RK3588 hardware workflow.**

The workflow checks that these operator-provided paths exist on the self-hosted runner:

```text
/opt/moss-build/moss_qwen3_0.6b_w8a8_rk3588.rkllm
/opt/moss-build/reference-zh-2spk-45s/input_embeds.f32
/opt/moss-build/reference-zh-2spk-45s/reference.json
```

It compiles the probe against `/usr/include/rkllm` and `/usr/lib/librkllmrt.so`, runs with network-dependent package installation disabled, captures output, and invokes `compare_pytorch_rkllm.py`.

- [ ] **Step 6: Define and run Gate A.**

`compare_pytorch_rkllm.py` normalizes both reference and RKLLM generations to parsed segment tuples and fails unless all are true:

```text
- RKLLM generation contains at least one timestamped segment.
- RKLLM generation contains at least two speaker labels for the 2-speaker fixture.
- Normalized text character overlap with the PyTorch reference is >= 0.80.
- Parsed speaker count differs from the PyTorch reference by at most 1.
- No NaN/Inf or invalid UTF-8 is observed.
```

Run the manual workflow. **If Gate A fails, stop the plan at Task 2 and investigate RKLLM conversion/input semantics before implementing the worker.**

- [ ] **Step 7: Run the contract test and commit after Gate A passes.**

```bash
python3 -m pytest tests/release/test_rk3588_moss_embed_probe_workflow.py -q
git add tools/moss_rk3588 .github/workflows/rk3588-moss-embed-probe.yml tests/release/test_rk3588_moss_embed_probe_workflow.py
git commit -m "test: prove MOSS external embeddings on RKLLM"
```

---

## Task 3: Convert Whisper-Medium + 4x merge + VQAdaptor into one RKNN FP16 graph

**Files:**
- Create: `tools/moss_rk3588/export_audio_encoder.py`
- Create: `tools/moss_rk3588/build_rknn.py`
- Create: `tools/moss_rk3588/compare_pytorch_rknn.py`
- Create: `tests/tools/test_moss_audio_export.py`
- Extend: `.github/workflows/rk3588-moss-embed-probe.yml`

**Interfaces:**
- Produces ONNX input `input_features: float32[1,80,3000]` and output `audio_embeds: float32[1,375,1024]`.
- Produces `moss_audio_encoder_fp16_rk3588.rknn` outside Git.
- **Gate B:** board RKNN output must remain numerically close enough to the PyTorch audio features before full runtime work proceeds.

- [ ] **Step 1: Write a failing shape/merge test around an export wrapper.**

```python
import torch
from tools.moss_rk3588.export_audio_encoder import MossAudioEncoderExport


class FakeWhisper(torch.nn.Module):
    def forward(self, x, return_dict=True):
        y = torch.arange(1500 * 4, dtype=torch.float32).reshape(1, 1500, 4)
        return type("O", (), {"last_hidden_state": y})()


class FakeAdaptor(torch.nn.Module):
    def forward(self, x):
        return x[..., :4]


def test_export_wrapper_merges_time_by_four():
    model = MossAudioEncoderExport(FakeWhisper(), FakeAdaptor(), merge_size=4)
    out = model(torch.zeros(1, 80, 3000))
    assert out.shape == (1, 375, 4)
```

Expected: FAIL before the export wrapper exists.

- [ ] **Step 2: Implement `MossAudioEncoderExport`.**

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
        t = (t // self.merge_size) * self.merge_size
        merged = feat[:, :t, :].reshape(b, t // self.merge_size, d * self.merge_size)
        return self.adaptor(merged)
```

The CLI loads Whisper and adaptor weights from the MOSS checkpoint, exports with static shapes, and runs ONNX Runtime once on the same fixture before reporting success.

- [ ] **Step 3: Convert ONNX to RKNN FP16 without quantization.**

The build script must call RKNN Toolkit2 with `target_platform="rk3588"`, no quantization dataset, and export the result. It prints input/output tensor metadata after build.

- [ ] **Step 4: Save PyTorch acoustic reference tensors for the same 30-second fixture.**

`compare_pytorch_rknn.py --write-reference` saves the adapted MOSS audio embedding tensor and `valid_audio_tokens` for a fixture. The fixture may be synthetic or licensed test audio, never case evidence.

- [ ] **Step 5: Extend the RK3588 workflow to run RKNN parity.**

The board step uses `rknnlite.api.RKNNLite`, runs exactly one `[1,80,3000]` input, saves output, and compares against the reference. Gate B requires:

```text
shape == [1,375,1024]
all values finite
cosine similarity of flattened outputs >= 0.995
mean absolute error <= 0.03
```

If the numerical gate is missed, retain FP16 and diagnose export/operator differences rather than adding quantization.

- [ ] **Step 6: Run focused tests and commit after Gate B passes.**

```bash
python3 -m pytest tests/tools/test_moss_audio_export.py tests/release/test_rk3588_moss_embed_probe_workflow.py -q
git add tools/moss_rk3588 tests/tools/test_moss_audio_export.py .github/workflows/rk3588-moss-embed-probe.yml
git commit -m "feat: add MOSS RKNN audio encoder conversion"
```

---

## Task 4: Produce a validated, versioned runtime model bundle

**Files:**
- Create: `tools/moss_rk3588/export_token_embedding.py`
- Create: `tools/moss_rk3588/build_manifest.py`
- Create: `tools/moss_rk3588/validate_bundle.py`
- Create: `tests/tools/test_moss_bundle_manifest.py`
- Modify: `.gitignore`

**Interfaces:**
- Runtime bundle directory contains exactly the model/config artifacts required by the spec.
- `manifest.json` is the canonical source for dimensions, context limit, toolkit/runtime versions, hashes, and upstream checkpoint identity.

- [ ] **Step 1: Write a failing manifest validator test.**

```python
from tools.moss_rk3588.validate_bundle import validate_manifest


def test_manifest_requires_all_production_artifacts():
    manifest = {
        "hidden_size": 1024,
        "audio_tokens_per_second": 12.5,
        "audio_merge_size": 4,
        "time_marker_every_seconds": 2,
        "artifacts": {},
    }
    errors = validate_manifest(manifest, existing_files=set())
    assert "moss_audio_encoder_fp16_rk3588.rknn" in "\n".join(errors)
    assert "moss_qwen3_0.6b_w8a8_rk3588.rkllm" in "\n".join(errors)
```

- [ ] **Step 2: Export the MOSS token embedding table as little-endian FP16.**

```python
weight = model.model.language_model.embed_tokens.weight.detach().cpu().to(torch.float16)
array = weight.numpy().astype("<f2", copy=False)
array.tofile(output_path)
```

Write `token_embedding.json` with `rows`, `hidden_size`, `dtype`, byte order, SHA-256, and source MOSS fingerprint.

- [ ] **Step 3: Build `manifest.json`.**

The manifest records at minimum:

```json
{
  "backend": "moss-rk3588-npu",
  "hidden_size": 1024,
  "audio_tokens_per_second": 12.5,
  "audio_merge_size": 4,
  "time_marker_every_seconds": 2,
  "encoder_dtype": "fp16",
  "decoder_dtype": "w8a8",
  "target_platform": "rk3588",
  "max_context_len": 40960,
  "upstream": {"repository": "OpenMOSS/MOSS-Transcribe-Diarize", "commit": "<resolved-by-script>"},
  "artifacts": {}
}
```

The script resolves the actual upstream commit/checkpoint fingerprint and replaces the example value before writing. Every artifact entry contains `sha256` and `size_bytes`.

- [ ] **Step 4: Validate the final bundle before deployment.**

Expected directory:

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
└─ manifest.json
```

`validate_bundle.py` verifies hashes, expected embedding byte count `rows * 1024 * 2`, tokenizer audio token presence, and that decoder context is positive.

- [ ] **Step 5: Add generated artifact patterns to `.gitignore`, run tests, and commit.**

```bash
python3 -m pytest tests/tools/test_moss_bundle_manifest.py -q
git add tools/moss_rk3588 tests/tools/test_moss_bundle_manifest.py .gitignore
git commit -m "feat: define MOSS RK3588 runtime bundle"
```

---

## Task 5: Add the pure job, segment, window, and context-budget domain types

**Files:**
- Create: `linux/backend/moss_worker/__init__.py`
- Create: `linux/backend/moss_worker/types.py`
- Create: `linux/backend/moss_worker/context_budget.py`
- Create: `linux/backend/moss_worker/windowing.py`
- Create: `linux/backend/tests/test_moss_windowing.py`

**Interfaces:**
- Produces immutable value types used by every later worker task.
- `ContextBudgetPlanner.plan_window(start_ms, remaining_ms) -> WindowSpec`.
- `build_window_chain(total_ms, planner) -> list[WindowSpec]` preserves 5-minute overlap across 60-minute logical boundaries.

- [ ] **Step 1: Write failing tests for the nominal long-audio chain and fallback ladder.**

```python
from moss_worker.context_budget import ContextBudgetPlanner
from moss_worker.windowing import build_window_chain


def test_two_hour_chain_crosses_hour_boundary_with_overlap():
    planner = ContextBudgetPlanner(max_context_len=40960)
    windows = build_window_chain(120 * 60_000, planner)
    assert windows[0].start_ms == 0
    assert windows[0].target_end_ms == 35 * 60_000
    assert windows[1].start_ms == 30 * 60_000
    assert windows[2].start_ms == 55 * 60_000
    assert windows[2].logical_chunk_index == 1


def test_context_planner_uses_35_30_25_20_minute_ladder():
    planner = ContextBudgetPlanner(max_context_len=33000, generation_reserve_tokens=8192)
    spec = planner.plan_window(0, 60 * 60_000)
    assert spec.duration_ms in {30, 25, 20} | set()
    assert spec.duration_ms >= 20 * 60_000
```

Use an integer-minute assertion in the implementation test, not a set mixing minutes and milliseconds; the final test should assert `spec.duration_ms in {30, 25, 20}` after dividing by `60_000`.

- [ ] **Step 2: Define the core enums/dataclasses.**

`types.py` defines:

```python
class JobState(str, Enum):
    QUEUED = "QUEUED"
    PREPARING = "PREPARING"
    ENCODING = "ENCODING"
    BUILDING_EMBEDS = "BUILDING_EMBEDS"
    DECODING = "DECODING"
    PARSING = "PARSING"
    REMAPPING = "REMAPPING"
    MERGING = "MERGING"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"
    CANCELLED = "CANCELLED"


@dataclass(frozen=True)
class WindowSpec:
    window_id: str
    index: int
    logical_chunk_index: int
    start_ms: int
    target_end_ms: int
    duration_ms: int
    overlap_ms: int
    expanded_input_tokens: int
```

Also define `ParseStatus`, `MergeStatus`, `RawSegment`, `NormalizedSegment`, `WindowResult`, `JobSnapshot`, and `JobResult` with explicit JSON serialization methods.

- [ ] **Step 3: Implement exact processor-length estimation.**

`ContextBudgetPlanner` computes audio tokens as `ceil(samples / (hop_length * 2 * merge_size))` equivalently `ceil(seconds * 12.5)` for the default checkpoint, then adds time-marker digit positions exactly as MOSS does for every 2-second marker. It includes prompt token count, `generation_reserve_tokens=8192`, and `safety_margin_tokens=512`.

- [ ] **Step 4: Implement the long-audio chain.**

Nominal starts must be `0, 30m, 55m, 85m, ...` when windows remain 35 minutes. If the context planner shrinks a window, the next start is `previous_end - 5m`; never derive starts from a fixed 30-minute stride.

- [ ] **Step 5: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_windowing.py -q
cd ../..
git add linux/backend/moss_worker linux/backend/tests/test_moss_windowing.py
git commit -m "feat: add MOSS long-audio window planning"
```

---

## Task 6: Reproduce MOSS processor semantics and build `RKLLM_INPUT_EMBED` buffers on CPU

**Files:**
- Create: `linux/backend/requirements-moss-rk3588.txt`
- Create: `linux/backend/moss_worker/embedding_builder.py`
- Create: `linux/backend/tests/test_moss_embedding_builder.py`

**Interfaces:**
- `TokenEmbeddingTable(path, metadata_path)` memory-maps the FP16 table.
- `MossEmbeddingBuilder.build(prompt: str, audio_embeds: np.ndarray) -> BuiltEmbeddings` returns contiguous FP32 `[n_tokens,1024]`, `input_ids`, and `audio_positions`.

- [ ] **Step 1: Add only board-runtime dependencies.**

`linux/backend/requirements-moss-rk3588.txt`:

```text
numpy>=1.26,<3
tokenizers>=0.20,<1
```

Do not add PyTorch or Transformers to the board runtime.

- [ ] **Step 2: Write failing tests for time markers and audio replacement.**

Use a tiny fake tokenizer/embedding table so CI does not require model files:

```python
def test_audio_span_inserts_digit_markers_without_consuming_audio_features(fake_builder):
    ids = fake_builder.build_audio_span_ids(audio_seq_len=50)
    assert ids.count(fake_builder.audio_token_id) == 50
    assert fake_builder.digit_token_ids["2"] in ids
    assert fake_builder.digit_token_ids["4"] in ids


def test_build_replaces_only_audio_token_positions(fake_builder):
    audio = np.arange(4 * 8, dtype=np.float32).reshape(4, 8)
    built = fake_builder.build_from_ids([10, 99, 11, 99, 99, 99, 12], audio)
    np.testing.assert_allclose(built.embeds[built.audio_positions], audio)
```

- [ ] **Step 3: Implement memory-mapped token lookup.**

`TokenEmbeddingTable.lookup(ids)` checks every token ID is within `[0, rows)`, gathers only requested FP16 rows, converts the result to FP32, and returns a C-contiguous NumPy array.

- [ ] **Step 4: Port the MOSS audio-span algorithm exactly.**

Use `audio_tokens_per_second`, `time_marker_every_seconds`, `audio_token_id`, and digit-token IDs loaded from `processor_config.json`; every time marker inserts digit token embeddings while the number of audio placeholders remains exactly equal to `audio_embeds.shape[0]`.

- [ ] **Step 5: Add context guard validation at build time.**

Before returning, assert:

```python
if built.n_tokens + generation_reserve_tokens + safety_margin_tokens > max_context_len:
    raise MossContextOverflow(...)
```

The exception contains the actual input token count and configured limit.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_embedding_builder.py tests/test_moss_windowing.py -q
cd ../..
git add linux/backend/requirements-moss-rk3588.txt linux/backend/moss_worker/embedding_builder.py linux/backend/tests/test_moss_embedding_builder.py
git commit -m "feat: build MOSS external embedding inputs"
```

---

## Task 7: Parse MOSS generations into validated absolute-time segments

**Files:**
- Create: `linux/backend/moss_worker/parser.py`
- Create: `linux/backend/tests/test_moss_parser.py`

**Interfaces:**
- `parse_generation(raw: str, window: WindowSpec) -> list[NormalizedSegment]`.
- Valid parser output always uses absolute `start_ms` / `end_ms`.
- Invalid raw fragments remain available in `WindowResult.raw_generation` and are not silently inserted into the authoritative timeline.

- [ ] **Step 1: Write failing tests for VALID, REPAIRED, INVALID, and absolute time.**

```python
def test_parser_offsets_local_time_to_absolute(window_30m):
    segments = parse_generation("[12.0][S01]你好[13.5]", window_30m)
    assert segments[0].start_ms == 30 * 60_000 + 12_000
    assert segments[0].end_ms == 30 * 60_000 + 13_500
    assert segments[0].parse_status is ParseStatus.VALID


def test_parser_repairs_missing_end_from_next_start(window_30m):
    raw = "[1.0][S01]第一句[2.5][S02]第二句[3.0]"
    segments = parse_generation(raw, window_30m)
    assert segments[0].end_ms == 30 * 60_000 + 2_500
    assert segments[0].parse_status is ParseStatus.REPAIRED
```

- [ ] **Step 2: Implement a strict timestamp/speaker parser.**

Accept only `S` followed by two or more digits, non-negative monotonically increasing timestamps, and non-empty text after Unicode whitespace trimming. Reject a segment whose end precedes start.

- [ ] **Step 3: Implement only deterministic repair rules.**

A missing end may use the next segment start. Do not invent timestamps for a final segment with no following boundary; mark it invalid instead.

- [ ] **Step 4: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_parser.py -q
cd ../..
git add linux/backend/moss_worker/parser.py linux/backend/tests/test_moss_parser.py
git commit -m "feat: parse MOSS diarized generations"
```

---

## Task 8: Add cross-window speaker remapping and overlap conflict merging

**Files:**
- Create: `linux/backend/moss_worker/speaker_remap.py`
- Create: `linux/backend/moss_worker/merger.py`
- Create: `linux/backend/tests/test_moss_speaker_remap.py`
- Create: `linux/backend/tests/test_moss_merger.py`

**Interfaces:**
- `SpeakerRemapper.map_adjacent(previous, current, state) -> SpeakerMappingResult`.
- `merge_adjacent(previous, current, mapping) -> list[NormalizedSegment]`.
- `GlobalSpeakerState` is serializable and can resume from spool checkpoints.

- [ ] **Step 1: Write failing correspondence tests.**

Construct overlap segments where previous `S01` matches current `S03` twelve times and previous `S02` matches current `S01` ten times. Assert the result is one-to-one and maps to prior `GS01`/`GS02` only when confidence is at least 0.85.

- [ ] **Step 2: Implement segment match scoring.**

Use exactly:

```python
score = (
    0.45 * time_iou
    + 0.35 * text_similarity
    + 0.10 * duration_similarity
    + 0.10 * order_similarity
)
```

Normalize text with Unicode NFKC, whitespace collapse, and punctuation removal. `text_similarity` may use `difflib.SequenceMatcher` to avoid an additional dependency.

- [ ] **Step 3: Implement deterministic maximum-weight one-to-one assignment.**

Because expected speaker counts are small, enumerate permutations of the smaller side, maximize total score, and use lexicographic local-speaker order as the tie breaker. Do not add SciPy solely for Hungarian assignment.

- [ ] **Step 4: Implement confidence policy and global-label allocation.**

`>=0.85` inherits a previous `GSxx`; `0.65-0.85` and `<0.65` allocate a new `GSxx`, store candidate evidence, and never rewrite prior segments.

- [ ] **Step 5: Write and implement overlap midpoint ownership tests.**

For a 30-35 minute overlap, the default boundary is 32:30. A segment spanning 32:28-32:34 remains whole; choose the version farther from its source window edge. Materially different text stores the unselected text in `alternate_text` and sets `merge_conflict=True`.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_speaker_remap.py tests/test_moss_merger.py -q
cd ../..
git add linux/backend/moss_worker/speaker_remap.py linux/backend/moss_worker/merger.py linux/backend/tests/test_moss_speaker_remap.py linux/backend/tests/test_moss_merger.py
git commit -m "feat: preserve MOSS speakers across windows"
```

---

## Task 9: Add durable spool storage, atomic checkpoints, and revision provenance

**Files:**
- Create: `linux/backend/moss_worker/storage.py`
- Create: `linux/backend/tests/test_moss_storage.py`

**Interfaces:**
- `MossSpool(root: Path)` owns `/var/lib/suspect-interrogation/moss/jobs/<job_id>` layout.
- `create_job()`, `load_job()`, `save_job()`, `save_window_result()`, `load_completed_windows()`, `save_speaker_state()`, and `save_merged_segments()` are atomic.

- [ ] **Step 1: Write failing crash-safety tests.**

Test that saves write to a temporary sibling, `fsync()` the file, replace the destination with `os.replace()`, and leave the old valid file readable if serialization raises before replace.

- [ ] **Step 2: Implement the spool layout.**

Each job directory contains:

```text
job.json
windows.json
speaker_state.json
merged_segments.jsonl
raw_generations/<window_id>.txt
checkpoints/<window_id>.json
logs/events.jsonl
```

`job.json` records audio path, audio SHA-256, duration, manifest SHA-256, state, current window, created/updated timestamps, and error object.

- [ ] **Step 3: Enforce source integrity.**

At job creation hash the original WAV. Before resuming a job, hash it again; if the SHA-256 differs, fail with `MOSS_AUDIO_CHANGED` rather than resuming against altered evidence.

- [ ] **Step 4: Preserve revisions.**

A new run of the same WAV under a different model manifest receives a new job ID and independent directory. Never overwrite a completed job merely because `audio_sha256` matches.

- [ ] **Step 5: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_storage.py -q
cd ../..
git add linux/backend/moss_worker/storage.py linux/backend/tests/test_moss_storage.py
git commit -m "feat: persist MOSS job checkpoints"
```

---

## Task 10: Wrap RKNN/RKLLM and implement one-window inference in an isolated child

**Files:**
- Create: `linux/backend/moss_worker/audio_frontend.py`
- Create: `linux/backend/moss_worker/rknn_audio_encoder.py`
- Create: `linux/backend/moss_worker/rkllm_decoder.py`
- Create: `linux/backend/moss_worker/runtime.py`
- Create: `linux/backend/moss_worker/child.py`
- Create: `linux/backend/tests/test_moss_runtime_contract.py`

**Interfaces:**
- `AudioFrontend.micro_chunks(wav_path, start_ms, end_ms) -> Iterator[AudioMicroChunk]` returns 16 kHz mono 30-second blocks plus real sample count.
- `RknnAudioEncoder.encode(input_features, valid_tokens) -> np.ndarray[valid_tokens,1024]`.
- `RkllmDecoder.generate(embeds: np.ndarray, max_new_tokens: int) -> str`.
- `MossRuntime.infer_window(window: WindowSpec, wav_path: Path) -> WindowResult`.
- Child-process request/response messages are Python dictionaries containing only paths, scalar parameters, and JSON-safe metadata; large embedding tensors never cross the process boundary.

- [ ] **Step 1: Write a failing runtime contract test with fake encoder/decoder.**

```python
def test_runtime_runs_encode_build_decode_parse_in_order(fake_runtime, window, wav):
    result = fake_runtime.infer_window(window, wav)
    assert [stage for stage in fake_runtime.trace] == [
        "ENCODING", "BUILDING_EMBEDS", "DECODING", "PARSING"
    ]
    assert result.segments[0].global_speaker is None
```

- [ ] **Step 2: Implement deterministic audio preparation.**

Decode WAV with Python `wave` for PCM16 mono and reject unsupported encodings initially. Resample only when needed using an explicit local implementation or an already-present system audio library; first acceptance fixtures are 16 kHz PCM16. Convert to float32 `[-1,1]`, compute Whisper log-mel with constants exported in `processor_config.json`, and pad each micro-chunk to 30 seconds.

- [ ] **Step 3: Implement the RKNN wrapper.**

Use `RKNNLite.load_rknn`, `init_runtime(core_mask=RKNNLite.NPU_CORE_0_1_2)`, check output shape, reject NaN/Inf, and slice `[:valid_tokens]`. Load once during child startup and release only when the child exits.

- [ ] **Step 4: Implement the RKLLM ctypes wrapper from the pinned 1.3.x header.**

Define only ABI structures and functions actually used: init, run, destroy, result callback, `RKLLM_INPUT_EMBED`, and performance fields. `generate()` requires C-contiguous float32 `[n_tokens,1024]`, sets `enable_thinking=False`, `keep_history=0`, and returns accumulated UTF-8 text. Any non-zero native return raises `MossRkllmInferenceFailed` with the return code.

- [ ] **Step 5: Implement `MossRuntime.infer_window`.**

The runtime serially runs all 30-second RKNN micro-chunks, concatenates valid adapted embeddings, builds the full MOSS input with Task 6, performs RKLLM generation, parses Task 7 segments, and returns per-stage timing plus RKLLM perf counters.

- [ ] **Step 6: Implement child startup self-test.**

At load, validate manifest hashes, run one stored 2-5 second self-test feature tensor through RKNN, assert finite output, then run a fixed small embedding request through RKLLM. If either fails, child returns `NOT_READY` and exits with a non-zero status.

- [ ] **Step 7: Run fake-runtime tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_runtime_contract.py tests/test_moss_embedding_builder.py tests/test_moss_parser.py -q
cd ../..
git add linux/backend/moss_worker linux/backend/tests/test_moss_runtime_contract.py
git commit -m "feat: add isolated MOSS NPU runtime"
```

---

## Task 11: Add supervisor job execution, cancellation, retry ladder, and crash recovery

**Files:**
- Create: `linux/backend/moss_worker/supervisor.py`
- Create: `linux/backend/tests/test_moss_supervisor.py`

**Interfaces:**
- `MossSupervisor.submit(job_request) -> JobSnapshot`.
- `get_job(job_id)`, `get_result(job_id)`, `cancel(job_id)`.
- One inference child is active at a time; supervisor can kill/restart it without losing completed-window checkpoints.

- [ ] **Step 1: Write failing tests for queue serialization and child crash recovery.**

Use a fake child that crashes on window `w0002`. Assert `w0001` remains DONE, the child is restarted, `w0002` may retry according to policy, and a second submitted job remains QUEUED until the first terminates.

- [ ] **Step 2: Implement the job state machine.**

Transitions are limited to the spec states. Reject invalid transitions such as `COMPLETED -> DECODING`. Persist every transition to `job.json` before starting the corresponding next stage.

- [ ] **Step 3: Implement context/OOM retry.**

For `MOSS_CONTEXT_OVERFLOW` or recoverable `MOSS_OOM`, retry the current window with target durations `35 -> 30 -> 25 -> 20` minutes, recalculating the following overlap chain from the successful end. Other errors do not trigger this ladder.

- [ ] **Step 4: Implement native crash recovery.**

If the inference child exits unexpectedly, record exit code/signal, mark the current attempt failed, reap it, start a fresh child, reload models, and perform one retry. A second native crash on the same window fails the job.

- [ ] **Step 5: Implement cancellation semantics.**

QUEUED jobs become CANCELLED immediately. RUNNING jobs set `cancel_requested`; stop at the next safe boundary. If RKLLM does not return within the configured cancellation grace period, terminate the inference child, restart a clean child, and mark the job CANCELLED while preserving completed checkpoints.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_supervisor.py tests/test_moss_storage.py -q
cd ../..
git add linux/backend/moss_worker/supervisor.py linux/backend/tests/test_moss_supervisor.py
git commit -m "feat: supervise durable MOSS jobs"
```

---

## Task 12: Add Unix-socket protocol, `moss_worker` server, and FastAPI-side client

**Files:**
- Create: `linux/backend/moss_worker/protocol.py`
- Create: `linux/backend/moss_worker/main.py`
- Create: `linux/backend/app/ai/moss/__init__.py`
- Create: `linux/backend/app/ai/moss/types.py`
- Create: `linux/backend/app/ai/moss/client.py`
- Create: `linux/backend/tests/test_moss_protocol.py`
- Create: `linux/backend/tests/test_moss_client_server.py`

**Interfaces:**
- Socket path default: `/run/suspect-interrogation/moss.sock`.
- Wire ops: `health`, `submit_job`, `get_job`, `get_result`, `cancel_job`.
- Responses follow existing worker convention: `{"request_id": ..., "ok": true, "result": ...}` or structured `error`.

- [ ] **Step 1: Write failing protocol framing tests.**

Reuse the existing 4-byte big-endian JSON framing behavior but use MOSS-specific error text and a conservative `MAX_MESSAGE_BYTES = 16 * 1024 * 1024`; results themselves should reference spool files for very large data rather than serializing model tensors.

- [ ] **Step 2: Define worker error codes exactly.**

```text
MOSS_MODEL_LOAD_FAILED
MOSS_RKNN_INFERENCE_FAILED
MOSS_RKLLM_INFERENCE_FAILED
MOSS_CONTEXT_OVERFLOW
MOSS_OOM
MOSS_INVALID_GENERATION
MOSS_AUDIO_CORRUPT
MOSS_AUDIO_CHANGED
MOSS_CANCELLED
MOSS_JOB_NOT_FOUND
MOSS_WORKER_CRASHED
```

- [ ] **Step 3: Implement server dispatch and stale-socket safety.**

Follow the existing `speech_worker` pattern: refuse to unlink a non-socket path, probe an existing socket before removing it, chmod the new socket `0660`, and never delete an active listener owned by another process.

- [ ] **Step 4: Implement `MossWorkerClient`.**

Expose:

```python
class MossWorkerClient:
    def health(self) -> dict[str, object]: ...
    def submit_job(self, audio_path: str, audio_sha256: str | None = None) -> MossJobSnapshot: ...
    def get_job(self, job_id: str) -> MossJobSnapshot: ...
    def get_result(self, job_id: str) -> MossJobResult: ...
    def cancel_job(self, job_id: str) -> MossJobSnapshot: ...
```

Validate `request_id`, boolean `ok`, and structured errors exactly as `SpeechWorkerClient` does.

- [ ] **Step 5: Add fake-supervisor socket tests.**

Start `MossWorkerServer` on a temporary Unix socket with a fake supervisor, exercise all five operations, verify malformed responses become worker errors, and verify two concurrent client requests do not corrupt framing.

- [ ] **Step 6: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_protocol.py tests/test_moss_client_server.py -q
cd ../..
git add linux/backend/moss_worker/protocol.py linux/backend/moss_worker/main.py linux/backend/app/ai/moss linux/backend/tests/test_moss_protocol.py linux/backend/tests/test_moss_client_server.py
git commit -m "feat: expose MOSS worker over local socket"
```

---

## Task 13: Integrate settings, model registry, business service, and health without making MOSS a hidden dependency of realtime ASR

**Files:**
- Modify: `linux/backend/app/ai/settings.py`
- Modify: `linux/backend/app/ai/registry.py`
- Modify: `linux/backend/config/model-registry.yaml`
- Create: `linux/backend/app/services/moss_transcription.py`
- Modify: `linux/backend/app/health.py`
- Create: `linux/backend/tests/test_moss_settings_registry.py`
- Create: `linux/backend/tests/test_moss_service.py`
- Modify: `linux/backend/tests/test_health.py` or the repository's existing health test file that owns `/health/ready` assertions.

**Interfaces:**
- Add `AISettings.moss_socket`, `moss_enabled`, `moss_spool_root`, and `moss_model_id`.
- Register one bundle entry `moss.default` with `kind="moss"`.
- `MossTranscriptionService` resolves the client and exposes business-safe submit/status/result/cancel methods.

- [ ] **Step 1: Write failing settings and registry tests.**

Assert defaults:

```text
MOSS_ENABLED=0
SUSPECT_MOSS_SOCKET=/run/suspect-interrogation/moss.sock
MOSS_SPOOL_ROOT=/var/lib/suspect-interrogation/moss
MOSS_MODEL_ID=moss.default
```

Extend `ModelRegistry` allowed kinds with `moss`; do not repurpose `asr.default` or `llm.default`.

- [ ] **Step 2: Add the model bundle registry entry.**

The JSON-compatible YAML entry should be equivalent to:

```json
"moss.default": {
  "kind": "moss",
  "backend": "moss-rk3588-npu",
  "path": "moss-rk3588",
  "architecture": "Whisper-Medium+VQAdaptor+Qwen3-0.6B",
  "required_files": [
    "moss_audio_encoder_fp16_rk3588.rknn",
    "moss_qwen3_0.6b_w8a8_rk3588.rkllm",
    "moss_token_embedding_fp16.bin",
    "tokenizer.json",
    "processor_config.json",
    "manifest.json"
  ],
  "device": "npu",
  "context": 40960,
  "memory_mb": 0,
  "capabilities": ["transcription", "diarization", "timestamps", "long_audio"]
}
```

If the built manifest reports a different decoder context, update the registry to that verified value in the same commit rather than leaving 40960 stale.

- [ ] **Step 3: Implement `MossTranscriptionService`.**

It hashes the resolved audio path if the caller did not supply a hash, submits the worker job, and returns typed snapshots. It never reads model artifacts directly and never translates `GSxx` into a person identity.

- [ ] **Step 4: Integrate health as an optional component.**

When `MOSS_ENABLED=0`, `/health/ready` remains unaffected and reports MOSS as disabled. When enabled, readiness exposes MOSS worker state, model readiness, manifest SHA-256, queue depth, active job, runtime versions, and last error. A failed enabled MOSS worker marks only the MOSS capability unavailable unless an API endpoint explicitly depends on it; do not break realtime interrogation startup merely because the experimental MOSS route is unavailable during this phase.

- [ ] **Step 5: Run tests and commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_settings_registry.py tests/test_moss_service.py tests/test_health.py -q
cd ../..
git add linux/backend/app/ai/settings.py linux/backend/app/ai/registry.py linux/backend/config/model-registry.yaml linux/backend/app/services/moss_transcription.py linux/backend/app/health.py linux/backend/tests
git commit -m "feat: integrate MOSS backend with application services"
```

If the repository health test file has a different filename, use the existing file discovered before editing and keep the command aligned to that exact path.

---

## Task 14: Add systemd service, offline model layout, bootstrap/redeploy integration, and RK3588 smoke checks

**Files:**
- Create: `systemd/moss-worker.service`
- Modify: `.github/workflows/rk3588-service-bootstrap.yml`
- Modify: `.github/workflows/rk3588-production-redeploy.yml`
- Extend: `.github/workflows/linux-ai-runtime-rk3588.yml`
- Create: `scripts/ci/probe-moss-rk3588.py`
- Create: `tests/release/test_moss_systemd_and_deploy.py`
- Modify: relevant release evidence documentation under `docs/release/`.

**Interfaces:**
- Production model path: `/opt/suspect-interrogation/models/moss-rk3588` or the existing shared model-root equivalent resolved from `MODEL_ROOT`; model files are outside immutable release directories.
- Spool: `/var/lib/suspect-interrogation/moss`.
- Socket: `/run/suspect-interrogation/moss.sock`.

- [ ] **Step 1: Write failing deployment contract tests.**

Assert the systemd unit:

```text
- runs as the same restricted service account as the backend unless deployment policy requires a dedicated one;
- has RuntimeDirectory=suspect-interrogation;
- has StateDirectory or explicit writable path for the MOSS spool;
- sets MOSS_ENABLED=1 only in the production environment file, not hard-coded into source defaults;
- does not bind TCP/8000;
- uses Restart=on-failure;
- starts before the API only if readiness integration requires the socket, otherwise the API remains able to start with MOSS unavailable.
```

- [ ] **Step 2: Add the systemd unit.**

`ExecStart` runs:

```text
/opt/suspect-interrogation/current/.venv/bin/python -m moss_worker.main
```

with `WorkingDirectory=/opt/suspect-interrogation/current/linux/backend`, `EnvironmentFile=-/etc/suspect-interrogation/moss-worker.env`, and `LD_LIBRARY_PATH` including the installed RKNN/RKLLM runtime directory.

- [ ] **Step 3: Add the read-only hardware probe.**

`probe-moss-rk3588.py` checks bundle hashes against `manifest.json`, imports `numpy` and `tokenizers`, loads worker health through the Unix socket, records architecture, RAM, RKNN/RKLLM runtime versions, queue depth, model state, and never submits a case-audio job. It exits non-zero when an enabled model is not ready.

- [ ] **Step 4: Integrate bootstrap and redeploy.**

Bootstrap installs board-only MOSS Python dependencies into the release venv from local/offline package sources already used by the runner, installs/copies `moss-worker.service`, creates spool/runtime directories with correct ownership, daemon-reloads, and enables the unit. Production redeploy restarts the MOSS worker as part of the same release transition while preserving shared model/spool directories.

- [ ] **Step 5: Extend the RK3588 AI workflow.**

Run unit tests without requiring model files. On the self-hosted RK3588, run the real MOSS health probe only when the external model directory and native runtime libraries are present; do not download them in CI.

- [ ] **Step 6: Run contract tests and commit.**

```bash
python3 -m pytest tests/release/test_moss_systemd_and_deploy.py -q
git add systemd/moss-worker.service .github/workflows scripts/ci/probe-moss-rk3588.py tests/release/test_moss_systemd_and_deploy.py docs/release
git commit -m "ops: deploy MOSS worker on RK3588"
```

---

## Task 15: Add golden fixtures, end-to-end long-audio acceptance, crash-resume tests, and production verification

**Files:**
- Create: `linux/backend/tests/fixtures/moss/README.md`
- Create: `linux/backend/tests/test_moss_e2e_mock.py`
- Create: `scripts/ci/moss-rk3588-acceptance.py`
- Create: `.github/workflows/rk3588-moss-acceptance.yml`
- Create: `tests/release/test_rk3588_moss_acceptance_workflow.py`
- Modify: `docs/release/RK3588-EVIDENCE.md` or the current RK3588 evidence document used by the branch.

**Interfaces:**
- CI fixtures contain synthetic metadata and tiny generated PCM only; large/real WAV fixtures remain on the RK3588 outside Git.
- Hardware acceptance writes JSON evidence including model manifest SHA, audio SHA, durations, window count, RTF, speaker mapping statistics, conflicts, crashes/retries, and final status.

- [ ] **Step 1: Add deterministic mock end-to-end tests.**

Use a fake runtime producing scripted window outputs for a 125-minute virtual recording. Assert:

```text
- windows cross the 60-minute logical boundary with overlap;
- local S labels change between windows but final GS labels remain stable when overlap evidence is strong;
- overlap text is deduplicated;
- a conflicting phrase preserves alternate_text;
- a simulated crash after a completed window resumes without recomputing prior windows;
- cancellation preserves completed checkpoints.
```

- [ ] **Step 2: Define the real hardware acceptance corpus outside Git.**

The RK3588 runner path `/opt/moss-acceptance/audio` contains operator-approved, non-case fixtures covering:

```text
01_single_speaker_05m.wav
02_two_speaker_30m.wav
03_two_speaker_60m.wav
04_three_speaker_65m.wav
05_overlap_boundary_70m.wav
06_silence_noise_30m.wav
07_two_speaker_120m.wav
```

Each has a sidecar JSON with expected minimum speaker count, language, duration, and whether cross-hour continuity is required. The workflow fails clearly when the corpus is absent rather than downloading substitutes.

- [ ] **Step 3: Implement `moss-rk3588-acceptance.py`.**

For each fixture, submit a worker job, poll until terminal state, calculate `RTF = processing_seconds / audio_seconds`, validate absolute timestamp monotonicity, ensure no segment lies outside audio bounds, report `GSxx` count, mapping-confidence distribution, parse repairs/invalids, merge conflicts, and model manifest SHA.

- [ ] **Step 4: Enforce Phase 1 acceptance thresholds.**

The hardware workflow requires:

```text
- 30-minute fixture completes with RTF <= 1.0.
- 60-minute fixture completes with no crash/OOM and produces one merged timeline.
- 65/70-minute fixtures demonstrate speaker continuity across the hour boundary.
- 120-minute fixture completes through chained windows.
- all completed results have finite, monotonic absolute timestamps.
- every segment contains model_manifest_sha256 and source window_id.
- network-dependent download commands are absent from the workflow.
```

The later optimization target `RTF <= 0.5` is recorded as a performance objective, not a Phase 1 merge gate.

- [ ] **Step 5: Run the complete software test suite before the final source commit.**

```bash
cd linux/backend
python3 -m pytest tests/test_moss_*.py -q
cd ../..
python3 -m pytest tests/tools/test_moss_*.py tests/release/test_moss_*.py tests/release/test_rk3588_moss_*.py -q
```

Expected: PASS.

- [ ] **Step 6: Commit the acceptance harness.**

```bash
git add linux/backend/tests/fixtures/moss linux/backend/tests/test_moss_e2e_mock.py scripts/ci/moss-rk3588-acceptance.py .github/workflows/rk3588-moss-acceptance.yml tests/release/test_rk3588_moss_acceptance_workflow.py docs/release
git commit -m "test: add MOSS RK3588 acceptance coverage"
```

- [ ] **Step 7: Run the real RK3588 MOSS acceptance workflow.**

Expected: Gate A and Gate B remain passing with the exact final model artifacts; all Phase 1 thresholds above pass. Save the workflow run ID and evidence JSON in the release evidence document.

- [ ] **Step 8: Complete the mandatory production deployment chain from `AGENTS.md`.**

For the exact final commit SHA:

```text
1. Confirm relevant CI gates are green.
2. Confirm RK3588 Production Redeploy ran for the exact SHA.
3. Verify frontend and backend were atomically installed from that SHA.
4. Verify https://192.168.0.9:18080 with the project LAN CA; do not use -k.
5. Verify /health/live and /health/ready with certificate validation.
6. Verify MOSS health shows ready, expected manifest SHA, and no active error.
7. Run a short offline MOSS job on the production host and verify timestamped GSxx output.
8. Verify browser audio endpoints still derive wss:// from the HTTPS origin.
9. Verify deployed release SHA equals the GitHub final commit SHA.
10. Verify TCP/8000 remains listening and owned by the pre-existing FunASR service.
```

Do not report implementation complete until this chain passes. If source is committed but deployment fails, report exactly: **code committed, production deployment incomplete**.

---

## Implementation Gates and Stop Conditions

The execution order is deliberate:

```text
Task 1  PyTorch reference / MOSS Qwen repack
   ↓
Task 2  Gate A: real MOSS inputs_embeds -> RKLLM_INPUT_EMBED
   ↓
Task 3  Gate B: Whisper-Medium+Adaptor -> RKNN parity
   ↓
Task 4  reproducible runtime bundle
   ↓
Tasks 5-12 worker correctness and durability
   ↓
Tasks 13-14 application + deployment integration
   ↓
Task 15 real long-audio acceptance and production verification
```

Stop after Task 2 if the RKLLM external-embedding path cannot produce a structurally valid MOSS generation. Do not hide that failure by switching to stock Qwen or CPU Transformers inference.

Stop after Task 3 if the RKNN acoustic graph cannot meet FP16 parity. Do not introduce INT8 acoustic quantization as a workaround.

Do not add ERes2Net identity binding during these tasks. That is a separately reviewed fusion phase after the standalone MOSS path is proven.
