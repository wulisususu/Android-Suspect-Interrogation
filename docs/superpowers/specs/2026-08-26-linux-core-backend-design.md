# Linux Core Backend Design

## Goal

Turn `linux/backend` into the single production Linux backend for the interrogation system, independent from Android APK/Kotlin/Room/NativeBridge and capable of fully offline operation on RK3588.

## Non-negotiable constraints

- `linux/backend` is the only production Linux backend.
- `backend-dev` is a behavior/API oracle only; `backend-fastapi` is reference material only.
- No cloud AI and no model-weight download in this change.
- Preserve the existing Vue/browser workflow wherever possible.
- Use SQLite for single-device offline persistence.
- Use SQLAlchemy 2.x style and Alembic migrations.
- No production-path global dictionaries for persisted business state.
- All state-changing operations must be transactional and auditable.
- Final verification must run on the self-hosted RK3588 GitHub Runner.

## Architecture

`linux/backend/app` is split into explicit boundaries:

- `api/`: FastAPI routers and request/response schemas only.
- `domain/`: enums, domain errors, constants and business-value definitions.
- `database/`: SQLAlchemy engine/session/bootstrap and ORM entities.
- `repositories/`: persistence-only operations over ORM entities.
- `services/`: application use cases and transaction boundaries.
- `workflow/`: legal workflow state machine.
- `websocket/`: session-scoped connection manager, protocol envelope, sync/broadcast.
- `hardware_gateway/`: abstract/offline hardware adapter with deterministic mock implementation.
- `ai_gateway/`: abstract/offline AI adapter with deterministic mock implementation.
- `audit/`: audit-service helpers over the audit repository.
- `reporting/`: document freeze/report status integration.

The API layer never manipulates SQLAlchemy models directly. Services coordinate repositories and state transitions. Repositories never make workflow decisions.

## Persistence model

Required tables:

1. `cases`
2. `persons`
3. `interrogation_sessions`
4. `messages`
5. `message_revisions`
6. `facts`
7. `timeline_events`
8. `audit_logs`
9. `device_events`
10. `document_snapshots`
11. `signature_records`

All primary IDs are stable strings. Foreign keys are enabled. SQLite uses WAL mode and `PRAGMA foreign_keys=ON`. Timestamps are timezone-aware UTC datetimes. Database location is controlled by `DB_PATH` / `DATABASE_URL`; default is `linux/backend/data/suspect-interrogation.db` relative to the backend working directory.

## Message evidence semantics

A message has an immutable identity (`messages.id`). Editing a message does not create a replacement message.

Edit transaction:

1. Read the current message.
2. Reject missing/empty/no-op edits as appropriate.
3. Insert one `message_revisions` row containing old/new text, version, reason and actor.
4. Update only the current text/version metadata on the same `messages` row.
5. Insert an `audit_logs` row recording actor, timestamp, old/new values and revision ID.

Mark/highlight/conflict operations update metadata on the same message and create audit rows; they never create another message.

## Workflow

Canonical workflow states:

`INIT -> IDENTITY_REQUIRED -> IDENTITY_READY -> CASE_CREATED -> QUESTIONING -> PAUSED -> SUMMARY -> FROZEN -> SIGNED -> REPORT_GENERATED`

Allowed transitions additionally include `PAUSED -> QUESTIONING`. State changes must go through the state-machine validator. Invalid transitions return HTTP 409 with structured error code `INVALID_STATE_TRANSITION`.

Interrogation UI stages remain compatible with the old browser contract: `IDENTITY`, `STATEMENT`, `FOLLOW_UP`, `SIGNING`. Stage changes are independent of the canonical workflow state but are validated against the allowed stage enum.

## REST compatibility

Canonical API prefix: `/api/v1`.

Canonical endpoints include:

- `POST /api/v1/cases`
- `GET /api/v1/cases`
- `GET /api/v1/cases/{case_id}`
- `PUT /api/v1/cases/{case_id}`
- `GET /api/v1/identity/status`
- `POST /api/v1/identity/read`
- `GET /api/v1/cases/{case_id}/session`
- `POST /api/v1/cases/{case_id}/session/start|pause|resume|finish`
- `POST /api/v1/cases/{case_id}/session/stage`
- message create/list/update/mark/revisions
- facts list/update
- timeline list/create
- audit list
- signature submit/list
- document state/freeze/report status
- device status/action

Compatibility aliases are kept for the current browser client and legacy smoke oracle:

- `/api/cases/create`
- `/api/cases...`
- `/work/case/{case_id}/message`
- `/api/device/status`
- `/api/device/action`
- `/api/health`

Responses use a common envelope for compatibility: `{ "ok": true|false, "code": "...", "message": "...", "data": ... }` on legacy routes. Canonical v1 routes return the same envelope to remove ambiguity across clients.

## Identity and hardware gateway

No concrete vendor driver is added here. The gateway interface exposes status/read/action. Default mode is `not_connected`; optional deterministic mock mode is enabled with `DEVICE_SIMULATOR=1`. Real hardware absence returns 409 `DEVICE_NOT_CONNECTED`, never fake success.

A successful identity read persists a `Person`, links it to the case when a case ID is supplied, records a `DeviceEvent`, and advances `IDENTITY_REQUIRED -> IDENTITY_READY` where legal.

## AI gateway

No cloud endpoint or API-key settings route exists. A deterministic offline mock adapter is provided only to unblock WebSocket protocol/testing before model weights are supplied. It produces repeatable responses from input and is replaceable behind an interface.

## WebSocket protocol

Endpoint: `/ws/interrogation/{session_id}`.

Envelope:

```json
{
  "session_id": "...",
  "event": "STATE_SYNC",
  "seq": 1,
  "timestamp": "2026-08-26T00:00:00Z",
  "payload": {}
}
```

Behavior:

- accept/reconnect by session ID;
- monotonically increasing server sequence per session during process lifetime;
- send `STATE_SYNC` immediately after connect/reconnect from persisted DB state;
- broadcast accepted events to all peers for that session;
- support `STATE_SYNC_REQUEST`, `DEVICE_EVENT`, `ASR_FRAGMENT`, `USER_TEXT`, `AI_RESPONSE`, `RECORDING_STATE`, `SIGNATURE_STATE`;
- malformed envelopes return `PROTOCOL_ERROR` without crashing the socket.

Persistent business truth is in SQLite, so reconnect state does not depend on in-memory WebSocket dictionaries.

## Document/signature flow

`finish` advances a questioning session to `SUMMARY`. `freeze` persists a `DocumentSnapshot` and advances to `FROZEN`. `sign` persists a `SignatureRecord`; once the required signer entry is present, state advances to `SIGNED`. report-status update to generated advances to `REPORT_GENERATED`.

## Error contract

Domain failures map to structured JSON:

```json
{
  "ok": false,
  "code": "CASE_NOT_FOUND",
  "message": "案件不存在",
  "data": null
}
```

Expected status classes:

- 400 validation/business input error
- 404 missing entity/route
- 409 illegal workflow/session/device state
- 422 Pydantic request validation
- 500 unexpected internal error

## Test strategy

Test layers:

- unit: state machine and deterministic adapters;
- repository: CRUD, foreign keys, revisions, audit persistence;
- API: canonical v1 and compatibility routes;
- workflow: all legal/illegal transitions;
- revision/audit: stable message ID, revision creation, old/new audit data;
- restart persistence: create/edit/mark/pause/resume/finish/freeze, close app DB, recreate app against same SQLite file and verify state remains.

The required end-to-end test performs: create case -> identity mock -> start -> add Q/A -> edit -> verify revision -> mark -> pause -> resume -> finish -> freeze -> restart -> verify state/data.

## Out of scope

- Vue UI redesign.
- Concrete ID-card/fingerprint/signature-pad vendor drivers.
- Real ASR/LLM model integration or model downloads.
- systemd/deployment redesign.
