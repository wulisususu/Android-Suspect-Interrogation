# MOSS-RK3588 NPU Backend Design

Date: 2026-09-08
Branch: `linux-adaptation`
Status: Approved design; 16K window/generation policy revised with user approval

Approved revision (2026-09-08): retain the Gate A/Gate B validated RKNN/RKLLM toolchain. Model context is 16,384 tokens, generation reserve 5,120, safety margin 512; model windows use 12/10/8 minutes with 2-minute overlap. The 60-minute logical chunk is unchanged. More than 16K context is a non-blocking optimization Spike, not a reason to replace the primary toolchain.

Approved revision (2026-09-09, user-approved final tiering): window policy is re-tiered to target 10 minutes, fallback 8 minutes, minimum 8 minutes (retry ladder 10 -> 8 -> terminal failure); fallback_window == minimum_window == 8 minutes, an 8-minute window failing again is a terminal failure (`RetryExhausted`) with no further automatic down-scaling, and adding smaller tiers (6m/4m/…) below the minimum is forbidden. The 2-minute overlap, 16,384 context, 5,120 generation reserve and 512 safety margin are unchanged. The same approval fixes the parser boundary semantics: a segment end at most one 10 ms model-raster half-step past the window end is clamped to the window end (`END_TIMESTAMP_CLAMPED_TO_WINDOW_END`, original value retained for audit), and a terminal fragment that is only a dangling timestamp is dropped (`DANGLING_TRAILING_TIMESTAMP_DROPPED`, verbatim text retained); any larger overshoot, any start-timestamp overshoot, and any fragment carrying speaker or text stays INVALID (`MOSS_INVALID_GENERATION`). Verified against the verbatim board capture `gradient-8m-w1` (audio sha256 `bd4776d6b321e7f5fd4d140576e3b2c9ffbe52d03acc9d149ec8fa707c53b998`): the run that previously published 0 segments now yields 74 VALID + 1 REPAIRED segments.

## 1. Objective

Introduce a standalone, fully offline `MOSS-RK3588 NPU backend` for long-form transcription plus anonymous speaker diarization on a single RK3588 32 GB device.

Phase 1 deliberately does **not** depend on the existing Paraformer/FSMN/ERes2Net path. The immediate goal is to prove and productionize a separate MOSS-only path that can produce:

```text
[start][Sxx]text[end]
```

and then normalize local speaker labels into stable global anonymous labels:

```text
GS01 / GS02 / GS03 / ...
```

Real-person identity binding is explicitly out of scope for Phase 1 and may be added later by fusing the MOSS diarization result with a voiceprint backend.

## 2. Hard Constraints

- Target hardware: one RK3588, 32 GB RAM.
- Offline-only inference; no cloud API or external-network dependency.
- Heavy inference should run on the RK3588 NPU.
- Total interrogation duration has no hard upper limit.
- The scheduler exposes one-hour logical chunks.
- Model inference uses smaller overlapping internal windows to stay within the MOSS/Qwen context budget.
- Existing `speech_worker` remains operational and is not the dependency of this backend.
- Raw audio remains the immutable source of truth; all MOSS outputs are derived artifacts.

## 3. Why a Separate Backend

The repository already isolates speech inference behind an independent Unix-socket worker. The MOSS path has different runtime characteristics from the current realtime speech path:

- MOSS performs long-window batch inference rather than low-latency streaming.
- RKNN and RKLLM native runtimes can hold large NPU resources for extended periods.
- A 10-minute MOSS window can take long enough that sharing the realtime worker lock would stall interactive speech processing.
- Native RKNN/RKLLM failures must not crash the FastAPI service or the existing speech worker.

Therefore MOSS is implemented as a new process family rather than being inserted into `speech_worker`.

## 4. High-Level Architecture

```text
Original WAV
    |
    v
MOSS Job Orchestrator
    |
    +-- 60 min logical chunks
    |
    +-- target 10 min model windows
    |       with 2 min overlap
    v
moss_worker supervisor
    |
    v
inference child process
    |
    +-----------------------------+
    |                             |
    v                             v
RKNN Audio Encoder          RKLLM Decoder
Whisper-Medium              MOSS-tuned Qwen3-0.6B
+ 4x merge                  W8A8
+ VQAdaptor                 RKLLM_INPUT_EMBED
FP16
    |                             ^
    +------ audio embeddings -----+
                                  |
                         CPU Embedding Builder
                                  |
                                  v
                      [time][Sxx]text[time]
                                  |
                                  v
                               Parser
                                  |
                                  v
                     Global Speaker Remapper
                                  |
                                  v
                    Overlap / Conflict Merger
                                  |
                                  v
                       Versioned Transcript
```

## 5. Repository Boundary

Recommended layout:

```text
linux/backend/
├─ speech_worker/                 # existing realtime path; Phase 1 unchanged
├─ moss_worker/
│  ├─ main.py                     # Unix socket server / job API
│  ├─ supervisor.py               # inference child lifecycle
│  ├─ runtime.py                  # runtime facade
│  ├─ audio_frontend.py           # decode/resample/log-mel
│  ├─ rknn_audio_encoder.py       # RKNN wrapper
│  ├─ embedding_builder.py        # MOSS processor semantics + embed injection
│  ├─ rkllm_decoder.py            # RKLLM wrapper
│  ├─ context_budget.py           # maximum-safe-window planning
│  ├─ windowing.py                # 60m logical / 10/8m model windows / 2m overlap
│  ├─ generation_policy.py        # fail-closed generation completion checks
│  ├─ parser.py                   # generated text -> typed segments
│  ├─ speaker_remap.py            # local Sxx -> global GSxx
│  ├─ merger.py                   # overlap ownership and conflict handling
│  ├─ protocol.py                 # Unix-socket wire schema
│  ├─ storage.py                  # spool/checkpoint persistence
│  └─ types.py                    # domain dataclasses
│
├─ app/
│  ├─ ai/moss/
│  │  ├─ client.py                # FastAPI-side moss.sock client
│  │  └─ types.py
│  └─ services/
│     └─ moss_transcription.py    # business orchestration
│
└─ config/model-registry.yaml     # model/runtime registrations

tools/moss_rk3588/
├─ capture_input_embeds.py
├─ export_audio_encoder.py
├─ export_onnx.py
├─ build_rknn.py
├─ build_calibration_set.py
├─ repack_moss_qwen.py
├─ build_rkllm.py
├─ export_token_embedding.py
├─ compare_pytorch_rknn.py
└─ compare_pytorch_rkllm.py
```

The PC conversion toolchain is strictly separated from the board runtime. Production does not require PyTorch, Transformers, RKNN Toolkit2, or RKLLM Toolkit.

## 6. Model Partitioning

MOSS-Transcribe-Diarize is treated as three runtime components.

### 6.1 Audio encoder graph

A single RKNN graph contains:

```text
Whisper-Medium Encoder
  -> 4x temporal merge
  -> Linear 4096 -> 1024
  -> SiLU
  -> Linear 1024 -> 1024
  -> LayerNorm
```

Target artifact:

```text
moss_audio_encoder_fp16_rk3588.rknn
```

First production version uses FP16 for the acoustic path. The design intentionally avoids INT8 acoustic quantization until numerical and diarization parity are demonstrated.

Fixed input shape:

```text
[1, 80, 3000]
```

representing one Whisper-style 30-second log-mel block.

Nominal fixed output:

```text
[1, 375, 1024]
```

For the final partially filled 30-second block, the model input is padded to the fixed shape, while only the calculated valid audio-token prefix is retained.

### 6.2 Language decoder

The language model must be repacked from the **MOSS checkpoint weights**, not replaced with a stock Qwen3-0.6B download.

The resulting standard-Qwen-compatible package includes:

- MOSS-trained Qwen3 language-model weights.
- MOSS-tied `lm_head`.
- MOSS tokenizer and special tokens.
- Generation configuration.

Target artifact:

```text
moss_qwen3_0.6b_w8a8_rk3588.rkllm
```

First production quantization target:

```text
W8A8
```

### 6.3 Text embedding table

Because the decoder is driven through `RKLLM_INPUT_EMBED`, the host runtime must construct the complete prompt/audio embedding sequence. Export the MOSS text embedding table as a separate runtime artifact:

```text
moss_token_embedding_fp16.bin
```

The table remains FP16 and can be memory-mapped. Only selected token rows are expanded to FP32 while building a request buffer.

## 7. Internal Audio Data Flow

A target 10-minute model window is not sent to RKNN as one tensor. It is split into 30-second acoustic micro-chunks.

```text
10 min window
  -> 20 x 30 s blocks
  -> CPU log-mel extraction
  -> RKNN audio encoder, serially
  -> keep valid adapted-token prefix for each block
  -> concatenate audio embeddings
```

The resulting adapted audio-token stream is then consumed by the CPU embedding builder.

This preserves the original MOSS long-audio behavior: Whisper chunks are encoded independently, valid encoder features are concatenated, then the 4x merge/adaptor semantics produce the language-model audio tokens.

## 8. MOSS Processor Compatibility

The RK3588 runtime must reproduce the upstream MOSS processor semantics rather than inventing a simplified prompt.

Critical invariants:

- Mono audio.
- MOSS tokenizer and chat template.
- MOSS audio token ID.
- `audio_tokens_per_second = 12.5` unless the selected checkpoint config states otherwise.
- `audio_merge_size = 4` unless checkpoint config differs.
- Numeric time markers are inserted at the checkpoint-configured cadence: the selected checkpoint uses 5 seconds (not the processor class's 2-second default). Reproduce the processor's integer marker placement exactly.

The audio span is not just a continuous list of audio placeholders. Numeric marker token IDs occur inside the span. Therefore the embedding builder performs:

1. Build the exact MOSS `input_ids` sequence.
2. Lookup normal and time-marker token embeddings from the MOSS embedding table.
3. Identify only `audio_token_id` positions.
4. Replace those positions in order with RKNN audio embeddings.
5. Submit the complete `n_tokens x 1024` floating-point embedding sequence to RKLLM.

This is the board-side equivalent of MOSS's `masked_scatter` operation.

## 9. Context Budget Planner

A 10-minute window is a target, not a hard constant. The actual tokenizer/processor expansion for the specific candidate interval is authoritative; a duration-only estimate must never authorize execution.

At 12.5 audio tokens/second:

```text
600 s * 12.5 = 7,500 audio tokens
```

MOSS time-marker digits, system/user prompt, assistant prefix, and generated transcript consume additional positions. Therefore every window must pass a context-budget calculation before inference.

Configuration starts with:

```text
max_context_len = 16384
target_window_minutes = 10
fallback_window_minutes = 8
minimum_window_minutes = 8
target_overlap_minutes = 2
generation_reserve_tokens = 5120
safety_margin_tokens = 512
```

Constraint:

```text
expanded_input_tokens
+ generation_reserve_tokens
+ safety_margin_tokens
<= rkllm_max_context_len
```

Count the complete actual expanded input, including the exact MOSS template, special tokens, time markers, audio placeholders and assistant prefix. With these reserves, at most 10,752 expanded input tokens fit; 10,753 does not. Duration-based audio/marker estimates and assumed prompt sizes cannot authorize execution. Load the selected checkpoint's 5-second marker cadence rather than the processor class default. Recount after clipping at a recording/hour boundary and before every submission.

An actual official-processor check with the default prompt and repeated synthetic engineering fixture produced expanded counts 6,354 / 7,926 / 9,498 for 8/10/12 minutes respectively. These are fixture evidence, not constants for execution; different prompts/processor versions must be recounted.

If the target window does not fit, directly try the 8-minute fallback, with the same output/safety reservations and 2-minute overlap:

```text
10 min -> 8 min
```

A window that cannot run at 8 minutes fails explicitly. The 8-minute fallback is also the minimum: fallback == minimum == 8 minutes, a failed 8-minute attempt is terminal (`RetryExhausted`), no tier exists below the minimum, and adding smaller tiers (6m/4m/…) is forbidden. A shorter recording/logical-boundary tail is allowed, but is not a further fallback size. Never shrink reserve or safety to force a fit. The model manifest must reflect the compiled context: the initial 4,096-token Gate A artifact is not eligible for this policy; rebuild at 16,384 with the same toolkit and repeat Gate A before bundling it.

### 9.1 Generation completion and bounded retry

Each decoder result must carry its actual generated-token count and normal-termination evidence from token IDs/native completion metadata, separately from decoded text. A successful native callback alone is not evidence of EOS. If the generated count reaches 5,120, normal termination is absent, or the timestamped output has an incomplete tail/extra unparsed suffix, mark `GENERATION_LIMIT_REACHED`. This precedence applies before parser repairs: never publish a plausible prefix as a complete transcript.

Retain raw output, token count, termination metadata and failed window interval as diagnostic evidence, but do not mark that attempt DONE or add its partial segments to the authoritative timeline. Re-execute the entire failed coverage interval with 8-minute windows after a 10-minute failure, preserving overlap and exact context checks. Retries must cover the original interval without gaps and must not recompute unrelated completed windows. A failed 8-minute attempt is terminal; a short clipped retry tail inherits its configured tier and cannot restart the ladder indefinitely. Retries use new attempt IDs and preserve the original provenance.

## 10. Long-Audio Windowing

The user-visible scheduling unit is one hour, but model windows overlap across both intra-hour and inter-hour boundaries.

Nominal sequence:

```text
W1 = 00:00-10:00
W2 = 08:00-18:00
W3 = 16:00-26:00
W4 = 24:00-34:00
W5 = 32:00-42:00
W6 = 40:00-50:00
W7 = 48:00-58:00
W8 = 56:00-60:00
W9 = 58:00-68:00
...
```

Thus every adjacent model window normally shares two minutes of real audio. A one-hour logical boundary never resets the speaker-continuity state. For non-first windows, logical ownership starts at window start plus two minutes; W9 belongs to logical chunk 1 despite starting at minute 58.

Logical one-hour chunks exist for:

- scheduling;
- progress reporting;
- cache organization;
- failure isolation;
- user-facing progress semantics.

They are not model-context boundaries.

## 11. Speaker Continuity

Phase 1 performs anonymous speaker continuity only.

### 11.1 Local labels

Each model window may independently generate labels such as:

```text
S01, S02, S03
```

These labels are local to that model run and cannot be assumed stable across windows.

### 11.2 Overlap segment matching

Within the shared two-minute overlap, duplicate utterances from neighboring windows are matched using a weighted score based on:

- interval/time overlap: 0.45;
- normalized text similarity: 0.35;
- duration similarity: 0.10;
- neighboring-turn ordering consistency: 0.10.

Exact weights are configuration, but time remains the primary constraint.

### 11.3 Speaker correspondence

Matched utterances vote for local-speaker correspondence. Accumulated evidence builds a small bipartite score matrix between previous-window and current-window local speakers.

A maximum-weight one-to-one assignment maps current local speakers to existing global speaker labels.

The design must prevent two distinct current speakers from being automatically collapsed into the same global speaker.

### 11.4 Confidence policy

Recommended initial mapping classes:

```text
>= 0.85      strong
0.65-0.85    tentative
< 0.65       unresolved
```

Only a strong mapping automatically inherits an existing `GSxx` label.

Tentative/unresolved mappings allocate a new `GSxx` and retain candidate-alias evidence for later review. The system prefers a temporary duplicate global label over an incorrect identity collapse.

No global label is silently rewritten based on weak later evidence.

## 12. Overlap Deduplication

After speaker remapping, the overlap still contains duplicate transcript copies.

The default ownership rule is overlap midpoint ownership. For a 10:00-12:00 overlap:

```text
Window A owns < 11:00
Window B owns >= 11:00
```

A segment that crosses the ownership boundary is never split mid-utterance. The merger selects one complete segment, preferring the version that:

1. lies farther from its model-window boundary;
2. has complete timestamps;
3. is not visibly truncated;
4. creates fewer timeline conflicts;
5. otherwise belongs to the default ownership window.

## 13. Transcript Conflicts

If neighboring windows produce materially different text for the same matched utterance, the merger must not erase the disagreement.

The primary transcript may select one version for display, but stores the alternate version and marks the segment as a merge conflict.

Example fields:

```json
{
  "text": "我十点半到的",
  "alternate_text": "我十点到的",
  "merge_conflict": true
}
```

The initial automatic selection preference is the result farther from its model-window edge.

## 14. Absolute Timeline

All MOSS local timestamps are converted to absolute recording offsets immediately after parsing:

```text
absolute_ms = window_start_ms + local_timestamp_ms
```

All downstream deduplication, remapping, persistence, and business integration operate only on absolute timestamps.

## 15. Parser Contract

Generated MOSS output is parsed into three validation classes:

```text
VALID
REPAIRED
INVALID
```

Examples of recoverable errors include a missing end time that can be bounded by the next valid segment, a segment end at most one 10 ms model-raster half-step past the window end (clamped to the window end, 2026-09-09 approval), and a terminal fragment that is only a dangling timestamp (dropped without semantic guessing). Every repair is explicitly recorded with its `repair_reason` and the retained original value/text.

Unreliable generations are retained in raw form but excluded from the authoritative normalized timeline.

A normalized segment minimally records:

```json
{
  "segment_id": "...",
  "window_id": "w0003",
  "start_ms": 3312400,
  "end_ms": 3315100,
  "local_speaker": "S03",
  "global_speaker": "GS01",
  "text": "我当时就在宿舍。",
  "speaker_mapping_confidence": 0.94,
  "parse_status": "VALID",
  "merge_status": "PRIMARY",
  "alternate": null,
  "model_manifest_sha256": "..."
}
```

## 16. Job Protocol

MOSS uses asynchronous jobs rather than realtime sessions.

Initial IPC operations:

```text
health
submit_job
get_job
get_result
cancel_job
```

Job states:

```text
QUEUED
PREPARING
ENCODING
BUILDING_EMBEDS
DECODING
PARSING
REMAPPING
MERGING
COMPLETED
FAILED
CANCELLED
```

Each internal window independently tracks:

```text
PENDING
RUNNING
DONE
FAILED
```

The Unix socket is separate from the existing speech socket, for example:

```text
/run/suspect-interrogation/moss.sock
```

## 17. Native-Runtime Isolation

`moss_worker` is a supervisor process. RKNN/RKLLM inference runs in a child process.

```text
FastAPI
  -> moss.sock
  -> moss_worker supervisor
  -> inference child
  -> librknnrt / librkllmrt
```

A native segmentation fault, abort, or runtime crash in the inference child must not terminate the supervisor or FastAPI service.

Retain the exact private runtime builds verified by Gate A/B: RKLLM 1.3.0 and RKNN Runtime / RKNNLite 2.3.2. Select absolute library paths explicitly and verify their hashes and the actually loaded library path; do not replace or retarget shared `/lib` or `/usr/lib` libraries. The current board's shared RKLLM link still points to 1.2.3 and is not the validated decoder runtime. Current gate artifacts reside under `/home/youyeetoo/moss-build/sdk-1.3.0` and `/home/youyeetoo/moss-build/rknn-2.3.2`; deployment must stage the same verified binaries in service-readable private storage. The native child uses an isolated Python 3.10 environment matching the verified RKNNLite wheel; the supervisor keeps the application's existing Python environment. Configure child Python and library paths explicitly rather than modifying the existing speech service.

On child failure, the supervisor:

1. records the current window failure;
2. persists crash metadata;
3. terminates/reaps the broken child if needed;
4. starts a fresh inference child;
5. reloads the runtime models;
6. allows a controlled retry according to policy.

## 18. NPU Concurrency

Initial limits are intentionally conservative:

```text
max_concurrent_moss_jobs = 1
max_concurrent_rknn_runs = 1
max_concurrent_rkllm_runs = 1
```

Other submitted jobs remain queued.

The three RK3588 NPU cores are dedicated to the currently active model call rather than statically partitioned between encoder and decoder.

Encoder/decoder overlap is deferred until correctness and stability are established.

## 19. Persistent Spool and Checkpoints

The worker owns a local durable spool, for example:

```text
/var/lib/suspect-interrogation/moss/
├─ jobs/<job_id>/
│  ├─ job.json
│  ├─ windows.json
│  ├─ speaker_state.json
│  ├─ merged_segments.jsonl
│  ├─ raw_generations/
│  ├─ checkpoints/
│  └─ logs/
└─ models/
```

Each completed model window is checkpointed immediately.

Checkpoint writes use an atomic pattern:

```text
write temporary file
-> flush
-> fsync
-> atomic rename
```

A power loss or process restart should cause at most the active incomplete window to be recomputed.

The business database stores case/job associations and selected final revisions; the worker spool stores inference-resume state.

## 20. Source-of-Truth and Revisions

The original audio file is immutable source material.

It is fingerprinted with SHA-256. Derived artifacts include:

- temporary micro-chunks;
- log-mel features;
- RKNN outputs;
- raw RKLLM generation;
- parsed local segments;
- merged global transcript.

A model or runtime upgrade creates a new transcription revision rather than overwriting the previous one.

Every result revision records at least:

- source `audio_sha256`;
- model manifest SHA-256;
- runtime versions;
- windowing parameters;
- generation parameters;
- creation time.

## 21. Model Manifest

Production model package:

```text
models/moss-rk3588/
├─ moss_audio_encoder_fp16_rk3588.rknn
├─ moss_qwen3_0.6b_w8a8_rk3588.rkllm
├─ moss_token_embedding_fp16.bin
├─ tokenizer.json
├─ tokenizer_config.json
├─ special_tokens_map.json
├─ generation_config.json
├─ processor_config.json
└─ manifest.json
```

`manifest.json` records:

- OpenMOSS upstream repository revision;
- source checkpoint fingerprint;
- Whisper weight fingerprint;
- adaptor weight fingerprint;
- Qwen/lm_head fingerprint;
- tokenizer fingerprint;
- RKNN Toolkit2 version;
- RKLLM Toolkit version;
- required RKNN Runtime version;
- required RKLLM Runtime version;
- RK3588 target;
- quantization and precision;
- configured context length;
- SHA-256 for every packaged artifact.

## 22. Health and Startup Self-Test

`health` returns more than process liveness:

```json
{
  "worker": "ready",
  "platform": "rk3588",
  "models": {
    "audio_encoder": "ready",
    "decoder": "ready",
    "token_embedding": "ready"
  },
  "runtime": {
    "rknn": "...",
    "rkllm": "..."
  },
  "manifest_sha256": "...",
  "queue_depth": 0,
  "active_job": null,
  "last_success_at": "...",
  "last_error": null
}
```

Startup performs a small deterministic self-test:

1. run a fixed short feature tensor through RKNN;
2. validate shape and absence of NaN/Inf;
3. run a fixed small embedding prompt through RKLLM;
4. confirm successful generation.

A failed self-test reports `DEGRADED`/`NOT_READY`; production jobs are not accepted as if the runtime were healthy.

## 23. Error Taxonomy and Retry

Initial error codes:

```text
MOSS_MODEL_LOAD_FAILED
MOSS_RKNN_INFERENCE_FAILED
MOSS_RKLLM_INFERENCE_FAILED
MOSS_CONTEXT_OVERFLOW
GENERATION_LIMIT_REACHED
MOSS_OOM
MOSS_INVALID_GENERATION
MOSS_AUDIO_CORRUPT
MOSS_CANCELLED
```

Recoverable context/OOM conditions use the window-size ladder:

```text
12 -> 10 -> 8 minutes
```

with the configured two-minute overlap and fixed 5,120/512 generation/safety reservations. `GENERATION_LIMIT_REACHED` also uses this bounded ladder, re-executing the failed coverage interval rather than accepting a truncated prefix.

Persistent failure at the minimum supported model window fails the window/job and is surfaced explicitly.

## 24. Cancellation

Queued jobs can be cancelled immediately.

Running jobs set a cancellation request and stop at the earliest safe boundary. If an RKLLM native call cannot be interrupted safely, the supervisor may terminate the inference child, then mark the job `CANCELLED` after process cleanup.

Cancellation never deletes completed checkpoints or raw evidence-derived artifacts.

A later continuation is represented as a new job/revision, not a silent resurrection of a cancelled job.

## 25. Build-Time Conversion Gates

Before production runtime integration, conversion must pass staged parity gates.

### Gate A: PyTorch reference

For fixed 30–60 second multilingual/Chinese multi-speaker fixtures, store:

- source audio;
- upstream MOSS raw generation;
- normalized segments;
- model/checkpoint hashes.

### Gate B: RKLLM external-embedding bridge

Capture the full upstream PyTorch MOSS `inputs_embeds` before the Qwen language model and submit those same embeddings to the RKLLM-converted MOSS Qwen.

This gate isolates Qwen/RKLLM correctness from audio-encoder conversion.

Required outcome: generated content preserves speaker count/turn structure and major transcription content closely enough for fixture review.

### Gate C: RKNN audio encoder parity

Compare PyTorch MOSS adapted audio embeddings against RKNN outputs for identical log-mel inputs.

Track numerical metrics such as:

- mean absolute error;
- maximum absolute error;
- cosine similarity by token/block;
- NaN/Inf checks.

Thresholds are set empirically from initial fixtures and then frozen as regression requirements.

### Gate D: Fully native board path

Run:

```text
WAV
-> board CPU frontend
-> RKNN audio encoder
-> board embedding builder
-> RKLLM decoder
-> normalized transcript
```

without PyTorch or Transformers installed on the board.

Only after Gate D passes does the backend become eligible for application integration.

## 26. Acceptance Criteria

Phase 1 engineering acceptance:

| Area | Requirement |
|---|---|
| Offline | Network disabled; full inference still completes |
| Hardware | Single RK3588 32 GB |
| Audio NPU | Whisper-Medium + MOSS adaptor via RKNN FP16 |
| Language NPU | MOSS-tuned Qwen3-0.6B via RKLLM W8A8 |
| Basic output | WAV -> timestamps + local speaker labels + text |
| Short parity | 30–60 s board results are acceptably close to upstream PyTorch reference |
| 30 min | Stable run without crash/OOM |
| 60 min | Complete through overlapping internal windows |
| >60 min | Speaker continuity crosses the one-hour logical boundary |
| Unlimited total duration | Total duration does not determine a single model context |
| Resume | Completed windows survive worker/process restart |
| Native crash | Inference child can crash without taking down supervisor/FastAPI |
| Provenance | Every normalized segment links to model manifest and source revision |
| Conflict retention | Overlap disagreements are preserved, not silently discarded |

Initial performance gate:

```text
RTF <= 1.0 for a representative 30-minute fixture
```

Stretch target after correctness stabilization:

```text
RTF <= 0.5
```

## 27. Test Matrix

Golden-fixture and integration tests cover at minimum:

- one speaker continuous speech;
- two speakers normal turn-taking;
- three speakers;
- rapid alternation;
- overlapping/cross-talk speech;
- long silence;
- background noise;
- very short utterances;
- long utterances;
- numbers, dates, money values;
- a speaker present in the overlap region;
- a speaker absent from the overlap region;
- 30-minute boundary;
- context-budget shrink;
- one-hour logical boundary;
- two-hour or longer recording;
- corrupt WAV;
- low disk space;
- cancellation;
- worker restart;
- inference child native crash;
- retry after RKLLM/RKNN failure;
- model/runtime upgrade regression.

Each golden fixture stores:

```text
source WAV
upstream PyTorch raw output
upstream normalized output
RK3588 raw output
RK3588 normalized output
manifest/runtime metadata
```

## 28. Phase 1 Non-Goals

The following are intentionally excluded from the first implementation:

- realtime MOSS streaming;
- replacing or repairing the current realtime ASR path;
- real-person identity determination;
- ERes2Net fusion;
- parallel RKNN/RKLLM execution;
- multi-job NPU concurrency;
- changing MOSS RoPE/context to force a 60-minute single context;
- acoustic INT8 quantization;
- automatic silent resolution of low-confidence speaker mappings or material text conflicts.

## 29. Future Fusion Boundary

Future voiceprint fusion is expected to consume stable `GSxx` clusters and the original audio timeline.

Possible later flow:

```text
MOSS global speaker GSxx
  -> collect high-quality segments for that GSxx
  -> voiceprint embedding/verification
  -> candidate real-world identity
  -> conservative identity policy
  -> operator-reviewed role binding
```

The MOSS backend itself remains anonymous-diarization-first and should not need to be rewritten to support this later stage.

## 30. Final Design Decision

Adopt a standalone `moss_worker` on one offline RK3588 32 GB system. Use a fused Whisper-Medium + 4x merge + MOSS VQAdaptor RKNN FP16 acoustic encoder and a MOSS-checkpoint Qwen3-0.6B RKLLM W8A8 decoder. Reproduce upstream MOSS processor semantics on CPU and feed complete embeddings through `RKLLM_INPUT_EMBED`.

Use one-hour logical scheduling units, target 10-minute model windows with two-minute overlap and an 8-minute fallback (2026-09-09 final tiering), and a real-tokenizer context guard under 16,384 tokens with fixed 5,120 generation reserve and 512 safety margin. Reject incomplete/limit-hit generations and retry their full coverage intervals. Normalize local speaker labels into conservative global anonymous `GSxx` labels using overlap evidence, retain conflicts and provenance, and support durable checkpoint/restart semantics plus native-runtime process isolation.

This design is the approved basis for the implementation plan. No implementation work should begin until the implementation plan derived from this specification is reviewed.

## 31. Non-blocking optimization Spike: context greater than 16K

Investigate official support, memory/performance cost and exact MOSS parity for context greater than 16,384 only after the primary 16K path is functional. Record results separately. This Spike neither blocks Phase 1 nor authorizes replacing the validated primary toolchain, changing RoPE, silently extending the compiled context, or relaxing the window/generation gates.
