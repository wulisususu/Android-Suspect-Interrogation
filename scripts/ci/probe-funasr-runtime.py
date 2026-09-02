#!/usr/bin/env python3
"""Read-only RK3588 probe for local FunASR models.

The probe never downloads or mutates model assets. Paraformer/FSMN-VAD use
FunASR AutoModel. XVector is exercised through the same project XVectorBackend
contract used by the speech worker, including the explicit legacy subprocess
fallback when a compatible legacy Python is supplied.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import sys
import time
import wave
from pathlib import Path
from typing import Any

REPO_ROOT = Path(__file__).resolve().parents[2]
BACKEND_ROOT = REPO_ROOT / "linux" / "backend"
if str(BACKEND_ROOT) not in sys.path:
    sys.path.insert(0, str(BACKEND_ROOT))

from funasr import AutoModel
import funasr
import torch

from speech_worker.speaker.xvector import XVectorBackend

MODEL_ROOT = Path(os.environ.get("MODEL_ROOT", "/home/youyeetoo/funasr-models")).resolve()
MODEL_DIRS = {
    "paraformer": "paraformer",
    "fsmn-vad": "fsmn-vad",
    "xvector": "xvector",
}
SMALL_METADATA_LIMIT = 8 * 1024 * 1024
METADATA_SUFFIXES = {
    ".yaml", ".yml", ".json", ".txt", ".conf", ".cfg", ".ini", ".tokens", ".vocab", ".scp", ".mvn"
}


class InferenceProbeError(RuntimeError):
    """Carry successful load evidence when an optional inference check fails."""

    def __init__(self, report: dict[str, Any], cause: Exception) -> None:
        super().__init__(str(cause))
        self.report = report
        self.cause = cause


def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _metadata(root: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for path in sorted(p for p in root.rglob("*") if p.is_file()):
        stat = path.stat()
        row: dict[str, Any] = {
            "path": str(path.relative_to(root)),
            "bytes": stat.st_size,
        }
        if stat.st_size <= SMALL_METADATA_LIMIT and (
            path.suffix.lower() in METADATA_SUFFIXES or path.name in {"config", "configuration"}
        ):
            row["sha256"] = _sha256(path)
        rows.append(row)
    return rows


def _safe_output_path(raw: str) -> Path:
    output = Path(raw).expanduser().resolve()
    allowed_roots = []
    for name in ("GITHUB_WORKSPACE", "RUNNER_TEMP"):
        value = os.environ.get(name)
        if value:
            allowed_roots.append(Path(value).expanduser().resolve())
    if not allowed_roots:
        raise RuntimeError("GITHUB_WORKSPACE or RUNNER_TEMP is required")
    if not any(output == root or root in output.parents for root in allowed_roots):
        roots = ", ".join(str(root) for root in allowed_roots)
        raise ValueError(f"--output must be inside an allowed runtime directory: {roots}")
    return output


def _result_keys(result: Any) -> list[str]:
    if isinstance(result, list) and result and isinstance(result[0], dict):
        return sorted(str(key) for key in result[0].keys())
    if isinstance(result, dict):
        return sorted(str(key) for key in result.keys())
    return []


def _first_record(result: Any) -> dict[str, Any]:
    if isinstance(result, list) and result and isinstance(result[0], dict):
        return result[0]
    if isinstance(result, dict):
        return result
    return {}


def _load_model(name: str, path: Path) -> tuple[Any, float, str]:
    started = time.perf_counter()
    model = AutoModel(
        model=str(path),
        device="cpu",
        disable_update=True,
        disable_pbar=True,
    )
    return model, time.perf_counter() - started, "funasr-automodel"


def _pcm16_from_wav(path: Path) -> bytes:
    with wave.open(str(path), "rb") as wav:
        if wav.getnchannels() != 1 or wav.getsampwidth() != 2 or wav.getframerate() != 16000 or wav.getcomptype() != "NONE":
            raise RuntimeError("xvector probe WAV must be uncompressed 16 kHz mono PCM16")
        return wav.readframes(wav.getnframes())


def _probe_xvector(
    path: Path,
    speaker_wav: Path | None,
    legacy_xvector_python: Path | None,
) -> dict[str, Any]:
    report: dict[str, Any] = {
        "path": str(path),
        "files": _metadata(path),
        "load_ok": False,
        "backend": "speaker-backend-contract",
    }
    previous_legacy_python = os.environ.get("SUSPECT_XVECTOR_LEGACY_PYTHON")
    if legacy_xvector_python is not None:
        os.environ["SUSPECT_XVECTOR_LEGACY_PYTHON"] = str(legacy_xvector_python)

    try:
        backend = XVectorBackend(model_path=path, model_factory=AutoModel)
        started = time.perf_counter()
        backend.load()
        report["load_ok"] = True
        report["load_seconds"] = round(time.perf_counter() - started, 6)
        report["implementation"] = backend.implementation
        report["model_id"] = backend.model_id
        report["model_version"] = backend.model_version
        report["model_fingerprint"] = backend.model_fingerprint
        if backend.fingerprint_error_type is not None:
            report["fingerprint_error_type"] = backend.fingerprint_error_type

        if speaker_wav is not None:
            try:
                embedding = backend.extract_embedding(_pcm16_from_wav(speaker_wav), 16_000)
                report["inference"] = {
                    "embedding_dim": len(embedding.embedding),
                    "latency_ms": round(float(embedding.latency_ms), 3),
                    "backend_key": getattr(embedding.backend_key, "value", str(embedding.backend_key)),
                    "model_id": embedding.model_id,
                    "model_version": embedding.model_version,
                    "model_fingerprint": embedding.model_fingerprint,
                    "implementation": backend.implementation,
                }
                report["inference_ok"] = True
            except Exception as exc:
                report["inference_ok"] = False
                report["inference_error"] = f"{type(exc).__name__}: {exc}"
                raise InferenceProbeError(report, exc) from exc
        return report
    finally:
        if legacy_xvector_python is not None:
            if previous_legacy_python is None:
                os.environ.pop("SUSPECT_XVECTOR_LEGACY_PYTHON", None)
            else:
                os.environ["SUSPECT_XVECTOR_LEGACY_PYTHON"] = previous_legacy_python


def _probe_model(
    name: str,
    path: Path,
    speech_wav: Path | None,
    speaker_wav: Path | None,
    legacy_xvector_python: Path | None,
) -> dict[str, Any]:
    if name == "xvector":
        return _probe_xvector(path, speaker_wav, legacy_xvector_python)

    report: dict[str, Any] = {
        "path": str(path),
        "files": _metadata(path),
        "load_ok": False,
    }
    model, load_seconds, backend = _load_model(name, path)
    report["load_ok"] = True
    report["load_seconds"] = round(load_seconds, 6)
    report["backend"] = backend

    try:
        if name == "fsmn-vad" and speech_wav is not None:
            result = model.generate(input=str(speech_wav))
            first = _first_record(result)
            report["inference"] = {
                "keys": _result_keys(result),
                "segments": first.get("value"),
            }
        elif name == "paraformer" and speech_wav is not None:
            result = model.generate(input=str(speech_wav))
            first = _first_record(result)
            report["inference"] = {
                "keys": _result_keys(result),
                "text": first.get("text"),
            }
    except Exception as exc:
        report["inference_ok"] = False
        report["inference_error"] = f"{type(exc).__name__}: {exc}"
        raise InferenceProbeError(report, exc) from exc
    if "inference" in report:
        report["inference_ok"] = True
    return report


def main() -> int:
    parser = argparse.ArgumentParser(description="Probe local FunASR models without downloads or mutations")
    parser.add_argument("--output", required=True, help="JSON output path inside GITHUB_WORKSPACE or RUNNER_TEMP")
    parser.add_argument("--speech-wav", type=Path, help="Optional speech WAV for Paraformer/VAD checks")
    parser.add_argument("--speaker-wav", type=Path, help="Optional speaker WAV for XVector embedding check")
    parser.add_argument(
        "--legacy-xvector-python",
        type=Path,
        help="Optional compatible legacy Python used only by XVectorBackend fallback",
    )
    args = parser.parse_args()

    output = _safe_output_path(args.output)
    speech_wav = args.speech_wav.resolve() if args.speech_wav else None
    speaker_wav = args.speaker_wav.resolve() if args.speaker_wav else None
    legacy_xvector_python = args.legacy_xvector_python.resolve() if args.legacy_xvector_python else None
    for sample in (speech_wav, speaker_wav):
        if sample is not None and not sample.is_file():
            raise FileNotFoundError(sample)
    if legacy_xvector_python is not None and not legacy_xvector_python.is_file():
        raise FileNotFoundError(legacy_xvector_python)

    report: dict[str, Any] = {
        "model_root": str(MODEL_ROOT),
        "python": sys.executable,
        "machine": platform.machine(),
        "cpu_count": os.cpu_count(),
        "funasr_version": getattr(funasr, "__version__", "unknown"),
        "torch_version": getattr(torch, "__version__", "unknown"),
        "legacy_xvector_python": str(legacy_xvector_python) if legacy_xvector_python is not None else None,
        "models": {},
        "success": False,
    }

    failures: list[str] = []
    for name, relative in MODEL_DIRS.items():
        model_path = (MODEL_ROOT / relative).resolve()
        if MODEL_ROOT not in model_path.parents:
            failures.append(f"{name}: resolved path escaped MODEL_ROOT")
            continue
        if not model_path.is_dir():
            failures.append(f"{name}: missing directory {model_path}")
            continue
        try:
            report["models"][name] = _probe_model(
                name,
                model_path,
                speech_wav,
                speaker_wav,
                legacy_xvector_python,
            )
        except InferenceProbeError as exc:
            report["models"][name] = exc.report
            failures.append(f"{name}: {type(exc.cause).__name__}: {exc.cause}")
        except Exception as exc:
            report["models"][name] = {
                "path": str(model_path),
                "load_ok": False,
                "error": f"{type(exc).__name__}: {exc}",
            }
            failures.append(f"{name}: {type(exc).__name__}: {exc}")

    report["success"] = not failures
    if failures:
        report["failures"] = failures

    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2, default=str) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2, default=str))
    return 0 if report["success"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
