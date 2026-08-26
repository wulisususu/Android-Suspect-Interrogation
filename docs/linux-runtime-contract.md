# Linux Runtime Contract

## Authority

For Linux deployments, **`linux/backend` is the only production backend**. The production frontend uses Linux HTTP/WebSocket interfaces only. `backend-dev` remains a historical behavior oracle and `backend-fastapi` is reference material only.

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
/health/live
/health/ready
```

## Existing Vue compatibility aliases

The browser compatibility routes are thin aliases over the same Linux services/database. New frontend work should prefer canonical `/api/v1` routes.

## Response shape

Canonical and compatibility REST routes use:

```json
{
  "ok": true,
  "code": "OK",
  "message": "OK",
  "data": {}
}
```

## Message semantics

- `message.id` is stable.
- Editing keeps the same ID and increments `version`.
- Revision history stores old/new text.
- Marks modify metadata on the same message.
- Edit/mark operations write audit entries.

## Session fields

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

The payload also exposes canonical workflow `state`.

## WebSocket expectations

Every server event contains:

```text
session_id
event
seq
timestamp
payload
```

After reconnect, the first `STATE_SYNC` is authoritative. The client replaces transient UI assumptions with persisted session/messages/document state. Sequence numbers order events for the current backend process and are not persisted evidence IDs.

## Offline boundary

The Linux runtime must not expose or call cloud-AI fallback. ASR/OCR/LLM execute behind the offline AI supervisor. Missing model weights are represented by capability states such as `MODEL_NOT_INSTALLED` and must not make the whole service unavailable.

## Ownership boundaries

Frontend:
- uses `LinuxHttpWsAdapter` in production;
- consumes `STATE_SYNC` after reconnect;
- may use `BrowserDevAdapter` only for explicit development mode.

Hardware:
- implements ID-card/fingerprint/signature/camera/audio adapters behind `hardware_gateway`;
- preserves explicit not-connected/not-configured semantics.

AI:
- implements local ASR/OCR/LLM engines behind `AISupervisor`;
- does not add cloud fallback.

Deployment:
- owns systemd/startup, data permissions, log rotation and kiosk integration;
- runs `alembic upgrade head` before service start.
