# Append-Only Audit Event Contract

## Invariant

The business `AuditLog` implementation must be append-only. Existing events are never edited or deleted through ordinary application APIs. Corrections are represented by a later event that references the earlier event/revision.

This release-hardening branch defines and tests the contract but intentionally does not replace the core persistence implementation owned by the backend workstream.

## Minimum event set

The backend must append an event for at least:

| Event | Minimum non-PII metadata |
| --- | --- |
| `case_created` | case ID, actor/operator ID, timestamp |
| `identity_read` | case ID, device/result category; never raw ID number in log message |
| `session_start` | case/session ID |
| `session_pause` | case/session ID, reason code if available |
| `session_resume` | case/session ID |
| `message_edit` | message ID, previous revision ID, new revision ID |
| `revision_created` | entity ID, revision/version |
| `freeze` | document version and SHA-256 |
| `sign` | frozen version/hash, signer role/reference, signature record ID |
| `report` | frozen version/hash and report record ID |
| `configuration_admin_operation` | operation type, actor, changed setting names; never secret values |

Additional useful events include device availability changes, backup creation, restore execution, failed authorization attempts, and release upgrade/rollback actions.

## Storage requirements

- Append-only semantics at the application layer.
- Stable monotonic event ID or sequence per database.
- UTC timestamp recorded by the server process.
- Actor and case/session correlation when applicable.
- Structured payload with an explicit schema/version.
- PII minimization: payload references data records rather than duplicating sensitive content.
- Backup/restore includes the audit store.

## Verification requirements

E2E must prove that events for the normal case lifecycle occur in order and remain after a service restart. Core-backend tests should additionally prove attempts to mutate a prior audit event are rejected once its persistence implementation lands.
