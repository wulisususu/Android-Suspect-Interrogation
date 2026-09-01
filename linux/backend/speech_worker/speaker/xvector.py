from __future__ import annotations

import base64
import json
import math
import os
import struct
import subprocess
import time
from pathlib import Path
from typing import Any, Callable

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCrashedError
from app.ai.speech.fingerprint import fingerprint_model_directory
from speech_worker.speaker.base import SpeakerBackendKey, SpeakerEmbeddingResult


ModelFactory = Callable[..., Any]
LegacySpeakerFactory = Callable[[Path], Any]


class _LegacyXVectorSubprocessAdapter:
    """Run an incompatible historical XVector checkpoint in its legacy Python."""

    def __init__(self, model_path: Path) -> None:
        python = os.environ.get("SUSPECT_XVECTOR_LEGACY_PYTHON", "")
        if not python or not Path(python).is_file():
            raise BackendUnavailableError(
                "legacy XVector Python is unavailable",
                details={"model": "xvector"},
            )
        self.python = python
        self.model_path = model_path
        self.script = Path(__file__).resolve().parents[1] / "xvector_legacy.py"
        self._run({"op": "health"})

    def generate(self, **kwargs: Any) -> list[dict[str, Any]]:
        pcm = kwargs.get("input")
        sample_rate = int(kwargs.get("fs", 16000))
        if sample_rate != 16000 or not isinstance(pcm, (bytes, bytearray, memoryview)):
            raise ValueError("legacy xvector requires 16 kHz PCM bytes")
        result = self._run(
            {
                "op": "embedding",
                "pcm_b64": base64.b64encode(bytes(pcm)).decode("ascii"),
            }
        )
        return [result]

    def _run(self, request: dict[str, Any]) -> dict[str, Any]:
        try:
            completed = subprocess.run(
                [self.python, str(self.script), "--model-root", str(self.model_path)],
                input=json.dumps(request),
                text=True,
                capture_output=True,
                timeout=90,
                check=False,
            )
            if completed.returncode != 0:
                raise RuntimeError(completed.stderr.strip() or completed.stdout.strip())
            result = json.loads(completed.stdout)
            if not isinstance(result, dict):
                raise RuntimeError("legacy XVector response must be an object")
            return result
        except Exception as exc:
            raise BackendUnavailableError(
                "legacy XVector subprocess failed",
                details={"model": "xvector", "error_type": type(exc).__name__},
            ) from exc


class XVectorBackend:
    """Existing XVector behavior behind the backend-neutral speaker contract."""

    key = SpeakerBackendKey.XVECTOR
    model_id = "xvector"

    def __init__(
        self,
        *,
        model_path: str | Path,
        model_factory: ModelFactory,
        legacy_speaker_factory: LegacySpeakerFactory | None = None,
        model_version: str | None = None,
    ) -> None:
        self.model_path = Path(model_path)
        self._model_factory = model_factory
        self._legacy_speaker_factory = legacy_speaker_factory
        self.model_version = model_version or os.environ.get("SUSPECT_XVECTOR_MODEL_VERSION", "local")
        self.model_fingerprint: str | None = None
        self.model: Any | None = None
        self.implementation: str | None = None

    def load(self) -> None:
        self.model = None
        self.implementation = None
        self.model_fingerprint = None
        if not self.model_path.is_dir():
            raise ModelNotInstalledError(
                "xvector model directory is not installed",
                details={"model": self.model_id, "path": str(self.model_path)},
            )

        self.model_fingerprint = fingerprint_model_directory(self.model_path)
        primary_error: Exception | None = None
        try:
            self.model = self._model_factory(
                model=str(self.model_path),
                device="cpu",
                disable_update=True,
                disable_pbar=True,
            )
            self.implementation = "funasr-automodel"
            return
        except Exception as exc:
            primary_error = exc

        try:
            legacy_factory = self._legacy_speaker_factory or self._load_legacy_speaker
            self.model = legacy_factory(self.model_path)
            self.implementation = "legacy-subprocess-xvector"
        except Exception as exc:
            self.model = None
            self.implementation = None
            raise BackendUnavailableError(
                "failed to load xvector speaker backend",
                details={
                    "model": self.model_id,
                    "path": str(self.model_path),
                    "error_type": type(exc).__name__,
                    "primary_error_type": type(primary_error).__name__ if primary_error is not None else "Unknown",
                },
            ) from exc

    def extract_embedding(self, pcm: bytes, sample_rate: int) -> SpeakerEmbeddingResult:
        if self.model is None:
            raise BackendUnavailableError(
                "xvector speaker backend is not loaded",
                details={"model": self.model_id},
            )
        started = time.perf_counter()
        try:
            result = self.model.generate(
                input=pcm,
                fs=int(sample_rate),
                embedding=True,
            )
        except Exception as exc:
            if isinstance(exc, (BackendUnavailableError, WorkerCrashedError)):
                raise
            raise BackendUnavailableError(
                f"xvector inference failed: {exc}",
                details={"model": self.model_id, "error_type": type(exc).__name__},
            ) from exc

        record = _first_record(result)
        if "spk_embedding" not in record:
            raise WorkerCrashedError(
                "xvector result did not contain spk_embedding",
                details={"model": self.model_id},
            )
        vector = _flatten_embedding(record["spk_embedding"])
        if not vector:
            raise WorkerCrashedError(
                "xvector returned an empty spk_embedding",
                details={"model": self.model_id},
            )
        norm = math.sqrt(sum(value * value for value in vector))
        if not math.isfinite(norm) or norm <= 0.0:
            raise WorkerCrashedError(
                "xvector returned a zero or invalid spk_embedding",
                details={"model": self.model_id},
            )
        normalized = [_float32(value / norm) for value in vector]
        return SpeakerEmbeddingResult(
            embedding=normalized,
            backend_key=self.key,
            model_id=self.model_id,
            model_version=self.model_version,
            model_fingerprint=self.model_fingerprint,
            latency_ms=(time.perf_counter() - started) * 1000.0,
        )

    @staticmethod
    def _load_legacy_speaker(model_path: Path) -> Any:
        if not (model_path / "sv.pth").is_file() or not (model_path / "sv.yaml").is_file():
            raise ModelNotInstalledError(
                "legacy xvector checkpoint files are missing",
                details={"model": "xvector"},
            )
        return _LegacyXVectorSubprocessAdapter(model_path)


def _first_record(result: Any) -> dict[str, Any]:
    if isinstance(result, dict):
        return result
    if isinstance(result, list) and result and isinstance(result[0], dict):
        return result[0]
    return {}


def _flatten_embedding(value: Any) -> list[float]:
    current = value
    for method_name in ("detach", "cpu"):
        method = getattr(current, method_name, None)
        if callable(method):
            current = method()
    tolist = getattr(current, "tolist", None)
    if callable(tolist):
        current = tolist()

    output: list[float] = []

    def visit(item: Any) -> None:
        if isinstance(item, (list, tuple)):
            for child in item:
                visit(child)
            return
        try:
            number = float(item)
        except (TypeError, ValueError) as exc:
            raise WorkerCrashedError("xvector spk_embedding contained a non-numeric value") from exc
        if not math.isfinite(number):
            raise WorkerCrashedError("xvector spk_embedding contained a non-finite value")
        output.append(number)

    visit(current)
    return output


def _float32(value: float) -> float:
    return struct.unpack("!f", struct.pack("!f", float(value)))[0]
