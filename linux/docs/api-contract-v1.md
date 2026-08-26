# Linux Suspect Interrogation API Contract v1

## 1. Scope

This contract is authoritative for the standalone Linux runtime. `linux/backend` owns persistence, workflow validation, evidence revisions, device abstraction, signature/document state and WebSocket synchronization. Runtime operation is offline; cloud AI endpoints are not part of this contract.

Base path:

```text
/api/v1
```

Legacy browser aliases under `/api/...` and `/work/...` remain temporarily supported and are documented in `docs/linux-runtime-contract.md`.

## 2. Common HTTP envelope

Successful response:

```json
{
  "ok": true,
  "code": "OK",
  "message": "OK",
  "data": {}
}
```

Domain error:

```json
{
  "ok": false,
  "code": "CASE_NOT_FOUND",
  "message": "案件不存在",
  "data": null
}
```

Status policy:

- `400` invalid business input (speaker, stage, mark, fact status, empty content)
- `404` entity/route not found
- `409` illegal workflow/session/device state
- `422` Pydantic request validation (`VALIDATION_ERROR`)
- `500` unexpected server failure

## 3. Case

### Create

```http
POST /api/v1/cases
Content-Type: application/json
```

```json
{
  "operator_id": "operator001",
  "case_type": "suspect_interrogation",
  "suspectName": "待录入",
  "officerName": "当前警官"
}
```

New persisted cases start at `workflowState=IDENTITY_REQUIRED`.

### List

```http
GET /api/v1/cases?limit=100
```

### Detail

```http
GET /api/v1/cases/{case_id}
```

### Update

```http
PUT /api/v1/cases/{case_id}
```

Accepted profile fields include `operator_id`, `case_type`, `suspectName`, `gender`, `age`, `officerName`, and a validated UI `stage`.

## 4. Identity

### Hardware status

```http
GET /api/v1/identity/status
```

### Read identity

```http
POST /api/v1/identity/read
```

```json
{
  "case_id": "CASE-...",
  "actor_id": "operator001"
}
```

When the adapter is connected/simulated, identity data is persisted in `persons`, a `device_events` entry is stored, an audit entry is written and `IDENTITY_REQUIRED -> IDENTITY_READY` is applied. With no hardware adapter, return HTTP `409` / `DEVICE_NOT_CONNECTED`; the backend must never fabricate a real-device success.

## 5. Interrogation session

### State

```http
GET /api/v1/cases/{case_id}/session
```

### Start

```http
POST /api/v1/cases/{case_id}/session/start
```

Canonical v1 requires identity readiness. Start legally advances `IDENTITY_READY -> CASE_CREATED -> QUESTIONING` and creates a `RUNNING` session.

### Pause / resume / finish

```http
POST /api/v1/cases/{case_id}/session/pause
POST /api/v1/cases/{case_id}/session/resume
POST /api/v1/cases/{case_id}/session/finish
```

- pause: `QUESTIONING -> PAUSED`, session status `PAUSED`
- resume: `PAUSED -> QUESTIONING`, session status `RUNNING`
- finish: `QUESTIONING|PAUSED -> SUMMARY`, session status `COMPLETED`

### UI stage

```http
POST /api/v1/cases/{case_id}/session/stage
```

```json
{ "stage": "STATEMENT", "actor_id": "operator001" }
```

Allowed UI stages: `IDENTITY`, `STATEMENT`, `FOLLOW_UP`, `SIGNING`.

## 6. Messages / QA evidence

### List

```http
GET /api/v1/cases/{case_id}/messages?limit=1000
```

### Create

```http
POST /api/v1/cases/{case_id}/messages
```

```json
{
  "speaker": "民警",
  "text": "你叫什么名字？",
  "actor_id": "operator001"
}
```

Allowed formal speakers are `民警` and `嫌疑人`. A running session is required.

### Revise

```http
PUT /api/v1/cases/{case_id}/messages/{message_id}
```

```json
{
  "text": "请说明你的姓名。",
  "reason": "核对录音",
  "actor_id": "operator001"
}
```

Evidence rule: `message_id` is immutable. An edit inserts one `message_revisions` row with old/new text, version, actor and reason, updates the current text/version on the same message row, and creates a `QA_UPDATE` audit entry. A no-op edit returns `409 NO_MESSAGE_CHANGE`.

### Mark

```http
POST /api/v1/cases/{case_id}/messages/{message_id}/mark
```

```json
{ "mark": "conflict" }
```

Allowed marks: empty, `conflict`, `confirmed`, `pending`, `highlight`. Marking updates the same message and creates `QA_MARK`; it never inserts a replacement message.

### Revisions

```http
GET /api/v1/cases/{case_id}/messages/{message_id}/revisions
GET /api/v1/cases/{case_id}/revisions
```

## 7. Facts

```http
GET /api/v1/cases/{case_id}/facts
PUT /api/v1/cases/{case_id}/facts/{fact_key}
```

Update example:

```json
{
  "value": "20:00",
  "status": "confirmed",
  "suggestion": "已与监控时间核对",
  "actor_id": "operator001"
}
```

Allowed statuses: `confirmed`, `pending`, `conflict`, `missing`.

## 8. Timeline

```http
GET /api/v1/cases/{case_id}/timeline
POST /api/v1/cases/{case_id}/timeline
```

```json
{
  "time": "20:00",
  "title": "到达",
  "detail": "到达现场",
  "evidence": ["CAM-1"],
  "actor_id": "operator001"
}
```

## 9. Audit

```http
GET /api/v1/cases/{case_id}/audit?limit=200
```

Each row exposes action, target, actor, timestamp plus `before`, `after`, and `detail` objects.

## 10. Device gateway

```http
GET /api/v1/device/status
POST /api/v1/device/action
```

```json
{ "type": "identity" }
```

Default production behavior without a concrete driver is `409 DEVICE_NOT_CONNECTED`. `DEVICE_SIMULATOR=1` enables deterministic test-only responses.

## 11. Document / signature / report

### Document state

```http
GET /api/v1/cases/{case_id}/document/status
```

### Freeze

```http
POST /api/v1/cases/{case_id}/document/freeze
```

Only `SUMMARY` may freeze. The backend stores a versioned `DocumentSnapshot` containing the case/messages/facts payload and SHA-256 content hash, then transitions to `FROZEN`.

### Signature

```http
GET /api/v1/cases/{case_id}/signatures
POST /api/v1/cases/{case_id}/signatures
```

```json
{
  "signer_role": "suspect",
  "signer_name": "张三",
  "image_data": "data:image/png;base64,...",
  "strokes_json": "[]",
  "actor_id": "operator001"
}
```

A frozen snapshot is required. Saving a signature transitions `FROZEN -> SIGNED`.

### Report generated

```http
POST /api/v1/cases/{case_id}/report/generated
```

Requires `SIGNED`; transitions to `REPORT_GENERATED` and sets `reportStatus=GENERATED`.

## 12. Workflow state machine

Canonical states:

```text
INIT
 -> IDENTITY_REQUIRED
 -> IDENTITY_READY
 -> CASE_CREATED
 -> QUESTIONING
 -> PAUSED -> QUESTIONING
 -> SUMMARY
 -> FROZEN
 -> SIGNED
 -> REPORT_GENERATED
```

Also legal: `QUESTIONING -> SUMMARY`, `PAUSED -> SUMMARY`.

All other jumps are rejected with HTTP `409` / `INVALID_STATE_TRANSITION` or a more specific session/document guard error. Direct arbitrary assignment through the public API is not permitted.

## 13. WebSocket v1

Endpoint:

```text
/ws/interrogation/{session_id}
```

Server/client envelope:

```json
{
  "session_id": "session-uuid",
  "event": "STATE_SYNC",
  "seq": 1,
  "timestamp": "2026-08-26T00:00:00+00:00",
  "payload": {}
}
```

On every connect/reconnect the server reads SQLite and immediately sends `STATE_SYNC` containing the persisted session, messages and document state.

Supported client events:

- `STATE_SYNC_REQUEST`
- `DEVICE_EVENT`
- `ASR_FRAGMENT`
- `USER_TEXT`
- `RECORDING_STATE`
- `SIGNATURE_STATE`

Server events include:

- `STATE_SYNC`
- `AI_RESPONSE`
- the accepted broadcast device/ASR/recording/signature event names
- `PROTOCOL_ERROR`

`USER_TEXT` is routed through the configured offline AI gateway. Until real model weights are supplied, the deterministic mock adapter returns a repeatable network-free `AI_RESPONSE`.

In-memory WebSocket registries are transport-only. Persisted business truth and reconnect recovery come from SQLite.

## 14. Persistence and migration

The authoritative SQLite schema contains:

- `cases`
- `persons`
- `interrogation_sessions`
- `messages`
- `message_revisions`
- `facts`
- `timeline_events`
- `audit_logs`
- `device_events`
- `document_snapshots`
- `signature_records`

SQLAlchemy 2.x is the ORM/persistence API. Alembic is the migration mechanism. SQLite foreign keys are enabled; WAL mode is used by the application engine. Data is expected to survive process restart.
