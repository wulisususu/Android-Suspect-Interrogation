# Offline model placement

Do not commit model weights to Git.

Default registry locations:

- ASR: `models/asr/default/model.onnx`
- OCR: `models/ocr/default/model.bin`
- RKLLM: `models/llm/default/model.rkllm`
- llama.cpp alternative: `models/llm/llamacpp/model.gguf`

The filenames are registry contracts, not bundled weights. If a required file is missing in `AI_MODE=real`, the API reports `MODEL_NOT_INSTALLED` and the business API remains online.

To use a different filename or directory, edit `config/model-registry.yaml` or point `MODEL_REGISTRY` / `MODEL_ROOT` at an appliance-local configuration. Never hard-code a developer-machine absolute path in Python code.
