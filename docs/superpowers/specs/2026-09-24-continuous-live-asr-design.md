# Continuous Live ASR Design

Date: 2026-09-24
Branch: `linux-adaptation`
Status: Architecture approved; awaiting written-spec review

## 1. Goal

Show provisional Mandarin transcript text continuously while a person is speaking, then persist the authoritative sentence transcript before asynchronous speaker analysis. The result should feel like live dictation: text appears in place as chunks are recognized, remains visible through short pauses, and moves into the durable dialogue when its VAD-bounded final transcript is saved.

## 2. Current Cause

`SpeechSession._preview_transcript()` calls the existing offline Paraformer on the entire growing utterance every 1.5 seconds. The call is synchronous on the only ordered ASR worker, so preview inference can delay processing of later audio ranges. Each new preview replaces the prior text, and `ASR_FRAGMENT` clears the preview when the final fragment is published. The `.109` model tree currently contains only the offline `paraformer` and streaming `fsmn-vad` models; it has no streaming Paraformer checkpoint.

FunASR documents `paraformer-zh-streaming` as the chunked model that uses session cache for incremental results. Its example feeds 600 ms chunks with cache and `is_final` state. The installed offline checkpoint is not a substitute for that streaming model.

## 3. Chosen Architecture

Keep two ASR roles:

1. **Live preview:** an optional, separately loaded `paraformer-zh-streaming` checkpoint processes fresh PCM chunks in order with capture-session-scoped cache. The worker accumulates its emitted chunk text for the current visible utterance and publishes cumulative `ASR_PARTIAL` updates. It never stores partial text as an official fragment.
2. **Final transcript:** the existing offline `paraformer` remains authoritative. Existing FSMN-VAD boundaries trigger one offline transcription per utterance; the final text and capture-relative sample range are durably committed as `ASR_FRAGMENT` before any speaker analysis.
3. **Speaker analysis:** retain the current deferred voiceprint queue and its accumulation threshold. It runs on committed audio/text only, never on live preview strings.

Use FunASR's documented `[0, 10, 5]` chunk configuration (600 ms input chunks with 300 ms lookahead), per-session cache, and CPU execution. Keep incomplete PCM shorter than one streaming chunk in a bounded per-session buffer. Do not repeatedly batch-decode the growing utterance for preview.

## 4. User Interface and Events

- `ASR_PARTIAL.text` carries the current cumulative provisional text for the open utterance; the frontend replaces the provisional line with that value.
- Empty/no-text chunks do not erase the most recently displayed text.
- When the durable final `ASR_FRAGMENT` arrives, show the stored final dialogue fragment and clear only the matching provisional line in the same state update, avoiding a blank placeholder between the two.
- If the streaming model is missing or fails, continue durable audio capture and offline final transcription. Report live-preview unavailability explicitly; do not fabricate text or silently fall back to repeated offline previews.

## 5. Model and Deployment

- Keep all model weights outside Git releases at the stable model root, under `paraformer-streaming/` beside `paraformer/` and `fsmn-vad/`.
- Treat the streaming model as an optional capability during startup so missing/corrupt streaming assets cannot disable archived recording or offline final ASR. Report a separate readiness/capability state for live streaming ASR.
- Install the official FunASR `paraformer-zh-streaming` weights on `.109`, validate required files and a real chunked inference, then load them by restarting only the speech worker while no capture is active. Never restart the API or recording path during capture.
- Keep the existing offline ASR and FSMN-VAD health independent from streaming-ASR health. A runtime preview failure degrades only provisional UI updates; final ASR continues from durable audio.

## 6. Acceptance Criteria

1. With live speech, provisional Chinese text updates as 600 ms audio chunks are processed, without waiting for VAD end.
2. A short pause keeps already recognized provisional text visible; new words extend or revise the provisional line rather than making it mostly blank.
3. VAD end persists one authoritative offline-ASR final fragment with the existing time bounds; the durable final replaces the provisional line without a blank interval.
4. Existing durable audio archiving, replay, final-fragment idempotency, and deferred speaker-analysis threshold remain intact.
5. Missing or failing streaming assets are visible as unavailable while durable capture and offline final ASR remain usable.
6. `.109` deployment validation happens only when no recording is active, with no API restart and no changes to the unrelated port-8000 service.

## 7. Sources and Constraints

- FunASR's [Chinese README](https://github.com/modelscope/FunASR/blob/main/README_zh.md) identifies `paraformer-zh-streaming` and documents cache-based chunked recognition with `[0, 10, 5]`.
- FunASR's [streaming Paraformer implementation](https://github.com/modelscope/FunASR/blob/main/funasr/models/paraformer_streaming/model.py) describes chunk-by-chunk processing with session cache.
- The `.109` check on 2026-09-24 found about 15 GiB total memory and 63 GiB free disk, and no `paraformer-streaming` directory. Actual loaded memory use and recognition latency must still be measured on the board before claiming production readiness.
- No recognition text, transcript, audio payload, or speaker identity is added to ordinary model logs.
