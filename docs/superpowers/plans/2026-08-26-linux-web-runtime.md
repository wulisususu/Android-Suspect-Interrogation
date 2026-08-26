# Linux Web Runtime Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the existing Vue 3 interrogation UI run as a first-class Linux RK3588 client over local HTTP/WebSocket while retaining Android as a compatibility runtime.

**Architecture:** Keep `webapp/src/api/*` as stable application-service facades. Move runtime selection, operation routing, capability normalization and reliable WebSocket behavior into focused files under `webapp/src/runtime/`. Linux is the default browser runtime; BrowserDev and Android are explicit adapters.

**Tech Stack:** Vue 3, TypeScript 5.9, Axios, Vitest 4, native WebSocket, Vite 7.

**Spec:** `docs/linux-runtime-contract.md`

## Global Constraints

- No cloud services.
- Models are not downloaded by this change.
- Preserve the existing A/B/C pages and UX; do not redesign the product.
- Linux formal REST base is `/api/v1`; WebSocket base is `/ws/...`.
- Missing model/device/backend capabilities must degrade to normalized states instead of Android-only exceptions.
- Production changes are primarily `webapp/**`; backend business logic and hardware drivers are not modified.

---

### Task 1: Runtime contracts and factory

**Files:**
- Create: `webapp/src/runtime/types.ts`
- Create: `webapp/src/runtime/errors.ts`
- Create: `webapp/src/runtime/index.ts`
- Test: `webapp/src/runtime/__tests__/runtimeFactory.test.ts`

**Interfaces:**
- Produces `RuntimeKind`, `RuntimeCapabilityState`, `RuntimeCapability`, `RuntimeOperation`, `RuntimeAdapter`, `getRuntimeAdapter()`, `resetRuntimeAdapterForTests()`.

- [ ] **Step 1: Write failing factory tests** asserting NativeBridge selects Android, explicit browser-dev selects BrowserDev, and ordinary browser selects Linux.
- [ ] **Step 2: Run** `npm test -- src/runtime/__tests__/runtimeFactory.test.ts` and verify failure because runtime modules do not exist.
- [ ] **Step 3: Implement minimal types/error/factory** with lazy singleton selection and test reset.
- [ ] **Step 4: Re-run the factory test** and verify PASS.

### Task 2: Reliable WebSocket client

**Files:**
- Create: `webapp/src/runtime/wsClient.ts`
- Test: `webapp/src/runtime/__tests__/wsClient.test.ts`

**Interfaces:**
- Produces `RuntimeWebSocketClient`, `RuntimeEvent`, `RuntimeEventListener`, `RuntimeConnectionState`.

- [ ] **Step 1: Write failing tests** for reconnect, bounded exponential delay, `SESSION_RESYNC`, sequence rejection and duplicate id rejection using an injected fake WebSocket constructor.
- [ ] **Step 2: Run** `npm test -- src/runtime/__tests__/wsClient.test.ts` and verify expected failures.
- [ ] **Step 3: Implement the client** with `connect()`, `close()`, `send()`, connection-state callback, backoff `[250,500,1000,2000,5000]`, last-sequence tracking and a bounded seen-id set.
- [ ] **Step 4: Re-run** the WebSocket test and verify PASS.

### Task 3: Linux, Android and BrowserDev adapters

**Files:**
- Create: `webapp/src/runtime/linuxHttpWsAdapter.ts`
- Create: `webapp/src/runtime/androidNativeAdapter.ts`
- Create: `webapp/src/runtime/browserDevAdapter.ts`
- Test: `webapp/src/runtime/__tests__/linuxHttpWsAdapter.test.ts`

**Interfaces:**
- Consumes `RuntimeAdapter`, `RuntimeWebSocketClient`, existing `http`, `callNative`.
- Produces concrete adapter classes implementing `invoke`, `getCapabilities`, `connectSession`.

- [ ] **Step 1: Write failing Linux adapter tests** for `/api/v1` routing, network->`NOT_CONNECTED`, 404 model->`MODEL_NOT_INSTALLED`, 404 device->`NOT_CONFIGURED`, and WebSocket URL derivation.
- [ ] **Step 2: Run** `npm test -- src/runtime/__tests__/linuxHttpWsAdapter.test.ts` and verify failures.
- [ ] **Step 3: Implement Linux adapter operation map and capability normalization**. Do not silently fall back to Android or legacy endpoints.
- [ ] **Step 4: Implement Android adapter** mapping existing action names to `callNative`, plus NativeBridge event compatibility.
- [ ] **Step 5: Implement BrowserDev adapter** preserving currently supported backend-dev case/message/fact/session REST behavior and explicit not-ready states for local models/device-only operations.
- [ ] **Step 6: Re-run adapter tests** and verify PASS.

### Task 4: Migrate application API facades

**Files:**
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/api/caseProfile.ts`
- Modify: `webapp/src/api/documentSigning.ts`
- Test: `webapp/src/runtime/__tests__/apiFacade.test.ts`

**Interfaces:**
- Existing exported function names and return types remain stable.

- [ ] **Step 1: Write failing facade tests** showing LLM/ASR/OCR/AI/signing calls delegate to the current adapter instead of throwing Android-only errors.
- [ ] **Step 2: Run the focused facade test** and verify the existing Android-only gates fail it.
- [ ] **Step 3: Replace NativeBridge branching with adapter delegation** while preserving `backendErrorMessage()` and all existing exports.
- [ ] **Step 4: Re-run focused tests** and verify PASS.

### Task 5: Capability-driven identity/device UI

**Files:**
- Modify: `webapp/src/components/IdentityIntakeModal.vue`
- Modify: `webapp/src/components/DeviceStatusBar.vue`

**Interfaces:**
- Consumes `fetchRuntimeCapabilities()` and existing API functions; no direct NativeBridge runtime checks.

- [ ] **Step 1: Remove imports of `isNativeBusinessRuntime`, `isNativeDeviceRuntime` and direct native device branching.**
- [ ] **Step 2: Load OCR/device capabilities on mount and render reasoned states** (`AVAILABLE`, `NOT_CONNECTED`, `NOT_CONFIGURED`, `MODEL_NOT_INSTALLED`, `BUSY`, `ERROR`).
- [ ] **Step 3: Keep manual identity entry available regardless of runtime** and keep OCR buttons disabled only when capability state is not usable.
- [ ] **Step 4: Preserve existing layout/classes wherever possible; add only small state labels/messages.**

### Task 6: CI verification on RK3588

**Files:**
- Create: `.github/workflows/linux-web-runtime-check.yml`

**Interfaces:**
- Pushes to `linux-web-runtime` execute on `[self-hosted, rk3588]`.

- [ ] **Step 1: Add a resilient sparse checkout mirroring the existing runner connectivity workflow.**
- [ ] **Step 2: Run `npm ci`, `npm run typecheck`, `npm test`, `npm run build` from `webapp`.**
- [ ] **Step 3: Inspect workflow job steps/logs and fix any TypeScript/test/build failures.**

### Task 7: Final verification and handoff

**Files:**
- Review all changed files and `docs/linux-runtime-contract.md`.

- [ ] **Step 1: Search changed frontend files for Android-only user-facing gates and direct component runtime checks.**
- [ ] **Step 2: Confirm tests cover runtime factory, Linux adapter and WebSocket reliability.**
- [ ] **Step 3: Confirm RK3588 workflow reports typecheck, tests and build.**
- [ ] **Step 4: Report final commit SHA, runner result and backend contract gaps.**
