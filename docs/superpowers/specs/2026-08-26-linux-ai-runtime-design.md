# Linux Offline AI Runtime Design

The Linux FastAPI process delegates ASR, OCR, and LLM inference to supervised subprocesses. Model registry and model paths are configuration-driven. Missing weights are a normal `MODEL_NOT_INSTALLED` state, not an application crash. The runtime remains fully offline and does not include cloud inference clients.

Each capability has a stable engine interface, deterministic mock implementation, real-adapter seam, lifecycle state, IPC worker, timeout/cancel/restart handling, health metadata, and lazy resource policy. The supervisor serializes requests per worker, evicts idle workers under the memory budget, and never writes AI output into original evidence storage.

AI results carry `source=ai`, `model_id`, `created_at`, and `session_id`. Context is bounded to case metadata, identity, facts, recent Q/A, timeline, and current stage. FastAPI exposes health/capability APIs, LLM generate/stream/cancel, ASR REST + WebSocket partial/final flow, and OCR recognition.

No model weights are committed. RK3588 CI runs a standard-library smoke covering mock inference, streaming, worker crash/restart, hard timeout/recovery, and real-mode missing-model behavior.
