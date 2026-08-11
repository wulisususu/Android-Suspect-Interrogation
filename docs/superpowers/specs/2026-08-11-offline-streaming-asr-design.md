# Offline Streaming ASR Design

## Goal

Run continuous, fully offline microphone ASR inside the existing Android APK on RK3576, with one user-selected ASR model loaded at a time.

## Runtime

- sherpa-onnx `v1.13.5` Android RKNN, arm64-v8a only.
- Zipformer uses `encoder.rknn`, `decoder.rknn`, `joiner.rknn`, `provider=rknn`.
- Paraformer uses only `encoder.int8.onnx`, `decoder.int8.onnx`, `provider=cpu`, initially with four threads.
- Both engines use the same sherpa-onnx Kotlin API and native libraries from the same release.
- Audio input is Android `AudioRecord`, 16 kHz, mono, PCM 16-bit, processed on a dedicated audio thread.

## Model Management

Both bundled ASR models appear in the existing ModelManager catalog. Zipformer is the default selection. Selecting a different ASR model stops recording, releases the current stream and recognizer, and creates no new recognizer until the next start command. The two model runtimes are never resident simultaneously.

## UI And Bridge

The existing WebView AI/model settings panel receives ASR status events from NativeBridge. It exposes the selected model, start/stop controls, partial text, final utterances, initialization time, first-token latency, and utterance latency. Android runtime microphone permission is requested only when recognition starts.

## Verification

Build and install the arm64 APK, verify model-load logs, inspect `rknn/rknpu/sherpa` logcat output, inspect available RK3576 NPU load nodes, and compare both engines with the same spoken Mandarin text. Recognition success alone is not accepted as proof of NPU use.

