# Linux Runtime Contract

## Authority

For Linux deployments, **`linux/backend` is the only production backend**. The frontend must not depend on `backend-dev`, `backend-fastapi`, Android Room, Kotlin backend services or NativeBridge for Linux business persistence.

`backend-dev` remains a historical behavior oracle. `backend-fastapi` is reference material only.

## Runtime endpoints

Recommended production origin:

```text
http://127.0.0.1:18080
```

Canonical REST prefix:

```text
/api/v1
```

WebSocket:

```text
/ws/interrogation/{session_id}
```

Health:

```text
/health
```

## Existing Vue compatibility aliases

The current browser API calls remain supported by thin aliases over the exact same Linux services/database:

```text
GET  /api/health
POST /api/cases/create
GET  /api/cases
GET  /api/cases/{case_id}
PUT  /api/cases/{case_id}
GET  /work/case/{case_id}
GET  /work/case/{case_id}/message
POST /work/case/{case_id}/message
GET  /api/cases/{case_id}/messages
PUT  /api/cases/{case_id}/messages/{message_id}
POST /api/cases/{case_id}/messages/{message_id}/mark
GET  /api/cases/{case_id}/messages/{message_id}/revisions
GET  /api/cases/{case_id}/revisions
GET  /api/cases/{case_id}/facts
PUT  /api/cases/{case_id}/facts/{fact_key}
GET  /api/cases/{case_id}/timeline
POST /api/cases/{case_id}/timeline
GET  /api/cases/{case_id}/session
POST /api/cases/{case_id}/session/start
POST /api/cases/{case_id}/session/pause
POST /api/cases/{case_id}/session/resume
POST /api/cases/{case_id}/session/finish
POST /api/cases/{case_id}/session/stage
GET  /api/cases/{case_id}/audit
GET  /api/device/status
POST /api/device/action
```

The compatibility start route can bypass the new explicit identity-read prerequisite only to preserve the existing browser flow. The bypass is not silent: it writes audit action `IDENTITY_BYPASS_LEGACY_COMPAT`. New Linux frontend work should migrate to canonical `/api/v1` and call identity first.

## Response shape

Both canonical v1 and compatibility REST routes use:

```json
{
  "ok": true,
  "code": "OK",
  "message": "OK",
  "data": {}
}
```

Frontend code may keep its current `unwrap()` behavior.

## Message semantics the frontend may rely on

- `message.id` is stable forever.
- Editing returns the same `id` and increments `version`.
- Revision history is queryable and contains old/new text.
- `mark` modifies metadata on the same message.
- The backend records edit/mark audit entries.

The frontend must never interpret an edited message as a newly inserted Q/A row.

## Session compatibility fields

Session payload keeps the browser fields:

```text
id
caseId
status = READY | RUNNING | PAUSED | COMPLETED
stage  = IDENTITY | STATEMENT | FOLLOW_UP | SIGNING
startedAt
pausedAt
endedAt
updatedAt
```

It additionally exposes canonical workflow `state`.

## Case compatibility fields

Case payload keeps:

```text
id
suspectName
gender
age
officerName
state
stage
createdAt
updatedAt
```

It additionally exposes:

```text
case_id
operator_id
case_type
workflowState
documentStatus
reportStatus
```

## WebSocket expectations

Every server event contains:

```text
session_id
event
seq
timestamp
payload
```

On reconnect, the frontend should treat the first `STATE_SYNC` as authoritative and replace transient UI assumptions with its persisted session/messages/document state. Sequence numbers order server events during the current backend process; they are not persisted evidence IDs.

## Offline boundary

Linux runtime must not expose or call cloud-AI configuration/inquiry routes. In particular, these historical browser cloud paths intentionally stay absent (`404`):

```text
/api/ai/settings
/work/case/{case_id}/session/message/inquiry
```

Actual ASR/LLM model adapters will be connected behind `ai_gateway`/hardware boundaries later; model weights are not part of this backend-core change.

## Ownership boundaries for other agents

Frontend agent:
- may update browser client calls from aliases to `/api/v1`;
- should consume `STATE_SYNC` on reconnect;
- should stop showing Android-only wording for Linux runtime features once adapters are connected.

Hardware agent:
- implements concrete Linux ID-card/fingerprint/signature/camera/audio adapters behind `hardware_gateway`;
- must preserve `DEVICE_NOT_CONNECTED` semantics when unavailable.

AI agent:
- replaces deterministic mock behind `ai_gateway` with offline local model adapters;
- must not add cloud fallback.

Deployment agent:
- owns systemd/startup, data-directory permissions, log rotation and kiosk service integration;
- must run `alembic upgrade head` before service start.
