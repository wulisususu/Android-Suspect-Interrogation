# External Model Storage Design

## Goal

All runtime model payloads live below `/sdcard/models/`; the APK contains only application code, native runtime libraries, web assets, and test-only fixtures. Existing root-level RKLLM deployments remain discoverable during migration.

## Directory contract

```text
/sdcard/models/
├── asr/
│   ├── zipformer_rk3576/
│   │   ├── encoder.rknn
│   │   ├── decoder.rknn
│   │   ├── joiner.rknn
│   │   └── tokens.txt
│   └── paraformer_int8/
│       ├── encoder.int8.onnx
│       ├── decoder.int8.onnx
│       └── tokens.txt
├── ocr/
│   ├── ppocrv4_det.onnx
│   ├── ppocrv4_rec.onnx
│   └── ppocr_keys_v1.txt
├── llm/
│   └── *.rkllm
├── vad/
└── speaker/
```

For backward compatibility, `.rkllm` files immediately below `/sdcard/models/` are also scanned. New imports go to `/sdcard/models/llm/`.

## Runtime flow

`ModelManager` uses `/sdcard/models` as its only catalog root. `ModelCatalogScanner` describes category subdirectories, probes known ASR layouts for completeness, and scans both the standard and legacy LLM locations. `AsrController` resolves the selected external descriptor to a known ASR specification. `SherpaOnlineAsrEngine` validates normal files and constructs `OnlineRecognizer` without an `AssetManager`, which selects sherpa's file-path loader.

PP-OCRv4 reads `ppocr_keys_v1.txt` beside the OCR model files. Missing or incomplete model payloads remain visible in the catalog but are not marked runtime-ready and produce an explicit model-file error if invoked.

## Packaging and deployment

The seven ASR payloads and the OCR dictionary are removed from `src/main/assets`. CI asserts that runtime model payloads are absent from the APK and that required native libraries remain present. Device regression setup deploys model files to the directory contract before running real-engine tests.

## Compatibility and non-goals

- Existing root-level LegalOne files continue to work.
- The app does not silently copy hundreds of megabytes on first launch.
- The app does not unpack model archives; deployers must place extracted runtime files in the standard directories.
- Implementing PP-OCRv6, VAD, or speaker runtimes is outside this storage migration.

## Verification

- Unit tests prove absolute ASR paths, completeness probing, standard LLM discovery, and legacy LLM discovery.
- A fresh APK build proves ASR/OCR payloads are not packaged.
- RK3576 instrumentation proves Paraformer, Zipformer, PP-OCRv4, and LegalOne load from `/sdcard/models/`.
