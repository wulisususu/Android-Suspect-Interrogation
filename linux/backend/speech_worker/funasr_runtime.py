from __future__ import annotations

import base64
import json
import math
import os
import struct
import subprocess
from pathlib import Path
from typing import Any, Callable

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCrashedError
from app.ai.speech.fingerprint import fingerprint_model_directory
from speech_worker.speaker.base import SpeakerBackendKey


DEFAULT_MODEL_ROOT = Path("/opt/suspect-interrogation/models/funasr")
_CRITICAL_MODEL_NAMES = ("paraformer", "fsmn-vad")
_OPTIONAL_MODEL_NAMES = ("xvector",)
_MODEL_NAMES = _CRITICAL_MODEL_NAMES + _OPTIONAL_MODEL_NAMES
ModelFactory = Callable[..., Any]
LegacySpeakerFactory = Callable[[Path], Any]


class _LegacyXVectorSubprocessAdapter:
    """Run the incompatible XVector checkpoint in its own legacy Python."""

    def __init__(self, model_path: Path) -> None:
        python = os.environ.get("SUSPECT_XVECTOR_LEGACY_PYTHON", "")
        if not python or not Path(python).is_file():
            raise BackendUnavailableError("legacy XVector Python is unavailable", details={"model": "xvector"})
        self.python = python
        self.model_path = model_path
        self.script = Path(__file__).with_name("xvector_legacy.py")
        self._run({"op": "health"})

    def generate(self, **kwargs: Any) -> list[dict[str, Any]]:
        pcm = kwargs.get("input")
        sample_rate = int(kwargs.get("fs", 16000))
        if sample_rate != 16000 or not isinstance(pcm, (bytes, bytearray, memoryview)):
            raise ValueError("legacy xvector requires 16 kHz PCM bytes")
        result = self._run({"op": "embedding", "pcm_b64": base64.b64encode(bytes(pcm)).decode("ascii")})
        return [result]

    def _run(self, request: dict[str, Any]) -> dict[str, Any]:
        try:
            completed = subprocess.run([self.python, str(self.script), "--model-root", str(self.model_path)], input=json.dumps(request), text=True, capture_output=True, timeout=90, check=False)
            if completed.returncode != 0:
                raise RuntimeError(completed.stderr.strip() or completed.stdout.strip())
            result = json.loads(completed.stdout)
            if not isinstance(result, dict):
                raise RuntimeError("legacy XVector response must be an object")
            return result
        except Exception as exc:
            raise BackendUnavailableError("legacy XVector subprocess failed", details={"model": "xvector", "error_type": type(exc).__name__}) from exc


class FunASRSpeechRuntime:
    """Own local FunASR ASR/VAD plus optional speaker verification."""

    def __init__(
        self,
        *,
        model_root: str | Path = DEFAULT_MODEL_ROOT,
        model_factory: ModelFactory | None = None,
        legacy_speaker_factory: LegacySpeakerFactory | None = None,
    ) -> None:
        self.model_root = Path(model_root)
        self._model_factory = model_factory
        self._legacy_speaker_factory = legacy_speaker_factory
        self.asr_model: Any | None = None
        self.vad_model: Any | None = None
        self.speaker_model: Any | None = None
        self.speaker_backend: str | None = None
        self.speaker_backend_key = SpeakerBackendKey.XVECTOR
        self.speaker_model_id = self.speaker_backend_key.value
        self.speaker_model_version = os.environ.get("SUSPECT_XVECTOR_MODEL_VERSION", "local")
        self.speaker_model_fingerprint: str | None = None
        self.model_errors: dict[str, dict[str, str]] = {}

    @property
    def loaded(self) -> bool:
        return self.core_loaded and self.speaker_model is not None

    @property
    def core_loaded(self) -> bool:
        return self.asr_model is not None and self.vad_model is not None

    def load(self) -> None:
        self._clear_models()
        self.model_errors = {}
        model_dirs = {name: self.model_root / name for name in _MODEL_NAMES}

        missing_critical = [
            str(model_dirs[name]) for name in _CRITICAL_MODEL_NAMES if not model_dirs[name].is_dir()
        ]
        if missing_critical:
            raise ModelNotInstalledError(
                "required FunASR ASR/VAD model directories are not installed",
                details={"model_root": str(self.model_root), "missing": missing_critical},
            )

        factory = self._model_factory or self._load_vendor_factory()
        loaded: dict[str, Any] = {}
        for name in _CRITICAL_MODEL_NAMES:
            model_path = model_dirs[name]
            try:
                loaded[name] = self._load_model(factory, model_path)
            except Exception as exc:
                self._clear_models()
                raise BackendUnavailableError(
                    f"failed to load FunASR model {name}: {exc}",
                    details={"model": name, "path": str(model_path), "error_type": type(exc).__name__},
                ) from exc

        self.asr_model = loaded["paraformer"]
        self.vad_model = loaded["fsmn-vad"]

        speaker_path = model_dirs["xvector"]
        if not speaker_path.is_dir():
            self.model_errors["xvector"] = {
                "code": "MODEL_NOT_INSTALLED",
                "error_type": "MissingModelDirectory",
            }
            return

        try:
            self.speaker_model_fingerprint = fingerprint_model_directory(speaker_path)
        except Exception as exc:
            self.model_errors["xvector_fingerprint"] = {
                "code": "FINGERPRINT_FAILED",
                "error_type": type(exc).__name__,
            }
            self.speaker_model_fingerprint = None

        primary_error: Exception | None = None
        try:
            self.speaker_model = self._load_model(factory, speaker_path)
            self.speaker_backend = "funasr-automodel"
            return
        except Exception as exc:
            primary_error = exc

        try:
            legacy_factory = self._legacy_speaker_factory or self._load_legacy_speaker
            self.speaker_model = legacy_factory(speaker_path)
            self.speaker_backend = "legacy-subprocess-xvector"
        except Exception as exc:
            self.speaker_model = None
            self.speaker_backend = None
            self.model_errors["xvector"] = {
                "code": "BACKEND_UNAVAILABLE",
                "error_type": type(exc).__name__,
                "primary_error_type": type(primary_error).__name__ if primary_error is not None else "Unknown",
            }

    @staticmethod
    def _load_model(factory: ModelFactory, model_path: Path) -> Any:
        return factory(
            model=str(model_path),
            device="cpu",
            disable_update=True,
            disable_pbar=True,
        )

    @staticmethod
    def _load_legacy_speaker(model_path: Path) -> Any:
        if not (model_path / "sv.pth").is_file() or not (model_path / "sv.yaml").is_file():
            raise ModelNotInstalledError(
                "legacy xvector checkpoint files are missing",
                details={"model": "xvector"},
            )
        return _LegacyXVectorSubprocessAdapter(model_path)

    def health(self) -> dict[str, Any]:
        if self.loaded:
            status = "ready"
        elif self.core_loaded:
            status = "degraded"
        else:
            status = "not_loaded"
        return {
            "status": status,
            "model_root": str(self.model_root),
            "models": {
                "asr": self.asr_model is not None,
                "vad": self.vad_model is not None,
                "speaker": self.speaker_model is not None,
            },
            "speaker_backend": self.speaker_backend,
            "speaker_backend_key": self.speaker_backend_key.value,
            "speaker_model_id": self.speaker_model_id,
            "speaker_model_version": self.speaker_model_version,
            "speaker_model_fingerprint": self.speaker_model_fingerprint,
            "errors": dict(self.model_errors),
        }

    def vad(self, pcm: bytes, sample_rate: int) -> list[list[int]]:
        model = self._require_model(self.vad_model, "fsmn-vad")
        result = self._generate(model, "fsmn-vad", input=pcm, fs=int(sample_rate))
        return self._normalize_vad(result)

    def vad_stream(
        self,
        pcm: bytes,
        sample_rate: int,
        *,
        cache: dict[str, Any],
        is_final: bool,
        chunk_size_ms: int = 200,
    ) -> list[list[int]]:
        model = self._require_model(self.vad_model, "fsmn-vad")
        result = self._generate(
            model,
            "fsmn-vad",
            input=pcm,
            fs=int(sample_rate),
            cache=cache,
            is_final=bool(is_final),
            chunk_size=int(chunk_size_ms),
        )
        return self._normalize_vad(result)

    def transcribe(self, pcm: bytes, sample_rate: int) -> dict[str, Any]:
        model = self._require_model(self.asr_model, "paraformer")
        result = self._generate(model, "paraformer", input=pcm, fs=int(sample_rate))
        record = _first_record(result)
        if not record:
            return {"text": "", "confidence": None}
        text = str(record.get("text") or "")
        confidence_value = record.get("confidence")
        if confidence_value is None and "score" in record:
            confidence_value = record.get("score")
        confidence = None if confidence_value is None else float(confidence_value)
        return {"text": text, "confidence": confidence}

    def speaker_embedding(self, pcm: bytes, sample_rate: int) -> dict[str, Any]:
        model = self._require_model(self.speaker_model, "xvector")
        result = self._generate(
            model,
            "xvector",
            input=pcm,
            fs=int(sample_rate),
            embedding=True,
        )
        record = _first_record(result)
        if "spk_embedding" not in record:
            raise WorkerCrashedError(
                "FunASR xvector result did not contain spk_embedding",
                details={"model": "xvector"},
            )
        vector = _flatten_embedding(record["spk_embedding"])
        if not vector:
            raise WorkerCrashedError(
                "FunASR xvector returned an empty spk_embedding",
                details={"model": "xvector"},
            )
        norm = math.sqrt(sum(value * value for value in vector))
        if not math.isfinite(norm) or norm <= 0.0:
            raise WorkerCrashedError(
                "FunASR xvector returned a zero or invalid spk_embedding",
                details={"model": "xvector"},
            )
        normalized = [_float32(value / norm) for value in vector]
        return {
            "embedding": normalized,
            "backend_key": self.speaker_backend_key.value,
            "model_id": self.speaker_model_id,
            "model_version": self.speaker_model_version,
            "model_fingerprint": self.speaker_model_fingerprint,
        }

    @staticmethod
    def _load_vendor_factory() -> ModelFactory:
        try:
            from funasr import AutoModel
        except Exception as exc:
            raise BackendUnavailableError(
                f"FunASR runtime is unavailable: {exc}",
                details={"error_type": type(exc).__name__},
            ) from exc
        return AutoModel

    @staticmethod
    def _require_model(model: Any | None, name: str) -> Any:
        if model is None:
            raise BackendUnavailableError(
                f"FunASR model {name} is not loaded",
                details={"model": name},
            )
        return model

    @staticmethod
    def _generate(model: Any, name: str, **kwargs: Any) -> Any:
        try:
            return model.generate(**kwargs)
        except Exception as exc:
            if isinstance(exc, (BackendUnavailableError, WorkerCrashedError)):
                raise
            raise BackendUnavailableError(
                f"FunASR inference failed for {name}: {exc}",
                details={"model": name, "error_type": type(exc).__name__},
            ) from exc

    @staticmethod
    def _normalize_vad(result: Any) -> list[list[int]]:
        record = _first_record(result)
        raw_segments = record.get("value") if record else None
        if raw_segments is None:
            return []
        if not isinstance(raw_segments, (list, tuple)):
            raise WorkerCrashedError("FunASR VAD result value must be a segment array")
        normalized: list[list[int]] = []
        for item in raw_segments:
            if not isinstance(item, (list, tuple)) or len(item) != 2:
                raise WorkerCrashedError("FunASR VAD segment must contain [start_ms, end_ms]")
            normalized.append([int(item[0]), int(item[1])])
        return normalized

    def _clear_models(self) -> None:
        self.asr_model = None
        self.vad_model = None
        self.speaker_model = None
        self.speaker_backend = None
        self.speaker_model_fingerprint = None


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
            raise WorkerCrashedError("FunASR spk_embedding contained a non-numeric value") from exc
        if not math.isfinite(number):
            raise WorkerCrashedError("FunASR spk_embedding contained a non-finite value")
        output.append(number)

    visit(current)
    return output


def _float32(value: float) -> float:
    return struct.unpack("!f", struct.pack("!f", float(value)))[0]
