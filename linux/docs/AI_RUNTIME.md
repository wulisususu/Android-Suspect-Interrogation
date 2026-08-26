# Linux Offline AI Runtime

The Linux FastAPI backend owns an `AISupervisor`; ASR, OCR, and LLM inference run in isolated subprocess workers over pipe IPC. No cloud AI APIs or model weights are included.

## Model placement

- `linux/backend/models/asr/default/model.onnx`
- `linux/backend/models/ocr/default/model.bin`
- `linux/backend/models/llm/default/model.rkllm`
- `linux/backend/models/llm/llamacpp/model.gguf`

Missing required files in `AI_MODE=real` return `MODEL_NOT_INSTALLED` while the business API stays online. The stable real-backend seam is `app/ai/engines/real.py`; vendor SDK inference should be implemented there, not inside FastAPI.

## Configuration

`AI_MODE`, `MODEL_ROOT`, `MODEL_REGISTRY`, `ASR_BACKEND`, `OCR_BACKEND`, `LLM_BACKEND`, `AI_REQUEST_TIMEOUT`, `AI_IDLE_UNLOAD_SECONDS`, `AI_MEMORY_BUDGET_MB`.

## Resource policy

Workers lazy-load, are singleton per capability, serialize requests, support hard timeout/cancel by process termination, restart after failure, idle-unload, and memory-budget LRU eviction. `ContextBuilder` bounds case metadata, identity, facts, recent Q/A, timeline, and current stage.

AI results are immutable and stamped with `source=ai`, `model_id`, `created_at`, and `session_id`. This runtime exposes no path that overwrites original evidence.

## API

- `GET /api/v1/ai/health`
- `GET /api/v1/ai/capabilities`
- `POST /api/v1/ai/llm/generate`
- `POST /api/v1/ai/llm/stream`
- `POST /api/v1/ai/llm/cancel`
- `POST /api/v1/ai/asr/transcribe`
- `WS /api/v1/ai/asr/stream?session_id=...`
- `POST /api/v1/ai/ocr/recognize`

ASR WebSocket binary frames produce partial events; send `{"type":"end"}` for final, `{"type":"cancel"}` to cancel, and `{"type":"close"}` to close.

## Start after models arrive

Copy weights to the registry paths (or set `MODEL_ROOT`), install the local device SDK/runtime, implement/enable the matching adapter in `app/ai/engines/real.py`, set `AI_MODE=real`, start `uvicorn app.main:app --host 0.0.0.0 --port 8000`, then verify `/api/v1/ai/capabilities` and `/api/v1/ai/health`.

## Verification

`cd linux/backend && PYTHONPATH=. python3 -m pytest -q`

RK3588 CI also runs `tests/rk3588_ai_runtime_smoke.py` without downloading pytest or any model weights.
