#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import math
import os
import subprocess
import sys
import time
import urllib.request
import uuid
import wave
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[2]
BACKEND = ROOT / "linux" / "backend"
if str(BACKEND) not in sys.path:
    sys.path.insert(0, str(BACKEND))

from app.ai.speech.client import SpeechWorkerClient  # noqa: E402
from app.ai.speech.types import SpeechEventType  # noqa: E402
from app.services.speaker_policy import SpeakerRole, decide_speaker  # noqa: E402

SAMPLE_RATE = 16_000
SAMPLE_WIDTH = 2
CHUNK_SIZE_MS = 200
THRESHOLD_KEY = "SUSPECT_SPEAKER_ACCEPT_THRESHOLD"
MARGIN_KEY = "SUSPECT_SPEAKER_MARGIN"
DEFAULT_SOCKET = "/run/suspect-interrogation/speech.sock"
DEFAULT_MODEL_ROOT = "/opt/suspect-interrogation/models/funasr"
RESTART_COMMAND = "systemctl restart ai-worker.service"
SUSPECT_ONLY = "SUSPECT_ONLY"
SUSPECT_PLUS_INTERROGATOR = "SUSPECT_PLUS_INTERROGATOR"
FULL = "FULL"
SUPPORTED_SPEAKER_BACKENDS = ("eres2net_large",)


def _normalize(values: Iterable[float]) -> list[float]:
    vector = [float(v) for v in values]
    if not vector or not all(math.isfinite(v) for v in vector):
        raise ValueError("embedding must contain finite values")
    norm = math.sqrt(sum(v * v for v in vector))
    if norm <= 0.0:
        raise ValueError("embedding norm must be positive")
    return [v / norm for v in vector]


def _cosine(left: list[float], right: list[float]) -> float:
    if len(left) != len(right):
        raise ValueError("embedding dimensions do not match")
    return max(-1.0, min(1.0, float(sum(a * b for a, b in zip(left, right)))))


def _read_pcm16_wav(path: Path) -> bytes:
    try:
        with wave.open(str(path), "rb") as wav:
            channels = wav.getnchannels()
            width = wav.getsampwidth()
            rate = wav.getframerate()
            compression = wav.getcomptype()
            frames = wav.readframes(wav.getnframes())
    except (OSError, wave.Error) as exc:
        raise ValueError("smoke input must be a readable PCM WAV") from exc
    if channels != 1 or width != SAMPLE_WIDTH or rate != SAMPLE_RATE or compression != "NONE":
        raise ValueError("smoke WAV must be uncompressed 16 kHz mono PCM16")
    if not frames or len(frames) % SAMPLE_WIDTH:
        raise ValueError("smoke WAV contains no complete PCM16 samples")
    return frames


def _vad_positive_pcm(client: SpeechWorkerClient, pcm: bytes) -> bytes:
    segments = client.speech_segments(pcm, sample_rate=SAMPLE_RATE)
    if not segments:
        raise RuntimeError("fsmn-vad returned no speech segments")
    bytes_per_ms = SAMPLE_RATE * SAMPLE_WIDTH / 1000.0
    duration_ms = int(round((len(pcm) / SAMPLE_WIDTH) * 1000.0 / SAMPLE_RATE))
    pieces: list[bytes] = []
    for start_ms, end_ms in segments:
        start = max(0, int(start_ms))
        end = min(duration_ms, int(end_ms))
        if end <= start:
            continue
        pieces.append(pcm[int(round(start * bytes_per_ms)) : int(round(end * bytes_per_ms))])
    speech = b"".join(pieces)
    if len(speech) < SAMPLE_RATE * SAMPLE_WIDTH:
        raise RuntimeError("fsmn-vad produced less than one second of usable speech")
    return speech


def _normalize_speaker_backend(value: str) -> str:
    backend = str(value or "").strip().lower()
    if backend not in SUPPORTED_SPEAKER_BACKENDS:
        raise ValueError("speaker backend must be eres2net_large")
    return backend


def _embedding(client: SpeechWorkerClient, pcm: bytes, speaker_backend: str) -> list[float]:
    backend = _normalize_speaker_backend(speaker_backend)
    speech = _vad_positive_pcm(client, pcm)
    payload = client.extract_embedding(speech, sample_rate=SAMPLE_RATE, backend=backend)
    values = payload.get("embedding")
    if not isinstance(values, list):
        raise RuntimeError(f"{backend} did not return an embedding array")
    returned_backend = str(payload.get("backend_key") or backend).strip().lower()
    if returned_backend != backend:
        raise RuntimeError("speech worker returned an embedding from the wrong speaker backend")
    return _normalize(values)


def _stream_smoke(
    client: SpeechWorkerClient,
    pcm: bytes,
    speaker_backend: str,
) -> dict[str, object]:
    speaker_backend = _normalize_speaker_backend(speaker_backend)
    session_id = f"rk3588-smoke-{uuid.uuid4().hex}"
    client.open_session(
        session_id,
        sample_rate=SAMPLE_RATE,
        speaker_backend=speaker_backend,
    )
    events = []
    chunk_bytes = SAMPLE_RATE * SAMPLE_WIDTH * CHUNK_SIZE_MS // 1000
    try:
        for offset in range(0, len(pcm), chunk_bytes):
            chunk = pcm[offset : offset + chunk_bytes]
            if chunk:
                events.extend(client.push_pcm(session_id, chunk))
        events.extend(client.finalize_session(session_id))
    finally:
        client.close_session(session_id)

    types = {event.type for event in events}
    required = {SpeechEventType.VAD_START, SpeechEventType.VAD_END, SpeechEventType.ASR_FINAL, SpeechEventType.SPEAKER_RESULT}
    missing = sorted(item.value for item in required - types)
    if missing:
        raise RuntimeError(f"real speech stream is missing expected events: {', '.join(missing)}")
    finals = [event for event in events if event.type is SpeechEventType.ASR_FINAL]
    if not any(str(event.text or "").strip() for event in finals):
        raise RuntimeError("paraformer produced no non-empty ASR_FINAL text")
    return {
        "event_count": len(events),
        "asr_final_count": len(finals),
        "speaker_result_count": sum(event.type is SpeechEventType.SPEAKER_RESULT for event in events),
    }


def _candidate(role: SpeakerRole, test: list[float], reference: list[float]) -> dict[str, object]:
    return {"role": role, "score": _cosine(test, reference), "speaker_id": role.value, "speaker_name": role.value}


def _assert_policy_modes(*, refs: dict[SpeakerRole, list[float]], threshold: float, margin: float) -> dict[str, str]:
    suspect = refs[SpeakerRole.SUSPECT]
    interrogator = refs[SpeakerRole.INTERROGATOR]
    recorder = refs[SpeakerRole.RECORDER]

    suspect_only_positive = decide_speaker(
        candidates=[_candidate(SpeakerRole.SUSPECT, suspect, suspect)],
        enabled_roles={SpeakerRole.SUSPECT},
        threshold=threshold,
        margin=margin,
        usable_duration_ms=2_000,
        overlap=False,
    )
    if suspect_only_positive.role is not SpeakerRole.SUSPECT:
        raise RuntimeError("SUSPECT_ONLY failed to recognize the suspect reference")

    suspect_only_officer = decide_speaker(
        candidates=[_candidate(SpeakerRole.SUSPECT, interrogator, suspect)],
        enabled_roles={SpeakerRole.SUSPECT},
        threshold=threshold,
        margin=margin,
        usable_duration_ms=2_000,
        overlap=False,
    )
    if suspect_only_officer.role is not SpeakerRole.OFFICER_FALLBACK:
        raise RuntimeError("SUSPECT_ONLY failed to preserve OFFICER_FALLBACK provenance")

    partial = decide_speaker(
        candidates=[
            _candidate(SpeakerRole.SUSPECT, interrogator, suspect),
            _candidate(SpeakerRole.INTERROGATOR, interrogator, interrogator),
        ],
        enabled_roles={SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR},
        threshold=threshold,
        margin=margin,
        usable_duration_ms=2_000,
        overlap=False,
    )
    if partial.role is not SpeakerRole.INTERROGATOR:
        raise RuntimeError("SUSPECT_PLUS_INTERROGATOR failed to recognize the interrogator")

    full = decide_speaker(
        candidates=[
            _candidate(SpeakerRole.SUSPECT, recorder, suspect),
            _candidate(SpeakerRole.INTERROGATOR, recorder, interrogator),
            _candidate(SpeakerRole.RECORDER, recorder, recorder),
        ],
        enabled_roles={SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR, SpeakerRole.RECORDER},
        threshold=threshold,
        margin=margin,
        usable_duration_ms=2_000,
        overlap=False,
    )
    if full.role is not SpeakerRole.RECORDER:
        raise RuntimeError("FULL failed to recognize the recorder")

    if margin <= 0.0:
        raise RuntimeError("calibrated margin must be positive so ambiguous speech can become UNKNOWN")
    ambiguous_score = max(0.0, min(1.0, threshold))
    ambiguous = decide_speaker(
        candidates=[
            {"role": SpeakerRole.SUSPECT, "score": ambiguous_score},
            {"role": SpeakerRole.INTERROGATOR, "score": ambiguous_score},
            {"role": SpeakerRole.RECORDER, "score": max(-1.0, ambiguous_score - margin)},
        ],
        enabled_roles={SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR, SpeakerRole.RECORDER},
        threshold=threshold,
        margin=margin,
        usable_duration_ms=2_000,
        overlap=False,
    )
    if ambiguous.role is not SpeakerRole.UNKNOWN:
        raise RuntimeError("FULL ambiguity gate forced a named identity instead of UNKNOWN")

    return {
        SUSPECT_ONLY: suspect_only_positive.role.value,
        f"{SUSPECT_ONLY}_OFFICER": suspect_only_officer.role.value,
        SUSPECT_PLUS_INTERROGATOR: partial.role.value,
        FULL: full.role.value,
        "AMBIGUOUS": ambiguous.role.value,
    }


def _read_env_file(path: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    if not path.is_file():
        return result
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        result[key.strip()] = value.strip()
    return result


def _calibration_value(cli_value: float | None, key: str, env_file: dict[str, str]) -> float:
    raw: object = cli_value if cli_value is not None else os.environ.get(key, env_file.get(key))
    if raw is None:
        raise RuntimeError(f"{key} is required for production speech smoke")
    value = float(raw)
    if not math.isfinite(value) or value < 0.0 or value > 1.0:
        raise RuntimeError(f"{key} must be finite and within [0, 1]")
    return value


def _check_systemd_and_mount(*, socket_path: Path, model_root: Path) -> None:
    subprocess.run(["systemctl", "is-active", "--quiet", "ai-worker.service"], check=True)
    if not socket_path.is_socket():
        raise RuntimeError("ai-worker.service is active but speech socket is missing")
    result = subprocess.run(["findmnt", "-no", "OPTIONS", str(model_root)], check=True, capture_output=True, text=True)
    options = {item.strip() for item in result.stdout.strip().split(",") if item.strip()}
    if "ro" not in options:
        raise RuntimeError("FunASR model mount is not read-only")


def _check_api_capabilities(api_base: str) -> dict[str, str]:
    with urllib.request.urlopen(api_base.rstrip("/") + "/health/ready", timeout=5) as response:
        payload = json.load(response)
    capabilities = payload.get("capabilities") if isinstance(payload, dict) else None
    if not isinstance(capabilities, dict):
        raise RuntimeError("health response does not contain capabilities")
    states: dict[str, str] = {}
    for name in ("asr", "vad", "speaker", "voiceprintCalibration", "audioCapture"):
        detail = capabilities.get(name)
        if not isinstance(detail, dict):
            raise RuntimeError(f"health response is missing {name}")
        states[name] = str(detail.get("state") or "")
    if states["voiceprintCalibration"] != "READY":
        raise RuntimeError("voiceprintCalibration is not READY")
    if states["audioCapture"] != "READY":
        raise RuntimeError("audioCapture is not READY")
    if states["asr"] != "AVAILABLE" or states["vad"] != "AVAILABLE" or states["speaker"] != "AVAILABLE":
        raise RuntimeError(f"speech capabilities are not all AVAILABLE: {states}")
    return states


def _restart_worker(socket_path: Path, timeout_seconds: float = 90.0) -> None:
    subprocess.run(["sudo", "-n", *RESTART_COMMAND.split()], check=True)
    deadline = time.monotonic() + timeout_seconds
    while time.monotonic() < deadline:
        if socket_path.is_socket() and subprocess.run(["systemctl", "is-active", "--quiet", "ai-worker.service"]).returncode == 0:
            return
        time.sleep(1)
    raise RuntimeError("ai-worker.service did not recover after restart")


def main() -> int:
    parser = argparse.ArgumentParser(description="Run a real RK3588 FSMN-VAD + Paraformer + selected speaker-backend smoke.")
    parser.add_argument("--socket", default=DEFAULT_SOCKET)
    parser.add_argument("--speaker-backend", choices=SUPPORTED_SPEAKER_BACKENDS, default="eres2net_large")
    parser.add_argument("--model-root", default=DEFAULT_MODEL_ROOT)
    parser.add_argument("--api-base", default="http://127.0.0.1:18080")
    parser.add_argument("--env-file", default="/etc/suspect-interrogation/ai-worker.env")
    parser.add_argument("--threshold", type=float)
    parser.add_argument("--margin", type=float)
    parser.add_argument("--suspect-wav", required=True)
    parser.add_argument("--interrogator-wav", required=True)
    parser.add_argument("--recorder-wav", required=True)
    parser.add_argument("--skip-systemd", action="store_true")
    parser.add_argument("--skip-api", action="store_true")
    parser.add_argument("--skip-mount", action="store_true")
    parser.add_argument("--no-restart", action="store_true", help="Never restart ai-worker.service after the smoke")
    args = parser.parse_args()
    speaker_backend = _normalize_speaker_backend(args.speaker_backend)

    socket_path = Path(args.socket)
    model_root = Path(args.model_root)
    if not args.skip_systemd or not args.skip_mount:
        if args.skip_systemd:
            result = subprocess.run(["findmnt", "-no", "OPTIONS", str(model_root)], check=True, capture_output=True, text=True)
            if "ro" not in {item.strip() for item in result.stdout.strip().split(",")}:
                raise RuntimeError("FunASR model mount is not read-only")
        elif args.skip_mount:
            subprocess.run(["systemctl", "is-active", "--quiet", "ai-worker.service"], check=True)
            if not socket_path.is_socket():
                raise RuntimeError("speech socket is missing")
        else:
            _check_systemd_and_mount(socket_path=socket_path, model_root=model_root)

    env_file = _read_env_file(Path(args.env_file))
    threshold = _calibration_value(args.threshold, THRESHOLD_KEY, env_file)
    margin = _calibration_value(args.margin, MARGIN_KEY, env_file)

    client = SpeechWorkerClient(socket_path, timeout=45.0)
    health = client.health()
    models = health.get("models") if isinstance(health, dict) else None
    if not isinstance(models, dict) or not all(models.get(name) for name in ("asr", "vad")):
        raise RuntimeError("speech worker health does not report paraformer/fsmn-vad ready")
    backend_health = health.get("speaker_backends") if isinstance(health, dict) else None
    if isinstance(backend_health, dict):
        selected_health = backend_health.get(speaker_backend)
        if isinstance(selected_health, dict) and selected_health.get("ready") is not True:
            raise RuntimeError(f"speech worker speaker backend is not ready: {speaker_backend}")
    elif not models.get("speaker"):
        raise RuntimeError("speech worker ERes2Net-large model is not ready")

    pcm_by_role = {
        SpeakerRole.SUSPECT: _read_pcm16_wav(Path(args.suspect_wav)),
        SpeakerRole.INTERROGATOR: _read_pcm16_wav(Path(args.interrogator_wav)),
        SpeakerRole.RECORDER: _read_pcm16_wav(Path(args.recorder_wav)),
    }
    refs = {role: _embedding(client, pcm, speaker_backend) for role, pcm in pcm_by_role.items()}
    stream = _stream_smoke(client, pcm_by_role[SpeakerRole.SUSPECT], speaker_backend)
    policy = _assert_policy_modes(refs=refs, threshold=threshold, margin=margin)
    api_states = {} if args.skip_api else _check_api_capabilities(args.api_base)

    restart_verified = False
    if not args.skip_systemd and not args.no_restart:
        _restart_worker(socket_path)
        restarted = SpeechWorkerClient(socket_path, timeout=45.0).health()
        restarted_models = restarted.get("models") if isinstance(restarted, dict) else None
        if not isinstance(restarted_models, dict) or not all(restarted_models.get(name) for name in ("asr", "vad", "speaker")):
            raise RuntimeError("speech worker model health did not recover after restart")
        restart_verified = True

    report = {
        "status": "ok",
        "sample_rate": SAMPLE_RATE,
        "chunk_size_ms": CHUNK_SIZE_MS,
        "speaker_backend": speaker_backend,
        "models": {
            "paraformer": bool(models.get("asr")),
            "fsmn-vad": bool(models.get("vad")),
            "speaker": True,
        },
        "stream": stream,
        "policy_modes": policy,
        "capabilities": api_states,
        "restart_verified": restart_verified,
        "privacy": "transient local acceptance inputs are not persisted by this script",
    }
    print(json.dumps(report, ensure_ascii=False, sort_keys=True, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
