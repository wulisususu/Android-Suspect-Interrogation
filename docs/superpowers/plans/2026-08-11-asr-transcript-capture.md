# ASR Transcript Capture Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add continuous offline recording to the interrogation transcript so endpoint results become editable temporary fragments and only explicit human confirmation creates formal QA records.

**Architecture:** The existing `AsrController` remains the only ASR engine owner. It forwards PCM batches, partials, finals, and errors to a new capture manager. The capture manager writes one app-private WAV per recording session and persists endpoint fragments in Room v2. NativeBridge exposes capture/fragment RPCs and events; the Vue store renders partial text and pending fragments, then performs update, single confirmation, ordered batch confirmation, or discard.

**Tech Stack:** Kotlin, Android AudioRecord, sherpa-onnx 1.13.5, Room/SQLCipher, Kotlin coroutines, NativeBridge JSON RPC, Vue 3, Pinia, TypeScript.

---

### Task 1: Add confidence and capture event contracts

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrEngine.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/SherpaOnlineAsrEngine.kt`
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrConfidence.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/asr/AsrConfidenceTest.kt`

- [x] Write failing unit tests proving confidence is `exp(mean(finite log probabilities))`, clamped to `[0, 1]`, and `null` when sherpa provides no usable values.
- [x] Run `android/gradlew.bat :app:testDebugUnitTest --tests "*.AsrConfidenceTest"` and verify the missing implementation fails.
- [x] Add nullable confidence fields to `AsrFinalResult` and a synchronous `onAudioSamples(ShortArray, count, sampleRate, capturedAtMs)` listener hook.
- [x] Calculate final confidence from the same `OnlineRecognizerResult` used for endpoint text; send each captured PCM batch to the listener before normalizing it for sherpa.
- [x] Re-run the focused test and existing ASR tests.

### Task 2: Persist capture sessions and temporary fragments in Room v2

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/data/Entities.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/data/Daos.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/data/AppDatabase.kt`
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/CaptureModels.kt`
- Create: `android/app/src/androidTest/java/com/wulisu/suspect/interrogation/data/AppDatabaseMigrationTest.kt`
- Modify: `android/app/build.gradle.kts`
- Generate: `android/app/schemas/com.wulisu.suspect.interrogation.data.AppDatabase/2.json`

- [x] Add a migration test that creates a v1 database, inserts an existing case/session/QA row, migrates to v2, and verifies both old data and new ASR tables.
- [x] Add `AsrCaptureSessionEntity` and `AsrTemporaryFragmentEntity` with foreign keys, ordering indexes, immutable `rawText`, editable text, speaker/source, nullable confidence/source, audio offsets, state, and `confirmedQaId`.
- [x] Add DAOs for active/latest capture session, ordered fragment listing, insertion, update, and state transitions.
- [x] Register both entities and `MIGRATION_1_2`; add `room-testing` and Android test dependencies.
- [x] Compile Room schemas and run the migration test on the connected device.

### Task 3: Implement continuous WAV recording and fragment lifecycle

**Files:**
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/PcmWavWriter.kt`
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrCaptureSessionManager.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/asr/PcmWavWriterTest.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/asr/CaptureFragmentRulesTest.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/RecordService.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrController.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/AppContainer.kt`

- [x] Write failing WAV tests for RIFF/PCM16 header sizes and a rules test for unknown speaker, empty edits, immutable raw text, low confidence, and idempotent confirmation.
- [x] Implement an app-private writer at `files/asr-audio/<caseId>/<captureSessionId>/capture.wav`, with a placeholder header, PCM append, endpoint header flush, and final close.
- [x] Require at least 256 MB free space before capture and stop with a retained partial file on write failure.
- [x] Implement one serialized capture manager that starts only for a running interrogation session, records model metadata, handles PCM/final callbacks, persists endpoint fragments in ordinal order, and emits capture snapshots.
- [x] Refactor `RecordService` only enough to let fragment confirmation create a QA record and mark the fragment confirmed in one Room transaction.
- [x] Make confirmation require nonblank edited text and a known speaker; make repeated confirmation return the existing QA record; make ordered batch confirmation report per-fragment failures without rolling back successful earlier fragments.
- [x] Ensure stop closes the writer before stopping ASR and leaves every pending fragment untouched.
- [x] Run focused unit tests and all Android unit tests.

### Task 4: Expose capture RPC and native events

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/RpcRouter.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/NativeBridge.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/MainActivity.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/AppContainer.kt`

- [x] Add JSON serialization for capture status, temporary fragments, confirmation results, nullable confidence, and logical audio references only.
- [x] Add `asr.capture.status/start/stop`, `asr.fragment.list/update/confirm/confirmBatch/discard` routes.
- [x] Route `asr.capture.start` through the existing microphone permission launcher.
- [x] Deliver `asr.capture.status` NativeBridge events and unregister the listener when the WebView closes.
- [x] Reject model switching while capture is active so only one model is resident and capture metadata remains truthful.
- [x] Compile Kotlin and exercise RPCs through an Android instrumentation/shell smoke test.

### Task 5: Add the interrogation recording workflow

**Files:**
- Modify: `webapp/package.json`
- Modify: `webapp/package-lock.json`
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/native/rpcBridge.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/components/TranscriptPanel.vue`
- Modify: `webapp/src/views/InterrogationWorkspace.vue`
- Modify: `webapp/src/styles.css`

- [x] Add `@lucide/vue` and typed capture/fragment DTOs plus API wrappers and event subscription.
- [x] Extend the Pinia store with capture initialization, elapsed state, start/stop, edit/speaker update, selected batch confirmation, discard, and insertion of confirmed QA rows into the formal transcript.
- [x] Put a microphone icon button before the one-to-five-line composer; show a red stop state and elapsed time while recording.
- [x] Show live partial text above the composer without adding it to the message list or persistence APIs.
- [x] Render compact pending fragment rows with time range, editable text, speaker selector, confidence/source, low-confidence emphasis, audio availability, selection, confirm, and discard controls.
- [x] Keep confirmation available while recording; make stop end capture only; retain pending rows after stop/reload.
- [x] Run `npm run typecheck` and `npm run build`.

### Task 6: Build and verify on RK3576

**Files:**
- Verify: `android/app/build/outputs/apk/debug/app-debug.apk`

- [x] Run `android/gradlew.bat :app:testDebugUnitTest` and `android/gradlew.bat :app:assembleDebug` after the web build.
- [x] Install the APK to `192.168.2.81:5555` and launch the interrogation workspace.
- [ ] Verify continuous recording, partial display, endpoint fragment creation, editing, speaker assignment, low-confidence display, single confirmation, ordered batch confirmation, discard, and persistence after stopping/restarting the page.
  - Remote limit: continuous WAV/start/stop and the fragment confirmation state machine were verified, but device speaker playback is removed by the `VOICE_RECOGNITION` echo path, so a real spoken endpoint still needs an on-site microphone pass.
- [x] Confirm each formal QA row is created once, audit logs are written, and partial text never appears in Room.
- [x] Inspect `adb logcat` for `OfflineAsr`, capture/WAV failures, selected model/provider, and endpoint timings; verify Zipformer still produces RK3576 NPU load while speaking.
- [x] Report the APK path, changed files, test/build results, and any physical-microphone verification limitation truthfully.
