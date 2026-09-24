# Continuous Live ASR Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:executing-plans` to implement this plan task-by-task. Steps use checkbox syntax for tracking.

**Goal:** Show cumulative provisional text while speech is in progress, then replace it with durable offline-ASR fragments before deferred speaker analysis.

**Architecture:** Load a separate optional FunASR Paraformer Streaming model for provisional output, feed fresh PCM in session-cached 600 ms chunks, and keep the installed offline Paraformer as the only source of persisted final text. Expose streaming readiness and preserve the existing audio archive and asynchronous speaker queue.

**Tech Stack:** Python, FunASR `AutoModel`, Vue 3/TypeScript, existing HTTP/WebSocket capture state, ModelScope model assets outside Git.

---

## File Map

- Modify `linux/backend/speech_worker/funasr_runtime.py`: optional stream-model loading, health, and cached chunk inference.
- Modify `linux/backend/speech_worker/session.py`: replace repeated full-prefix preview decoding with bounded streaming chunks; keep offline VAD-final transcription.
- Modify `linux/backend/app/services/asr_capture_service.py`, `linux/backend/app/ai/supervisor.py`, `linux/backend/app/health.py`, and `linux/backend/app/api/asr.py`: carry independent live-preview readiness to capture status and runtime capabilities; preserve event time ranges.
- Modify `webapp/src/types/interrogation.ts`, `webapp/src/stores/interrogation.ts`, `webapp/src/components/AsrWorkflowStatus.vue`, and `webapp/src/components/LiveDialoguePanel.vue`: show live-preview readiness, retain non-empty provisional text, and clear only the provisional range that the durable fragment replaces.
- Modify `linux/docs/AI_RUNTIME.md` and `scripts/ai-worker-start.sh`: document and validate the optional model path without making offline ASR startup depend on it.

## Task 1: Add Optional Streaming Model Support

**Files:**
- Modify `linux/backend/speech_worker/funasr_runtime.py`

- [x] Add `streaming_asr_model` and `streaming_asr_error` state beside the existing `asr_model` and `vad_model` state.
- [x] Resolve the checkpoint from `SUSPECT_FUNASR_STREAMING_MODEL_DIR` when set; otherwise use `<model_root>/paraformer-streaming`.
- [x] Load it with the existing model factory and CPU setting only when its directory exists. A missing or failed optional model must not clear the already loaded offline ASR or VAD models.
- [x] Add `transcribe_stream(pcm, sample_rate, *, cache, is_final=False) -> str`. Pass float32 PCM, `fs`, the supplied cache, `is_final`, `chunk_size=[0, 10, 5]`, `encoder_chunk_look_back=4`, and `decoder_chunk_look_back=1`; return the first result record's text or an empty string.

```python
result = self._generate(
    self.streaming_asr_model,
    "paraformer-streaming",
    input=pcm16_bytes_to_float32(pcm),
    fs=int(sample_rate),
    cache=cache,
    is_final=bool(is_final),
    chunk_size=[0, 10, 5],
    encoder_chunk_look_back=4,
    decoder_chunk_look_back=1,
)
record = _first_record(result)
return str(record.get("text") or "") if record else ""
```

- [x] Include `asr_streaming` state, model path, and a non-sensitive error code in `health()`. Make `loaded` continue to mean the required offline ASR, VAD, and speaker capability only.
- [x] Clear optional stream-model state in `_clear_models()`.

## Task 2: Stream Provisional Text Without Blocking the Archive

**Files:**
- Modify `linux/backend/speech_worker/session.py`

- [x] Extend `SpeechRuntime` with `transcribe_stream` while keeping the existing `transcribe` method for final utterances.
- [x] Add a bounded PCM staging buffer, one session cache, and a time-ranged queue `[(start_ms, end_ms, text), ...]` of stream text chunks. Use `chunk_samples = round(sample_rate * 600 / 1000)` (9,600 samples at 16 kHz); retain the shorter tail until enough PCM arrives.
- [x] Feed only each fresh complete chunk to `transcribe_stream`; never call offline `transcribe` from preview code.
- [x] Associate returned chunk text with its audio time range. For an open VAD utterance, publish cumulative text for chunks overlapping that utterance, using the VAD utterance's start time and current input end time. Retain only the active utterance plus the existing bounded pre-roll; trim text-chunk history after a final result.
- [x] Leave `_finish_utterance()`'s offline `transcribe(utterance_pcm, sample_rate)` unchanged as the canonical final result. Keep speaker embedding and speaker analysis out of this session path.
- [x] Do not flush the streaming model's buffered tail at stop; offline final transcription already covers those samples and remains authoritative.
- [x] If the optional streaming method is missing or errors, stop emitting provisional text for that capture and preserve final offline recognition; report the stream-preview state separately.

## Task 3: Expose Streaming Readiness and Preserve Event Ordering

**Files:**
- Modify `linux/backend/app/ai/supervisor.py`
- Modify `linux/backend/app/health.py`
- Modify `linux/backend/app/api/asr.py`
- Modify `linux/backend/app/services/asr_capture_service.py`

- [x] Add an independent `asrStreaming` runtime capability derived from `speech_worker.health().asr_streaming`; do not make overall ASR or capture readiness fail when only the preview model is unavailable.
- [x] Include `liveTranscriptStatus` in active capture and capture-status responses so clients can distinguish `AVAILABLE`, `MODEL_NOT_INSTALLED`, and runtime `ERROR` states.
- [x] Publish `ASR_PARTIAL` with cumulative `text`, `startedAtMs`, and `endedAtMs` as already expected by the client.
- [x] Collect partial events while reducing a batch; persist/publish final fragments before publishing partials for a later VAD range in that same batch. Suppress any partial text whose time range has already been finalized. This prevents a new sentence preview from being cleared by the preceding final fragment.
- [x] Keep the existing archive-first ordering, final-fragment idempotency, cursor advancement, and speaker-job scheduling unchanged.

## Task 4: Keep the Provisional Line Stable in the UI

**Files:**
- Modify `webapp/src/types/interrogation.ts`
- Modify `webapp/src/stores/interrogation.ts`
- Modify `webapp/src/components/AsrWorkflowStatus.vue`
- Modify `webapp/src/components/LiveDialoguePanel.vue`

- [x] Add a typed live-transcript readiness field and provisional time range to capture state.
- [x] Replace the provisional text only when a non-empty, current-session `ASR_PARTIAL` arrives; ignore empty streaming chunks rather than clearing visible words.
- [x] On `ASR_FRAGMENT`, upsert the durable fragment and clear provisional text only when its `startedAtMs` matches the final fragment's `startedAtMs`. A final fragment from another range must leave the current preview untouched.
- [x] Show an explicit “实时转写模型未安装/不可用，最终文字仍会保存” message when live preview is unavailable. Keep the regular “待输入” state only when streaming is available and no speech has been recognized yet.
- [x] Preserve the existing final dialogue layout, waveform, and recording timer.

## Task 5: Document and Load the Model on `.109` Safely

**Files:**
- Modify `linux/docs/AI_RUNTIME.md`
- Modify `scripts/ai-worker-start.sh`

- [x] Document `paraformer-streaming/` under the stable model root, the official ModelScope checkpoint `iic/speech_paraformer-large_asr_nat-zh-cn-16k-common-vocab8404-online`, and the staging/validation path outside Git releases.
- [x] Make the startup script report the optional stream-model directory without requiring it for the offline worker to start.
- [x] Build the code and inspect deployment diff before touching `.109`.
- [ ] Download the checkpoint outside the release tree to `/opt/suspect-interrogation/staging-models/paraformer-streaming` on `.109` using `sudo env PATH=/opt/suspect-interrogation/runtime/funasr-env/bin:$PATH modelscope download --model iic/speech_paraformer-large_asr_nat-zh-cn-16k-common-vocab8404-online --local_dir /opt/suspect-interrogation/staging-models/paraformer-streaming`. Verify required model files and run one chunked inference with the installed FunASR runtime, then place it in the stable model tree.
- [ ] Before loading the new model, confirm no capture is active. Restart only `ai-worker.service`; do not restart the API or touch the separate port-8000 service. Confirm the worker is ready and reports `asr_streaming=READY` afterward.
- [ ] Do not use a live microphone sample for validation; the approved check is a chunked inference against a fixed local sample. Report live capture behavior separately if it has not been observed.

## Completion Checks

- Static inspection confirms no preview path calls offline `transcribe()` on a growing prefix.
- Frontend production build/type check completes without errors.
- Worker health distinguishes missing streaming assets from offline-ASR failure.
- Deployment does not restart while a capture is active and does not alter the API or port 8000.
- Do not add or run automated tests unless the user explicitly requests test/verification work.
