# External Model Storage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Load every runtime model payload from `/sdcard/models/` and remove model payloads from the APK while preserving existing root-level RKLLM deployments.

**Architecture:** Make `/sdcard/models` the catalog root, retain category subdirectories, and resolve known ASR descriptors to absolute-path sherpa configurations. OCR dictionaries live beside OCR graphs; LLM scanning covers `/sdcard/models/llm` plus the legacy root.

**Tech Stack:** Kotlin, Android `File`, sherpa-onnx JNI, ONNX Runtime, RKLLM JNI, Gradle Kotlin DSL, JUnit4, Android instrumentation.

---

### Task 1: Specify the external directory contract

**Files:**
- Modify: `android/app/src/test/java/com/wulisu/suspect/interrogation/asr/AsrModelSpecTest.kt`
- Modify: `android/app/src/test/java/com/wulisu/suspect/interrogation/service/ModelCatalogScannerTest.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrModels.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelCatalogScanner.kt`

- [ ] Write tests asserting `ASR:asr/<name>` IDs, `/sdcard/models/asr/<name>/...` paths, ASR completeness, `/sdcard/models/llm` discovery, and legacy root discovery.
- [ ] Run `gradlew testDebugUnitTest --tests '*AsrModelSpecTest' --tests '*ModelCatalogScannerTest'` and confirm the new assertions fail because the code still uses assets and ignores the standard LLM directory.
- [ ] Change the two known ASR specifications to absolute file paths and make the catalog scanner mark only complete known ASR directories runtime-ready.
- [ ] Scan the standard LLM category directory before legacy external roots and deduplicate by absolute path.
- [ ] Re-run the focused tests and confirm they pass.

### Task 2: Switch ASR runtime and selection to file-backed models

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/SherpaOnlineAsrEngine.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrController.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelManager.kt`
- Delete: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/BundledAsrModels.kt`
- Modify: ASR unit and instrumentation tests

- [ ] Extend focused tests so the selected ASR descriptor must come from the external catalog and missing required files are rejected.
- [ ] Run the focused tests and confirm failure while bundled descriptors are still injected.
- [ ] Remove bundled-ASR catalog injection, choose the default only when its external directory is complete, and preserve no selection when no ASR model is ready.
- [ ] Replace asset validation with `File` validation and construct `OnlineRecognizer(config = ...)` so JNI uses file paths.
- [ ] Update instrumentation preconditions to inspect external files.
- [ ] Re-run focused unit tests.

### Task 3: Externalize OCR dictionary and imports

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/ocr/OcrController.kt`
- Modify: OCR instrumentation tests
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelManager.kt`

- [ ] Change OCR tests to require `ppocr_keys_v1.txt` from the selected external OCR directory and confirm they fail against the asset-only implementation.
- [ ] Load the dictionary from the selected model root and report an explicit missing-file error.
- [ ] Send new LLM imports to `/sdcard/models/llm/`; retain scanning of root-level legacy files.
- [ ] Re-run focused OCR and model-catalog tests.

### Task 4: Remove payloads and enforce APK boundaries

**Files:**
- Delete: `android/app/src/main/assets/models/paraformer_int8/*`
- Delete: `android/app/src/main/assets/models/zipformer_rk3576/*`
- Delete: `android/app/src/main/assets/models/ocr/ppocr_keys_v1.txt`
- Modify: `.github/workflows/android-ci.yml`
- Modify: `README.md`
- Modify: `android/README.md`

- [ ] Remove the eight runtime model resources from main assets.
- [ ] Replace Git-LFS/APK payload-presence checks with assertions that no `.onnx`, `.rknn`, `.rkllm`, or OCR dictionary is packaged.
- [ ] Document the exact external directory layout and deployment prerequisite.
- [ ] Build the APK and inspect its ZIP entries and size.

### Task 5: Full regression

**Files:**
- Verify all modified production and test files.

- [ ] Deploy the external ASR and OCR dictionary payloads to `192.168.2.81:5555` without overwriting unrelated model files.
- [ ] Run frontend typecheck/build and backend check/smoke.
- [ ] Run Android unit tests, APK assembly, test APK assembly, and native-library verification with `--rerun-tasks`.
- [ ] Install both APKs and run the complete instrumentation suite.
- [ ] Confirm the final APK has no runtime model payloads, launches without native crashes, and report its size and SHA-256.
