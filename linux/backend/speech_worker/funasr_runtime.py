from __future__ import annotations

import os
from pathlib import Path
from typing import Any, Callable

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCrashedError
from speech_worker.speaker.base import SpeakerBackendKey
from speech_worker.speaker.xvector import LegacySpeakerFactory, XVectorBackend


DEFAULT_MODEL_ROOT = Path("/opt/suspect-interrogation/models/funasr")
_CRITICAL_MODEL_NAMES = ("paraformer", "fsmn-vad")
_OPTIONAL_MODEL_NAMES = ("xvector",)
_MODEL_NAMES = _CRITICAL_MODEL_NAMES + _OPTIONAL_MODEL_NAMES
ModelFactory = Callable[..., Any]


class FunASRSpeechRuntime:
    """Own local FunASR ASR/VAD and delegate speaker embeddings to a backend."""

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
        self._speaker_embedding_backend: XVectorBackend | None = None
        self.speaker_backend: str | None = None
        self.speaker_backend_key = SpeakerBackendKey.XVECTOR
        self.speaker_model_id = self.speaker_backend_key.value
        self.speaker_model_version = os.environ.get("SUSPECT_XVECTOR_MODEL_VERSION", "local")
        self.speaker_model_fingerprint: str | None = None
        self.model_errors: dict[str, dict[str, str]] = {}

    @property
    def loaded(self) -> bool:
        return self.core_loaded and self._speaker_embedding_backend is not None

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
                    details={
                        "model": name,
                        "path": str(model_path),
                        "error_type": type(exc).__name__,
                    },
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

        backend = XVectorBackend(
            model_path=speaker_path,
            model_factory=factory,
            legacy_speaker_factory=self._legacy_speaker_factory,
            model_version=self.speaker_model_version,
        )
        try:
            backend.load()
        except Exception as exc:
            self.model_errors["xvector"] = {
                "code": getattr(exc, "code", "BACKEND_UNAVAILABLE"),
                "error_type": type(exc).__name__,
            }
            details = getattr(exc, "details", None)
            if isinstance(details, dict) and details.get("primary_error_type"):
                self.model_errors["xvector"]["primary_error_type"] = str(
                    details["primary_error_type"]
                )
            return

        self._speaker_embedding_backend = backend
        self.speaker_model = backend.model
        self.speaker_backend = backend.implementation
        self.speaker_backend_key = backend.key
        self.speaker_model_id = backend.model_id
        self.speaker_model_version = backend.model_version or "local"
        self.speaker_model_fingerprint = backend.model_fingerprint
        if backend.fingerprint_error_type is not None:
            self.model_errors["xvector_fingerprint"] = {
                "code": "FINGERPRINT_FAILED",
                "error_type": backend.fingerprint_error_type,
            }

    @staticmethod
    def _load_model(factory: ModelFactory, model_path: Path) -> Any:
        return factory(
            model=str(model_path),
            device="cpu",
            disable_update=True,
            disable_pbar=True,
        )

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
                "speaker": self._speaker_embedding_backend is not None,
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
        backend = self._speaker_embedding_backend
        if backend is None:
            raise BackendUnavailableError(
                "speaker embedding backend is not loaded",
                details={"backend_key": self.speaker_backend_key.value},
            )
        result = backend.extract_embedding(pcm, int(sample_rate))
        return {
            "embedding": result.embedding,
            "backend_key": result.backend_key.value,
            "model_id": result.model_id,
            "model_version": result.model_version,
            "model_fingerprint": result.model_fingerprint,
            "latency_ms": result.latency_ms,
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
        self._speaker_embedding_backend = None
        self.speaker_backend = None
        self.speaker_model_fingerprint = None


def _first_record(result: Any) -> dict[str, Any]:
    if isinstance(result, dict):
        return result
    if isinstance(result, list) and result and isinstance(result[0], dict):
        return result[0]
    return {}
