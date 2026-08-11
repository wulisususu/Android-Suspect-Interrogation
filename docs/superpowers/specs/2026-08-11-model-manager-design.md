# ModelManager Design

## Goal

Prepare the Android APK for user-managed local AI models without bundling models into the APK or blocking application startup when no model is installed.

## Scope

- Add an Android `ModelManager` that scans app-private model storage by category.
- Allow the Android system file manager to import either a model file or a model directory.
- Persist one selected model per category: ASR, VAD, Speaker, and LLM.
- Expose scan, list, import, and select operations through the existing NativeBridge RPC surface.
- Put model management inside the existing `AI: provider` settings entry.
- Open a stable local LLM runtime interface while keeping the default runtime unavailable.
- Keep application startup non-blocking and successful when model storage is empty or unreadable.

This phase does not unpack archives, execute a local model, bundle a model in the APK, build the web application, or build/install an APK.

## Storage

Imported models live below Android app-private storage:

```text
files/models/asr/
files/models/vad/
files/models/speaker/
files/models/llm/
```

Every immediate child of a category directory is one model entry. A child may be a single archive/model file or a directory containing a multi-file model. Imports first copy into a hidden `.importing-*` entry and are renamed only after the copy succeeds. Scans ignore hidden and partial import entries.

The model ID is its category plus app-private relative path. Display names are derived from the file or directory name. Archive suffixes such as `.tar.bz2` are removed only from the display name; the stored file remains unchanged.

## Runtime Semantics

The following states are deliberately separate:

- `imported`: model bytes exist in app-private storage.
- `selected`: the user selected this model for its category.
- `runtimeReady`: an installed native runtime reports that it can execute the selected model.

Importing or selecting a model must not set `localAvailable` to true. The initial `UnavailableLocalLlmRuntime` always reports false. A later JNI/RKNN/ONNX/llama.cpp implementation can implement `LocalLlmRuntime` and consume the selected LLM descriptor without changing the WebView protocol.

## Startup

`AppContainer` creates `ModelManager` and starts a best-effort background scan. Scan exceptions are contained by the manager. No model is required to open the app, browse cases, configure the cloud API, or enter the interrogation workspace.

## NativeBridge Contract

- `model.scan`: rescan storage and return the catalog.
- `model.list`: return the current catalog, refreshing from disk.
- `model.select`: select a model by category and ID; an empty ID clears that category.
- `model.import.request`: open the Android system picker for a file or directory.
- `model.import`: internal continuation used after the picker returns with a granted content URI.

The JavaScript import request uses a longer timeout because the user may spend time in the picker and large files may take time to copy.

## UI

The existing AI settings modal has two tabs:

- `推理设置`: existing cloud/local routing and API controls.
- `本地模型`: grouped ASR, VAD, Speaker, and LLM model rows with size, source type, selection, refresh, and import actions.

The browser development view renders the same empty model-management state, but import and selection controls are disabled with an Android-only explanation. No new top-level navigation entry is added.

## Error Handling

- Picker cancellation resolves as a user cancellation rather than an app failure.
- Invalid category, missing model, failed copy, and insufficient storage return explicit RPC errors.
- A failed import removes its temporary destination.
- A selected model removed outside the app is automatically deselected on the next scan.

