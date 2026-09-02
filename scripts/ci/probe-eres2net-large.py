#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import os
import sys
import wave
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[2]
BACKEND = ROOT / "linux" / "backend"
if str(BACKEND) not in sys.path:
    sys.path.insert(0, str(BACKEND))

from app.ai.speech.client import SpeechWorkerClient  # noqa: E402

MODEL_ID = "iic/speech_eres2net_large_200k_sv_zh-cn_16k-common"
MODEL_SLUG = "speech_eres2net_large_200k_sv_zh-cn_16k-common"


def _sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        while True:
            chunk = handle.read(1024 * 1024)
            if not chunk:
                break
            digest.update(chunk)
    return digest.hexdigest()


def _inventory(model_dir: Path) -> tuple[list[dict[str, object]], str | None]:
    files = sorted(item for item in model_dir.rglob("*") if item.is_file())
    if not files:
        return [], None

    manifest = hashlib.sha256()
    result: list[dict[str, object]] = []
    for item in files:
        relative = item.relative_to(model_dir).as_posix()
        size = item.stat().st_size
        file_hash = _sha256_file(item)
        result.append({"path": relative, "bytes": size, "sha256": file_hash})
        manifest.update(relative.encode("utf-8"))
        manifest.update(b"\0")
        manifest.update(str(size).encode("ascii"))
        manifest.update(b"\0")
        manifest.update(file_hash.encode("ascii"))
        manifest.update(b"\n")
    return result, manifest.hexdigest()


def _candidate_paths(search_root: Path) -> Iterable[Path]:
    root = search_root.expanduser().resolve()
    direct = (
        root / MODEL_SLUG,
        root / "iic" / MODEL_SLUG,
        root / "hub" / "iic" / MODEL_SLUG,
        root / "hub" / "models" / "iic" / MODEL_SLUG,
        root / "models" / "iic" / MODEL_SLUG,
    )
    yielded: set[Path] = set()
    for candidate in direct:
        resolved = candidate.resolve()
        if resolved in yielded:
            continue
        yielded.add(resolved)
        yield resolved

    if not root.is_dir():
        return
    for current, dirs, _files in os.walk(root, followlinks=False):
        current_path = Path(current)
        for name in tuple(dirs):
            if name != MODEL_SLUG:
                continue
            resolved = (current_path / name).resolve()
            if resolved not in yielded:
                yielded.add(resolved)
                yield resolved


def _discover_model_dir(explicit: Path | None, search_roots: list[Path]) -> tuple[Path | None, list[str]]:
    inspected: list[str] = []
    if explicit is not None:
        candidate = explicit.expanduser().resolve()
        inspected.append(os.fspath(candidate))
        return (candidate if candidate.is_dir() else None), inspected

    for search_root in search_roots:
        for candidate in _candidate_paths(search_root):
            inspected.append(os.fspath(candidate))
            if candidate.is_dir():
                return candidate, inspected
    return None, inspected


def _allowed_output_roots() -> list[Path]:
    roots: list[Path] = []
    for name in ("GITHUB_WORKSPACE", "RUNNER_TEMP"):
        value = os.environ.get(name)
        if value:
            roots.append(Path(value).expanduser().resolve())
    return roots


def _read_pcm16_wav(path: Path) -> bytes:
    try:
        with wave.open(str(path), "rb") as wav_file:
            channels = wav_file.getnchannels()
            width = wav_file.getsampwidth()
            rate = wav_file.getframerate()
            compression = wav_file.getcomptype()
            frames = wav_file.readframes(wav_file.getnframes())
    except (OSError, wave.Error) as exc:
        raise ValueError("embedding smoke input must be a readable PCM WAV") from exc
    if channels != 1 or width != 2 or rate != 16000 or compression != "NONE":
        raise ValueError("embedding smoke WAV must be uncompressed 16 kHz mono PCM16")
    if not frames or len(frames) % 2:
        raise ValueError("embedding smoke WAV contains no complete PCM16 samples")
    return frames


def _runtime_embedding_smoke(socket_path: str, wav_path: Path) -> dict[str, object]:
    pcm = _read_pcm16_wav(wav_path)
    client = SpeechWorkerClient(socket_path, timeout=60.0)
    payload = client.extract_embedding(pcm, sample_rate=16000, backend="eres2net_large")
    values = payload.get("embedding")
    if not isinstance(values, list) or not values:
        raise ValueError("ERes2Net-large runtime returned no embedding values")
    if str(payload.get("backend_key") or "").strip().lower() != "eres2net_large":
        raise ValueError("ERes2Net-large runtime returned the wrong backend identity")
    fingerprint = payload.get("model_fingerprint")
    if not isinstance(fingerprint, str) or not fingerprint.strip():
        raise ValueError("ERes2Net-large runtime did not return a model fingerprint")
    latency = payload.get("latency_ms")
    return {
        "embedding_dim": len(values),
        "embedding_latency_ms": None if latency is None else float(latency),
        "runtime_model_id": payload.get("model_id"),
        "runtime_model_version": payload.get("model_version"),
        "runtime_model_fingerprint": fingerprint,
    }


def _write_report(report: dict[str, object], output: Path | None) -> None:
    payload = json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    if output is None:
        sys.stdout.write(payload)
        return

    destination = output.expanduser().resolve()
    allowed_roots = _allowed_output_roots()
    if allowed_roots and not any(destination == root or root in destination.parents for root in allowed_roots):
        raise ValueError(f"output path is outside GITHUB_WORKSPACE/RUNNER_TEMP: {destination}")
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(payload, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description="Read-only ERes2Net-large offline model package probe")
    parser.add_argument("--model-dir", type=Path, help="Exact local ERes2Net-large package directory")
    parser.add_argument("--socket", help="Optional isolated speech-worker Unix socket for a real embedding smoke")
    parser.add_argument("--embedding-wav", type=Path, help="Local 16 kHz mono PCM16 WAV used only for transient runtime inference")
    parser.add_argument(
        "--search-root",
        action="append",
        default=[],
        type=Path,
        help="Local root to inspect recursively; may be supplied more than once",
    )
    parser.add_argument("--output", type=Path, help="Optional JSON report path")
    parser.add_argument(
        "--allow-missing",
        action="store_true",
        help="Return success with NOT_INSTALLED when no local package is found",
    )
    args = parser.parse_args()
    if bool(args.embedding_wav) != bool(args.socket):
        parser.error("--socket and --embedding-wav must be supplied together")

    search_roots = list(args.search_root)
    model_dir, inspected = _discover_model_dir(args.model_dir, search_roots)
    if model_dir is None:
        report: dict[str, object] = {
            "model_id": MODEL_ID,
            "status": "NOT_INSTALLED",
            "model_dir": os.fspath(args.model_dir.expanduser().resolve()) if args.model_dir else None,
            "search_roots": [os.fspath(path.expanduser().resolve()) for path in search_roots],
            "inspected_candidates": inspected,
            "files": [],
            "fingerprint": None,
        }
        _write_report(report, args.output)
        return 0 if args.allow_missing else 1

    files, fingerprint = _inventory(model_dir)
    status = "INSTALLED" if files else "EMPTY_PACKAGE"
    runtime_metrics: dict[str, object] = {}
    if args.socket and args.embedding_wav:
        runtime_metrics = _runtime_embedding_smoke(args.socket, args.embedding_wav.expanduser().resolve())

    report = {
        "model_id": MODEL_ID,
        "status": status,
        "model_dir": os.fspath(model_dir),
        "search_roots": [os.fspath(path.expanduser().resolve()) for path in search_roots],
        "inspected_candidates": inspected,
        "files": files,
        "fingerprint": fingerprint,
        **runtime_metrics,
    }
    _write_report(report, args.output)
    return 0 if status == "INSTALLED" or args.allow_missing else 1


if __name__ == "__main__":
    raise SystemExit(main())
