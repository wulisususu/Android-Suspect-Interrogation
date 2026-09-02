#!/usr/bin/env python3
"""Read-only RK3588 probe for local production FunASR models.

The probe never downloads or mutates model assets. It validates Paraformer and
FSMN-VAD through FunASR AutoModel. ERes2Net is checked separately through the
speech worker by probe-eres2net-large.py.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import sys
import time
from pathlib import Path
from typing import Any

from funasr import AutoModel
import funasr
import torch

MODEL_ROOT = Path(os.environ.get("MODEL_ROOT", "/home/youyeetoo/funasr-models")).resolve()
MODEL_DIRS = {"paraformer": "paraformer", "fsmn-vad": "fsmn-vad"}
SMALL_METADATA_LIMIT = 8 * 1024 * 1024
METADATA_SUFFIXES = {".yaml", ".yml", ".json", ".txt", ".conf", ".cfg", ".ini", ".tokens", ".vocab", ".scp", ".mvn"}


class InferenceProbeError(RuntimeError):
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
        row: dict[str, Any] = {"path": str(path.relative_to(root)), "bytes": stat.st_size}
        if stat.st_size <= SMALL_METADATA_LIMIT and (path.suffix.lower() in METADATA_SUFFIXES or path.name in {"config", "configuration"}):
            row["sha256"] = _sha256(path)
        rows.append(row)
    return rows


def _safe_output_path(raw: str) -> Path:
    output = Path(raw).expanduser().resolve()
    roots = [Path(value).expanduser().resolve() for name in ("GITHUB_WORKSPACE", "RUNNER_TEMP") if (value := os.environ.get(name))]
    if not roots:
        raise RuntimeError("GITHUB_WORKSPACE or RUNNER_TEMP is required")
    if not any(output == root or root in output.parents for root in roots):
        raise ValueError(f"--output must be inside an allowed runtime directory: {', '.join(map(str, roots))}")
    return output


def _first_record(result: Any) -> dict[str, Any]:
    if isinstance(result, list) and result and isinstance(result[0], dict):
        return result[0]
    return result if isinstance(result, dict) else {}


def _probe_model(name: str, path: Path, speech_wav: Path | None) -> dict[str, Any]:
    report: dict[str, Any] = {"path": str(path), "files": _metadata(path), "load_ok": False}
    started = time.perf_counter()
    model = AutoModel(model=str(path), device="cpu", disable_update=True, disable_pbar=True)
    report.update(load_ok=True, load_seconds=round(time.perf_counter() - started, 6), backend="funasr-automodel")
    try:
        if name == "fsmn-vad" and speech_wav is not None:
            result = model.generate(input=str(speech_wav))
            report["inference"] = {"keys": sorted(map(str, _first_record(result))), "segments": _first_record(result).get("value")}
        elif name == "paraformer" and speech_wav is not None:
            result = model.generate(input=str(speech_wav))
            report["inference"] = {"keys": sorted(map(str, _first_record(result))), "text": _first_record(result).get("text")}
    except Exception as exc:
        report.update(inference_ok=False, inference_error=f"{type(exc).__name__}: {exc}")
        raise InferenceProbeError(report, exc) from exc
    if "inference" in report:
        report["inference_ok"] = True
    return report


def main() -> int:
    parser = argparse.ArgumentParser(description="Probe local production FunASR models without downloads or mutations")
    parser.add_argument("--output", required=True, help="JSON output path inside GITHUB_WORKSPACE or RUNNER_TEMP")
    parser.add_argument("--speech-wav", type=Path, help="Optional speech WAV for Paraformer/VAD checks")
    args = parser.parse_args()
    output = _safe_output_path(args.output)
    speech_wav = args.speech_wav.resolve() if args.speech_wav else None
    if speech_wav is not None and not speech_wav.is_file():
        raise FileNotFoundError(speech_wav)
    report: dict[str, Any] = {"model_root": str(MODEL_ROOT), "python": sys.executable, "machine": platform.machine(), "cpu_count": os.cpu_count(), "funasr_version": getattr(funasr, "__version__", "unknown"), "torch_version": getattr(torch, "__version__", "unknown"), "models": {}, "success": False}
    failures: list[str] = []
    for name, relative in MODEL_DIRS.items():
        model_path = (MODEL_ROOT / relative).resolve()
        if MODEL_ROOT not in model_path.parents or not model_path.is_dir():
            failures.append(f"{name}: missing directory {model_path}")
            continue
        try:
            report["models"][name] = _probe_model(name, model_path, speech_wav)
        except InferenceProbeError as exc:
            report["models"][name] = exc.report
            failures.append(f"{name}: {type(exc.cause).__name__}: {exc.cause}")
        except Exception as exc:
            report["models"][name] = {"path": str(model_path), "load_ok": False, "error": f"{type(exc).__name__}: {exc}"}
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
