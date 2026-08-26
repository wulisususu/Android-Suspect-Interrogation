# Linux Core Backend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the Linux backend skeleton with a persistent, offline, testable FastAPI/SQLite backend that preserves the current browser behavior while enforcing evidence and workflow semantics.

**Architecture:** FastAPI routers call application services; services own transaction/workflow decisions; repositories are SQLAlchemy 2.x persistence adapters; SQLite is the single production state store; WebSocket state synchronization is reconstructed from SQLite after reconnect/restart. Legacy browser routes are thin aliases over the same services as canonical `/api/v1` routes.

**Tech Stack:** Python 3.11+, FastAPI, Pydantic 2, SQLAlchemy 2.x, SQLite, Alembic, pytest, FastAPI TestClient.

**Spec:** `docs/superpowers/specs/2026-08-26-linux-core-backend-design.md`

## Global Constraints

- `linux/backend` is the only production Linux backend.
- Fully offline; no cloud AI and no model download.
- Preserve existing Vue/browser behavior where possible.
- SQLAlchemy 2.x + Alembic + SQLite foreign keys/transactions.
- No persisted business state in Python global dictionaries.
- Real hardware absence must return an explicit failure, not fake success.
- Final pytest verification must run on `[self-hosted, rk3588]`.

---

### Task 1: Database foundation and ORM model

**Files:**
- Modify: `linux/backend/requirements.txt`
- Create: `linux/backend/app/database/base.py`
- Create: `linux/backend/app/database/session.py`
- Create: `linux/backend/app/database/models.py`
- Create: `linux/backend/app/database/__init__.py`
- Create: `linux/backend/tests/conftest.py`
- Create: `linux/backend/tests/test_database.py`

**Interfaces:**
- Produces `Base`, `configure_database(url)`, `get_session_factory()`, `session_scope()`, `init_database()`.
- Produces ORM classes for Case, Person, InterrogationSession, Message, MessageRevision, Fact, TimelineEvent, AuditLog, DeviceEvent, DocumentSnapshot, SignatureRecord.

- [ ] Write `test_database.py` asserting all required tables exist, SQLite foreign keys are enabled, and data survives closing/reopening the engine.
- [ ] Run `pytest tests/test_database.py -q` and verify RED because database modules do not exist.
- [ ] Implement database engine/session bootstrap and ORM entities with UTC timestamps, relationships, indexes and foreign keys.
- [ ] Run the test and verify GREEN.
- [ ] Refactor only after green; keep DB bootstrap deterministic for test overrides.

### Task 2: Domain errors and legal workflow state machine

**Files:**
- Create: `linux/backend/app/domain/enums.py`
- Create: `linux/backend/app/domain/errors.py`
- Create: `linux/backend/app/domain/__init__.py`
- Replace: `linux/backend/app/workflow/state.py`
- Create: `linux/backend/tests/test_state_machine.py`

**Interfaces:**
- Produces `WorkflowState`, `SessionStatus`, `InterrogationStage`, `MessageMark`, `DomainError`.
- Produces `StateMachine.validate_transition(current, target)` and `StateMachine.transition(current, target)`.

- [ ] Write tests for every legal workflow edge plus representative illegal jumps (`INIT -> QUESTIONING`, `FROZEN -> QUESTIONING`, etc.).
- [ ] Run tests and verify RED.
- [ ] Implement the enum-backed transition graph and structured `INVALID_STATE_TRANSITION` error.
- [ ] Run tests and verify GREEN.

### Task 3: Repositories and evidence-preserving revisions/audit

**Files:**
- Create: `linux/backend/app/repositories/cases.py`
- Create: `linux/backend/app/repositories/sessions.py`
- Create: `linux/backend/app/repositories/messages.py`
- Create: `linux/backend/app/repositories/facts.py`
- Create: `linux/backend/app/repositories/timeline.py`
- Create: `linux/backend/app/repositories/audit.py`
- Create: `linux/backend/app/repositories/documents.py`
- Create: `linux/backend/app/repositories/devices.py`
- Create: `linux/backend/app/repositories/__init__.py`
- Create: `linux/backend/tests/test_repositories.py`
- Create: `linux/backend/tests/test_revision_audit.py`

**Interfaces:**
- Message repository exposes `create`, `list_for_case`, `get`, `revise`, `mark`, `list_revisions`.
- `revise` preserves message ID, increments revision version, inserts old/new text and audit data in the same transaction.

- [ ] Write repository tests for CRUD and foreign-key behavior.
- [ ] Write revision tests asserting message count stays 1, ID stays stable, one revision is added and audit detail contains old/new text.
- [ ] Run tests and verify RED.
- [ ] Implement repositories with SQLAlchemy 2.x `select()` and explicit flush/commit ownership delegated to services/test transaction scopes.
- [ ] Run tests and verify GREEN.

### Task 4: Application services, hardware mock and AI mock

**Files:**
- Create: `linux/backend/app/services/case_service.py`
- Create: `linux/backend/app/services/session_service.py`
- Create: `linux/backend/app/services/message_service.py`
- Create: `linux/backend/app/services/identity_service.py`
- Create: `linux/backend/app/services/document_service.py`
- Create: `linux/backend/app/services/device_service.py`
- Create: `linux/backend/app/services/__init__.py`
- Create: `linux/backend/app/hardware_gateway/base.py`
- Create: `linux/backend/app/hardware_gateway/mock.py`
- Create: `linux/backend/app/hardware_gateway/__init__.py`
- Create: `linux/backend/app/ai_gateway/base.py`
- Create: `linux/backend/app/ai_gateway/mock.py`
- Create: `linux/backend/app/ai_gateway/__init__.py`
- Create: `linux/backend/tests/test_services.py`

**Interfaces:**
- Services return plain dictionaries/Pydantic-compatible data, never ORM instances to routers.
- Hardware `read_identity()` returns deterministic data only when `DEVICE_SIMULATOR=1`, otherwise raises `DEVICE_NOT_CONNECTED`.
- AI mock `generate(text)` is deterministic and network-free.

- [ ] Write tests for case creation, start/pause/resume/finish, identity mock, device-not-connected failure, stage validation and deterministic AI output.
- [ ] Run tests and verify RED.
- [ ] Implement service transaction boundaries and adapters.
- [ ] Run tests and verify GREEN.

### Task 5: Canonical API v1 plus browser compatibility routes

**Files:**
- Create: `linux/backend/app/api/schemas.py`
- Replace: `linux/backend/app/api/cases.py`
- Replace: `linux/backend/app/api/identity.py`
- Replace: `linux/backend/app/api/interrogation.py`
- Replace: `linux/backend/app/api/signature.py`
- Replace: `linux/backend/app/api/device_events.py`
- Create: `linux/backend/app/api/compat.py`
- Create: `linux/backend/app/api/errors.py`
- Replace: `linux/backend/app/main.py`
- Create: `linux/backend/app/__init__.py`
- Create: `linux/backend/tests/test_api.py`
- Create: `linux/backend/tests/test_legacy_compat.py`

**Interfaces:**
- All endpoints use one error/envelope contract.
- `create_app(database_url=None)` supports restart-persistence tests and production initialization.
- Canonical and compatibility routes call the same services.

- [ ] Write API tests for all required case/session/message/fact/timeline/audit/device/document/signature routes and error codes.
- [ ] Write compatibility tests reproducing `backend-dev/test/smoke.mjs` route shapes.
- [ ] Run tests and verify RED.
- [ ] Implement schemas, exception handlers, routers and aliases.
- [ ] Run tests and verify GREEN.

### Task 6: WebSocket protocol and persisted reconnect sync

**Files:**
- Replace: `linux/backend/app/api/events.py`
- Replace: `linux/backend/app/websocket/manager.py`
- Create: `linux/backend/app/websocket/protocol.py`
- Create: `linux/backend/app/websocket/__init__.py`
- Create: `linux/backend/tests/test_websocket.py`

**Interfaces:**
- Envelope fields: `session_id`, `event`, `seq`, `timestamp`, `payload`.
- Immediate connect/reconnect event: `STATE_SYNC` sourced from SQLite.
- Supports `STATE_SYNC_REQUEST`, `DEVICE_EVENT`, `ASR_FRAGMENT`, `USER_TEXT`, `AI_RESPONSE`, `RECORDING_STATE`, `SIGNATURE_STATE`.

- [ ] Write websocket tests for initial sync, bad envelope, deterministic AI response, and reconnect state sync.
- [ ] Run tests and verify RED.
- [ ] Implement connection manager and protocol parser; keep connections in memory only as transport handles, never as business truth.
- [ ] Run tests and verify GREEN.

### Task 7: Alembic, API/runtime documentation and restart E2E

**Files:**
- Create: `linux/backend/alembic.ini`
- Create: `linux/backend/alembic/env.py`
- Create: `linux/backend/alembic/script.py.mako`
- Create: `linux/backend/alembic/versions/0001_linux_core_schema.py`
- Create: `linux/backend/README.md`
- Replace: `linux/docs/api-contract-v1.md`
- Create: `docs/linux-runtime-contract.md`
- Create: `linux/backend/tests/test_end_to_end_restart.py`

**Interfaces:**
- Migration upgrade creates the same schema represented by ORM metadata.
- Runtime contract identifies Linux backend as authoritative and documents compatibility aliases for the frontend agent.

- [ ] Write restart E2E test: create case -> identity mock -> start -> Q/A -> edit -> revision -> mark -> pause -> resume -> finish -> freeze -> dispose app -> recreate against same SQLite DB -> verify state/message/revision/audit persist.
- [ ] Run and verify RED before freeze/restart implementation is complete.
- [ ] Add migration/docs and finish missing document-flow service behavior.
- [ ] Run E2E and full suite; verify GREEN.

### Task 8: RK3588 self-hosted CI verification

**Files:**
- Create: `.github/workflows/linux-backend-rk3588.yml`

**Interfaces:**
- Runs on `[self-hosted, rk3588]`.
- Uses robust sparse checkout pattern already proven by `runner-connectivity-check.yml`.
- Creates a local virtualenv or user install as available, installs `linux/backend/requirements.txt`, runs `alembic upgrade head`, then `pytest -q`.

- [ ] Add workflow triggered by pushes to `linux-core-backend` affecting `linux/backend/**`, `linux/docs/**`, `docs/linux-runtime-contract.md` or the workflow itself, plus `workflow_dispatch`.
- [ ] Commit the complete implementation.
- [ ] Observe workflow run/jobs/logs on the resulting commit.
- [ ] If a code/test failure occurs, fix with another test-first cycle and re-run failed job/workflow.
- [ ] Record final commit SHA, pytest result and remaining external work (real hardware/model drivers) in the completion report.
