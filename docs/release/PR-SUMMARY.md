# Linux Release Hardening PR Summary

## Scope

This branch hardens the Linux release/runtime path for RK3588 without modifying model weights or taking ownership of core business migration work.

## Delivered

- Linux hosted CI and RK3588 self-hosted smoke workflow.
- Bounded resilient checkout with partial clone, sparse checkout, retries, HTTP/1.1 and low-speed detection.
- Non-root hardened systemd units for API, optional AI worker, and kiosk.
- Standard release directories and environment template.
- Idempotent install/deploy/upgrade/health/rollback/status/backup/restore control commands.
- `/health/live` and `/health/ready` with storage/database checks and optional hardware/AI capabilities.
- Missing local model assets report `NOT_INSTALLED` without making the API unavailable.
- SQLite online backup, checksums, retention, restore verification and restore path hardening.
- Web maintenance gate when backend readiness is unavailable.
- Mock E2E/reliability coverage for release-side failure modes.
- Linux security, audit-event, signed-snapshot, RK3588 evidence, deployment and release checklist documentation.

## Release gate

Do not merge/release on static review alone. Require `Linux hosted gate` and `RK3588 smoke` to complete successfully, then record exact run/job evidence in `docs/release/RK3588-EVIDENCE.md`.
