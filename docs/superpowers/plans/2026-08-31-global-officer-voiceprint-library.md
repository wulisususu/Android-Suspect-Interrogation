# Global Officer Voiceprint Library Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Convert officer voiceprints into an independent system-level, multi-sample library with versioned aggregate references and immutable per-session reference snapshots.

**Architecture:** Replace the single mutable officer embedding with a profile + samples model. Each accepted enrollment appends a sample, rebuilds a normalized aggregate reference, and increments its version. Case role binding snapshots the aggregate so later global changes cannot alter an active/historical session.

**Tech Stack:** Python 3.11+, FastAPI, SQLAlchemy 2, Alembic, SQLite, Vue 3, TypeScript, Pinia/Vitest, FunASR/XVector speech worker.

**Spec:** `docs/superpowers/specs/2026-08-31-global-officer-voiceprint-library-design.md`

## Global Constraints

- Officer voiceprints are global system assets, not case-owned assets.
- Case pages only select/bind existing active officers.
- Existing officer samples must never be overwritten by a later enrollment.
- Raw voiceprint audio must not be persisted.
- Sample quality, capture time, source/device, model metadata and usable duration must be retained.
- New global changes must not mutate the reference used by an already-bound session.
- Legacy `officer_voiceprints` data must migrate without embedding loss.
- Production default audio input remains ALSA; browser input remains a LAN test path only.

---

### Task 1: Add migration contract tests and new persistence schema

**Files:**
- Create: `linux/backend/alembic/versions/0004_global_officer_voiceprint_library.py`
- Modify: `linux/backend/app/database/models.py`
- Modify: `linux/backend/tests/test_migrations.py`
- Create: `linux/backend/tests/test_officer_voiceprint_profiles.py`

**Interfaces:**
- Produces `OfficerVoiceProfile` and `OfficerVoiceSample` ORM models.
- Extends `SessionVoiceAssignment` with frozen profile/version/reference fields.

- [ ] **Step 1: Write failing persistence/migration tests** asserting profile/sample tables exist, `officer_id` is unique at profile level, multiple samples may reference one profile, legacy data migrates to one `LEGACY_MIGRATED` sample, and session assignments receive frozen legacy references.
- [ ] **Step 2: Run targeted tests**: `pytest linux/backend/tests/test_migrations.py linux/backend/tests/test_officer_voiceprint_profiles.py -q`; expected failure because 0004/models do not exist.
- [ ] **Step 3: Implement ORM models and Alembic 0004 migration**. Migration creates profiles/samples, migrates every legacy officer row, adds assignment snapshot columns, copies existing assignment references, then preserves compatibility while application code moves to profiles.
- [ ] **Step 4: Run targeted tests** and verify pass.
- [ ] **Step 5: Commit** `feat: add multi-sample officer voiceprint schema`.

### Task 2: Implement append-only samples and aggregate reference rebuilding

**Files:**
- Modify: `linux/backend/app/repositories/voiceprints.py`
- Modify: `linux/backend/app/services/voiceprint_service.py`
- Modify: `linux/backend/tests/test_voiceprint_repositories.py`
- Modify: `linux/backend/tests/test_voiceprint_service.py`

**Interfaces:**
- Produces repository functions `get_officer_profile`, `list_officer_profiles`, `add_officer_sample`, `disable_officer_sample`, `rebuild_officer_aggregate` and snapshot-aware role binding.
- `VoiceprintService.enroll_officer(...)` creates a profile plus sample; repeated enrollment calls `add_officer_sample(...)` instead of overwrite.

- [ ] **Step 1: Write failing tests** for two enrollments producing two sample rows, aggregate version increment, weighted normalized aggregate, sample disable/rebuild, last-active-sample unavailability, and non-destructive revocation.
- [ ] **Step 2: Run targeted repository/service tests**; expected failure on missing functions/new semantics.
- [ ] **Step 3: Implement repository operations and aggregation** using L2-normalized sample references and bounded quality/duration weights from the approved spec.
- [ ] **Step 4: Change service enrollment** so existing officers append samples, emit `OFFICER_VOICEPRINT_SAMPLE_ADD`, and return profile/sample metadata.
- [ ] **Step 5: Run targeted tests** and verify pass.
- [ ] **Step 6: Commit** `feat: aggregate multi-sample officer voiceprints`.

### Task 3: Freeze officer references at session binding and use snapshots for recognition

**Files:**
- Modify: `linux/backend/app/repositories/voiceprints.py`
- Modify: `linux/backend/app/services/voiceprint_service.py`
- Modify: `linux/backend/app/services/speaker_policy.py`
- Modify: `linux/backend/tests/test_speaker_policy.py`
- Modify: `linux/backend/tests/test_voiceprint_service.py`

**Interfaces:**
- `assign_session_roles(...)` copies profile aggregate bytes, dimension, model metadata and aggregate version into assignment snapshot fields.
- Speaker policy consumes the assignment snapshot first and never re-reads a changed global officer aggregate for an already-bound session.

- [ ] **Step 1: Write failing freeze tests**: bind officer at aggregate v1, append a sample to create v2, then assert the same session still classifies against its v1 snapshot while a new session binds v2.
- [ ] **Step 2: Run targeted tests**; expected failure because current policy dereferences global mutable voiceprints.
- [ ] **Step 3: Implement snapshot copying and snapshot-first recognition**.
- [ ] **Step 4: Extend binding audit detail** with interrogator/recorder aggregate versions.
- [ ] **Step 5: Run targeted tests** and verify pass.
- [ ] **Step 6: Commit** `feat: freeze officer references per interrogation session`.

### Task 4: Split global officer-library APIs from case role-binding APIs

**Files:**
- Modify: `linux/backend/app/api/voiceprints.py`
- Modify: `linux/backend/tests/test_voiceprint_api.py`
- Modify: `linux/backend/tests/test_voiceprint_browser_transport.py`

**Interfaces:**
- `GET /officer-voiceprints` returns profiles with sample count/version.
- `GET /officer-voiceprints/{officer_id}` returns profile + retained sample metadata.
- Existing enrollment start/stop appends a sample.
- New `DELETE /officer-voiceprints/{officer_id}/samples/{sample_id}` disables a sample rather than deleting it.
- Case `/voiceprints/assignments` remains selection/binding only.

- [ ] **Step 1: Write failing API tests** for profile detail, append-sample behavior, sample disable, source/device metadata, and no case ID required for global officer administration.
- [ ] **Step 2: Run targeted API tests**; expected failure on old single-row contract.
- [ ] **Step 3: Implement API contract** while preserving browser/ALSA enrollment transport.
- [ ] **Step 4: Run targeted tests** and verify pass.
- [ ] **Step 5: Commit** `feat: expose global officer voiceprint library api`.

### Task 5: Add system-level Officer Voiceprint Library UI

**Files:**
- Create: `webapp/src/views/SystemSettingsView.vue`
- Create: `webapp/src/components/OfficerVoiceprintLibrary.vue`
- Create: `webapp/src/api/officerVoiceprints.ts`
- Create: `webapp/src/components/OfficerVoiceprintLibrary.test.ts`
- Modify: `webapp/src/App.vue`
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/styles.css`

**Interfaces:**
- Top-level navigation supports `cases` and `settings` without a case ID.
- Officer library supports search, add sample, sample metadata display, sample disable, and profile revoke.
- Reuses existing voiceprint capture/browser transport components instead of creating a second audio pipeline.

- [ ] **Step 1: Write failing Vue tests** asserting the library is reachable with no case ID and exposes profile/sample administration.
- [ ] **Step 2: Run `npm test -- --run` in `webapp`**; expected failure because settings/library components do not exist.
- [ ] **Step 3: Implement API/types/settings/library UI** and top-level navigation.
- [ ] **Step 4: Run Vue tests, typecheck and build**.
- [ ] **Step 5: Commit** `feat: add system officer voiceprint library`.

### Task 6: Remove officer administration from case preparation

**Files:**
- Modify: `webapp/src/components/VoiceprintPreparationPanel.vue`
- Modify: `webapp/src/components/VoiceprintPreparationPanel.test.ts`
- Modify: `webapp/src/composables/useAutoVoiceprintEnrollment.ts`
- Modify: `webapp/src/views/InterrogationWorkspace.vue`

**Interfaces:**
- Case panel retains suspect enrollment, officer selectors, readiness, and role binding only.
- Officer enroll/update/revoke/sample-management events are removed from case component contracts.

- [ ] **Step 1: Update tests first** to require absence of officer ID/name inputs and administration buttons while retaining interrogator/recorder selectors.
- [ ] **Step 2: Run targeted Vue tests**; expected failure with current `officer-enrollment-box`.
- [ ] **Step 3: Remove case-local officer administration and obsolete event wiring**.
- [ ] **Step 4: Run Vue tests/typecheck/build**.
- [ ] **Step 5: Commit** `refactor: keep case voiceprint page binding-only`.

### Task 7: Full verification and documentation closeout

**Files:**
- Modify: `linux/docs/api-contract-v1.md`
- Modify: `docs/security/AUDIT-EVENTS.md`
- Modify: `docs/lan-browser-audio-testing.md` only if UI entry instructions need adjustment.

**Interfaces:**
- Documents global-vs-case ownership, append-only sample semantics, aggregate versions, and frozen assignment behavior.

- [ ] **Step 1: Run backend suite**: `pytest linux/backend/tests -q`.
- [ ] **Step 2: Run frontend suite**: `cd webapp && npm test -- --run && npm run build` plus project typecheck command.
- [ ] **Step 3: Run release/e2e gates** used by `linux-ci.yml`.
- [ ] **Step 4: Update docs/audit contract** with exact API/event behavior.
- [ ] **Step 5: Push final closeout commit** `docs: document global officer voiceprint lifecycle`.
- [ ] **Step 6: Verify GitHub Actions hosted Linux gate and RK3588 smoke are green before declaring completion.**
