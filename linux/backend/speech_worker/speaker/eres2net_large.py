from __future__ import annotations

import math
import os
import struct
import time
from pathlib import Path
from typing import Any, Callable

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCrashedError
from app.ai.speech.fingerprint import fingerprint_model_directory
from speech_worker.speaker.base import SpeakerBackendKey, SpeakerEmbeddingResult


MODEL_ID = "iic/speech_eres2net_large_200k_sv_zh-cn_16k-common"
ModelFactory = Callable[[Path], Any]


class ERes2NetLargeBackend:
    """Local/offline ERes2Net-large speaker-embedding backend.

    Heavy ModelScope/NumPy imports are intentionally delayed until the
    production factory is used so the API process and hosted unit tests do not
    acquire a Torch/ModelScope dependency.
    """

    key = SpeakerBackendKey.ERES2NET_LARGE
    model_id = MODEL_ID

    def __init__(
        self,
        *,
        model_path: str | Path,
        model_factory: ModelFactory | None = None,
        model_version: str | None = None,
    ) -> None:
        self.model_path = Path(model_path).expanduser()
        self._model_factory = model_factory
        self.model_version = model_version or os.environ.get(
            "SUSPECT_ERES2NET_MODEL_VERSION", "local"
        )
        self.model_fingerprint: str | None = None
        self.model: Any | None = None

    def load(self) -> None:
        self.model = None
        self.model_fingerprint = None
        if not self.model_path.is_dir():
            raise ModelNotInstalledError(
                "ERes2Net-large model directory is not installed",
                details={"model": self.model_id, "path": str(self.model_path)},
            )

        try:
            self.model_fingerprint = fingerprint_model_directory(self.model_path)
        except Exception as exc:
            raise ModelNotInstalledError(
                "ERes2Net-large local model package is empty or invalid",
                details={
                    "model": self.model_id,
                    "path": str(self.model_path),
                    "error_type": type(exc).__name__,
                },
            ) from exc

        factory = self._model_factory or _load_modelscope_embedding_model
        try:
            self.model = factory(self.model_path.resolve())
        except Exception as exc:
            if isinstance(exc, ModelNotInstalledError):
                raise
            raise BackendUnavailableError(
                f"failed to load ERes2Net-large local backend: {exc}",
                details={
                    "model": self.model_id,
                    "path": str(self.model_path),
                    "error_type": type(exc).__name__,
                },
            ) from exc

    def extract_embedding(self, pcm: bytes, sample_rate: int) -> SpeakerEmbeddingResult:
        if int(sample_rate) != 16000:
            raise ValueError("ERes2Net-large requires 16 kHz audio")
        if not isinstance(pcm, (bytes, bytearray, memoryview)):
            raise TypeError("ERes2Net-large PCM input must be bytes-like")
        pcm_bytes = bytes(pcm)
        if not pcm_bytes or len(pcm_bytes) % 2:
            raise ValueError("ERes2Net-large requires non-empty PCM16 audio")
        if self.model is None:
            raise BackendUnavailableError(
                "ERes2Net-large speaker backend is not loaded",
                details={"model": self.model_id},
            )

        waveform = [sample[0] / 32768.0 for sample in struct.iter_unpack("<h", pcm_bytes)]
        started = time.perf_counter()
        try:
            raw_embedding = self.model.extract_embedding(waveform)
        except Exception as exc:
            if isinstance(exc, (BackendUnavailableError, WorkerCrashedError)):
                raise
            raise BackendUnavailableError(
                f"ERes2Net-large inference failed: {exc}",
                details={"model": self.model_id, "error_type": type(exc).__name__},
            ) from exc

        vector = _flatten_embedding(raw_embedding)
        if not vector:
            raise WorkerCrashedError(
                "ERes2Net-large returned an empty embedding",
                details={"model": self.model_id},
            )
        norm = math.sqrt(sum(value * value for value in vector))
        if not math.isfinite(norm) or norm <= 0.0:
            raise WorkerCrashedError(
                "ERes2Net-large returned a zero or invalid embedding",
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


class _ModelScopeEmbeddingAdapter:
    def __init__(self, pipeline: Any, numpy_module: Any) -> None:
        self._pipeline = pipeline
        self._np = numpy_module

    def extract_embedding(self, waveform: list[float]) -> Any:
        audio = self._np.asarray(waveform, dtype=self._np.float32)
        result = self._pipeline([audio], output_emb=True)
        if not isinstance(result, dict) or "embs" not in result:
            raise WorkerCrashedError(
                "ModelScope ERes2Net-large pipeline did not return embs",
                details={"model": MODEL_ID},
            )
        embeddings = result["embs"]
        if embeddings is None:
            return []
        try:
            return embeddings[0]
        except (IndexError, KeyError, TypeError):
            return []


def _load_modelscope_embedding_model(model_path: Path) -> _ModelScopeEmbeddingAdapter:
    # Only a resolved local directory is passed to ModelScope. This avoids
    # resolving MODEL_ID over the network during production inference/load.
    if not model_path.is_absolute() or not model_path.is_dir():
        raise ModelNotInstalledError(
            "ERes2Net-large production loader requires a local model directory",
            details={"model": MODEL_ID, "path": str(model_path)},
        )
    try:
        import numpy as np
        from modelscope.pipelines import pipeline
        from modelscope.utils.constant import Tasks
    except Exception as exc:
        raise BackendUnavailableError(
            "ModelScope ERes2Net-large runtime dependencies are unavailable",
            details={"model": MODEL_ID, "error_type": type(exc).__name__},
        ) from exc

    try:
        model_pipeline = pipeline(
            task=Tasks.speaker_verification,
            model=str(model_path),
        )
    except Exception as exc:
        raise BackendUnavailableError(
            f"ModelScope could not load local ERes2Net-large package: {exc}",
            details={"model": MODEL_ID, "path": str(model_path), "error_type": type(exc).__name__},
        ) from exc
    return _ModelScopeEmbeddingAdapter(model_pipeline, np)


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
            raise WorkerCrashedError(
                "ERes2Net-large embedding contained a non-numeric value"
            ) from exc
        if not math.isfinite(number):
            raise WorkerCrashedError(
                "ERes2Net-large embedding contained a non-finite value"
            )
        output.append(number)

    visit(current)
    return output


def _float32(value: float) -> float:
    return struct.unpack("!f", struct.pack("!f", float(value)))[0]
