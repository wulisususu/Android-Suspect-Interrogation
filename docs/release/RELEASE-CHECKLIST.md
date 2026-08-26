# RK3588 Linux Release Checklist

## Before release

- [ ] Target commit belongs to `linux-adaptation` or an approved release-hardening PR.
- [ ] Linux hosted CI is green: backend import, Python, DB gate, API contract, hardware mock, AI mock, Vue test/typecheck/build, integration.
- [ ] RK3588 self-hosted smoke is green on runner label `rk3588`.
- [ ] No model weights were added, downloaded, or modified by the release commit.
- [ ] `git diff` contains no unintended Android/core-business changes.
- [ ] Free disk is above `SUSPECT_MIN_FREE_MB` and has room for one additional release plus backup.
- [ ] `/opt/suspect-interrogation/models` contains only operator-provided assets required for enabled capabilities.

## Install / permissions

- [ ] `suspect-interrogation` system user/group exists.
- [ ] Business services run as that user, not root.
- [ ] `/etc/suspect-interrogation/runtime.env` is root-owned/group-readable and not world-readable.
- [ ] `/var/lib/suspect-interrogation` and `/var/log/suspect-interrogation` are service-owned and restrictive.
- [ ] API defaults to `127.0.0.1`; any LAN bind is an explicit reviewed choice.
- [ ] CORS contains explicit origins only; never `*`.
- [ ] Debug mode is disabled.

## Deploy

- [ ] `sudo ./deploy/control.sh install` completes idempotently.
- [ ] `sudo ./deploy/control.sh deploy <source>` creates a new release and atomically switches `current`.
- [ ] `systemctl is-active interrogation-api.service` is active.
- [ ] `/health/live` returns 200.
- [ ] `/health/ready` reports required checks `READY`.
- [ ] Missing AI model, if intentional, is shown as `NOT_INSTALLED` capability rather than API failure.
- [ ] Kiosk launches and does not show a blank screen while backend is unavailable.

## Functional / evidence

- [ ] Create-case → identity → session → recording/ASR → messages/AI → edit/revision/mark → pause/resume → finish path passes with the current core backend.
- [ ] Freeze produces a reproducible SHA-256 for a fixed canonical document.
- [ ] Signature binds to the frozen version/hash.
- [ ] Editing after freeze creates a new version/hash/signature cycle; old signed snapshot remains unchanged.
- [ ] Audit events are append-only and cover the minimum catalog.
- [ ] Report references the intended frozen version/hash.

## Reliability

- [ ] Kill API process and verify systemd restarts it.
- [ ] Stop/crash optional AI worker and verify API remains live.
- [ ] Force WebSocket disconnect and verify the current web client reconnect behavior.
- [ ] Unplug/disable test device and verify capability degradation without API crash.
- [ ] Simulate low disk threshold and verify readiness/preflight refusal.
- [ ] Validate GitHub fetch retry evidence on the self-hosted runner.

## Backup / rollback

- [ ] Create a fresh backup and record archive path/checksum.
- [ ] Verify backup archive checksum manifest.
- [ ] Run restore verification on a non-production copy or approved test state.
- [ ] `PRAGMA integrity_check` is `ok` after restore.
- [ ] Perform a controlled upgrade.
- [ ] Perform a controlled rollback and verify previous release/data compatibility.

## Final evidence

- [ ] Record release commit SHA.
- [ ] Record GitHub Actions workflow run ID and RK3588 job ID.
- [ ] Record runner name/architecture and smoke conclusion.
- [ ] Record any intentionally disabled capabilities.
- [ ] Archive this completed checklist with the release record.
