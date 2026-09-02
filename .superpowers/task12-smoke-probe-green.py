from pathlib import Path


def replace_once(text: str, old: str, new: str, label: str) -> str:
    if text.count(old) != 1:
        raise SystemExit(f'expected one {label} anchor, found {text.count(old)}: {old[:80]!r}')
    return text.replace(old, new, 1)

# --- rk3588-speech-smoke.py ---
smoke_path = Path('scripts/ci/rk3588-speech-smoke.py')
smoke = smoke_path.read_text(encoding='utf-8')
smoke = replace_once(
    smoke,
    'FULL = "FULL"\n',
    'FULL = "FULL"\nSUPPORTED_SPEAKER_BACKENDS = ("xvector", "eres2net_large")\n',
    'smoke constants',
)
smoke = replace_once(
    smoke,
'''def _embedding(client: SpeechWorkerClient, pcm: bytes) -> list[float]:\n    speech = _vad_positive_pcm(client, pcm)\n    payload = client.extract_embedding(speech, sample_rate=SAMPLE_RATE)\n    values = payload.get("embedding")\n    if not isinstance(values, list):\n        raise RuntimeError("xvector did not return an embedding array")\n    return _normalize(values)\n\n\ndef _stream_smoke(client: SpeechWorkerClient, pcm: bytes) -> dict[str, object]:\n    session_id = f"rk3588-smoke-{uuid.uuid4().hex}"\n    client.open_session(session_id, sample_rate=SAMPLE_RATE)\n''',
'''def _normalize_speaker_backend(value: str) -> str:\n    backend = str(value or "").strip().lower()\n    if backend not in SUPPORTED_SPEAKER_BACKENDS:\n        raise ValueError("speaker backend must be xvector or eres2net_large")\n    return backend\n\n\ndef _embedding(client: SpeechWorkerClient, pcm: bytes, speaker_backend: str) -> list[float]:\n    backend = _normalize_speaker_backend(speaker_backend)\n    speech = _vad_positive_pcm(client, pcm)\n    payload = client.extract_embedding(speech, sample_rate=SAMPLE_RATE, backend=backend)\n    values = payload.get("embedding")\n    if not isinstance(values, list):\n        raise RuntimeError(f"{backend} did not return an embedding array")\n    returned_backend = str(payload.get("backend_key") or backend).strip().lower()\n    if returned_backend != backend:\n        raise RuntimeError("speech worker returned an embedding from the wrong speaker backend")\n    return _normalize(values)\n\n\ndef _stream_smoke(\n    client: SpeechWorkerClient,\n    pcm: bytes,\n    speaker_backend: str,\n) -> dict[str, object]:\n    speaker_backend = _normalize_speaker_backend(speaker_backend)\n    session_id = f"rk3588-smoke-{uuid.uuid4().hex}"\n    client.open_session(\n        session_id,\n        sample_rate=SAMPLE_RATE,\n        speaker_backend=speaker_backend,\n    )\n''',
    'smoke embedding/session',
)
smoke = replace_once(
    smoke,
'''    parser = argparse.ArgumentParser(description="Run the real RK3588 FSMN-VAD + Paraformer + XVector speech smoke.")\n    parser.add_argument("--socket", default=DEFAULT_SOCKET)\n''',
'''    parser = argparse.ArgumentParser(description="Run a real RK3588 FSMN-VAD + Paraformer + selected speaker-backend smoke.")\n    parser.add_argument("--socket", default=DEFAULT_SOCKET)\n    parser.add_argument("--speaker-backend", choices=SUPPORTED_SPEAKER_BACKENDS, default="xvector")\n''',
    'smoke parser backend',
)
smoke = replace_once(
    smoke,
'''    parser.add_argument("--skip-systemd", action="store_true")\n    parser.add_argument("--skip-api", action="store_true")\n    parser.add_argument("--skip-mount", action="store_true")\n    args = parser.parse_args()\n\n    socket_path = Path(args.socket)\n''',
'''    parser.add_argument("--skip-systemd", action="store_true")\n    parser.add_argument("--skip-api", action="store_true")\n    parser.add_argument("--skip-mount", action="store_true")\n    parser.add_argument("--no-restart", action="store_true", help="Never restart ai-worker.service after the smoke")\n    args = parser.parse_args()\n    speaker_backend = _normalize_speaker_backend(args.speaker_backend)\n\n    socket_path = Path(args.socket)\n''',
    'smoke no restart',
)
smoke = replace_once(
    smoke,
'''    health = client.health()\n    models = health.get("models") if isinstance(health, dict) else None\n    if not isinstance(models, dict) or not all(models.get(name) for name in ("asr", "vad", "speaker")):\n        raise RuntimeError("speech worker health does not report paraformer/fsmn-vad/xvector ready")\n\n    pcm_by_role = {\n''',
'''    health = client.health()\n    models = health.get("models") if isinstance(health, dict) else None\n    if not isinstance(models, dict) or not all(models.get(name) for name in ("asr", "vad")):\n        raise RuntimeError("speech worker health does not report paraformer/fsmn-vad ready")\n    backend_health = health.get("speaker_backends") if isinstance(health, dict) else None\n    if isinstance(backend_health, dict):\n        selected_health = backend_health.get(speaker_backend)\n        if isinstance(selected_health, dict) and selected_health.get("ready") is not True:\n            raise RuntimeError(f"speech worker speaker backend is not ready: {speaker_backend}")\n    elif speaker_backend == "xvector" and not models.get("speaker"):\n        raise RuntimeError("speech worker XVector model is not ready")\n\n    pcm_by_role = {\n''',
    'smoke health',
)
smoke = replace_once(
    smoke,
'''    refs = {role: _embedding(client, pcm) for role, pcm in pcm_by_role.items()}\n    stream = _stream_smoke(client, pcm_by_role[SpeakerRole.SUSPECT])\n''',
'''    refs = {role: _embedding(client, pcm, speaker_backend) for role, pcm in pcm_by_role.items()}\n    stream = _stream_smoke(client, pcm_by_role[SpeakerRole.SUSPECT], speaker_backend)\n''',
    'smoke calls',
)
smoke = replace_once(
    smoke,
'''    restart_verified = False\n    if not args.skip_systemd:\n        _restart_worker(socket_path)\n''',
'''    restart_verified = False\n    if not args.skip_systemd and not args.no_restart:\n        _restart_worker(socket_path)\n''',
    'smoke restart policy',
)
smoke = replace_once(
    smoke,
'''        "models": {"paraformer": bool(models.get("asr")), "fsmn-vad": bool(models.get("vad")), "xvector": bool(models.get("speaker"))},\n        "stream": stream,\n''',
'''        "speaker_backend": speaker_backend,\n        "models": {\n            "paraformer": bool(models.get("asr")),\n            "fsmn-vad": bool(models.get("vad")),\n            "speaker": True,\n        },\n        "stream": stream,\n''',
    'smoke report',
)
smoke_path.write_text(smoke, encoding='utf-8')

# --- probe-eres2net-large.py ---
probe_path = Path('scripts/ci/probe-eres2net-large.py')
probe = probe_path.read_text(encoding='utf-8')
probe = replace_once(
    probe,
'''import os\nimport sys\nfrom pathlib import Path\nfrom typing import Iterable\n\nMODEL_ID = "iic/speech_eres2net_large_200k_sv_zh-cn_16k-common"\n''',
'''import os\nimport sys\nimport wave\nfrom pathlib import Path\nfrom typing import Iterable\n\nROOT = Path(__file__).resolve().parents[2]\nBACKEND = ROOT / "linux" / "backend"\nif str(BACKEND) not in sys.path:\n    sys.path.insert(0, str(BACKEND))\n\nfrom app.ai.speech.client import SpeechWorkerClient  # noqa: E402\n\nMODEL_ID = "iic/speech_eres2net_large_200k_sv_zh-cn_16k-common"\n''',
    'probe imports',
)
probe = replace_once(
    probe,
'''def _write_report(report: dict[str, object], output: Path | None) -> None:\n''',
'''def _read_pcm16_wav(path: Path) -> bytes:\n    try:\n        with wave.open(str(path), "rb") as wav_file:\n            channels = wav_file.getnchannels()\n            width = wav_file.getsampwidth()\n            rate = wav_file.getframerate()\n            compression = wav_file.getcomptype()\n            frames = wav_file.readframes(wav_file.getnframes())\n    except (OSError, wave.Error) as exc:\n        raise ValueError("embedding smoke input must be a readable PCM WAV") from exc\n    if channels != 1 or width != 2 or rate != 16000 or compression != "NONE":\n        raise ValueError("embedding smoke WAV must be uncompressed 16 kHz mono PCM16")\n    if not frames or len(frames) % 2:\n        raise ValueError("embedding smoke WAV contains no complete PCM16 samples")\n    return frames\n\n\ndef _runtime_embedding_smoke(socket_path: str, wav_path: Path) -> dict[str, object]:\n    pcm = _read_pcm16_wav(wav_path)\n    client = SpeechWorkerClient(socket_path, timeout=60.0)\n    payload = client.extract_embedding(pcm, sample_rate=16000, backend="eres2net_large")\n    values = payload.get("embedding")\n    if not isinstance(values, list) or not values:\n        raise ValueError("ERes2Net-large runtime returned no embedding values")\n    if str(payload.get("backend_key") or "").strip().lower() != "eres2net_large":\n        raise ValueError("ERes2Net-large runtime returned the wrong backend identity")\n    fingerprint = payload.get("model_fingerprint")\n    if not isinstance(fingerprint, str) or not fingerprint.strip():\n        raise ValueError("ERes2Net-large runtime did not return a model fingerprint")\n    latency = payload.get("latency_ms")\n    return {\n        "embedding_dim": len(values),\n        "embedding_latency_ms": None if latency is None else float(latency),\n        "runtime_model_id": payload.get("model_id"),\n        "runtime_model_version": payload.get("model_version"),\n        "runtime_model_fingerprint": fingerprint,\n    }\n\n\ndef _write_report(report: dict[str, object], output: Path | None) -> None:\n''',
    'probe runtime helper',
)
probe = replace_once(
    probe,
'''    parser.add_argument("--model-dir", type=Path, help="Exact local ERes2Net-large package directory")\n''',
'''    parser.add_argument("--model-dir", type=Path, help="Exact local ERes2Net-large package directory")\n    parser.add_argument("--socket", help="Optional isolated speech-worker Unix socket for a real embedding smoke")\n    parser.add_argument("--embedding-wav", type=Path, help="Local 16 kHz mono PCM16 WAV used only for transient runtime inference")\n''',
    'probe parser',
)
probe = replace_once(
    probe,
'''    args = parser.parse_args()\n\n    search_roots = list(args.search_root)\n''',
'''    args = parser.parse_args()\n    if bool(args.embedding_wav) != bool(args.socket):\n        parser.error("--socket and --embedding-wav must be supplied together")\n\n    search_roots = list(args.search_root)\n''',
    'probe argument policy',
)
probe = replace_once(
    probe,
'''    report = {\n        "model_id": MODEL_ID,\n        "status": status,\n        "model_dir": os.fspath(model_dir),\n        "search_roots": [os.fspath(path.expanduser().resolve()) for path in search_roots],\n        "inspected_candidates": inspected,\n        "files": files,\n        "fingerprint": fingerprint,\n    }\n    _write_report(report, args.output)\n''',
'''    runtime_metrics: dict[str, object] = {}\n    if args.socket and args.embedding_wav:\n        runtime_metrics = _runtime_embedding_smoke(args.socket, args.embedding_wav.expanduser().resolve())\n\n    report = {\n        "model_id": MODEL_ID,\n        "status": status,\n        "model_dir": os.fspath(model_dir),\n        "search_roots": [os.fspath(path.expanduser().resolve()) for path in search_roots],\n        "inspected_candidates": inspected,\n        "files": files,\n        "fingerprint": fingerprint,\n        **runtime_metrics,\n    }\n    _write_report(report, args.output)\n''',
    'probe report runtime metrics',
)
probe_path.write_text(probe, encoding='utf-8')
print('Task12 smoke/probe GREEN apply complete')
