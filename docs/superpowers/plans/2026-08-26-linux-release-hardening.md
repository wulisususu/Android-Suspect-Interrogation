# Linux Release Hardening Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship repeatable Linux/RK3588 release plumbing for CI, services, deploy/upgrade/rollback, health, backup/restore, security, and mock E2E without touching model weights.

**Architecture:** Keep business logic in `linux/backend` and `webapp`, put release mechanics in dedicated `deploy/`, `scripts/`, and `systemd/` units, and gate changes through hosted Linux CI plus a self-hosted RK3588 smoke stage. Use atomic release symlink switching and SQLite-aware backups so upgrades and restores are reversible.

**Tech Stack:** Bash, systemd, Python 3/FastAPI/pytest, SQLite, Vue 3/TypeScript/Vite, GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-08-26-linux-release-hardening-design.md`

## Global Constraints

- Base branch: `linux-adaptation`.
- Working branch: `linux-release-hardening`.
- Offline runtime: no cloud API dependency.
- Do not download or modify ASR/OCR/LLM model weights.
- Default API bind: `127.0.0.1`; LAN exposure must be explicit configuration.
- Business services must not run as root.
- Missing model assets are `NOT_INSTALLED` capability state, not API unhealthiness.
- RK3588 checkout uses bounded retry, partial clone, sparse checkout, 120-second fetch timeout, HTTP/1.1, and low-speed detection.

---

### Task 1: Health contract tests first

**Files:**
- Create: `linux/backend/tests/test_health_contract.py`
- Create: `linux/backend/tests/test_capability_health.py`

**Interfaces:**
- Consumes: `linux.backend.app.main:app`.
- Produces: `/health/live`, `/health/ready`, and capability-state contract.

- [ ] **Step 1: Write failing tests** asserting `/health/live` returns 200 and `/health/ready` contains `status`, `checks`, and `capabilities`, with absent AI model represented as `NOT_INSTALLED` without changing overall readiness to failure.
- [ ] **Step 2: Run** `python -m pytest linux/backend/tests/test_health_contract.py linux/backend/tests/test_capability_health.py -q` and verify failure is caused by missing endpoints/module behavior.
- [ ] **Step 3: Implement minimal health module** in `linux/backend/app/health.py` and wire routers in `linux/backend/app/main.py`.
- [ ] **Step 4: Re-run tests** and require PASS.
- [ ] **Step 5: Commit** health implementation and tests.

### Task 2: Security defaults and production configuration

**Files:**
- Create: `linux/backend/app/runtime_settings.py`
- Create: `linux/backend/tests/test_runtime_security.py`
- Modify: `linux/backend/app/main.py`

**Interfaces:**
- Produces: environment-driven bind/CORS/debug settings with loopback/no-wildcard defaults.

- [ ] **Step 1: Write failing tests** for loopback bind, `debug=False`, and empty CORS allowlist by default.
- [ ] **Step 2: Run** the tests and verify they fail because settings do not exist.
- [ ] **Step 3: Implement** `RuntimeSettings` with `SUSPECT_API_HOST=127.0.0.1`, `SUSPECT_API_PORT=8000`, `SUSPECT_DEBUG=false`, and explicit CORS parsing.
- [ ] **Step 4: Re-run** security and health tests.
- [ ] **Step 5: Commit** security defaults.

### Task 3: Deployment and release control

**Files:**
- Create: `deploy/control.sh`
- Create: `deploy/lib/common.sh`
- Create: `deploy/lib/release.sh`
- Create: `deploy/suspect-interrogation.env.example`
- Create: `scripts/check-release.sh`
- Create: `tests/release/test_control_shell.sh`

**Interfaces:**
- `deploy/control.sh install|deploy|upgrade|health|rollback|status|backup|restore`.
- Release symlink: `/opt/suspect-interrogation/current`.

- [ ] **Step 1: Write shell contract test** that sources only temp paths and verifies command parsing plus atomic symlink rollback behavior.
- [ ] **Step 2: Run** `bash tests/release/test_control_shell.sh` and verify failure before scripts exist.
- [ ] **Step 3: Implement** idempotent directory/user setup, virtualenv dependency install, web build, release staging, atomic `ln -sfn` switch, service restart, health gate, and automatic rollback on failed health.
- [ ] **Step 4: Run** `bash -n` over all release scripts and execute the contract test.
- [ ] **Step 5: Commit** deploy control.

### Task 4: SQLite-safe backup and restore

**Files:**
- Create: `scripts/backup.sh`
- Create: `scripts/restore.sh`
- Create: `tests/release/test_backup_restore.py`

**Interfaces:**
- Backup archive contains SQLite online backup, mutable data payload, `manifest.sha256`, and metadata.
- Restore validates checksums and SQLite integrity before replacement.

- [ ] **Step 1: Write failing Python test** that creates a WAL-mode SQLite DB, performs a backup while a connection is open, mutates live DB, restores backup, and verifies the snapshot rows and `PRAGMA integrity_check`.
- [ ] **Step 2: Run** test and verify scripts are missing.
- [ ] **Step 3: Implement** backup with Python `sqlite3.Connection.backup`, timestamped archive, checksum manifest, retention, and restore verification.
- [ ] **Step 4: Re-run** backup/restore test.
- [ ] **Step 5: Commit** backup/restore.

### Task 5: systemd units and kiosk startup

**Files:**
- Create: `systemd/interrogation-api.service`
- Create: `systemd/ai-worker.service`
- Create: `systemd/kiosk.service`
- Create: `scripts/kiosk-launch.sh`
- Create: `tests/release/test_systemd_units.py`

**Interfaces:**
- API unit uses non-root `suspect-interrogation`, `EnvironmentFile=/etc/suspect-interrogation/runtime.env`, restart-on-failure, and explicit writable paths.
- Kiosk waits for readiness and launches configured Chromium binary/URL.

- [ ] **Step 1: Write failing static tests** checking `User=`, `Group=`, `WorkingDirectory=`, `EnvironmentFile=`, `Restart=`, hardening directives, and no `0.0.0.0` hard-code.
- [ ] **Step 2: Run** tests and verify units are absent.
- [ ] **Step 3: Implement** hardened units and kiosk readiness loop.
- [ ] **Step 4: Re-run** unit tests and `systemd-analyze verify` when available.
- [ ] **Step 5: Commit** systemd runtime.

### Task 6: Web maintenance state

**Files:**
- Create: `webapp/src/components/MaintenanceGate.vue`
- Create: `webapp/src/api/health.ts`
- Create: `webapp/src/components/MaintenanceGate.test.ts`
- Modify: `webapp/src/App.vue`

**Interfaces:**
- UI polls `/health/ready`; backend failure renders a maintenance panel and retry affordance while keeping the page shell visible.

- [ ] **Step 1: Write failing Vitest** for maintenance rendering when readiness fetch fails.
- [ ] **Step 2: Run** targeted Vitest and verify component is absent.
- [ ] **Step 3: Implement** health client and gate without changing existing business pages.
- [ ] **Step 4: Run** `npm test`, `npm run typecheck`, and `npm run build`.
- [ ] **Step 5: Commit** maintenance state.

### Task 7: Linux CI and RK3588 smoke

**Files:**
- Create: `.github/workflows/linux-ci.yml`
- Create: `scripts/ci/resilient-checkout.sh`
- Create: `scripts/ci/rk3588-smoke.sh`

**Interfaces:**
- Hosted job chain: backend-import → Python tests → DB/backup test → API contract → hardware mock → AI mock → Vue typecheck/build → integration.
- RK3588 job: `[self-hosted, rk3588]`, bounded sparse checkout and smoke.

- [ ] **Step 1: Add workflow after tests exist** so first run exercises real contracts.
- [ ] **Step 2: Validate YAML/shell syntax** and ensure path filters cover `linux/**`, `webapp/**`, release directories, and workflow itself.
- [ ] **Step 3: Implement resilient checkout** with five bounded 120s attempts, HTTP/1.1, low-speed limit/time, partial clone, sparse checkout, and exact-SHA verification.
- [ ] **Step 4: Push and inspect hosted + RK3588 jobs**; collect job IDs/log excerpts.
- [ ] **Step 5: Commit** CI evidence docs after successful run.

### Task 8: Mock E2E and reliability suite

**Files:**
- Create: `tests/e2e/test_release_e2e.py`
- Create: `tests/reliability/test_release_faults.py`
- Create: `docs/release/E2E-CONTRACT.md`

**Interfaces:**
- Mock release-state harness models create case through restore without requiring model weights or physical devices.

- [ ] **Step 1: Write failing E2E state-contract test** covering boot, case, identity, session, recording, ASR, messages, AI, edit, revision, mark, pause/resume, finish, freeze, signature, report, restart, backup, restore.
- [ ] **Step 2: Implement only release-side mock fixtures/state persistence** necessary to test restart and backup plumbing; do not replace business APIs.
- [ ] **Step 3: Add reliability assertions** for backend restart, AI unavailable, reconnect retry contract, DB unavailable, device unavailable, low disk, and flaky checkout retry.
- [ ] **Step 4: Run** E2E/reliability tests.
- [ ] **Step 5: Commit** E2E/reliability suite.

### Task 9: Security, audit, signing and release documentation

**Files:**
- Create: `docs/security/LINUX-HARDENING.md`
- Create: `docs/security/AUDIT-EVENTS.md`
- Create: `docs/security/SIGNED-SNAPSHOT.md`
- Create: `docs/release/RK3588-EVIDENCE.md`
- Create: `docs/release/RELEASE-CHECKLIST.md`

**Interfaces:**
- Audit event catalog is append-only by requirement.
- Signed snapshot contract: canonical document → SHA-256 → frozen version → signature binding → immutable signed snapshot; post-freeze edits require new version/hash/signature.

- [ ] **Step 1: Document** PII logging prohibitions, file modes, bind/CORS/debug defaults, LAN opt-in, audit event set, and signing invariants.
- [ ] **Step 2: Record** exact workflow run/job IDs, runner identity, architecture, commit SHA, and smoke results.
- [ ] **Step 3: Complete** operator release checklist including install, health, upgrade, rollback, backup, restore, disk-space, permissions, and offline-model checks.
- [ ] **Step 4: Run** all static checks/tests again.
- [ ] **Step 5: Commit** release evidence and checklist.

### Task 10: Final verification

- [ ] Run hosted Linux CI and require all hosted jobs green.
- [ ] Require RK3588 self-hosted smoke green, or document the exact external runner/connectivity blocker with logs if GitHub cannot schedule/reach the runner.
- [ ] Fetch combined commit status and workflow jobs/logs.
- [ ] Compare `linux-adaptation...linux-release-hardening` and inspect changed-file scope for accidental model/core-business edits.
- [ ] Record final commit SHA and PR/branch URL in the completion report.
