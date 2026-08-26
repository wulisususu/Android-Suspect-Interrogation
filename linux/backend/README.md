# Linux Backend

`linux/backend` is the authoritative production backend for the Linux adaptation of Android-Suspect-Interrogation. It runs independently of Android APK/Kotlin/Room/NativeBridge and is designed for fully offline RK3588 deployments.

## Architecture

- `app/api/` — FastAPI HTTP contracts and browser compatibility aliases.
- `app/domain/` — workflow/session/stage enums and structured domain errors.
- `app/database/` — SQLAlchemy 2.x ORM, engine/session bootstrap and SQLite policy.
- `app/repositories/` — persistence-only operations.
- `app/services/` — transaction and use-case boundaries.
- `app/workflow/` — legal state transition validation.
- `app/websocket/` — session transport, reconnect state sync and broadcast protocol.
- `app/hardware_gateway/` — hardware abstraction and deterministic simulator.
- `app/ai_gateway/` — offline AI abstraction and deterministic mock adapter.
- `app/audit/` — audit helpers.
- `app/reporting/` — report/signature integration boundary.
- `alembic/` — schema migrations.
- `tests/` — unit, repository, API, WebSocket, migration and restart-persistence tests.

`backend-dev` and `backend-fastapi` are not runtime backends for Linux. `backend-dev` remains useful only as a historical behavior/API oracle.

## Requirements

- Python 3.11+
- Linux (RK3588 target; x86_64 Linux is suitable for development tests)
- SQLite 3
- No network or cloud AI is required at runtime

## Install

```bash
cd linux/backend
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r requirements.txt
```

## Database

Default database file:

```text
linux/backend/data/suspect-interrogation.db
```

Override it with either:

```bash
export DATABASE_URL='sqlite:////absolute/path/interrogation.db'
# or
export DB_PATH='/absolute/path/interrogation.db'
```

Apply migrations before production startup:

```bash
alembic upgrade head
```

SQLite connections enable foreign keys, WAL and `synchronous=NORMAL`.

## Run

```bash
uvicorn app.main:app --host 0.0.0.0 --port 18080
```

Health endpoints:

```text
GET /health
GET /api/health       # legacy browser compatibility
```

## Hardware simulator

Real hardware is **not** faked by default. Without a concrete adapter, hardware actions return HTTP 409 `DEVICE_NOT_CONNECTED`.

For deterministic integration tests only:

```bash
export DEVICE_SIMULATOR=1
```

The simulator returns fixed identity/device payloads and never calls the network.

## Offline AI adapter

Model weights are intentionally not included. `DeterministicAIGateway` is a network-free adapter used to stabilize WebSocket integration until the actual offline model gateway is supplied. There is intentionally no `/api/ai/settings` or browser cloud-AI inquiry endpoint.

## Tests

```bash
cd linux/backend
pytest -q
```

The suite covers:

- workflow transition validation;
- required SQLite schema and foreign keys;
- repository behavior;
- stable message identity + revisions + audit trail;
- API v1 and legacy browser compatibility routes;
- hardware-not-connected failures;
- WebSocket connect/reconnect state sync;
- Alembic `upgrade head`;
- complete restart persistence flow.

## Required lifecycle

Canonical workflow:

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

A persisted `Case` begins at `IDENTITY_REQUIRED`; `INIT` exists as the pre-case workflow state and is tested in the state-machine unit.

## Compatibility policy

The canonical contract is `/api/v1`. Existing Vue browser calls under `/api/...` and `/work/...` are aliases over the same service layer, not a second implementation. The old `/api/cases/{id}/session/start` compatibility route may bypass the newly explicit identity read so the current frontend remains operational; that bypass creates an `IDENTITY_BYPASS_LEGACY_COMPAT` audit entry. New Linux integrations should use `/api/v1` and perform identity first.

See:

- `../docs/api-contract-v1.md`
- `../../docs/linux-runtime-contract.md`
