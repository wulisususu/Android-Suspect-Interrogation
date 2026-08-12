# Android Offline RKLLM Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add in-process, fully offline RKLLM 1.3.0 model management, streaming generation, cancellation, and RK3576 device verification to the existing Android/WebView application.

**Architecture:** `/sdcard/models/*.rkllm` is probed into the existing model catalog, while `LlmController` exclusively owns one `RkllmEngine` through `LlmEngineSwitcher`. Kotlin runs synchronous RKLLM inference on a dedicated native dispatcher; JNI forwards callbacks as NativeBridge events and supports concurrent abort. The WebView receives sanitized model DTOs and never receives absolute paths.

**Tech Stack:** Kotlin 2.1.20, coroutines, Android SharedPreferences and WebView NativeBridge, C++17/JNI/CMake, RKLLM runtime 1.3.0, Vue 3.5, TypeScript 5.9, Vite 7.

**Execution constraint:** Work in the current worktree, preserve the user's existing `AiSettingsStore.kt` change, and do not create Git commits. Every checkpoint uses `git diff --check` and targeted tests instead of a commit.

---

## File map

Create:

- `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmModels.kt` — LLM specs, request/result/status types, constants, and JSON conversion.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmModelProbe.kt` — pure filename/size/platform compatibility evaluation.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmEngine.kt` — engine contract and one-engine switcher.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmSettingsStore.kt` — persisted generation defaults.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmController.kt` — serialized lifecycle, concurrency guard, status, streaming, and model selection.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/RkllmNative.kt` — narrow JNI binding.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/RkllmEngine.kt` — Kotlin RKLLM engine and metrics.
- `android/app/src/main/cpp/CMakeLists.txt` — builds and links the JNI wrapper.
- `android/app/src/main/cpp/include/rkllm.h` — exact release-v1.3.0 header copied from the verified server release.
- `android/app/src/main/cpp/rkllm_jni.cpp` — handle/callback/abort/destroy wrapper.
- `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmModelProbeTest.kt`.
- `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmEngineSwitcherTest.kt`.
- `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmControllerTest.kt`.
- `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmJsonTest.kt`.
- `android/app/src/androidTest/java/com/wulisu/suspect/interrogation/llm/RkllmInstrumentedSmokeTest.kt`.
- `webapp/src/components/LlmConsole.vue` — model runtime controls and independently scrolling streaming output.

Modify:

- `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelModels.kt` — add target platform/compatibility metadata while retaining internal paths.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelCatalogScanner.kt` — scan top-level external `.rkllm` files only for LLM.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelManager.kt` — fixed LLM destination, permission state, collision-safe import, and selection validation hook.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/service/AiProviders.kt` — replace unavailable local runtime with `LlmController` adapter without touching `AiSettingsStore.kt`.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/RpcRouter.kt` — LLM actions and sanitized model JSON.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/NativeBridge.kt` — LLM events and storage authorization interception.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/AppContainer.kt` — construct one shared LLM controller.
- `android/app/src/main/java/com/wulisu/suspect/interrogation/MainActivity.kt` — special storage permission flow and LLM release on destroy.
- `android/app/src/main/AndroidManifest.xml` — `MANAGE_EXTERNAL_STORAGE` permission.
- `android/app/build.gradle.kts` — CMake/C++17, NDK, `.rkllm` no-compress rule, and runtime packaging.
- `android/app/src/test/java/com/wulisu/suspect/interrogation/service/ModelCatalogScannerTest.kt` — external LLM catalog coverage.
- `webapp/src/types/interrogation.ts` — sanitized model DTO and LLM types.
- `webapp/src/api/interrogation.ts` — LLM RPC helpers and long inference timeout.
- `webapp/src/components/AiSettingsPanel.vue` — mount LLM console and enforce LLM selection rules.
- `webapp/src/ai-settings.css` — fixed panel/output scroll layout.

Binary inputs copied without alteration:

- `android/app/src/main/jniLibs/arm64-v8a/librkllmrt.so`
- `android/app/src/main/jniLibs/arm64-v8a/libomp.so`

## Task 1: Pure LLM model metadata and platform probe

**Files:**

- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmModelProbeTest.kt`
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmModels.kt`
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmModelProbe.kt`

- [ ] **Step 1: Write failing probe tests**

```kotlin
class LlmModelProbeTest {
    @Test fun `known RK3576 model is complete and runnable on RK3576`() {
        val result = LlmModelProbe.evaluate(
            "LegalOne-4B_W8A8_RK3576.rkllm",
            4_862_583_588L,
            readable = true,
            devicePlatform = "rk3576",
        )
        assertEquals(LlmTargetPlatform.RK3576, result.targetPlatform)
        assertEquals("RKLLM / RK3576 NPU", result.provider)
        assertTrue(result.complete)
        assertTrue(result.runtimeReady)
    }

    @Test fun `RK3588 model is visible but not runnable on RK3576`() {
        val result = LlmModelProbe.evaluate(
            "LegalOne-4B_W8A8_RK3588.rkllm",
            4_849_163_100L,
            readable = true,
            devicePlatform = "rk3576",
        )
        assertEquals(LlmCompatibility.PLATFORM_MISMATCH, result.compatibility)
        assertFalse(result.runtimeReady)
    }

    @Test fun `partial and unknown models cannot run`() {
        assertEquals(
            LlmCompatibility.INCOMPLETE,
            LlmModelProbe.evaluate("LegalOne-4B_W8A8_RK3576.rkllm", 12L, true, "rk3576").compatibility,
        )
        assertEquals(
            LlmCompatibility.UNSUPPORTED,
            LlmModelProbe.evaluate("custom.rkllm", 12L, true, "rk3576").compatibility,
        )
    }
}
```

- [ ] **Step 2: Run the test and confirm RED**

Run:

```powershell
cd 'D:\police Android\repo\android'
.\gradlew.bat testDebugUnitTest --tests '*LlmModelProbeTest'
```

Expected: compilation fails because the LLM probe types do not exist.

- [ ] **Step 3: Implement the minimal pure types and evaluator**

Use these exact public constants and result shape:

```kotlin
const val RKLLM_RUNTIME_VERSION = "1.3.0"
const val RKLLM_PROVIDER = "RKLLM / RK3576 NPU"

enum class LlmTargetPlatform { RK3576, RK3588, UNKNOWN }
enum class LlmCompatibility { READY, INCOMPLETE, UNREADABLE, PLATFORM_MISMATCH, UNSUPPORTED }

data class LlmProbeResult(
    val displayName: String,
    val targetPlatform: LlmTargetPlatform,
    val provider: String,
    val modelFormat: String,
    val complete: Boolean,
    val runtimeReady: Boolean,
    val compatibility: LlmCompatibility,
)
```

`LlmModelProbe.evaluate()` must compare the two known filenames against exact expected sizes, use case-insensitive `.rkllm` matching, and return `UNSUPPORTED` for unknown platform names.

- [ ] **Step 4: Run GREEN and checkpoint**

Run the targeted test, then:

```powershell
git diff --check
git status --short
```

Expected: probe tests pass; no whitespace errors; no commit is created.

## Task 2: Scan fixed external LLM directory and sanitize catalog metadata

**Files:**

- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelModels.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelCatalogScanner.kt`
- Modify: `android/app/src/test/java/com/wulisu/suspect/interrogation/service/ModelCatalogScannerTest.kt`

- [ ] **Step 1: Add failing external LLM scan tests**

Add a scanner `devicePlatform` parameter and assertions:

```kotlin
@Test fun `scan reads rkllm files from external root without exposing unrelated files`() {
    val privateRoot = temporaryFolder.newFolder("private")
    val sharedRoot = temporaryFolder.newFolder("shared")
    File(sharedRoot, "LegalOne-4B_W8A8_RK3576.rkllm").setLength(4_862_583_588L)
    File(sharedRoot, "notes.txt").writeText("ignore")

    val models = scanner.scan(privateRoot, externalRoots = listOf(sharedRoot), devicePlatform = "rk3576")
        .models.filter { it.category == ModelCategory.LLM }

    assertEquals(1, models.size)
    assertEquals("RKLLM", models.single().modelFormat)
    assertEquals("RK3576", models.single().targetPlatform)
    assertTrue(models.single().runtimeReady)
}

@Test fun `private llm directory is not used`() {
    val root = temporaryFolder.newFolder("models")
    File(File(root, "llm").apply { mkdirs() }, "private.rkllm").writeBytes(byteArrayOf(1))
    assertTrue(scanner.scan(root, devicePlatform = "rk3576").models.none { it.category == ModelCategory.LLM })
}
```

- [ ] **Step 2: Verify RED**

Run `testDebugUnitTest --tests '*ModelCatalogScannerTest'`; expected failure is missing scanner argument/metadata behavior.

- [ ] **Step 3: Implement focused scanner changes**

Extend internal descriptors with:

```kotlin
val targetPlatform: String? = null,
val compatibility: String? = null,
```

For `ModelCategory.LLM`, skip the private category directory and map only top-level external `.rkllm` files through `LlmModelProbe`. Keep OCR and all other category behavior byte-for-byte equivalent except for constructor defaults.

- [ ] **Step 4: Run scanner and existing ASR/OCR model tests**

Run:

```powershell
.\gradlew.bat testDebugUnitTest --tests '*ModelCatalogScannerTest' --tests '*AsrModelSpecTest' --tests '*OcrModelSpecTest'
git diff --check
```

Expected: all selected tests pass.

## Task 3: One-engine switcher and controller concurrency

**Files:**

- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmEngine.kt`
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmController.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmEngineSwitcherTest.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmControllerTest.kt`

- [ ] **Step 1: Write failing switcher tests**

Use a fake engine that counts `release()` and a factory that tracks live instances:

```kotlin
@Test fun `switch releases old engine before creating replacement`() {
    val events = mutableListOf<String>()
    val switcher = LlmEngineSwitcher { spec, _ ->
        events += "create:${spec.id}"
        FakeEngine(spec) { events += "release:${spec.id}" }
    }
    switcher.switchTo(spec("one"), config())
    switcher.switchTo(spec("two"), config())
    assertEquals(listOf("create:one", "release:one", "create:two"), events)
}

@Test fun `same model and context reuses engine`() {
    var created = 0
    val switcher = LlmEngineSwitcher { spec, _ -> FakeEngine(spec).also { created++ } }
    assertSame(switcher.switchTo(spec("one"), config()), switcher.switchTo(spec("one"), config()))
    assertEquals(1, created)
}
```

- [ ] **Step 2: Verify switcher RED, then implement minimal switcher**

The switcher must call old `release()` before invoking the factory and compare model ID plus `maxContextLen`.

- [ ] **Step 3: Write failing controller concurrency/cancel tests**

```kotlin
@Test fun `parallel generate is rejected and cancel permits a later generate`() = runTest {
    val engine = BlockingFakeEngine(spec("one"))
    val controller = controllerWith(engine)
    val first = async { controller.generate(LlmInput("g1", "first", config())) }
    engine.awaitStarted()
    val error = assertFailsWith<BusinessException> {
        controller.generate(LlmInput("g2", "second", config()))
    }
    assertEquals("LLM_GENERATION_BUSY", error.code)
    controller.cancel()
    first.await()
    assertEquals("third", controller.generate(LlmInput("g3", "third", config())).outputText)
}

@Test fun `release is idempotent`() = runTest {
    val engine = FakeEngine(spec("one"))
    val controller = controllerWith(engine)
    controller.release()
    controller.release()
    assertEquals(1, engine.releaseCount)
}
```

- [ ] **Step 4: Verify controller RED, implement state machine, then run GREEN**

`LlmController.generate()` must use an `AtomicBoolean.compareAndSet(false, true)` before initialization; clear it in `finally`. `cancel()` calls the active engine without acquiring the long-running generation lock. All state changes notify the status listener.

Run:

```powershell
.\gradlew.bat testDebugUnitTest --tests '*LlmEngineSwitcherTest' --tests '*LlmControllerTest'
git diff --check
```

Expected: both classes pass, including cancellation followed by generation.

## Task 4: Persistence, fixed-directory import, and selection validation

**Files:**

- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmSettingsStore.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelManager.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmController.kt`
- Add tests to: `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmControllerTest.kt`

- [ ] **Step 1: Add failing selection tests**

```kotlin
@Test fun `select rejects incompatible model without releasing current engine`() {
    val error = assertFailsWith<BusinessException> { controller.selectModel(rk3588Descriptor.id) }
    assertEquals("LLM_PLATFORM_MISMATCH", error.code)
    assertEquals(0, currentEngine.releaseCount)
}

@Test fun `select clears old engine before persisting a new compatible model`() {
    controller.selectModel(rk3576Descriptor.id)
    assertEquals(listOf("release", "persist:${rk3576Descriptor.id}"), events)
}
```

- [ ] **Step 2: Verify RED and implement selection order**

Validate descriptor existence, category, completeness, compatibility and `runtimeReady`; then release current engine; then persist selection through ModelManager. Clearing selection also releases the engine first.

- [ ] **Step 3: Implement LLM-specific import destination**

For `category == LLM`, require `Environment.isExternalStorageManager()`, require source kind FILE and `.rkllm`, copy to `/sdcard/models/.importing-<uuid>.part`, validate byte count, and rename. Do not change the existing ASR/OCR/private import branch.

Collision policy:

```kotlin
if (destination.exists() && destination.length() == document.length()) return@withContext scan()
if (destination.exists()) throw BusinessException("MODEL_IMPORT_NAME_CONFLICT", "同名 LLM 模型已存在且大小不同")
```

- [ ] **Step 4: Run controller/scanner regression tests and checkpoint**

Run all `llm` and `ModelCatalogScannerTest` JVM tests. Expected: pass; Room files and schema are unchanged.

## Task 5: Sanitized JSON and LLM RPC dispatch

**Files:**

- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/llm/LlmJsonTest.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/llm/LlmModels.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/RpcRouter.kt`

- [ ] **Step 1: Write failing result/path JSON tests**

```kotlin
@Test fun `result json includes metrics and nullable tokens`() {
    val json = result(tokenIds = null).toJson()
    assertEquals("回答", json.getString("outputText"))
    assertTrue(json.getBoolean("finished"))
    assertTrue(json.isNull("tokenIds"))
    assertEquals(64, json.getInt("maxNewTokens"))
    assertEquals(1024, json.getInt("maxContextLen"))
}

@Test fun `catalog json never exposes absolute paths`() {
    val raw = catalogWithPath("/sdcard/models/secret.rkllm").toWireJson().toString()
    assertFalse(raw.contains("/sdcard"))
    assertFalse(raw.contains("absolutePath"))
    assertEquals("Android 设备模型目录", JSONObject(raw).getString("rootPath"))
}
```

- [ ] **Step 2: Verify RED and implement JSON conversion**

Move catalog serialization to an internal reusable function accessible to tests. Do not emit `absolutePath`; emit provider, format, targetPlatform, compatibility and completeness.

- [ ] **Step 3: Add RPC actions**

Map exact actions:

```kotlin
"llm.status" -> llm.status().toJson()
"llm.model.list" -> models.list().llmOnly().toWireJson()
"llm.model.select" -> llm.selectModel(payload.nullableString("modelId")).toWireJson()
"llm.generate" -> llm.generate(payload.requiredLlmInput("prompt")).toJson()
"llm.chat" -> llm.generate(payload.requiredLlmInput("message")).toJson()
"llm.cancel" -> llm.cancel().toJson()
"llm.release" -> llm.release().toJson()
```

Route `model.select` category LLM through the same controller. Validate generation IDs and numeric config bounds before calling the controller.

- [ ] **Step 4: Run JSON and controller tests**

Expected: JSON assertions pass and existing RPC compilation remains green.

## Task 6: RKLLM 1.3.0 JNI runtime integration

**Files:**

- Create: native/Kotlin files listed in the file map.
- Modify: `android/app/build.gradle.kts`
- Create: `android/app/src/androidTest/java/com/wulisu/suspect/interrogation/llm/RkllmInstrumentedSmokeTest.kt`

- [ ] **Step 1: Add a compile-failing Android smoke test contract**

```kotlin
@RunWith(AndroidJUnit4::class)
class RkllmInstrumentedSmokeTest {
    @Test fun nativeLibrariesLoad() {
        assertEquals("1.3.0", RkllmNative.runtimeVersion)
        assertTrue(RkllmNative.loadError == null)
    }
}
```

Run `compileDebugAndroidTestKotlin`; expected failure is missing `RkllmNative`.

- [ ] **Step 2: Copy verified runtime/header inputs and verify hashes before use**

Copy with SFTP from the specified server release, then run SHA-256 locally. Required hashes:

```text
librkllmrt.so 84b247f2efe16096551698f2d21ab4340a4663a2c7ef03773a8ef0b441668e55
libomp.so      1c4db1866bef4228365dc2a44264f7452b9f7af35e100bcbecf05c24b02bfe6f
```

Compare `rkllm.h` with the server source byte-for-byte. Do not use any 1.2.x artifact.

- [ ] **Step 3: Configure CMake and arm64-only packaging**

Set C++17, import `rkllmrt` and `omp`, link `log`, and configure `externalNativeBuild`. Install a compatible Android NDK/CMake package if absent. Preserve existing `abiFilters += "arm64-v8a"`.

- [ ] **Step 4: Implement narrow JNI methods**

Kotlin declarations:

```kotlin
private external fun nativeCreate(modelPath: String, maxContextLen: Int, maxNewTokens: Int, callback: Callback): Long
private external fun nativeRun(handle: Long, prompt: String, role: String, maxNewTokens: Int): Int
private external fun nativeAbort(handle: Long): Int
private external fun nativeDestroy(handle: Long): Int
```

C++ must use `rkllm_createDefaultParam`, `rkllm_init`, synchronous `rkllm_run`, `rkllm_abort`, `rkllm_is_running`, and `rkllm_destroy`. Copy callback text before invoking Java, attach/detach native callback threads, and protect destroy with atomic state plus condition variable. Never call destroy while `rkllm_run` is still active.

- [ ] **Step 5: Implement RkllmEngine metrics and streaming**

Measure initialization, first nonempty callback and total inference with `SystemClock.elapsedRealtime()`. Accumulate copied fragments and valid token IDs; return null token list if none. Map nonzero init/run codes to `BusinessException` with runtime code.

- [ ] **Step 6: Compile native and APK code**

Run:

```powershell
.\gradlew.bat compileDebugKotlin compileDebugAndroidTestKotlin
```

Expected: CMake config, arm64 native compilation, Kotlin, and smoke test compilation all succeed.

## Task 7: Storage permission flow, NativeBridge streaming, and lifecycle release

**Files:**

- Modify: `AndroidManifest.xml`, `MainActivity.kt`, `NativeBridge.kt`, `AppContainer.kt`.

- [ ] **Step 1: Add permission declaration and MainActivity launcher**

Use `Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION` with `package:<applicationId>`. Intercept `llm.storage.permission.request` in NativeBridge like the existing model/image chooser actions. On return/resume, re-check permission and call `modelManager.scanAsync()` plus LLM status notification.

- [ ] **Step 2: Wire streaming listeners**

NativeBridge subscribes to controller status and fragment callbacks:

```kotlin
llm.setStatusListener { deliverEvent("llm.status", it.toJson().toString()) }
llm.setFragmentListener { deliverEvent("llm.fragment", it.toJson().toString()) }
```

Clear both listeners in `close()`.

- [ ] **Step 3: Wire one shared controller and local AI provider**

Construct `LlmController` once in AppContainer, pass it to RpcRouter and NativeBridge, and implement LocalAiProvider with that controller. Do not edit `AiSettingsStore.kt`.

- [ ] **Step 4: Release on Activity destruction**

After ASR capture stop and before WebView destruction, call `appContainer.llmController.release()` off the UI thread using the existing controlled teardown. Repeated explicit release plus onDestroy must remain safe.

- [ ] **Step 5: Run all JVM tests and compile Android**

Expected: all unit tests pass; debug Android compilation succeeds.

## Task 8: Vue types, API, LLM console, and bounded scrolling

**Files:**

- Modify/create WebView files listed in the file map.

- [ ] **Step 1: Create a TypeScript RED state**

Add `LlmConsole.vue` imports for `LlmRuntimeStatus`, `LlmFragment`, `generateLlm`, `cancelLlm`, and `releaseLlm` before defining those exports. Run `npm run typecheck` and confirm it fails only for missing LLM contracts.

- [ ] **Step 2: Add exact sanitized types and API functions**

Model DTO must omit `absolutePath`. Add:

```ts
export interface LlmGenerationConfig { maxNewTokens: number; maxContextLen: number }
export interface LlmFragment { generationId: string; text: string; accumulatedText: string; tokenId?: number | null; elapsedMs: number }
export interface LlmResult { outputText: string; finished: boolean; fragments: string[]; tokenIds?: number[] | null; modelName: string; provider: string; maxNewTokens: number; maxContextLen: number; initializationMs: number; firstTokenLatencyMs?: number | null; totalInferenceMs: number; error?: string | null }
export interface LlmRuntimeStatus { selectedModelId?: string | null; selectedModelName?: string | null; activeModelId?: string | null; provider: string; storagePermissionGranted: boolean; initialized: boolean; busy: boolean; generationId?: string | null; config: LlmGenerationConfig; initializationMs?: number | null; firstTokenLatencyMs?: number | null; totalInferenceMs?: number | null; error?: string | null }
```

Use a 15-minute timeout for generate/chat and 30 seconds for cancel/release/status.

- [ ] **Step 3: Implement LlmConsole behavior**

Register `llm.fragment` and `llm.status` listeners on mount. Generate a UUID, clear output, call generate, append only matching fragment events, expose stop and release, and display browser-only warning without simulated output.

- [ ] **Step 4: Integrate model selection and permission button**

Mount LlmConsole under the LLM model category. Disable incompatible/incomplete radio controls and show compatibility text. Add “授权模型目录” only when native status says permission missing.

- [ ] **Step 5: Apply bounded layout**

Set panel body to a flex column with bounded height; set model list and `.llm-output` to `overflow:auto`; keep `.llm-actions` visible. Do not change the overall single-window visual language.

- [ ] **Step 6: Run TypeScript and production build GREEN**

Run:

```powershell
cd 'D:\police Android\repo\webapp'
npm run typecheck
npm run build
```

Expected: both commands exit 0 and generate `webapp/dist`.

## Task 9: Full automated verification and APK contents

- [ ] **Step 1: Run the full JVM suite**

```powershell
cd 'D:\police Android\repo\android'
.\gradlew.bat testDebugUnitTest
```

Expected: zero failures.

- [ ] **Step 2: Build the debug APK with current web assets**

```powershell
.\gradlew.bat clean assembleDebug
```

Expected APK: `android/app/build/outputs/apk/debug/app-debug.apk`.

- [ ] **Step 3: Inspect APK invariants**

Use `apkanalyzer` or ZIP listing and assert:

- only `lib/arm64-v8a/` exists;
- `librkllmrt.so`, `libomp.so`, and `librkllm_jni.so` exist;
- no `.rkllm` entry exists;
- packaged WebView assets contain LLM UI strings.

- [ ] **Step 4: Record APK size and SHA-256**

Use `Get-Item` and `Get-FileHash -Algorithm SHA256` and retain output for final reporting.

## Task 10: Install and verify on RK3576 device

- [ ] **Step 1: Install without uninstalling**

```powershell
adb connect 192.168.2.81:5555
adb -s 192.168.2.81:5555 install -r 'D:\police Android\repo\android\app\build\outputs\apk\debug\app-debug.apk'
```

Expected: `Success`; app data and selected model preferences remain unless schema/package incompatibility is observed.

- [ ] **Step 2: Grant/verify all-files access and App UID readability**

Use the App UI flow first. For automated validation, inspect appops and run an App-process/RPC scan; do not accept shell-only `ls` as proof.

- [ ] **Step 3: Select the RK3576 model and reject RK3588**

Verify status for both model names, select RK3576, attempt RK3588 and record the platform mismatch response, then restart the App and verify selection persistence.

- [ ] **Step 4: Run three Chinese prompts**

Use prompts covering legal text, arithmetic reasoning and concise factual output. Capture streamed output, initialization time, first-fragment time and total time for each.

- [ ] **Step 5: Verify cancel/retry/release**

Start a long generation, cancel it, immediately generate again, release, then generate once more to prove clean reinitialization. Confirm no second handle or residual `llm_demo`/helper process exists.

- [ ] **Step 6: Capture CPU, memory and NPU evidence**

Collect synchronized `logcat`, `top`/process CPU, `dumpsys meminfo`, RKLLM perf logs and available `/sys` RKNPU load data. Report NPU confirmation only if logs or load data show actual RKLLM/RKNPU execution.

- [ ] **Step 7: Final regression and worktree review**

Run Web typecheck/build, full JVM tests and APK build once more after device fixes. Run:

```powershell
git diff --check
git status --short
git diff --stat
```

Verify every changed line traces to the LLM task, `AiSettingsStore.kt` retains the user's original change, and no Git commit was created.
