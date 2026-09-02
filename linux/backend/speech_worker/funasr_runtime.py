from __future__ import annotations

import os
from pathlib import Path
from typing import Any, Callable

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCrashedError
from speech_worker.speaker.base import SpeakerBackendKey, SpeakerEmbeddingBackend
from speech_worker.speaker.eres2net_large import ERes2NetLargeBackend, ModelFactory as ERes2NetModelFactory


DEFAULT_MODEL_ROOT = Path("/opt/suspect-interrogation/models/funasr")
_CRITICAL_MODEL_NAMES = ("paraformer", "fsmn-vad")
_MODEL_NAMES = _CRITICAL_MODEL_NAMES
ModelFactory = Callable[..., Any]


class FunASRSpeechRuntime:
    """Own local FunASR ASR/VAD and model-isolated speaker embedding backends."""

    def __init__(
        self,
        *,
        model_root: str | Path = DEFAULT_MODEL_ROOT,
        model_factory: ModelFactory | None = None,
        legacy_speaker_factory: Any | None = None,
        eres2net_model_dir: str | Path | None = None,
        eres2net_model_factory: ERes2NetModelFactory | None = None,
    ) -> None:
        self.model_root = Path(model_root)
        self._model_factory = model_factory
        del legacy_speaker_factory
        self._eres2net_model_factory = eres2net_model_factory
        configured_eres_dir = eres2net_model_dir
        if configured_eres_dir is None:
            configured_eres_dir = os.environ.get("SUSPECT_ERES2NET_MODEL_DIR") or None
        self.eres2net_model_dir = (
            Path(configured_eres_dir).expanduser() if configured_eres_dir is not None else None
        )
        self.asr_model: Any | None = None
        self.vad_model: Any | None = None
        self.speaker_model: Any | None = None
        self._speaker_embedding_backend: SpeakerEmbeddingBackend | None = None
        self._speaker_backends: dict[SpeakerBackendKey, SpeakerEmbeddingBackend] = {}
        self.speaker_backend: str | None = None
        self.speaker_backend_key = SpeakerBackendKey.ERES2NET_LARGE
        self.speaker_model_id = self.speaker_backend_key.value
        self.speaker_model_version = os.environ.get("SUSPECT_ERES2NET_MODEL_VERSION", "local")
        self.speaker_model_fingerprint: str | None = None
        self.model_errors: dict[str, dict[str, str]] = {}

    @property
    def loaded(self) -> bool:
        return self.core_loaded and SpeakerBackendKey.ERES2NET_LARGE in self._speaker_backends

    @property
    def core_loaded(self) -> bool:
        return self.asr_model is not None and self.vad_model is not None

    def load(self) -> None:
        self._clear_models()
        self._speaker_backends = {}
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
        self._load_eres2net()

    def _load_eres2net(self) -> None:
        key = SpeakerBackendKey.ERES2NET_LARGE
        model_path = self.eres2net_model_dir
        if model_path is None:
            self.model_errors[key.value] = {
                "code": "MODEL_NOT_CONFIGURED",
                "error_type": "MissingModelConfiguration",
            }
            return
        if not model_path.is_dir():
            self.model_errors[key.value] = {
                "code": "MODEL_NOT_INSTALLED",
                "error_type": "MissingModelDirectory",
            }
            return
        backend = ERes2NetLargeBackend(
            model_path=model_path,
            model_factory=self._eres2net_model_factory,
        )
        try:
            backend.load()
        except Exception as exc:
            self.model_errors[key.value] = {
                "code": getattr(exc, "code", "BACKEND_UNAVAILABLE"),
                "error_type": type(exc).__name__,
            }
            return
        self._speaker_backends[key] = backend
        self._speaker_embedding_backend = backend
        self.speaker_model = backend.model
        self.speaker_backend = "modelscope-eres2net-large"
        self.speaker_backend_key = backend.key
        self.speaker_model_id = backend.model_id
        self.speaker_model_version = backend.model_version or "local"
        self.speaker_model_fingerprint = backend.model_fingerprint

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
        backend_health: dict[str, dict[str, Any]] = {}
        for key in (SpeakerBackendKey.ERES2NET_LARGE,):
            backend = self._speaker_backends.get(key)
            error = self.model_errors.get(key.value)
            backend_health[key.value] = {
                "ready": backend is not None,
                "model_id": getattr(backend, "model_id", None),
                "model_version": getattr(backend, "model_version", None),
                "model_fingerprint": getattr(backend, "model_fingerprint", None),
                "error": dict(error) if isinstance(error, dict) else None,
            }
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
            "speaker_backends": backend_health,
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

    def speaker_embedding(
        self,
        pcm: bytes,
        sample_rate: int,
        *,
        backend_key: str | SpeakerBackendKey | None = None,
    ) -> dict[str, Any]:
        try:
            key = SpeakerBackendKey(backend_key or SpeakerBackendKey.ERES2NET_LARGE)
        except ValueError as exc:
            raise BackendUnavailableError(
                "requested speaker embedding backend is unknown",
                details={"backend_key": str(backend_key)},
            ) from exc
        if key is not SpeakerBackendKey.ERES2NET_LARGE:
            raise BackendUnavailableError(
                "ERes2Net-large is the only enabled speaker embedding backend",
                details={"backend_key": key.value},
            )
        backend = self._speaker_backends.get(key)
        if backend is None:
            error = self.model_errors.get(key.value) or {}
            raise BackendUnavailableError(
                f"speaker embedding backend {key.value} is not loaded",
                details={"backend_key": key.value, **error},
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
        self._speaker_backends = {}
        self.speaker_backend = None
        self.speaker_backend_key = SpeakerBackendKey.XVECTOR
        self.speaker_model_id = self.speaker_backend_key.value
        self.speaker_model_version = os.environ.get("SUSPECT_XVECTOR_MODEL_VERSION", "local")
        self.speaker_model_fingerprint = None


def _first_record(result: Any) -> dict[str, Any]:
    if isinstance(result, dict):
        return result
    if isinstance(result, (list, tuple)) and result and isinstance(result[0], dict):
        return result[0]
    return {}
