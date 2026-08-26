# Linux Runtime Security Hardening

## Security posture

This Linux kiosk is designed for a single-machine, offline RK3588 deployment handling identity-card data, interrogation transcripts, signatures, audio-derived text, and reports. The default posture is therefore local-only and least-privilege.

## Network exposure

- `SUSPECT_API_HOST=127.0.0.1` is the production default.
- LAN exposure is opt-in through `/etc/suspect-interrogation/runtime.env`.
- CORS is disabled by default. Wildcard `*` origins are rejected by runtime settings.
- If LAN access is enabled, configure only the exact trusted kiosk/operator origins and apply host firewall rules outside the application.
- Production units do not enable FastAPI debug mode or developer tracebacks.

## Service identity

Business processes run as the dedicated system account `suspect-interrogation`, never as root. Root is used only by `deploy/control.sh install` to create the account, directories, configuration, and systemd unit files.

The API and AI units use:

- `NoNewPrivileges=true`
- `PrivateTmp=true`
- `ProtectSystem=strict`
- `ProtectHome=true`
- kernel/control-group protection
- empty capability bounding/ambient sets
- explicit `ReadWritePaths` limited to mutable data/log directories
- `UMask=0077`

The kiosk unit is similarly restricted and treats the current release tree as read-only.

## Filesystem separation and permissions

| Path | Purpose | Ownership / intent |
| --- | --- | --- |
| `/opt/suspect-interrogation/current` | active immutable release | root-managed, service-readable |
| `/opt/suspect-interrogation/releases/*` | versioned release history | root-managed |
| `/opt/suspect-interrogation/models` | externally managed model assets | not modified by release scripts |
| `/etc/suspect-interrogation` | runtime/operator configuration | root + service group, directory 0750 |
| `/etc/suspect-interrogation/runtime.env` | environment configuration | installed as 0640 |
| `/var/lib/suspect-interrogation` | DB, reports, signatures, attachments | service user/group, directory 0750 |
| `/var/log/suspect-interrogation` | optional file logs | service user/group, directory 0750 |

## PII logging policy

Application and operational logs MUST NOT contain raw or complete:

- PRC identity-card numbers or equivalent government identifiers;
- identity-card images or OCR payloads;
- signature image/base64/blob data;
- raw audio content;
- full interrogation/report bodies;
- authentication secrets, API tokens, private keys, or environment-file contents.

When an identifier is operationally necessary, log an opaque case/session ID. If a human identifier is unavoidable for diagnostics, log only an explicitly approved masked form.

Systemd journal is the primary service log. Do not enable shell tracing (`set -x`) in production deployment scripts because environment variables may contain sensitive values.

## Error handling

- `/health/live` reveals only process liveness.
- `/health/ready` reports dependency/capability states and terse diagnostic categories, not PII.
- Hardware errors are capability-level failures.
- Missing model weights are `NOT_INSTALLED`, not an API outage.
- Production responses must not expose Python stack traces.

## Report/signature permissions

Reports, signed snapshots, signatures, and attachments belong under `/var/lib/suspect-interrogation` and inherit restrictive service permissions. No release command grants world-readable permissions. Export to removable media or LAN shares requires a separate operator-controlled workflow and is outside this branch.

## Offline invariant

Runtime services have no cloud API dependency. This branch does not download ASR/OCR/LLM weights. Dependency download can occur during CI/build unless an offline wheel/npm cache is configured, but the installed runtime is designed to operate without internet access.
