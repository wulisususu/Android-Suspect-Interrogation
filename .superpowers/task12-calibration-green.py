from pathlib import Path

path = Path('scripts/ci/rk3588-speech-calibrate.py')
text = path.read_text(encoding='utf-8')


def replace_once(old: str, new: str) -> None:
    global text
    if text.count(old) != 1:
        raise SystemExit(f'expected one calibration anchor, found {text.count(old)}: {old[:80]!r}')
    text = text.replace(old, new, 1)

replace_once('import tempfile\nimport wave\n', 'import tempfile\nimport uuid\nimport wave\n')
replace_once('MARGIN_KEY = "SUSPECT_SPEAKER_MARGIN"\n', 'MARGIN_KEY = "SUSPECT_SPEAKER_MARGIN"\nSUPPORTED_SPEAKER_BACKENDS = ("xvector", "eres2net_large")\n')

replace_once(
'''def _embedding_for_wav(client: SpeechWorkerClient, path: Path) -> tuple[list[float], int]:\n    pcm = _read_pcm16_wav(path)\n    speech_pcm, speech_ms = _vad_positive_pcm(client, pcm)\n    result = client.extract_embedding(speech_pcm, sample_rate=SAMPLE_RATE)\n    embedding = result.get("embedding")\n    if not isinstance(embedding, list):\n        raise ValueError("speech worker did not return an embedding array")\n    return _normalize(embedding), speech_ms\n''',
'''def _normalize_speaker_backend(value: str) -> str:\n    backend = str(value or "").strip().lower()\n    if backend not in SUPPORTED_SPEAKER_BACKENDS:\n        raise ValueError("speaker backend must be xvector or eres2net_large")\n    return backend\n\n\ndef _embedding_for_wav(\n    client: SpeechWorkerClient,\n    path: Path,\n    speaker_backend: str,\n) -> tuple[list[float], int, dict[str, object]]:\n    backend = _normalize_speaker_backend(speaker_backend)\n    pcm = _read_pcm16_wav(path)\n    speech_pcm, speech_ms = _vad_positive_pcm(client, pcm)\n    result = client.extract_embedding(\n        speech_pcm,\n        sample_rate=SAMPLE_RATE,\n        backend=backend,\n    )\n    embedding = result.get("embedding")\n    if not isinstance(embedding, list):\n        raise ValueError("speech worker did not return an embedding array")\n    returned_backend = str(result.get("backend_key") or backend).strip().lower()\n    if returned_backend != backend:\n        raise ValueError("speech worker returned an embedding from the wrong speaker backend")\n    model_fingerprint = result.get("model_fingerprint")\n    if not isinstance(model_fingerprint, str) or not model_fingerprint.strip():\n        raise ValueError("speech worker did not return a speaker model fingerprint")\n    metadata: dict[str, object] = {\n        "speaker_backend": backend,\n        "model_id": result.get("model_id"),\n        "model_version": result.get("model_version"),\n        "model_fingerprint": model_fingerprint,\n        "embedding_latency_ms": result.get("latency_ms"),\n    }\n    return _normalize(embedding), speech_ms, metadata\n''')

replace_once(
'''def _paths(values: list[str]) -> list[Path]:\n    return [Path(value).expanduser() for value in values if str(value).strip()]\n\n\ndef main() -> int:\n    parser = argparse.ArgumentParser(description="Calibrate RK3588 XVector threshold/margin from local WAV samples.")\n''',
'''def _paths(values: list[str]) -> list[Path]:\n    return [Path(value).expanduser() for value in values if str(value).strip()]\n\n\ndef _validate_apply_policy(speaker_backend: str, apply: bool) -> None:\n    backend = _normalize_speaker_backend(speaker_backend)\n    if apply and backend != "xvector":\n        raise ValueError("--apply remains xvector-only; ERes2Net-large calibration is diagnostic until explicitly selected")\n\n\ndef main() -> int:\n    parser = argparse.ArgumentParser(description="Calibrate one RK3588 speaker backend from local WAV samples.")\n''')

replace_once(
'''    parser.add_argument("--socket", default="/run/suspect-interrogation/speech.sock")\n''',
'''    parser.add_argument("--socket", default="/run/suspect-interrogation/speech.sock")\n    parser.add_argument("--speaker-backend", choices=SUPPORTED_SPEAKER_BACKENDS, default="xvector")\n''')

replace_once(
'''    args = parser.parse_args()\n\n    groups = {\n''',
'''    args = parser.parse_args()\n    speaker_backend = _normalize_speaker_backend(args.speaker_backend)\n    _validate_apply_policy(speaker_backend, bool(args.apply))\n\n    groups = {\n''')

replace_once(
'''    health = client.health()\n    models = health.get("models") if isinstance(health, dict) else None\n    if not isinstance(models, dict) or not models.get("vad") or not models.get("speaker"):\n        raise SystemExit("speech worker VAD/XVector models are not ready")\n\n    samples: dict[str, list[list[float]]] = {}\n    speech_ms_by_identity: dict[str, int] = {}\n''',
'''    health = client.health()\n    models = health.get("models") if isinstance(health, dict) else None\n    if not isinstance(models, dict) or not models.get("vad"):\n        raise SystemExit("speech worker VAD model is not ready")\n    backend_health = health.get("speaker_backends") if isinstance(health, dict) else None\n    if isinstance(backend_health, dict):\n        selected_health = backend_health.get(speaker_backend)\n        if isinstance(selected_health, dict) and selected_health.get("ready") is not True:\n            raise SystemExit(f"speech worker speaker backend is not ready: {speaker_backend}")\n    elif speaker_backend == "xvector" and not models.get("speaker"):\n        raise SystemExit("speech worker XVector model is not ready")\n\n    samples: dict[str, list[list[float]]] = {}\n    speech_ms_by_identity: dict[str, int] = {}\n    run_model_metadata: dict[str, object] | None = None\n''')

replace_once(
'''        for path in paths:\n            vector, speech_ms = _embedding_for_wav(client, path)\n            vectors.append(vector)\n            total_speech_ms += speech_ms\n''',
'''        for path in paths:\n            vector, speech_ms, metadata = _embedding_for_wav(client, path, speaker_backend)\n            if run_model_metadata is None:\n                run_model_metadata = dict(metadata)\n            else:\n                for key in ("speaker_backend", "model_id", "model_version", "model_fingerprint"):\n                    if metadata.get(key) != run_model_metadata.get(key):\n                        raise SystemExit(f"speaker model metadata changed during calibration: {key}")\n            vectors.append(vector)\n            total_speech_ms += speech_ms\n''')

replace_once(
'''    scores = _build_scores(samples)\n    threshold, margin, metrics = choose_calibration(scores)\n''',
'''    if run_model_metadata is None:\n        raise SystemExit("calibration produced no speaker model metadata")\n\n    scores = _build_scores(samples)\n    threshold, margin, metrics = choose_calibration(scores)\n''')

replace_once(
'''    report = {\n        "status": "safe" if metrics["false_accepts"] == 0 and metrics["false_rejects"] == 0 else "unsafe",\n        "sample_rate": SAMPLE_RATE,\n''',
'''    report = {\n        "status": "safe" if metrics["false_accepts"] == 0 and metrics["false_rejects"] == 0 else "unsafe",\n        "calibration_id": f"{speaker_backend}-{uuid.uuid4().hex}",\n        "speaker_backend": speaker_backend,\n        "model_id": run_model_metadata.get("model_id"),\n        "model_version": run_model_metadata.get("model_version"),\n        "model_fingerprint": run_model_metadata.get("model_fingerprint"),\n        "sample_rate": SAMPLE_RATE,\n''')

replace_once(
'''REPORT_PAYLOAD = (\n    "status",\n    "sample_rate",\n''',
'''REPORT_PAYLOAD = (\n    "status",\n    "calibration_id",\n    "speaker_backend",\n    "model_id",\n    "model_version",\n    "model_fingerprint",\n    "sample_rate",\n''')

path.write_text(text, encoding='utf-8')
print('Task12 calibration GREEN apply complete')
