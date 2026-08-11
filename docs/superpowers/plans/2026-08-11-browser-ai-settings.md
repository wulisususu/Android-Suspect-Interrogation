# Browser AI Settings Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable browser-side AI configuration and cloud inquiry while keeping all workspace feedback out of document flow.

**Architecture:** Keep Android on `NativeBridge`; add an HTTP-compatible AI settings/router implementation to `backend-dev`. Reuse the existing Vue types and settings panel for both runtimes, with runtime-specific explanatory text only.

**Tech Stack:** Node.js 22, SQLite-backed development data directory, Vue 3, TypeScript, SSE, Playwright CLI

---

### Task 1: Backend AI Settings Contract

**Files:**
- Create: `backend-dev/src/aiSettings.mjs`
- Modify: `backend-dev/src/server.mjs`
- Test: `backend-dev/test/smoke.mjs`

- [ ] Add smoke assertions that `GET /api/ai/settings` returns defaults, `PATCH` stores a supplied key without returning it, and `clearApiKey` clears configured state.
- [ ] Run `npm run smoke` and confirm the missing routes fail.
- [ ] Implement a focused settings store persisted below the configured backend data directory.
- [ ] Add GET/PATCH routes and run the smoke test again.

### Task 2: Configured Cloud Inquiry

**Files:**
- Modify: `backend-dev/src/aiProxy.mjs`
- Modify: `backend-dev/src/server.mjs`
- Test: `backend-dev/test/smoke.mjs`

- [ ] Start a fake OpenAI-compatible SSE provider in the smoke test and assert model, authorization, message, and streamed text.
- [ ] Run the smoke test and confirm the legacy proxy behavior fails the new assertion.
- [ ] Route inquiries using browser AI settings and translate OpenAI-compatible SSE chunks into the webapp payload shape.
- [ ] Run backend syntax checks and smoke tests.

### Task 3: Shared AI Settings Panel

**Files:**
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/components/AiSettingsPanel.vue`

- [ ] Make browser settings calls use the backend HTTP routes while Android keeps NativeBridge calls.
- [ ] Load and show the form in both runtimes, display provider status, and explain that Windows has no local runtime.
- [ ] Run Vue type checking and production build.

### Task 4: Non-Layout Feedback

**Files:**
- Modify: `webapp/src/views/InterrogationWorkspace.vue`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/styles.css`

- [ ] Render loading, success, and error messages in a fixed toast container.
- [ ] Rename question persistence feedback from `已落库` to `已保存`.
- [ ] Build and use Playwright to verify no document scrollbar appears and AI settings remain usable.
