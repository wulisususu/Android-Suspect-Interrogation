# Inline Voiceprint Gate Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Put suspect voiceprint enrollment in the right-hand live-dialogue area and release that area to live dialogue once enrollment succeeds.

**Architecture:** `InterrogationWorkspace` passes the existing browser microphone and enrollment state into `TemplateDrivenInterrogationPage`. The page renders a compact enrollment gate before a real suspect voiceprint exists, then replaces it with `LiveDialoguePanel`. Existing backend voiceprint enforcement remains unchanged.

**Tech Stack:** Vue 3, TypeScript, Pinia, Vitest, Vite.

---

### Task 1: Add the right-panel enrollment gate

**Files:**
- Create: `webapp/src/components/VoiceprintEnrollmentGate.vue`
- Modify: `webapp/src/components/TemplateDrivenInterrogationPage.test.ts`
- Test: `webapp/src/components/VoiceprintEnrollmentGate.test.ts`

- [ ] **Step 1: Write the failing contract test**

```ts
it('puts suspect enrollment in the dialogue column', () => {
  expect(pageSource).toContain('VoiceprintEnrollmentGate')
  expect(pageSource).toContain(':voiceprint-ready="voiceprintReady"')
})
```

- [ ] **Step 2: Run the test to verify RED**

Run: `npm test -- --run src/components/TemplateDrivenInterrogationPage.test.ts`

Expected: FAIL because the page has no enrollment-gate component or readiness prop.

- [ ] **Step 3: Create the minimal gate component**

The component accepts microphone source, secure-context state, suspect name, readiness, enrollment state, and busy state. It renders `VoiceprintAudioSourceBanner`, the existing usable-speech progress meter, and only start/stop suspect enrollment controls. It emits `suspectStart` and `suspectStop`; it has no officer selector or role-binding control.

- [ ] **Step 4: Run the gate and page tests to verify GREEN**

Run: `npm test -- --run src/components/VoiceprintEnrollmentGate.test.ts src/components/TemplateDrivenInterrogationPage.test.ts`

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add webapp/src/components/VoiceprintEnrollmentGate.vue webapp/src/components/VoiceprintEnrollmentGate.test.ts webapp/src/components/TemplateDrivenInterrogationPage.test.ts
git commit -m "feat: add inline suspect voiceprint gate"
```

### Task 2: Replace the former middle-column preparation stack

**Files:**
- Modify: `webapp/src/components/TemplateDrivenInterrogationPage.vue`
- Modify: `webapp/src/views/InterrogationWorkspace.vue`
- Modify: `webapp/src/components/TemplateDrivenInterrogationPage.test.ts`

- [ ] **Step 1: Extend the failing page contract**

```ts
it('releases the dialogue panel after enrollment and removes the middle preparation stack', () => {
  expect(pageSource).toContain('v-if="!voiceprintReady"')
  expect(pageSource).toContain('<LiveDialoguePanel')
  expect(workspaceSource).not.toContain('voiceprint-prep-stack')
  expect(workspaceSource).not.toContain('<VoiceprintPreparationPanel')
})
```

- [ ] **Step 2: Run the test to verify RED**

Run: `npm test -- --run src/components/TemplateDrivenInterrogationPage.test.ts`

Expected: FAIL because `InterrogationWorkspace` currently renders the source banner and preparation panel above the two-column page.

- [ ] **Step 3: Wire the state transition**

`TemplateDrivenInterrogationPage` receives readiness, enrollment state, source fields, and enrollment handlers. At the right-column location, render `VoiceprintEnrollmentGate` when `!voiceprintReady`; otherwise render the existing `LiveDialoguePanel`. In `InterrogationWorkspace`, remove the `voiceprint-prep-stack` block and forward the existing `autoVoiceprint` and store values. Keep `SessionControls` disabled by `voiceprintStartGuard` until enrollment is ready.

- [ ] **Step 4: Run the test to verify GREEN**

Run: `npm test -- --run src/components/TemplateDrivenInterrogationPage.test.ts`

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add webapp/src/components/TemplateDrivenInterrogationPage.vue webapp/src/views/InterrogationWorkspace.vue webapp/src/components/TemplateDrivenInterrogationPage.test.ts
git commit -m "feat: gate live dialogue on suspect enrollment"
```

### Task 3: Validate and ship

**Files:**
- Test: `webapp/src/components/VoiceprintEnrollmentGate.test.ts`

- [ ] **Step 1: Add the failing content test**

```ts
it('contains source and enrollment controls but no police controls', () => {
  expect(source).toContain('VoiceprintAudioSourceBanner')
  expect(source).toContain('完成录入后即可开始审讯')
  expect(source).not.toContain('选择主审民警声纹')
  expect(source).not.toContain('选择记录民警声纹')
})
```

- [ ] **Step 2: Run it to verify RED, then add the minimal copy and scoped CSS**

Run: `npm test -- --run src/components/VoiceprintEnrollmentGate.test.ts`

Expected before implementation: FAIL. Expected after implementation: PASS.

- [ ] **Step 3: Run the full frontend verification**

Run: `npm test && npm run build`

Expected: all Vitest tests pass and Vite reports `built`.

- [ ] **Step 4: Publish and verify RK3588 production**

Publish one fast-forward commit to `linux-adaptation`, wait for the existing RK3588 production redeploy, then verify the release SHA, HTTPS Vue shell, and both `interrogation-api` and `ai-worker` services are active.
