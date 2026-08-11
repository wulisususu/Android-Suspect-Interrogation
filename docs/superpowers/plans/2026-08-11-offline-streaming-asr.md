# Offline Streaming ASR Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate two switchable offline streaming ASR engines into the Android APK and prove the RKNN/CPU execution paths on RK3576.

**Architecture:** ModelManager exposes two bundled ASR descriptors and persists one active selection. An engine switcher owns at most one `AsrEngine`; sherpa engines share an AudioRecord loop and differ only in exact model config. NativeBridge carries RPC commands and live status events to the existing Vue interface.

**Tech Stack:** Kotlin, Android AudioRecord, sherpa-onnx v1.13.5, RKNN Runtime, ONNX Runtime, Vue 3, NativeBridge.

---

### Task 1: Lock model assets and sherpa release

- [x] Move device archives from `/sdcard/Download` to `/sdcard/models`.
- [x] Verify device and workstation SHA-256 values match.
- [x] Extract only four Zipformer and three Paraformer production files.
- [x] Vendor the five arm64 native libraries and Kotlin API from v1.13.5.

### Task 2: Define tested model and lifecycle contracts

- [ ] Test exact model paths, providers, model types, and Paraformer thread count.
- [ ] Test that switching releases the previous engine and never starts both.
- [ ] Implement `AsrModelSpec`, `AsrEngine`, and `AsrEngineSwitcher`.

### Task 3: Implement real microphone engines

- [ ] Add shared AudioRecord streaming/decode/endpoint loop.
- [ ] Add explicit Zipformer RKNN and Paraformer INT8 configs.
- [ ] Add status, timing, errors, and version logging.
- [ ] Add a single-active-engine controller integrated with ModelManager.

### Task 4: Connect Android lifecycle and WebView UI

- [ ] Add microphone permission handling.
- [ ] Add ASR RPC actions and NativeBridge status events.
- [ ] Add model descriptors and switch handling to ModelManager.
- [ ] Add the ASR comparison console to the existing model settings tab.

### Task 5: Package and verify

- [ ] Restrict ABI to arm64-v8a and configure noCompress for ONNX/RKNN.
- [ ] Run unit tests, type checks, and debug APK build.
- [ ] Install to `192.168.2.81:5555` and fix runtime issues.
- [ ] Verify RKNN NPU load, Paraformer CPU INT8 path, logs, memory, and latency.

