# Offline Mock E2E Contract

The release E2E is intentionally model-free and device-free. It validates release, persistence, evidence-integrity, restart, backup and restore plumbing while other workstreams own the real ASR/AI/hardware implementations.

## Required lifecycle

```text
boot
-> create case
-> identity mock
-> session start
-> recording mock
-> ASR mock
-> messages
-> AI mock
-> edit
-> revision
-> mark
-> pause/resume
-> finish
-> freeze
-> signature mock
-> report
-> restart services / reopen DB
-> verify data
-> backup
-> restore
```

`scripts/mock_e2e.py` performs this flow against a temporary SQLite state directory. It never downloads a model and reports `model_downloads=0`.

## Integrity assertions

- The case survives a simulated service restart (database close/reopen).
- Freeze uses deterministic canonical JSON and SHA-256.
- Mock signature is explicitly bound to the frozen digest.
- Report metadata references the same digest.
- Backup is generated through `scripts/backup.sh`.
- Live state is deliberately damaged before restore.
- Restore recovers the case, digest and signature.
- `PRAGMA integrity_check` returns `ok` after restore.

## Business API boundary

The current `linux/backend` skeleton does not yet expose every production endpoint required to drive the complete lifecycle through HTTP. The release E2E therefore does not invent substitute business endpoints. When backend work adds those APIs, an HTTP-level E2E should be layered on top while retaining this storage/recovery test.
