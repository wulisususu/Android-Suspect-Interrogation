# Linux Release Hardening Design

## Goal

Make the Linux migration reliably installable, startable, upgradeable, testable, rollback-capable, auditable, and verifiable on RK3588 without downloading or modifying model weights.

## Scope

Primary changes live in `.github/workflows/**`, `deploy/**`, `scripts/**`, `systemd/**`, Linux integration tests, and release/security documentation. Backend/frontend changes are limited to health/readiness, maintenance-state UX, and security defaults.

## Release layout

The runtime uses four separated classes of paths:

- `/opt/suspect-interrogation/app` — immutable release code, versioned under `releases/<sha>` and switched through `current`.
- `/var/lib/suspect-interrogation` — SQLite database, generated reports, signatures, attachments, and mutable state.
- `/etc/suspect-interrogation` — environment and operator configuration.
- `/opt/suspect-interrogation/models` — model weights managed outside this release task.
- `/var/log/suspect-interrogation` — optional application log files; systemd journal remains the primary service log.

No business service runs as root. Installation may require root to create users/directories and install units.

## Health model

Expose:

- `GET /health/live`: process liveness only; returns 200 while the API event loop is serving.
- `GET /health/ready`: operational dependencies and capabilities.

Readiness separates required dependencies from optional capabilities. Required checks are storage and configured database reachability. Hardware and AI are reported as capabilities with states such as `READY`, `UNAVAILABLE`, and `NOT_INSTALLED`; missing model weights must not make the API unhealthy.

The API defaults to loopback binding through systemd/environment configuration. LAN exposure is opt-in.

## Service model

Systemd units:

- `interrogation-api.service` — FastAPI/uvicorn, loopback by default, restart-on-failure, hardened filesystem and privilege settings.
- `ai-worker.service` — optional offline AI worker; failure does not prevent API liveness, and missing model assets may leave this unit disabled/not started.
- `kiosk.service` — waits for `/health/ready`, then launches a browser in kiosk mode. If readiness is unavailable, the web application still renders a maintenance page rather than a blank screen.

## Deployment model

`deploy/control.sh` is the stable operator interface:

- `install`
- `deploy <source-or-release>`
- `upgrade <source-or-release>`
- `health`
- `rollback [release]`
- `status`
- `backup`
- `restore <archive>`

Deployments stage a new release directory, create/update a virtual environment, build the Vue app, run validation, atomically switch `current`, restart services, and roll back the symlink if post-deploy health fails.

## Backup model

SQLite backups use SQLite's online backup mechanism (or `.backup`) rather than copying a live database file. A backup contains a timestamped manifest and SHA-256 checksums. Retention is configurable. Restore validates the archive/checksums and runs `PRAGMA integrity_check` before replacing live data.

## CI model

Linux CI is path-scoped to `.github/workflows/**`, `linux/**`, `webapp/**`, `deploy/**`, `scripts/**`, `systemd/**`, and release/security docs.

Hosted Linux stages:

1. backend import
2. Python tests
3. DB migration/SQLite integrity test
4. API contract tests
5. hardware mock tests
6. AI mock tests
7. Vue typecheck
8. Vue build
9. integration test

RK3588 stage uses self-hosted label `rk3588` and a bounded checkout pattern: partial clone, sparse checkout, HTTP/1.1, low-speed detection, 120-second fetch bound, and bounded retry. It performs architecture/runner identity checks, import/tests, service/deploy script syntax, web build when toolchain is available, and smoke health checks without model downloads.

## Security model

- API service binds to `127.0.0.1` by default.
- No wildcard CORS by default.
- Debug mode and tracebacks are not enabled in production units.
- Environment files are root-owned and not world-readable.
- Mutable PII directories are service-user owned and mode-restricted.
- Service hardening includes `NoNewPrivileges`, private temporary directories, filesystem protection, capability bounding, and explicit writable paths.
- Operational logging guidance prohibits raw ID numbers, signature payloads, audio content, and full report bodies.

## Audit and evidence integrity

Release hardening documents the required append-only audit events and enforces the signing rule at the release/test layer: canonicalized signed content produces SHA-256, a frozen version is immutable, and any edit after freeze produces a new revision/hash/signature cycle. This branch does not take ownership of other agents' core business persistence implementation.

## E2E

A mock E2E harness validates the release plumbing for the sequence: boot → create case → identity mock → session start → recording/ASR/AI mocks → edit/revision/mark → pause/resume → finish → freeze → signature mock → report → restart → persistence verification → backup → restore.

Where the current business backend does not yet expose a required endpoint, the release test marks that contract explicitly rather than inventing business behavior.

## Reliability acceptance

Automated or scripted checks cover backend crash/restart, optional AI worker failure, WebSocket reconnect contract, database/SQLite availability, unavailable device capability, low disk readiness, and flaky GitHub fetch behavior.

## Non-goals

- Downloading ASR/OCR/LLM weights.
- Replacing core interrogation, identity, report, signing, or AI business implementations owned by the other Linux migration branches.
