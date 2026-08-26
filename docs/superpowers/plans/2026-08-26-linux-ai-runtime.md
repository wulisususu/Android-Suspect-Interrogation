# Linux Offline AI Runtime Implementation Plan

**Goal:** Build the model-independent, fully offline AI runtime infrastructure for the Linux branch so later model weights can be installed without restructuring FastAPI.

**Architecture:** FastAPI owns an `AISupervisor`; each active ASR/OCR/LLM capability runs in a dedicated `multiprocessing` worker with pipe IPC. A dependency-free registry controls model placement and capabilities; deterministic mocks allow end-to-end verification without weights.

**Spec:** `docs/superpowers/specs/2026-08-26-linux-ai-runtime-design.md`

- [x] Registry, lifecycle types, ASR/OCR/LLM interfaces, VAD/Speaker seams, deterministic mocks, and real-adapter shell.
- [x] Process-isolated worker supervisor with startup health, crash/restart, timeout, cancel, streaming, busy serialization, lazy load, idle unload, and memory-budget eviction.
- [x] Bounded interrogation context and immutable AI provenance metadata.
- [x] FastAPI health/capability, LLM, ASR REST/WebSocket, and OCR integration while preserving existing routers.
- [x] Backward-compatible `LocalModelManager` facade.
- [x] No-weight model registry/directories and operator instructions.
- [x] Test matrix plus standard-library RK3588 smoke workflow.

Verification commands:

```bash
cd linux/backend
PYTHONPATH=. python3 -m compileall -q app/ai app/api/ai_runtime.py app/main.py tests
PYTHONPATH=. python3 tests/rk3588_ai_runtime_smoke.py
PYTHONPATH=. python3 -m pytest -q
```
