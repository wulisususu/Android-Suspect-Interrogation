# ASR Audio Input Recovery Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Route live ASR to the working built-in microphone, expose the actual route and signal level, and report digital silence instead of listening forever without text.

**Architecture:** Keep the existing `AudioRecord -> sherpa-onnx -> AsrListener` pipeline. Add two pure Kotlin units for device-selection policy and PCM signal classification, then use a small Android adapter in `SherpaOnlineAsrEngine` to request the built-in microphone and publish diagnostics through the existing ASR status event. Do not add an untestable 8888 client while the vendor service is absent.

**Tech Stack:** Kotlin 2/Android `AudioManager` + `AudioRecord`, JUnit 4, existing JSONObject bridge, Vue 3/TypeScript.

---

### Task 1: Input-device selection policy

**Files:**
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AudioInputSelection.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/asr/AudioInputSelectionTest.kt`

- [ ] **Step 1: Write the failing policy tests**

```kotlin
class AudioInputSelectionTest {
    @Test fun `built in microphone wins over connected USB input`() {
        val usb = AudioInputCandidate(2, AudioInputKind.USB, "HK DXMIC V1")
        val builtIn = AudioInputCandidate(1, AudioInputKind.BUILT_IN, "rockchip-es8388")
        assertEquals(builtIn, AudioInputSelectionPolicy.select(listOf(usb, builtIn)))
    }

    @Test fun `no built in microphone leaves routing to system default`() {
        assertNull(AudioInputSelectionPolicy.select(listOf(AudioInputCandidate(2, AudioInputKind.USB, "USB"))))
    }
}
```

- [ ] **Step 2: Run the focused test and verify RED**

Run: `android/gradlew.bat -p android testDebugUnitTest --tests "*.AudioInputSelectionTest"`

Expected: compilation fails because `AudioInputCandidate` and `AudioInputSelectionPolicy` do not exist.

- [ ] **Step 3: Implement the minimal pure policy**

```kotlin
enum class AudioInputKind { BUILT_IN, USB, OTHER }
data class AudioInputCandidate(val id: Int, val kind: AudioInputKind, val name: String)
object AudioInputSelectionPolicy {
    fun select(candidates: List<AudioInputCandidate>): AudioInputCandidate? =
        candidates.firstOrNull { it.kind == AudioInputKind.BUILT_IN }
}
```

- [ ] **Step 4: Run the focused test and verify GREEN**

Run the command from Step 2. Expected: both tests pass.

### Task 2: PCM signal classifier

**Files:**
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/PcmSignalMonitor.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/asr/PcmSignalMonitorTest.kt`

- [ ] **Step 1: Write failing signal tests**

```kotlin
class PcmSignalMonitorTest {
    @Test fun `three seconds below threshold becomes silent`() {
        val monitor = PcmSignalMonitor(sampleRate = 10, silenceWindowSeconds = 3, digitalSilencePeak = 64)
        repeat(3) { monitor.accept(ShortArray(10) { 18 }, 10) }
        assertEquals(AudioSignalState.SILENT, monitor.snapshot.state)
    }

    @Test fun `valid signal resets accumulated silence`() {
        val monitor = PcmSignalMonitor(sampleRate = 10, silenceWindowSeconds = 3, digitalSilencePeak = 64)
        repeat(2) { monitor.accept(ShortArray(10) { 18 }, 10) }
        monitor.accept(shortArrayOf(500), 1)
        assertEquals(AudioSignalState.ACTIVE, monitor.snapshot.state)
        assertEquals(500, monitor.snapshot.peak)
    }
}
```

- [ ] **Step 2: Run the focused test and verify RED**

Run: `android/gradlew.bat -p android testDebugUnitTest --tests "*.PcmSignalMonitorTest"`

Expected: compilation fails because the monitor types do not exist.

- [ ] **Step 3: Implement sample-count-based monitoring**

Implement `WAITING`, `ACTIVE`, and `SILENT`; compute absolute peak without overflowing on `Short.MIN_VALUE`; accumulate low-level sample count and reset it on a peak above 64.

- [ ] **Step 4: Run the focused test and verify GREEN**

Run the command from Step 2. Expected: both tests pass.

### Task 3: Bind policy and diagnostics to Android AudioRecord

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AudioInputSelection.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrEngine.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/SherpaOnlineAsrEngine.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrController.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/RpcRouter.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/asr/AsrAudioInputStatusJsonTest.kt`

- [ ] **Step 1: Write the failing JSON contract test**

Construct an `AsrRuntimeStatus` containing preferred/routed input names, `peak=500`, and `signalState=ACTIVE`, then assert `toJson()` exposes `preferredAudioInput`, `routedAudioInput`, `audioPeak`, and `audioSignalState`.

- [ ] **Step 2: Run the focused JSON test and verify RED**

Run: `android/gradlew.bat -p android testDebugUnitTest --tests "*.AsrAudioInputStatusJsonTest"`

Expected: compilation fails because the status fields do not exist.

- [ ] **Step 3: Add the Android selector and status callback**

Map `AudioDeviceInfo.TYPE_BUILTIN_MIC` to `BUILT_IN`, USB device/headset types to `USB`, and other inputs to `OTHER`. Add a default `AsrListener.onAudioInputStatus` callback so existing listeners remain source-compatible.

- [ ] **Step 4: Request and verify the built-in route**

Before `startRecording`, call `setPreferredDevice` when a built-in candidate exists and fail with `ASR_AUDIO_ROUTE_FAILED` if Android rejects it. After starting, read `routedDevice`, log both names/types, and fail if a requested built-in input was routed to a non-built-in device.

- [ ] **Step 5: Publish throttled signal diagnostics and no-signal errors**

Feed each PCM batch into `PcmSignalMonitor`, publish diagnostics at most twice per second or on state changes, and raise `ASR_AUDIO_NO_SIGNAL` after three seconds only when the effective route is USB/unknown. Built-in silence remains a visible diagnostic and does not terminate the session.

- [ ] **Step 6: Run focused and full Android unit tests**

Run:

```powershell
android/gradlew.bat -p android testDebugUnitTest --tests "*.AsrAudioInputStatusJsonTest"
android/gradlew.bat -p android testDebugUnitTest
```

Expected: all tests pass.

### Task 4: Show the route and signal in the Web UI

**Files:**
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/components/AsrConsole.vue`

- [ ] **Step 1: Extend the TypeScript contract**

Add optional `preferredAudioInput`, `routedAudioInput`, `audioPeak`, and `audioSignalState: 'WAITING' | 'ACTIVE' | 'SILENT'` fields to `AsrRuntimeStatus`.

- [ ] **Step 2: Render diagnostics without changing the capture workflow**

Add metric rows for the routed input and signal (`有效 / 等待声音 / 无有效信号`, including the peak value). Keep existing start/stop and partial/final rendering unchanged.

- [ ] **Step 3: Build the web app**

Run: `npm --prefix webapp run build`

Expected: Vite exits 0 without TypeScript errors.

### Task 5: Build and verify on the target device

**Files:**
- Verify only: `android/app/build/outputs/apk/debug/app-debug.apk`

- [ ] **Step 1: Run full unit tests and assemble**

```powershell
android/gradlew.bat -p android testDebugUnitTest assembleDebug
```

Expected: `BUILD SUCCESSFUL` and zero test failures.

- [ ] **Step 2: Review only task-related diffs**

Run: `git diff --check` and inspect diffs for the files listed above. Do not stage or discard the existing external-model-storage work.

- [ ] **Step 3: Install without deleting app data**

Run: `adb -s 192.168.2.81:5555 install -r android/app/build/outputs/apk/debug/app-debug.apk`

Expected: `Success`.

- [ ] **Step 4: Reproduce and verify the route**

Clear logcat, start capture, and verify logs report a built-in preferred and routed device even while `HK DXMIC V1` remains connected.

- [ ] **Step 5: Verify captured PCM and ASR text**

After spoken input, inspect the newly written capture WAV. Expected peak is above 64 and the app emits a non-empty partial or final ASR result. If no person is available to speak during the run, report that final text verification needs an interactive spoken sample rather than claiming it passed.

## Working-tree note

The repository already contains uncommitted external-model-storage changes, including overlap in `SherpaOnlineAsrEngine.kt` and `AsrController.kt`. Implementation commits are intentionally omitted from this plan: committing whole files would mix scopes, while partial staging would risk separating dependent existing changes. Preserve the dirty tree and report the exact diff instead.
