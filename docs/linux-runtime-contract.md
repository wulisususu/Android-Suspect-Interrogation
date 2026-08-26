# Linux Web Runtime Contract

## Goal

Make the existing Vue 3 interrogation UI a first-class Linux RK3588 client. Vue components must not branch on Android/Linux. Linux uses only local same-origin HTTP/WebSocket services; Android NativeBridge remains a compatibility runtime.

## Runtime selection

1. `window.NativeBridge.call` present -> `android-native`.
2. `VITE_RUNTIME_MODE=browser-dev` -> `browser-dev`.
3. Otherwise -> `linux-http-ws`.

Linux is therefore the default browser/kiosk runtime.

## RuntimeAdapter

The adapter exposes three responsibilities:

- `invoke<T>(operation, payload?, options?)`: typed operation gateway for case, identity, session, message, facts, timeline, device, ASR, OCR, LLM, signature, document and report actions.
- `getCapabilities(force?)`: capability/state discovery with normalized states.
- `connectSession(sessionId, listener)`: reliable session event stream.

Existing files under `webapp/src/api/` remain the application-service facade and preserve their public function signatures. They delegate to `getRuntimeAdapter()` instead of checking NativeBridge.

## Capability states

Canonical states:

- `AVAILABLE`
- `NOT_CONNECTED`
- `NOT_CONFIGURED`
- `MODEL_NOT_INSTALLED`
- `BUSY`
- `ERROR`

A capability contains `name`, `state`, optional `reason`, and optional metadata. Missing model endpoints, explicit model-not-installed responses, or model status with no selected model normalize to `MODEL_NOT_INSTALLED`. Missing hardware/configuration endpoints normalize to `NOT_CONFIGURED`. Network failure normalizes to `NOT_CONNECTED`.

## Linux REST mapping

The formal base path is `/api/v1` and takes precedence over legacy browser-development endpoints.

Minimum contract used by the adapter:

- `POST /api/v1/cases`
- `GET /api/v1/cases`
- `GET /api/v1/cases/{caseId}`
- `PUT /api/v1/cases/{caseId}`
- `GET /api/v1/cases/{caseId}/messages`
- `POST /api/v1/cases/{caseId}/messages`
- `PUT /api/v1/cases/{caseId}/messages/{messageId}`
- `POST /api/v1/cases/{caseId}/messages/{messageId}/mark`
- `GET /api/v1/cases/{caseId}/facts`
- `PUT /api/v1/cases/{caseId}/facts/{factKey}`
- `GET /api/v1/cases/{caseId}/timeline`
- `GET /api/v1/cases/{caseId}/audit`
- `GET /api/v1/cases/{caseId}/session`
- `POST /api/v1/interrogation/start`
- `POST /api/v1/interrogation/{sessionId}/pause|resume|finish`
- `POST /api/v1/interrogation/{sessionId}/stage`
- `GET /api/v1/capabilities`
- `POST /api/v1/identity/read`
- `POST /api/v1/device/action`
- `GET /api/v1/models`
- `POST /api/v1/models/select`
- `POST /api/v1/models/import`
- `/api/v1/asr/*`, `/api/v1/ocr/*`, `/api/v1/llm/*`
- `POST /api/v1/ai/inquiry`
- `GET /api/v1/cases/{caseId}/document`
- `POST /api/v1/cases/{caseId}/document/freeze`
- `POST /api/v1/cases/{caseId}/document/sign`
- `GET /api/v1/cases/{caseId}/report`

The baseline backend currently implements only a subset. The frontend must not fabricate success for missing endpoints. It returns normalized not-ready states/errors and keeps the page alive. Legacy browser-dev endpoints are allowed only in `BrowserDevAdapter`, never as an implicit Linux fallback.

## WebSocket

Endpoint: `/ws/interrogation/{sessionId}`.

`RuntimeWebSocketClient` must:

- reconnect with bounded exponential backoff;
- reset backoff after a successful connection;
- send `SESSION_RESYNC` after reconnect with the last accepted sequence;
- reject duplicate/replayed events by event id and/or non-increasing sequence;
- tolerate both `{event,payload,seq,id}` and older `{type,...}` envelopes;
- expose connection state without throwing into Vue render paths.

Supported event families include `IDENTITY_*`, `DEVICE_*`, `RECORDING_*`, `ASR_PARTIAL`, `ASR_FINAL`, `AI_RESPONSE`, `SESSION_STATE`, `SIGNATURE_*`, `REPORT_*`.

## Android compatibility

`AndroidNativeAdapter` delegates operations to the existing `callNative()` action names and native device RPC. No component may import `isNativeBusinessRuntime()` or `isNativeDeviceRuntime()` for business decisions after this migration.

## Browser development

`BrowserDevAdapter` uses the existing local backend-dev REST endpoints where they already exist and returns explicit not-ready capability states for Native-only model/device features. It must never call a cloud model.

## Error behavior

`RuntimeAdapterError` carries `code`, `capability`, `state`, and human-readable `message`. API facade functions may throw this error for an invoked unavailable feature; status functions should prefer returning a normalized not-ready status where their existing return type permits it. UI text must never say a feature is Android-only when Linux is the active runtime.

## Kiosk recovery

Runtime selection is deterministic after refresh. Session pages reconnect their WebSocket and resync using the session id supplied by application state. HTTP network errors become `NOT_CONNECTED`; they do not cause a blank page.

## Backend coordination gaps

The current baseline Linux backend lacks most case CRUD/list, messages/facts/timeline/audit, capability, model, document-freeze/signing and report endpoints listed above. Those are backend contract gaps, not reasons for the frontend to reintroduce NativeBridge gates. Backend implementation should converge on this contract or document an intentional v1 change.
