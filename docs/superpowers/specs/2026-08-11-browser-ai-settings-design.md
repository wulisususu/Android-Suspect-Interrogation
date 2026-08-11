# Browser AI Settings Design

## Goal

Make the Windows browser development page behave like the Android AI settings surface without requiring an APK rebuild, while keeping Windows-local model availability honest and preserving the fixed-height workspace.

## Architecture

- Android WebView continues to use `NativeBridge` and the Kotlin `AiRouter` unchanged.
- A normal desktop browser uses `backend-dev` HTTP endpoints for AI settings and inquiry.
- `backend-dev` persists browser-development settings under its ignored `data/` directory and never returns the API Key value to the browser.
- Browser inquiry calls the configured cloud provider directly through `backend-dev`. Local modes remain selectable for parity, but status and inquiry clearly report that no local runtime is available on Windows.

## Interface

- `GET /api/ai/settings` returns the same `AiRuntimeStatus` shape as Android.
- `PATCH /api/ai/settings` accepts the same `AiSettingsPatch` shape and returns the updated status.
- The existing inquiry SSE endpoint uses the persisted settings instead of the legacy UAT pass-through path.
- The settings trigger displays the active provider, not the implementation environment.

## Layout Feedback

- Loading, success, and error feedback render as fixed-position toasts.
- Toasts do not add a row to the workspace flex layout.
- Persistence feedback uses plain language such as `Q1 已保存`.

## Verification

- Backend smoke tests cover settings read/update/clear and cloud SSE proxying through a fake provider.
- Vue type checking and production build must pass.
- Browser automation verifies settings can be opened and saved and that feedback does not create page scrolling.
