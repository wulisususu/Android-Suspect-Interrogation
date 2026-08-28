# Browser/ALSA Voiceprint Audio Source Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Allow remote HTTPS browsers to enroll suspect/officer voiceprints through the browser computer microphone while preserving the RK3588 ALSA path, with AUTO source selection and no mixed-source enrollment.

**Architecture:** `AudioCaptureService` remains the single authoritative PCM/VAD buffer. ALSA continues to feed it from the RK3588 collector thread; BROWSER capture feeds the same ingest path through a dedicated binary WebSocket identified by a random `captureId`. The Vue store acquires the browser mic before REST start, falls back to ALSA only before enrollment begins, and keeps one source fixed until completion/cancel.

**Tech Stack:** FastAPI/WebSocket, Python threading, existing `SpeechWorkerClient` FSMN-VAD/XVector runtime, Vue 3/Pinia/TypeScript, Web Audio API, Vitest/pytest, GitHub Actions + RK3588 self-hosted runner.

**Spec:** `docs/superpowers/specs/2026-08-28-browser-voiceprint-audio-source-design.md`

## Global Constraints

- Branch: `linux-adaptation`; do not modify `main`.
- Voiceprint PCM is PCM16 little-endian, mono, 16 kHz.
- Effective-speech target remains exactly 20,000 ms; five-minute capture ceiling remains safety-only.
- One enrollment selects exactly one source (`BROWSER` or `ALSA`) and never mixes sources.
- Browser audio is never persisted in browser storage, logs, CI artifacts, or a new server-side raw-audio artifact.
- Browser WebSocket accepts only the current active BROWSER `captureId`; binary chunks must be non-empty, even-length PCM16, and bounded.
- Browser WebSocket loss before completion cancels the capture; it never silently falls back to ALSA mid-enrollment.
- Formal interrogation ASR remains RK3588 ALSA in this iteration.
- Backward-compatible REST start without `source` must remain ALSA.

---

### Task 1: Make the backend capture owner source-aware

**Files:**
- Modify: `linux/backend/app/services/audio_capture_service.py`
- Test: `linux/backend/tests/test_audio_capture_service.py`

**Interfaces:**
- Produces: `AudioCaptureService.start(kind, subject_id, source="ALSA") -> dict`
- Produces: `AudioCaptureService.push_browser_pcm(capture_id, pcm) -> dict`
- Produces: `AudioCaptureService.cancel(capture_id=None) -> dict`
- Status fields: `captureId`, `source`, `recordedDurationMs`, `usableSpeechMs`, `requiredUsableSpeechMs`, `complete`, `completeReason`.

- [ ] **Step 1: Write failing tests** proving BROWSER start does not call `device_manager.start_record()`, ALSA still does, source defaults to ALSA, wrong captureId/source is rejected, BROWSER PCM enters streaming VAD, 20 s effective speech marks complete, and cancel clears the capture without enrollment.
- [ ] **Step 2: Run focused tests** with `pytest -q linux/backend/tests/test_audio_capture_service.py`; expected RED because `source`, `captureId`, browser push and cancel do not exist.
- [ ] **Step 3: Implement minimal source-aware capture** by extracting the shared PCM ingest/VAD path from `_collect`; BROWSER has no collector thread and is fed only by `push_browser_pcm`.
- [ ] **Step 4: Keep final quality semantics unchanged**: REST stop still returns the accumulated PCM for existing final VAD/XVector enrollment; streaming VAD only decides when capture is complete.
- [ ] **Step 5: Run focused tests**; expected GREEN.
- [ ] **Step 6: Commit** as `feat: add browser voiceprint capture source`.

### Task 2: Add source-aware REST and dedicated binary WebSocket transport

**Files:**
- Modify: `linux/backend/app/api/voiceprints.py`
- Create: `linux/backend/app/websocket/voiceprint_enrollment.py`
- Modify: `linux/backend/app/main.py`
- Test: `linux/backend/tests/test_api.py`
- Create/Test: `linux/backend/tests/test_voiceprint_browser_transport.py`

**Interfaces:**
- REST start request: `source: "ALSA" | "BROWSER" = "ALSA"`.
- REST cancel: `POST /api/v1/voiceprints/enrollment/cancel` with `capture_id`.
- WebSocket: `/ws/voiceprints/enrollment/{captureId}` accepting raw binary PCM16 only.

- [ ] **Step 1: Write failing API/transport tests** for default ALSA, explicit BROWSER, returned source/captureId, cancel, wrong captureId, text-frame rejection, odd-size/empty/oversized PCM rejection, and disconnect-before-complete cancellation.
- [ ] **Step 2: Run focused tests**; expected RED for missing source fields/cancel/WebSocket.
- [ ] **Step 3: Extend enrollment bodies and context** to retain `capture_id` and `source`; add cancellation that clears matching enrollment context and never invokes XVector.
- [ ] **Step 4: Add the binary WebSocket router** with a 64 KiB per-frame cap, even-length PCM16 validation, no logging of payload/captureId, and disconnect cancellation only while the active BROWSER capture is incomplete.
- [ ] **Step 5: Register the router in `main.py`** without changing the existing interrogation WebSocket.
- [ ] **Step 6: Run focused API/transport tests**; expected GREEN.
- [ ] **Step 7: Commit** as `feat: stream browser voiceprint pcm`.

### Task 3: Add browser microphone PCM16 capture module

**Files:**
- Create: `webapp/src/audio/browserVoiceprintCapture.ts`
- Create/Test: `webapp/src/audio/browserVoiceprintCapture.test.ts`

**Interfaces:**
- Produces: `acquireBrowserVoiceprintMic() -> Promise<BrowserVoiceprintCapture>`.
- `BrowserVoiceprintCapture.start(captureId, callbacks)` opens `/ws/voiceprints/enrollment/{captureId}` and sends 16 kHz mono PCM16 chunks.
- `stop()` closes WebSocket/audio graph/tracks without retaining audio.
- Produces pure `Pcm16Resampler`/conversion helpers for deterministic unit testing.

- [ ] **Step 1: Write failing Vitest tests** for Float32 clipping/PCM16 conversion, 48 kHz→16 kHz duration preservation across chunk boundaries, secure-context/mediaDevices guard, and cleanup.
- [ ] **Step 2: Run focused Vitest**; expected RED because the module does not exist.
- [ ] **Step 3: Implement browser capture** using `getUserMedia`, a Web Audio graph, mono Float32 processing, stateful resampling to 16 kHz, and bounded WebSocket binary chunks. Disable echo cancellation/noise suppression/AGC where supported.
- [ ] **Step 4: Implement lifecycle callbacks** for socket failure and microphone track end; never reconnect to ALSA from this module.
- [ ] **Step 5: Run focused Vitest**; expected GREEN.
- [ ] **Step 6: Commit** as `feat: capture browser voiceprint pcm`.

### Task 4: Wire AUTO source selection into runtime/store/UI

**Files:**
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/runtime/types.ts`
- Modify: `webapp/src/runtime/linuxHttpWsAdapter.ts`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/components/VoiceprintPreparationPanel.vue`
- Test: existing relevant Vue/store/runtime tests plus `VoiceprintPreparationPanel` tests.

**Interfaces:**
- Adds `VoiceprintAudioSource = 'BROWSER' | 'ALSA'`.
- Start API functions accept optional source.
- Capture state carries `captureId`, `source`, `recordedDurationMs`, `usableSpeechMs`, `requiredUsableSpeechMs`.
- Cancel runtime operation maps to `/api/v1/voiceprints/enrollment/cancel`.

- [ ] **Step 1: Write failing frontend contract tests**: AUTO chooses BROWSER when mic acquisition succeeds; pre-start browser failure falls back to ALSA; BROWSER socket failure cancels and reports restart-required; completion stops browser stream before REST stop; source label/warning renders.
- [ ] **Step 2: Run focused Vue tests**; expected RED.
- [ ] **Step 3: Update normalized types/runtime mappings** so status uses explicit recorded/effective durations and start sends the chosen source.
- [ ] **Step 4: Implement AUTO store orchestration**: acquire mic first, start BROWSER REST capture, then WebSocket; fallback to ALSA only when acquisition fails before REST start; cancel BROWSER capture on transport/track failure or case reset.
- [ ] **Step 5: Update UI** to show `音源：本机浏览器麦克风（远程）` or `音源：RK3588 开发板麦克风（现场）`, explicit HTTPS/fallback reason, effective-speech progress, and total received duration diagnostics.
- [ ] **Step 6: Run focused frontend tests, typecheck and build**; expected GREEN.
- [ ] **Step 7: Commit** as `feat: auto-select voiceprint audio source`.

### Task 5: Release verification and RK3588 deployment

**Files:**
- Modify only if required by a failing deployment contract: existing `.github/workflows/*production*redeploy*.yml` / release tests.
- Update: `docs/template-interrogation-operator-guide.md` if it already documents voiceprint capture.

**Interfaces:**
- Hosted gates remain authoritative for backend/frontend/release behavior.
- RK3588 production service remains port `18080`.

- [ ] **Step 1: Add/reuse release-level integration test** sending deterministic PCM through the browser transport without saving audio artifacts and verifying `usableSpeechMs` changes and source remains BROWSER.
- [ ] **Step 2: Run full hosted gate**: Python tests, migrations, API/security, hardware/AI mocks, Vue tests, typecheck, build, screenshot QA, release E2E.
- [ ] **Step 3: Run RK3588 smoke** proving ALSA enrollment behavior is unchanged and the deployed speech worker still supports streaming VAD/XVector.
- [ ] **Step 4: Trigger codeload-based production redeploy** of the exact verified `linux-adaptation` SHA to port 18080; restart API/AI worker and verify `/health/ready` plus the new frontend bundle.
- [ ] **Step 5: Verify remote-browser acceptance boundary**: HTTPS/browser permission is required for BROWSER mode; HTTP/non-secure access visibly falls back to ALSA rather than pretending to capture remote audio.
- [ ] **Step 6: Commit any deployment-only verification adjustment** only if a failing gate proves it is required.
