# ModelManager Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the model-management contracts, Android storage service, NativeBridge import flow, and AI settings UI needed for future local model runtimes.

**Architecture:** A pure Kotlin scanner describes app-private model entries and is wrapped by an Android `ModelManager` for preferences and Storage Access Framework imports. The existing AI provider depends on a new runtime interface and the selected LLM, while WebView RPC keeps model management under the existing AI settings entry.

**Tech Stack:** Kotlin, Android Storage Access Framework, AndroidX DocumentFile, coroutines, Vue 3, TypeScript, NativeBridge RPC.

---

### Task 1: Define and test the model catalog

**Files:**
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelModels.kt`
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelCatalogScanner.kt`
- Test: `android/app/src/test/java/com/wulisu/suspect/interrogation/service/ModelCatalogScannerTest.kt`

- [x] Define category, source, descriptor, and catalog data classes.
- [x] Write scanner tests for empty roots, files/directories, archive display names, selected entries, sizes, and ignored partial imports.
- [x] Implement the minimal pure file scanner needed by the tests.

### Task 2: Add Android ModelManager and local runtime contract

**Files:**
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/ModelManager.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/AiProviders.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/AiRouter.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/AppContainer.kt`
- Modify: `android/app/build.gradle.kts`

- [x] Add scan/list/select operations and one persisted selection per model category.
- [x] Add file and recursive-directory import through AndroidX DocumentFile with temporary destinations.
- [x] Add `LocalLlmRuntime` and an unavailable default implementation.
- [x] Make `LocalAiProvider` read the selected LLM and runtime capability.
- [x] Start a contained background scan from the application container.

### Task 3: Expose model RPC and Android picker flow

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/RpcRouter.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/NativeBridge.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/MainActivity.kt`

- [x] Serialize model catalogs and descriptors to JSON.
- [x] Add scan, list, select, and import dispatch actions.
- [x] Intercept `model.import.request` in NativeBridge and launch file or directory selection from MainActivity.
- [x] Continue the original RPC after picker success and resolve cancellation explicitly.

### Task 4: Add the model-management UI

**Files:**
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/native/rpcBridge.ts`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/components/AiSettingsPanel.vue`
- Modify: `webapp/src/ai-settings.css`

- [x] Add TypeScript model catalog contracts and long-timeout NativeBridge calls.
- [x] Add native scan, select, and import API wrappers plus a browser empty-state fallback.
- [x] Add `推理设置` and `本地模型` tabs under the existing AI entry.
- [x] Render dense category lists, selection controls, import actions, loading, empty, and error states.

### Task 5: Verification deferred by request

- [ ] Run Android unit tests and Web TypeScript checks when builds are permitted.
- [ ] Build web assets and the debug APK when requested.
- [ ] Install and verify on `192.168.2.81:5555` when requested.
- [ ] Capture the implemented state and complete visual design QA after a runnable build exists.
