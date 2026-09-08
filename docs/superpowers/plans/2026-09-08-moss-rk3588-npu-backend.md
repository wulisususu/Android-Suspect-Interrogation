# MOSS-RK3588 NPU Backend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a standalone, fully offline MOSS-Transcribe-Diarize backend on one RK3588 32 GB device, using RKNN for Whisper-Medium + VQAdaptor, RKLLM for the MOSS-tuned Qwen3-0.6B decoder, and durable long-audio windowing with anonymous global speaker continuity.

**Architecture:** Keep the existing realtime `speech_worker` unchanged. Add a separate `moss_worker` supervisor behind `/run/suspect-interrogation/moss.sock`; isolate RKNN/RKLLM native inference in a child process. Prove `inputs_embeds -> RKLLM_INPUT_EMBED` first, prove the acoustic RKNN graph second, then implement long-audio windows, overlap/speaker merge, durable jobs, application integration, and RK3588 deployment.

**Tech Stack:** Python 3.11/3.12, NumPy, `tokenizers`, PyTorch/Transformers only on the conversion workstation, RKNN Toolkit2/RKNN Runtime, RKLLM Toolkit **1.3.0**/RKLLM Runtime **1.3.0**, Unix sockets, FastAPI, systemd, GitHub Actions self-hosted RK3588 runner.

**Spec:** `docs/superpowers/specs/2026-09-08-moss-rk3588-npu-backend-design.md`

**Approved revision (2026-09-08):** retain the validated RKNN/RKLLM toolchain. Use context 16,384, generation reserve 5,120, safety 512, 12/10/8-minute windows and 2-minute overlap. Tasks 1–3 hardware gates passed on the short fixture; they do not establish long-window acceptance. Execute the explicit policy revision and same-toolchain 16K rebuild below before Task 4. Greater than 16K context is a non-blocking optimization Spike.

**Implementation checkpoint (2026-09-08):** Task 4 (`1bb64e8`) passed 40 bundle tests and validation on the conversion workstation, local E: storage, and RK3588; bundle manifest SHA-256 is `a50ce60b04e3715a4ce9d05381336fd95072f359c7883115e946d55321657e69`. Task 5 (`6521c80`) adds immutable shared records without replacing the approved planner. Task 6 (`3421c61`) passed 69 combined MOSS tests and full input-ID parity with the official processor for 8/10/12-minute engineering fixtures and a one-sample tail. A real-tokenizer long-prompt case planned 10 minutes after rejecting 12 minutes (10,798 expanded tokens vs. 9,226 at 10 minutes). Native submission guards, completion metadata, durable generation-limit retries, and long-window NPU acceptance remain pending Tasks 10/11 and acceptance tasks. These are local commits, not a production deployment; TCP/8000 remains unchanged.

## Global Constraints

- Hardware: one RK3588, 32 GB RAM.
- Production inference is network-independent: no cloud API, model download, telemetry, or update check.
- Phase 1 is MOSS-only; Paraformer/FSMN-VAD/ERes2Net are not dependencies and `GSxx` is never auto-bound to a named person.
- Existing `speech_worker` stays unchanged; TCP/8000 is never stopped, rebound, proxied, or reconfigured.
- Acoustic graph: MOSS Whisper-Medium -> 4x time merge -> VQAdaptor, RKNN FP16.
- Decoder: **MOSS-tuned** Qwen3-0.6B, RKLLM W8A8. Stock Qwen3 weights are forbidden as a fallback.
- Decoder input: `RKLLM_INPUT_EMBED`, complete host-built `float32[n_tokens,1024]`.
- Logical progress boundary: 60 minutes. Target model window: 12 minutes. Adjacent windows overlap 2 minutes.
- Context fallback ladder: 12 -> 10 -> 8 minutes; failure at 8 minutes is explicit. Short recording/logical-boundary tails are allowed, but are not extra fallback tiers.
- Context 16,384; fixed generation reserve 5,120 and safety 512. Require actual tokenizer/processor expanded input for the candidate interval: count+5120+512<=16384. Duration estimates cannot authorize execution.
- Generated count >=5120, missing normal termination, or incomplete output tail produces `GENERATION_LIMIT_REACHED`. Retain diagnostics, publish no partial authoritative result, and re-execute the failed coverage interval using 10/8-minute windows; tier 8 failure is terminal.
- Acoustic micro-chunk: 30 seconds, RKNN input `[1,80,3000]`; padded tail keeps only valid adapted tokens.
- `max_concurrent_moss_jobs=1`, `max_concurrent_rknn_runs=1`, `max_concurrent_rkllm_runs=1`.
- Raw WAV + SHA-256 is immutable source evidence; every model product is derived/versioned.
- Speaker correspondence `>=0.85` may inherit an existing `GSxx`; lower confidence gets a new `GSxx` plus candidate evidence.
- Native inference runs in a child; its crash must not terminate the supervisor/FastAPI.
- Never commit model/checkpoint binaries, `.rknn`, `.rkllm`, token embedding tables, calibration tensors, or real/large acceptance audio.
- Production service account is exactly `suspect-interrogation:suspect-interrogation`, matching `systemd/ai-worker.service`.
- Production native libraries are `/lib/librknnrt.so` and `/lib/librkllmrt.so` for the current RK3588 image; probes fail closed if absent.
- Every task begins with a failing test or failing hardware gate, then minimal implementation, focused verification, and an independent commit.
- `AGENTS.md` production Definition of Done applies to the exact final source SHA.

---

## File Structure

```text
tools/moss_rk3588/
  capture_input_embeds.py       # PyTorch golden capture
  repack_moss_qwen.py           # MOSS language weights -> standard Qwen3 package
  build_calibration_set.py      # real inputs_embeds calibration dataset
  build_rkllm.py                # Qwen3 -> RKLLM W8A8
  export_audio_encoder.py       # Whisper+merge+adaptor -> ONNX
  build_rknn.py                 # ONNX -> RKNN FP16
  export_token_embedding.py     # MOSS token table -> FP16 mmap artifact
  build_manifest.py             # version/hash manifest + self-test assets
  validate_bundle.py
  compare_pytorch_rknn.py
  compare_pytorch_rkllm.py
  native/rkllm_embed_probe.cpp

linux/backend/moss_worker/
  types.py                      # shared immutable job/window/segment types
  context_budget.py             # exact MOSS input-token budgeting
  windowing.py                  # 60m logical boundaries, target 12m/2m overlap
  generation_policy.py          # fail-closed generation completion checks
  embedding_builder.py          # tokenizer/time markers/masked audio injection
  parser.py                     # generation -> absolute-time segments
  speaker_remap.py              # local Sxx -> global GSxx
  merger.py                     # overlap ownership/dedup/conflicts
  storage.py                    # durable spool/checkpoints
  audio_frontend.py             # PCM16/16k/mono -> Whisper log-mel micro-chunks
  rknn_audio_encoder.py
  rkllm_decoder.py
  runtime.py                    # one-window pipeline
  child.py                      # native inference process
  supervisor.py                 # queue/retry/cancel/crash recovery
  protocol.py                   # length-prefixed JSON
  main.py                       # Unix socket server

linux/backend/app/ai/moss/
  types.py
  client.py
linux/backend/app/services/moss_transcription.py
linux/backend/requirements-moss-rk3588.txt
systemd/moss-worker.service
```

---

## Task 1: Capture a PyTorch golden reference and repack the MOSS Qwen3 weights

**Files:**
- Create: `tools/moss_rk3588/__init__.py`
- Create: `tools/moss_rk3588/requirements.txt`
- Create: `tools/moss_rk3588/capture_input_embeds.py`
- Create: `tools/moss_rk3588/repack_moss_qwen.py`
- Test: `tests/tools/test_moss_reference_tools.py`

**Interfaces:**
- `build_reference_manifest(wav_path: Path, model_fingerprint: str, input_shape: tuple[int,...], output_text: str) -> dict[str, object]`
- `capture_reference(model_dir: Path, wav_path: Path, output_dir: Path, force: bool=False) -> dict[str, object]`
- `classify_state_key(key: str) -> str | None`
- Output reference includes `input_embeds.npy` **and raw C-contiguous `input_embeds.f32`** from the same FP32 tensor.

- [ ] **Step 1: Write the failing tests.**

```python
from pathlib import Path
from tools.moss_rk3588.capture_input_embeds import build_reference_manifest
from tools.moss_rk3588.repack_moss_qwen import classify_state_key


def test_manifest_records_audio_sha_and_shape(tmp_path: Path):
    wav = tmp_path / "sample.wav"
    wav.write_bytes(b"RIFFtest")
    m = build_reference_manifest(wav, "moss-sha", (1, 912, 1024), "[0.0][S01]你好[0.8]")
    assert len(m["audio_sha256"]) == 64
    assert m["input_shape"] == [1, 912, 1024]


def test_repack_key_mapping_excludes_audio_weights():
    assert classify_state_key("model.language_model.layers.0.self_attn.q_proj.weight") == "model.layers.0.self_attn.q_proj.weight"
    assert classify_state_key("lm_head.weight") == "lm_head.weight"
    assert classify_state_key("model.whisper_encoder.layers.0.self_attn.q_proj.weight") is None
    assert classify_state_key("model.vq_adaptor.layers.0.weight") is None
```

- [ ] **Step 2: Verify failure.**

Run: `python3 -m pytest tests/tools/test_moss_reference_tools.py -q`

Expected: import failure because the modules do not exist.

- [ ] **Step 3: Add conversion-workstation dependencies.**

```text
numpy>=1.26,<3
soundfile>=0.12,<1
transformers>=5.0,<6
torch>=2.5,<3
safetensors>=0.4,<1
onnx>=1.18,<2
onnxruntime>=1.20,<2
```

- [ ] **Step 4: Implement golden capture.**

```python
captured = {}
def hook(module, args, kwargs):
    captured["embeds"] = kwargs["inputs_embeds"].detach().float().cpu().numpy().copy(order="C")

handle = model.model.language_model.register_forward_pre_hook(hook, with_kwargs=True)
try:
    output_ids = model.generate(**inputs, do_sample=False)
finally:
    handle.remove()
```

Save `.npy`, `.f32`, input IDs/mask, generated text, audio SHA, tensor shape/dtype, model fingerprint, and Python/Torch/Transformers versions. Refuse non-empty output dir unless `force=True`.

- [ ] **Step 5: Implement exact language-weight repack.**

```python
def classify_state_key(key: str) -> str | None:
    prefix = "model.language_model."
    if key.startswith(prefix):
        return "model." + key[len(prefix):]
    return key if key == "lm_head.weight" else None
```

Instantiate standard `Qwen3ForCausalLM` from `model.config.text_config`, load mapped MOSS tensors, copy MOSS tokenizer/chat-template files, save safetensors and `repack_manifest.json`.

- [ ] **Step 6: Verify software tests.**

Run: `python3 -m pytest tests/tools/test_moss_reference_tools.py -q`

Expected: PASS.

- [ ] **Step 7: Produce one 45-second 2-speaker reference on the conversion workstation.**

```bash
python3 tools/moss_rk3588/capture_input_embeds.py --model /opt/moss-build/source/MOSS-Transcribe-Diarize --wav /opt/moss-build/fixtures/zh_2spk_45s.wav --output /opt/moss-build/reference-zh-2spk-45s
python3 tools/moss_rk3588/repack_moss_qwen.py --model /opt/moss-build/source/MOSS-Transcribe-Diarize --output /opt/moss-build/moss-qwen3-repacked
```

Expected: embedding width 1024, `.f32` size = `n_tokens*1024*4`, generation includes timestamped speaker labels.

- [ ] **Step 8: Commit.**

```bash
git add tools/moss_rk3588 tests/tools/test_moss_reference_tools.py
git commit -m "feat: add MOSS golden reference tools"
```

---

## Task 2: Gate A — prove real MOSS `inputs_embeds` through RKLLM on RK3588

**Files:**
- Create: `tools/moss_rk3588/build_calibration_set.py`
- Create: `tools/moss_rk3588/build_rkllm.py`
- Create: `tools/moss_rk3588/compare_pytorch_rkllm.py`
- Create: `tools/moss_rk3588/native/rkllm_embed_probe.cpp`
- Create: `.github/workflows/rk3588-moss-embed-probe.yml`
- Test: `tests/release/test_rk3588_moss_embed_probe_workflow.py`

**Interfaces:** output `/opt/moss-build/moss_qwen3_0.6b_w8a8_rk3588.rkllm`; later tasks are blocked until Gate A passes.

- [ ] **Step 1: Write the failing workflow test.**

```python
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
W = ROOT / ".github/workflows/rk3588-moss-embed-probe.yml"

def test_probe_is_manual_offline_rk3588():
    text = W.read_text(encoding="utf-8")
    assert "workflow_dispatch" in text
    assert "self-hosted" in text and "rk3588" in text.lower()
    assert "RKLLM_INPUT_EMBED" in text
    assert "curl " not in text and "wget " not in text
```

- [ ] **Step 2: Verify failure.**

Run: `python3 -m pytest tests/release/test_rk3588_moss_embed_probe_workflow.py -q`

- [ ] **Step 3: Implement calibration dataset generation from captured embeddings.**

Use the Rockchip multimodal calibration convention: for each reference save a pickle containing at least `{"inputs_embeds": torch.from_numpy(array)}` and write `inputs.json` entries with `{"sample": relative_pickle_path, "token_nums": int(array.shape[1])}`. Reject arrays with final dimension !=1024.

- [ ] **Step 4: Implement RKLLM W8A8 build.**

```python
llm = RKLLM()
assert llm.load_huggingface(model=args.model, device="cpu") == 0
assert llm.build(do_quantization=True, optimization_level=0, quantized_dtype="w8a8",
                 quantized_algorithm="normal", target_platform="rk3588",
                 num_npu_core=3, dataset=args.dataset) == 0
assert llm.export_rkllm(args.output) == 0
```

Abort unless the repack manifest identifies a MOSS source checkpoint.

- [ ] **Step 5: Implement the minimal native external-embedding probe.**

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

Reject raw-file byte-count mismatch before native inference; accumulate callback UTF-8 text; fail on native error state/return.

- [ ] **Step 6: Add the manual self-hosted workflow.**

It requires pre-staged model/reference files plus `/lib/librkllmrt.so`, compiles against RKLLM 1.3.0 headers, runs with no install/download step, and saves generation text.

- [ ] **Step 7: Enforce Gate A.**

`compare_pytorch_rkllm.py` fails unless: at least one segment parses, at least two speaker labels appear on the chosen fixture, normalized character similarity to PyTorch >=0.80, speaker-count difference <=1, and UTF-8 is valid.

If Gate A fails: **stop plan execution here**; do not replace MOSS Qwen with stock Qwen or CPU inference.

- [ ] **Step 8: Verify and commit after hardware Gate A passes.**

```bash
python3 -m pytest tests/release/test_rk3588_moss_embed_probe_workflow.py -q
git add tools/moss_rk3588 .github/workflows/rk3588-moss-embed-probe.yml tests/release/test_rk3588_moss_embed_probe_workflow.py
git commit -m "test: prove MOSS external embeddings on RKLLM"
```

---

## Task 3: Gate B — export Whisper-Medium + merge + VQAdaptor as RKNN FP16

**Files:**
- Create: `tools/moss_rk3588/export_audio_encoder.py`
- Create: `tools/moss_rk3588/build_rknn.py`
- Create: `tools/moss_rk3588/compare_pytorch_rknn.py`
- Test: `tests/tools/test_moss_audio_export.py`
- Modify: `.github/workflows/rk3588-moss-embed-probe.yml`

**Interfaces:** static input `[1,80,3000]`, output `[1,375,1024]`; output `/opt/moss-build/moss_audio_encoder_fp16_rk3588.rknn`.

- [ ] **Step 1: Write the failing export-wrapper test.**

```python
import torch
from tools.moss_rk3588.export_audio_encoder import MossAudioEncoderExport

class FakeWhisper(torch.nn.Module):
    def forward(self, x, return_dict=True):
        y = torch.zeros(1, 1500, 4)
        return type("Out", (), {"last_hidden_state": y})()
class FakeAdaptor(torch.nn.Module):
    def forward(self, x): return x[..., :4]

def test_merge_is_four_to_one():
    out = MossAudioEncoderExport(FakeWhisper(), FakeAdaptor(), 4)(torch.zeros(1,80,3000))
    assert out.shape == (1,375,4)
```

- [ ] **Step 2: Verify failure.** Run: `python3 -m pytest tests/tools/test_moss_audio_export.py -q`

- [ ] **Step 3: Implement export wrapper.**

```python
class MossAudioEncoderExport(torch.nn.Module):
    def __init__(self, whisper, adaptor, merge_size=4):
        super().__init__(); self.whisper=whisper; self.adaptor=adaptor; self.merge_size=merge_size
    def forward(self, input_features):
        feat = self.whisper(input_features, return_dict=True).last_hidden_state
        b,t,d = feat.shape; t = (t//self.merge_size)*self.merge_size
        return self.adaptor(feat[:,:t,:].reshape(b,t//self.merge_size,d*self.merge_size))
```

Load the actual MOSS encoder/adaptor weights, export static ONNX, and require one ONNX Runtime inference to pass.

- [ ] **Step 4: Build RKNN with `do_quantization=False`, `target_platform="rk3588"`.**

- [ ] **Step 5: Enforce board parity Gate B.**

Run fixed reference input with `RKNNLite.NPU_CORE_0_1_2`; require `[1,375,1024]`, finite values, flattened cosine >=0.995, MAE <=0.03.

If Gate B fails: stop and diagnose FP16 export/operators; do not add INT8.

- [ ] **Step 6: Verify and commit.**

```bash
python3 -m pytest tests/tools/test_moss_audio_export.py tests/release/test_rk3588_moss_embed_probe_workflow.py -q
git add tools/moss_rk3588 tests/tools/test_moss_audio_export.py .github/workflows/rk3588-moss-embed-probe.yml
git commit -m "feat: convert MOSS audio encoder to RKNN"
```

---

## Approved revision before Task 4: window policy and 16K rebuild

**Files:** `linux/backend/moss_worker/{__init__,context_budget,windowing,generation_policy}.py`; tests `linux/backend/tests/test_moss_context_budget.py`, `test_moss_windowing.py`, `test_moss_generation_limit.py`; modify `tools/moss_rk3588/build_rkllm.py` and its conversion tests. No application or existing speech-worker changes.

**Verified implementation evidence (2026-09-08):** policy commit `ab75fb0`, same-toolchain 16K builder commit `23e3214`; 50 context/window/generation-limit tests and 29 RKLLM conversion/workflow tests passed. The rebuilt decoder SHA-256 is `e08ba297847920948c4bf4a94141465e6ea5158f60db35308346aea94c849445`; RK3588 runtime reported `max_context_limit: 16384`. Repeated Gate A on the unchanged 666-token engineering fixture produced 7 segments / 2 speakers and normalized character similarity 1.0. This is short-fixture gate evidence, not long-window acceptance; runtime completion metadata and retry persistence still require Tasks 10/11. Source is committed locally; production deployment is incomplete and nothing has been pushed.

- [ ] **Step 1: Run failing policy tests, then implement pure policy functions.** `ContextBudget(max_context_len=16384)` fixes reserve=5120 and safety=512. `plan_windows(duration_ms, expanded_input_tokens, budget)` requires a callable `(start_ms,end_ms)->int` from actual tokenizer/processor expansion; no default estimate. `classify_generation(text, token_count, normal_termination)` returns `GENERATION_LIMIT_REACHED` if any completion guard fails. `plan_retry_windows(failed_window, expanded_input_tokens, budget)` covers the entire failed interval at the next tier with two-minute overlap.

```python
assert ContextBudget().fits(10752)
assert not ContextBudget().fits(10753)
assert classify_generation('[0.0][S01]你好[1.0]', 5119, True) is None
assert classify_generation('[0.0][S01]你好[1.0]', 5120, True) == 'GENERATION_LIMIT_REACHED'
assert classify_generation('[0.0][S01]你好[1.0]', 1, False) == 'GENERATION_LIMIT_REACHED'
assert classify_generation('[0.0][S01]你好', 1, True) == 'GENERATION_LIMIT_REACHED'
```

- [ ] **Step 2: Verify exact-count, logical-boundary and retry coverage tests.** Include exact-fit/one-token overflow, interval-dependent counts, 60/65/125-minute chains, clipped tails, and failed-interval 12->10->8 coverage without gaps or recomputing unrelated windows. Carry the configured tier even on short tails. Run `cd linux/backend && python3 -m pytest tests/test_moss_context_budget.py tests/test_moss_windowing.py tests/test_moss_generation_limit.py -q`.

- [ ] **Step 3: Rebuild decoder with the same RKLLM 1.3.0 toolchain.** Add/test explicit `--max-context 16384` passed as `max_context` to `RKLLM.build`; reject unsupported values before conversion. Preserve the 4096-context artifact. Keep the same MOSS repack, calibration, W8A8 and source hashes.

```bash
python3 tools/moss_rk3588/build_rkllm.py --model /opt/moss-build/moss-qwen3-repacked --dataset /opt/moss-build/calibration-zh-2spk-45s/inputs.json --max-context 16384 --output /opt/moss-build/context-16k/moss_qwen3_0.6b_w8a8_rk3588.rkllm
```

- [ ] **Step 4: Verify the new artifact on RK3588.** Verify full SHA, runtime log `max_context_limit: 16384`, and repeat Gate A on unchanged captured embeddings. Record a new artifact hash; do not relabel the old binary or claim 12-minute acceptance from a short fixture. Bundle only the rebuilt, verified 16K artifact.

- [ ] **Step 5: Review and commit the revision, then continue Task 4.** Real-count adapter and decoder completion metadata integration remain mandatory in Tasks 6/10/11. Pure policy tests do not replace integration.

## Task 4: Build and validate the production model bundle

**Files:**
- Create: `tools/moss_rk3588/export_token_embedding.py`
- Create: `tools/moss_rk3588/build_manifest.py`
- Create: `tools/moss_rk3588/validate_bundle.py`
- Test: `tests/tools/test_moss_bundle_manifest.py`
- Modify: `.gitignore`

**Interfaces:** production root `/opt/suspect-interrogation/models/moss-rk3588`; includes self-test inputs generated from non-case fixture data.

- [ ] **Step 1: Write the failing validator test.**

```python
from tools.moss_rk3588.validate_bundle import validate_manifest

def test_required_bundle_assets():
    errors = "\n".join(validate_manifest({"artifacts":{}}, set()))
    assert "moss_audio_encoder_fp16_rk3588.rknn" in errors
    assert "moss_qwen3_0.6b_w8a8_rk3588.rkllm" in errors
    assert "selftest/encoder_input.npy" in errors
    assert "selftest/decoder_input.f32" in errors
```

- [ ] **Step 2: Verify failure.** Run: `python3 -m pytest tests/tools/test_moss_bundle_manifest.py -q`

- [ ] **Step 3: Export token table.**

```python
w = model.model.language_model.embed_tokens.weight.detach().cpu().to(torch.float16)
w.numpy().astype("<f2", copy=False).tofile(output_path)
```

Write rows, hidden_size=1024, dtype, byte order, source fingerprint and SHA in `token_embedding.json`.

- [ ] **Step 4: Build manifest and self-tests.**

Resolve MOSS source SHA with `git -C SOURCE rev-parse HEAD`; refuse dirty checkout unless `--allow-dirty`. Record actual checkpoint config, toolkit/runtime versions and hashes. Generate `selftest/encoder_input.npy`, `encoder_expected.json`, `decoder_input.f32`, `decoder_expected.json`.

- [ ] **Step 5: Validate exact layout.**

```text
moss_audio_encoder_fp16_rk3588.rknn
moss_qwen3_0.6b_w8a8_rk3588.rkllm
moss_token_embedding_fp16.bin
token_embedding.json
tokenizer.json
tokenizer_config.json
special_tokens_map.json
generation_config.json
processor_config.json
manifest.json
selftest/encoder_input.npy
selftest/encoder_expected.json
selftest/decoder_input.f32
selftest/decoder_expected.json
```

Verify hashes, `rows*1024*2` embedding bytes, audio token, time-marker config, and actually compiled/board-verified context 16,384. Record reserve=5120, safety=512 and the window/overlap policy. Reject the original 4096-context artifact for this bundle.

- [ ] **Step 6: Verify and commit.**

```bash
python3 -m pytest tests/tools/test_moss_bundle_manifest.py -q
git add tools/moss_rk3588 tests/tools/test_moss_bundle_manifest.py .gitignore
git commit -m "feat: define MOSS RK3588 runtime bundle"
```

---

## Task 5: Define types, exact context budget, and 60-minute logical windowing

**Files:**
- Create: `linux/backend/moss_worker/__init__.py`
- Create: `linux/backend/moss_worker/types.py`
- Create: `linux/backend/moss_worker/context_budget.py`
- Create: `linux/backend/moss_worker/windowing.py`
- Test: `linux/backend/tests/test_moss_windowing.py`

**Interfaces:**
- Reuse `ContextBudget(max_context_len=16384)` with fixed reserve=5120 and safety=512 from the approved revision; do not add a second planner with different defaults.
- `plan_windows(duration_ms, expanded_input_tokens, budget)` selects 12/10/8m using the required actual interval-specific input counter.
- Retain tested `WindowSpec(start_ms,end_ms,logical_chunk_index,window_minutes)`; the last field preserves retry tier even on clipped tails.
- For a non-first window, ownership begins at `start_ms + overlap_ms`; `logical_chunk_index = ownership_start_ms // 3_600_000`.

- [ ] **Step 1: Write failing exact-count/window tests.**

```python
from moss_worker.context_budget import ContextBudget
from moss_worker.windowing import plan_windows

def test_exact_count_boundary():
    p = ContextBudget()
    assert p.fits(10752)
    assert not p.fits(10753)

def test_nominal_chain_clips_at_hour_boundaries():
    w = plan_windows(120*60_000, lambda start,end: 10000, ContextBudget())
    assert [(x.start_ms//60_000, x.end_ms//60_000) for x in w[:7]] == [(0,12),(10,22),(20,32),(30,42),(40,52),(50,60),(58,70)]
    assert w[6].logical_chunk_index == 1

def test_smaller_context_uses_approved_ladder():
    count = lambda start,end: 10753 if end-start > 10*60_000 else 9000
    w = plan_windows(60*60_000, count, ContextBudget())
    assert w[0].end_ms == 10*60_000
```

- [ ] **Step 2: Verify failure.** Run: `cd linux/backend && python3 -m pytest tests/test_moss_windowing.py -q`

- [ ] **Step 3: Define immutable enums/dataclasses.**

`types.py`: `JobState`, `WindowState`, `ParseStatus`, `MergeStatus`, `NormalizedSegment`, `WindowResult`, `JobSnapshot`, `JobResult`, with deterministic `to_dict/from_dict`. Import/re-export policy `WindowSpec`, do not create an incompatible duplicate. Add IDs/provenance without breaking approved window/retry tests.

- [ ] **Step 4: Implement exact token accounting.**

Actual complete expanded input IDs determine fit: `expanded_input + 5120 + 512 <= 16384`. Duration-only audio/marker formulas are diagnostic, never execution authorization. The required counter is wired to the real tokenizer/processor path in Task 6; do not silently substitute an estimated prompt count.

- [ ] **Step 5: Implement logical-boundary clipping.**

```python
start = 0
while start < total_ms:
    ownership_start = start if not windows else start + overlap_ms
    logical_end = ((ownership_start // HOUR_MS) + 1) * HOUR_MS
    for minutes in (12, 10, 8):
        end = min(start + minutes*60_000, logical_end, total_ms)
        if budget.fits(expanded_input_tokens(start, end)):
            break
    else:
        raise RuntimeError('MOSS_CONTEXT_OVERFLOW')
    append_window(start, end, ownership_start // HOUR_MS)
    if end == total_ms: break
    start = end - overlap_ms
```

With overlap=2m, this produces `0-12, 10-22, 20-32, 30-42, 40-52, 50-60, 58-70`. Require forward progress, recount clipped intervals and preserve overlap under 10/8-minute tiers.

- [ ] **Step 6: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_windowing.py -q
cd ../..
git add linux/backend/moss_worker linux/backend/tests/test_moss_windowing.py
git commit -m "feat: plan MOSS long-audio windows"
```

---

## Task 6: Reproduce MOSS time markers and build `RKLLM_INPUT_EMBED`

**Files:**
- Create: `linux/backend/requirements-moss-rk3588.txt`
- Create: `linux/backend/moss_worker/embedding_builder.py`
- Test: `linux/backend/tests/test_moss_embedding_builder.py`

**Interfaces:** `TokenEmbeddingTable.lookup(ids) -> float32[n,1024]`; `MossEmbeddingBuilder.build_audio_span_ids`; `build_from_ids`; `build(prompt,audio_embeds)`.

- [ ] **Step 1: Add production-only dependencies.**

```text
numpy>=1.26,<3
tokenizers>=0.20,<1
```

- [ ] **Step 2: Write failing self-contained tests.**

```python
import numpy as np
from moss_worker.embedding_builder import MossEmbeddingBuilder

class FakeTable:
    def lookup(self, ids): return np.asarray([[float(i)]*8 for i in ids], dtype=np.float32)

class FakeTokenizer:
    def encode(self, text): return [10] if text else []


def builder():
    return MossEmbeddingBuilder(FakeTokenizer(), FakeTable(), hidden_size=8,
        audio_token_id=99, digit_token_ids={str(i):200+i for i in range(10)},
        audio_tokens_per_second=12.5, time_marker_every_seconds=5)

def test_markers_do_not_consume_audio_slots():
    b=builder(); ids=b.build_audio_span_ids(125)
    assert ids == [99]*62 + [205] + [99]*62 + [201,200] + [99]

def test_only_audio_ids_are_replaced():
    b=builder(); a=np.arange(32,dtype=np.float32).reshape(4,8)
    x=b.build_from_ids([10,99,11,99,99,99,12], a)
    np.testing.assert_allclose(x.embeds[x.audio_positions], a)
```

- [ ] **Step 3: Verify failure.** Run: `cd linux/backend && python3 -m pytest tests/test_moss_embedding_builder.py -q`

- [ ] **Step 4: Implement FP16 mmap table and exact audio-span insertion.** Reject out-of-range IDs; gather requested rows only; convert selected rows to C-contiguous FP32. Marker digits add token positions without reducing audio placeholder count.

- [ ] **Step 5: Implement final build/context guard.** Tokenize exact MOSS prompt, expand audio placeholder, inject only at `audio_token_id`, and require actual input+5120+512<=16384. Supply the planner's interval counter from the same builder/tokenizer path. Compare 8/10/12-minute full input IDs/counts against the official processor on the conversion workstation. Test an estimate that fits while the actual prompt does not: directly select 10, not 12 minutes. Repeat the count guard at native submission.

- [ ] **Step 6: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_embedding_builder.py tests/test_moss_windowing.py -q
cd ../..
git add linux/backend/requirements-moss-rk3588.txt linux/backend/moss_worker/embedding_builder.py linux/backend/tests/test_moss_embedding_builder.py
git commit -m "feat: construct MOSS external embeddings"
```

---

## Task 7: Parse generation into absolute-time segments

**Files:**
- Create: `linux/backend/moss_worker/parser.py`
- Test: `linux/backend/tests/test_moss_parser.py`

**Interfaces:** `parse_generation(raw: str, window: WindowSpec) -> ParsedGeneration`; parser module defines `ParsedGeneration(valid_segments, invalid_fragments, raw_generation)`.

- [ ] **Step 1: Write failing tests with a local window helper.**

```python
from moss_worker.parser import parse_generation
from moss_worker.types import WindowSpec, ParseStatus

def w(): return WindowSpec(30*60_000,42*60_000,0,12)

def test_absolute_offset():
    s=parse_generation("[12.0][S01]你好[13.5]", w()).valid_segments[0]
    assert (s.start_ms,s.end_ms)==(30*60_000+12_000,30*60_000+13_500)
    assert s.parse_status is ParseStatus.VALID

def test_missing_end_repairs_from_next_start():
    s=parse_generation("[1.0][S01]第一句[2.5][S02]第二句[3.0]", w()).valid_segments[0]
    assert s.end_ms==30*60_000+2_500 and s.parse_status is ParseStatus.REPAIRED
```

- [ ] **Step 2: Verify failure.** Run: `cd linux/backend && python3 -m pytest tests/test_moss_parser.py -q`

- [ ] **Step 3: Implement strict parser.** Accept `S` + >=2 digits, non-negative monotonic timestamps, non-empty text, end>=start; convert local seconds to absolute ms immediately.

- [ ] **Step 4: Implement deterministic repair only.** Missing end can use next start. Final unbounded fragment becomes INVALID and stays outside authoritative timeline.

- [ ] **Step 5: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_parser.py -q
cd ../..
git add linux/backend/moss_worker/parser.py linux/backend/tests/test_moss_parser.py
git commit -m "feat: parse MOSS diarized generations"
```

---

## Task 8: Map local speakers to global speakers and merge overlap

**Files:**
- Create: `linux/backend/moss_worker/speaker_remap.py`
- Create: `linux/backend/moss_worker/merger.py`
- Test: `linux/backend/tests/test_moss_speaker_remap.py`
- Test: `linux/backend/tests/test_moss_merger.py`

**Interfaces:** `segment_match_score(a,b,order_score) -> float`; `SpeakerRemapper.map_adjacent`; `merge_adjacent`.

- [ ] **Step 1: Write failing scoring/one-to-one tests.**

```python
from moss_worker.speaker_remap import segment_match_score

def test_identical_overlap_is_strong():
    a={"start_ms":1_000,"end_ms":2_000,"text":"你几点到的"}
    b={"start_ms":1_020,"end_ms":2_010,"text":"你是几点到的"}
    assert segment_match_score(a,b,1.0) > 0.80
```

Add a second test with a 2x2 correspondence matrix and assert the assignment contains two distinct global labels.

- [ ] **Step 2: Verify failure.** Run both Task 8 test files.

- [ ] **Step 3: Implement score exactly.** `0.45*time_iou + 0.35*text_similarity + 0.10*duration_similarity + 0.10*order_similarity`; NFKC + punctuation/space normalization; `difflib.SequenceMatcher` for text.

- [ ] **Step 4: Implement deterministic maximum-weight one-to-one assignment.** Enumerate permutations of the smaller speaker set; lexicographic speaker order is tie-breaker. `>=0.85` inherits; lower confidence allocates new `GSxx`.

- [ ] **Step 5: Write failing merge test and implement midpoint ownership.**

```python
def test_conflicting_overlap_preserves_alternate(merger_fixture):
    merged = merger_fixture("我十点半到的", "我十点到的")
    assert merged.primary.merge_conflict is True
    assert merged.primary.alternate_text in {"我十点半到的","我十点到的"}
```

For 10-12m overlap boundary=11:00. Never split a crossing utterance; choose complete version farther from source-window edge.

- [ ] **Step 6: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_speaker_remap.py tests/test_moss_merger.py -q
cd ../..
git add linux/backend/moss_worker/speaker_remap.py linux/backend/moss_worker/merger.py linux/backend/tests/test_moss_speaker_remap.py linux/backend/tests/test_moss_merger.py
git commit -m "feat: preserve MOSS speakers across windows"
```

---

## Task 9: Add durable spool/checkpoints

**Files:**
- Create: `linux/backend/moss_worker/storage.py`
- Test: `linux/backend/tests/test_moss_storage.py`

**Interfaces:** `MossSpool.create_job/load_job/save_job/save_window_result/load_completed_windows/save_speaker_state/save_merged_segments`.

- [ ] **Step 1: Write failing atomic-write test.**

```python
from moss_worker.storage import atomic_write_json

def test_atomic_json_keeps_previous_file_on_serialization_error(tmp_path):
    p=tmp_path/"job.json"; atomic_write_json(p,{"state":"QUEUED"})
    try: atomic_write_json(p,{"bad":object()})
    except TypeError: pass
    assert '"QUEUED"' in p.read_text()
```

- [ ] **Step 2: Verify failure.** Run: `cd linux/backend && python3 -m pytest tests/test_moss_storage.py -q`

- [ ] **Step 3: Implement `tmp -> flush -> fsync -> os.replace` and exact layout.**

```text
jobs/JOB/job.json
jobs/JOB/windows.json
jobs/JOB/speaker_state.json
jobs/JOB/merged_segments.jsonl
jobs/JOB/raw_generations/WINDOW.txt
jobs/JOB/checkpoints/WINDOW.json
jobs/JOB/logs/events.jsonl
```

- [ ] **Step 4: Implement source integrity/revisions.** Hash WAV at creation/resume; mismatch raises `MOSS_AUDIO_CHANGED`. Same audio under another model manifest gets a new job ID; never overwrite a completed revision.

- [ ] **Step 5: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_storage.py -q
cd ../..
git add linux/backend/moss_worker/storage.py linux/backend/tests/test_moss_storage.py
git commit -m "feat: persist MOSS job checkpoints"
```

---

## Task 10: Implement one-window RKNN/RKLLM runtime in a child process

**Files:**
- Create: `linux/backend/moss_worker/audio_frontend.py`
- Create: `linux/backend/moss_worker/rknn_audio_encoder.py`
- Create: `linux/backend/moss_worker/rkllm_decoder.py`
- Create: `linux/backend/moss_worker/runtime.py`
- Create: `linux/backend/moss_worker/child.py`
- Test: `linux/backend/tests/test_moss_runtime_contract.py`

**Interfaces:** accepted Phase-1 WAV is PCM16/mono/16000 Hz; other formats raise `MOSS_AUDIO_UNSUPPORTED_FORMAT`. `MossRuntime.infer_window(window,wav)->WindowResult`.

- [ ] **Step 1: Write failing orchestration test with explicit fakes.**

```python
class Enc:
    def encode(self,x,n): return np.zeros((n,8),np.float32)
class Dec:
    def generate(self,x,max_new_tokens):
        return type("R",(),{"text":"[0.0][S01]你好[1.0]",
                            "token_count":16,"normal_termination":True})()

def test_runtime_pipeline_order(fake_frontend, fake_builder, window, wav):
    rt=MossRuntime(fake_frontend,Enc(),fake_builder,Dec()); rt.infer_window(window,wav)
    assert rt.trace==["ENCODING","BUILDING_EMBEDS","DECODING","PARSING"]
```

- [ ] **Step 2: Verify failure.** Run runtime contract test.

- [ ] **Step 3: Implement audio frontend.** Use `wave`; require sample width=2, channels=1, rate=16000; float32 normalize; compute Whisper log-mel using values exported in `processor_config.json`; pad each 30s chunk and calculate valid adapted tokens from real sample count.

- [ ] **Step 4: Implement RKNN wrapper.** Load once, `NPU_CORE_0_1_2`, finite/shape checks, slice valid token prefix.

- [ ] **Step 5: Implement RKLLM 1.3.0 ctypes wrapper.** Require C-contiguous `float32[n,1024]`, EMBED, thinking false, history false; expose generated text, actual generated-token count, normal termination evidence and perf counters. Set max_new_tokens=5120. Inspect actual SDK token/finish metadata: native FINISH alone is not EOS proof. If normal termination cannot be established, fail closed with `GENERATION_LIMIT_REACHED`. Convert native errors to structured MOSS errors.

- [ ] **Step 6: Implement `infer_window` and startup self-test.** Serial RKNN chunks -> concat -> builder -> exact context guard -> RKLLM -> `classify_generation` -> parser. Retain raw output/metadata but reject authoritative partials on `GENERATION_LIMIT_REACHED`; parser repairs cannot hide a limit-hit or incomplete tail. Test 5119 complete tokens, 5120 tokens, missing EOS, incomplete tail and no DONE checkpoint for failed attempts. On child startup run Task 4 self-tests; failure exits non-zero/NOT_READY.

- [ ] **Step 7: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_runtime_contract.py tests/test_moss_embedding_builder.py tests/test_moss_parser.py -q
cd ../..
git add linux/backend/moss_worker linux/backend/tests/test_moss_runtime_contract.py
git commit -m "feat: add isolated MOSS NPU runtime"
```

---

## Task 11: Add supervisor queue, retries, cancellation, and child recovery

**Files:**
- Create: `linux/backend/moss_worker/supervisor.py`
- Test: `linux/backend/tests/test_moss_supervisor.py`

**Interfaces:** `submit`, `get_job`, `get_result`, `cancel`; one active job/child call.

- [ ] **Step 1: Write failing crash-resume test.**

```python
class CrashOnceChild:
    def __init__(self): self.calls=[]; self.crashed=False
    def infer(self,w):
        self.calls.append(w.window_id)
        if w.window_id=="w0002" and not self.crashed:
            self.crashed=True; raise ChildExited(signal=11)
        return scripted_result(w)

def test_completed_window_is_not_recomputed_after_child_crash(spool, windows):
    child=CrashOnceChild(); s=MossSupervisor(spool, lambda:child)
    s.run_scripted(windows)
    assert child.calls.count("w0001")==1
    assert child.calls.count("w0002")==2
```

- [ ] **Step 2: Verify failure.** Run supervisor test.

- [ ] **Step 3: Implement state transitions/serialization.** Only the spec states are legal; terminal states cannot transition out.

- [ ] **Step 4: Implement retry policy.** Context/OOM or `GENERATION_LIMIT_REACHED`: 12->10->8 with 2-minute overlap and fixed reserve/safety. `plan_retry_windows` covers the full failed interval, preserving raw failed attempts and unrelated completed windows; only completed replacements enter the authoritative timeline. Test full coverage, repeated failures, tier 8 terminal and no infinite clipped-tail retry. Native crash: restart/self-test child and retry same window once; second crash fails job.

- [ ] **Step 5: Implement cancellation.** QUEUED immediate; RUNNING sets cancel flag; 10s native cancellation grace then kill/restart child; preserve completed checkpoints.

- [ ] **Step 6: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_supervisor.py tests/test_moss_storage.py -q
cd ../..
git add linux/backend/moss_worker/supervisor.py linux/backend/tests/test_moss_supervisor.py
git commit -m "feat: supervise durable MOSS jobs"
```

---

## Task 12: Add Unix socket server/client

**Files:**
- Create: `linux/backend/moss_worker/protocol.py`
- Create: `linux/backend/moss_worker/main.py`
- Create: `linux/backend/app/ai/moss/__init__.py`
- Create: `linux/backend/app/ai/moss/types.py`
- Create: `linux/backend/app/ai/moss/client.py`
- Test: `linux/backend/tests/test_moss_protocol.py`
- Test: `linux/backend/tests/test_moss_client_server.py`

**Interfaces:** `/run/suspect-interrogation/moss.sock`; ops `health`, `submit_job`, `get_job`, `get_result`, `cancel_job`; 4-byte big-endian JSON framing; max 16 MiB.

- [ ] **Step 1: Write failing framing test.**

```python
def test_frame_round_trip(socket_pair):
    a,b=socket_pair
    send_frame(a,{"request_id":"1","op":"health"})
    assert recv_frame(b)=={"request_id":"1","op":"health"}
```

Also test oversized/truncated/non-object JSON rejection.

- [ ] **Step 2: Verify failure.** Run both protocol/client-server tests.

- [ ] **Step 3: Implement protocol and exact errors.** Include model/RKNN/RKLLM/context/OOM/invalid-generation/audio-corrupt/unsupported/audio-changed/cancelled/job-not-found/worker-crashed codes and exact `GENERATION_LIMIT_REACHED`; preserve failed interval, attempt tier and termination metadata for status/results.

- [ ] **Step 4: Implement stale-socket-safe server.** Refuse non-socket path, probe active socket, remove only proven stale socket, bind/chmod 0660.

- [ ] **Step 5: Implement client.**

```python
class MossWorkerClient:
    def health(self)->dict[str,object]: ...
    def submit_job(self,audio_path:str,audio_sha256:str|None=None)->MossJobSnapshot: ...
    def get_job(self,job_id:str)->MossJobSnapshot: ...
    def get_result(self,job_id:str)->MossJobResult: ...
    def cancel_job(self,job_id:str)->MossJobSnapshot: ...
```

Validate request ID/`ok` exactly like existing speech client.

- [ ] **Step 6: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_protocol.py tests/test_moss_client_server.py -q
cd ../..
git add linux/backend/moss_worker/protocol.py linux/backend/moss_worker/main.py linux/backend/app/ai/moss linux/backend/tests/test_moss_protocol.py linux/backend/tests/test_moss_client_server.py
git commit -m "feat: expose MOSS worker socket API"
```

---

## Task 13: Integrate settings, registry, service layer, and health

**Files:**
- Modify: `linux/backend/app/ai/settings.py`
- Modify: `linux/backend/app/ai/registry.py`
- Modify: `linux/backend/config/model-registry.yaml`
- Create: `linux/backend/app/services/moss_transcription.py`
- Modify: `linux/backend/app/health.py`
- Test: `linux/backend/tests/test_moss_settings_registry.py`
- Test: `linux/backend/tests/test_moss_service.py`
- Modify test: `linux/backend/tests/test_health_contract.py`
- Modify test: `linux/backend/tests/test_capability_health.py`

- [ ] **Step 1: Write failing defaults test.**

```python
def test_moss_defaults(monkeypatch):
    for k in ("MOSS_ENABLED","SUSPECT_MOSS_SOCKET","MOSS_SPOOL_ROOT","MOSS_MODEL_ID"): monkeypatch.delenv(k,raising=False)
    s=AISettings()
    assert s.moss_enabled is False
    assert str(s.moss_socket)=="/run/suspect-interrogation/moss.sock"
    assert str(s.moss_spool_root)=="/var/lib/suspect-interrogation/moss"
    assert s.moss_model_id=="moss.default"
```

- [ ] **Step 2: Verify failure.** Run the four Task 13 test files.

- [ ] **Step 3: Add settings + registry kind `moss` and `moss.default`.** Registry required files come from Task 4; capabilities are transcription/diarization/timestamps/long_audio; device=npu; context equals verified manifest value.

- [ ] **Step 4: Implement `MossTranscriptionService`.** Resolve audio path/hash, call worker client, return typed snapshots/results, never person-identify `GSxx`.

- [ ] **Step 5: Add optional health capability.** `MOSS_ENABLED=0` reports disabled and does not change readiness. Enabled MOSS reports worker/model/manifest/queue/active job/runtime/last error as non-required capability; realtime ASR remains independent.

- [ ] **Step 6: Verify and commit.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_settings_registry.py tests/test_moss_service.py tests/test_health_contract.py tests/test_capability_health.py -q
cd ../..
git add linux/backend/app/ai/settings.py linux/backend/app/ai/registry.py linux/backend/config/model-registry.yaml linux/backend/app/services/moss_transcription.py linux/backend/app/health.py linux/backend/tests/test_moss_settings_registry.py linux/backend/tests/test_moss_service.py linux/backend/tests/test_health_contract.py linux/backend/tests/test_capability_health.py
git commit -m "feat: integrate MOSS backend capability"
```

---

## Task 14: Add systemd/offline deployment integration

**Files:**
- Create: `systemd/moss-worker.service`
- Modify: `.github/workflows/rk3588-service-bootstrap.yml`
- Modify: `.github/workflows/rk3588-production-redeploy.yml`
- Modify: `.github/workflows/linux-ai-runtime-rk3588.yml`
- Create: `scripts/ci/probe-moss-rk3588.py`
- Test: `tests/release/test_moss_systemd_and_deploy.py`
- Modify: `docs/release/RK3588-EVIDENCE.md`

- [ ] **Step 1: Write failing unit-file contract test.**

```python
from pathlib import Path
UNIT=Path("systemd/moss-worker.service")
def test_unit_is_local_restricted_and_not_tcp8000():
    t=UNIT.read_text()
    assert "User=suspect-interrogation" in t and "Group=suspect-interrogation" in t
    assert "RuntimeDirectory=suspect-interrogation" in t
    assert "Restart=on-failure" in t
    assert "8000" not in t
    assert "/opt/suspect-interrogation/models/moss-rk3588" in t
```

- [ ] **Step 2: Verify failure.** Run: `python3 -m pytest tests/release/test_moss_systemd_and_deploy.py -q`

- [ ] **Step 3: Implement `moss-worker.service`.** Use same hardening as `ai-worker.service`, exact user/group, current backend working directory, runtime/moss env files, socket/model env, `ExecStart=/opt/suspect-interrogation/current/.venv/bin/python -m moss_worker.main`, restart-on-failure, writable run/var-lib/var-log, read-only model and `/lib` runtime files.

- [ ] **Step 4: Implement read-only RK3588 probe.** Verify bundle hashes, `/lib/librknnrt.so`, `/lib/librkllmrt.so`, aarch64, socket health, model state, manifest SHA, queue depth, runtime versions; never submit case audio or download anything.

- [ ] **Step 5: Modify bootstrap/redeploy workflows.** Create spool with correct owner, install/enable service, install MOSS Python deps only from pre-staged offline wheel source, restart MOSS on atomic redeploy when enabled, preserve shared model/spool directories, leave TCP/8000 owner untouched.

- [ ] **Step 6: Verify and commit.**

```bash
python3 -m pytest tests/release/test_moss_systemd_and_deploy.py -q
git add systemd/moss-worker.service .github/workflows/rk3588-service-bootstrap.yml .github/workflows/rk3588-production-redeploy.yml .github/workflows/linux-ai-runtime-rk3588.yml scripts/ci/probe-moss-rk3588.py tests/release/test_moss_systemd_and_deploy.py docs/release/RK3588-EVIDENCE.md
git commit -m "ops: deploy MOSS worker on RK3588"
```

---

## Task 15: Long-audio acceptance and production verification

**Files:**
- Create: `linux/backend/tests/fixtures/moss/README.md`
- Create: `linux/backend/tests/test_moss_e2e_mock.py`
- Create: `scripts/ci/moss-rk3588-acceptance.py`
- Create: `.github/workflows/rk3588-moss-acceptance.yml`
- Test: `tests/release/test_rk3588_moss_acceptance_workflow.py`
- Modify: `docs/release/RK3588-EVIDENCE.md`

- [ ] **Step 1: Write failing mock 125-minute acceptance test.**

```python
def test_125m_mock_keeps_global_speaker_and_resume(orchestrator_fixture):
    r=orchestrator_fixture.run(total_minutes=125, crash_once_at="w0003")
    assert r.completed is True
    assert r.recomputed_windows==[]
    assert r.cross_hour_continuity is True
    assert any(s.merge_conflict for s in r.segments)
```

Fixture scripts local S labels to change between windows while strong overlap evidence points to the same global speakers.

- [ ] **Step 2: Verify failure.** Run `linux/backend/tests/test_moss_e2e_mock.py` plus workflow contract test.

- [ ] **Step 3: Define external PCM16/mono/16k corpus.**

```text
/opt/moss-acceptance/audio/01_single_speaker_05m.wav
/opt/moss-acceptance/audio/02_two_speaker_30m.wav
/opt/moss-acceptance/audio/03_two_speaker_60m.wav
/opt/moss-acceptance/audio/04_three_speaker_65m.wav
/opt/moss-acceptance/audio/05_overlap_boundary_70m.wav
/opt/moss-acceptance/audio/06_silence_noise_30m.wav
/opt/moss-acceptance/audio/07_two_speaker_120m.wav
```

Each has same-basename JSON sidecar with duration, language, minimum speakers, cross-hour requirement. Workflow fails if corpus absent; no download substitutes.

- [ ] **Step 4: Implement hardware runner.** Submit/poll each job, compute `RTF=processing_seconds/audio_seconds`, validate timestamps finite/monotonic/in-range, record GS count, confidence distribution, repairs/invalids, conflicts, retries, audio SHA and manifest SHA.

- [ ] **Step 5: Enforce Phase-1 gates.** 30m two-speaker RTF<=1.0; 60m completes no crash/OOM; 65/70m demonstrate cross-hour speaker continuity; 120m completes chained windows; all authoritative segments have source `window_id` + `model_manifest_sha256`. RTF<=0.5 is only the later optimization target.

- [ ] **Step 6: Run software verification.**

```bash
cd linux/backend && python3 -m pytest tests/test_moss_*.py -q
cd ../..
python3 -m pytest tests/tools/test_moss_*.py tests/release/test_moss_*.py tests/release/test_rk3588_moss_*.py -q
```

- [ ] **Step 7: Commit acceptance harness, then run real RK3588 acceptance.**

```bash
git add linux/backend/tests/fixtures/moss linux/backend/tests/test_moss_e2e_mock.py scripts/ci/moss-rk3588-acceptance.py .github/workflows/rk3588-moss-acceptance.yml tests/release/test_rk3588_moss_acceptance_workflow.py docs/release/RK3588-EVIDENCE.md
git commit -m "test: add MOSS RK3588 acceptance coverage"
```

Record exact workflow run/evidence in `docs/release/RK3588-EVIDENCE.md`.

- [ ] **Step 8: Complete `AGENTS.md` production Definition of Done for exact final SHA.**

```text
1. Relevant CI green.
2. RK3588 Production Redeploy ran for exact SHA.
3. Atomic release installed from exact SHA.
4. https://192.168.0.9:18080 validates with project LAN CA; no -k.
5. /health/live and /health/ready validate with TLS verification.
6. MOSS capability ready with expected manifest SHA.
7. Short offline production MOSS fixture returns timestamped GSxx output.
8. Browser audio still derives wss:// from HTTPS origin.
9. Deployed release SHA equals GitHub SHA.
10. TCP/8000 remains listening and owned by the pre-existing FunASR service.
```

Do not report implementation complete before all ten checks pass. If source is committed but deployment is incomplete, report exactly: **code committed, production deployment incomplete**.

---

## Execution Gates

```text
Task 1  Golden reference + MOSS Qwen repack
  -> Task 2 Gate A: real MOSS inputs_embeds on RKLLM
  -> Task 3 Gate B: acoustic RKNN parity
  -> Task 4 reproducible runtime bundle
  -> Tasks 5-12 runtime/windowing/persistence/IPC
  -> Tasks 13-14 application + system deployment
  -> Task 15 long-audio acceptance + production verification
```

**Stop at Gate A** if external embeddings do not yield structurally valid MOSS output. No stock-Qwen/CPU fallback.

**Stop at Gate B** if FP16 RKNN does not meet parity. No acoustic INT8 workaround.

**Do not add ERes2Net identity binding in this plan.** Fusion is a separately reviewed phase after the standalone MOSS path is proven.

## Non-blocking Spike: more than 16K context

After the 16K primary path works, separately record official longer-context support, memory/performance and MOSS parity. This investigation must not block current tasks, replace the validated primary toolchain, alter RoPE, or expand the approved window ladder without new approval.
