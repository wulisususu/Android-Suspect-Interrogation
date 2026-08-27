from __future__ import annotations

import math
import statistics
import struct
from typing import Any

from sqlalchemy.orm import Session

from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import voiceprints as voiceprint_repo


_SAMPLE_RATE = 16000
_MIN_USABLE_SPEECH_MS = 20000
_MIN_SEGMENT_MS = 1000
_MAX_SEGMENT_MS = 8000
_MIN_EMBEDDING_SEGMENTS = 3
_FLOAT32_BYTES = 4


class VoiceprintService:
    def __init__(self, db: Session, *, speech_client: Any):
        self.db = db
        self.speech_client = speech_client

    def enroll_suspect(self, case_id: str, pcm: bytes, actor_id: str | None = None) -> dict:
        case_repo.get(self.db, case_id)
        audio = self._validate_pcm16(pcm)
        segments = self.speech_client.speech_segments(audio, sample_rate=_SAMPLE_RATE)
        usable_duration_ms = sum(max(0, int(end) - int(start)) for start, end in segments)
        if usable_duration_ms < _MIN_USABLE_SPEECH_MS:
            raise DomainError(
                "VOICEPRINT_INSUFFICIENT_SPEECH",
                "有效语音不足20秒，请重新录制声纹",
                400,
            )

        chunks = self._embedding_chunks(segments, total_ms=self._pcm_duration_ms(audio))
        if len(chunks) < _MIN_EMBEDDING_SEGMENTS:
            raise DomainError(
                "VOICEPRINT_INSUFFICIENT_SEGMENTS",
                "有效语音片段不足，请重新录制声纹",
                400,
            )

        vectors: list[list[float]] = []
        model_id: str | None = None
        model_version: str | None = None
        for start_ms, end_ms in chunks:
            segment_pcm = self._slice_pcm(audio, start_ms, end_ms)
            result = self.speech_client.extract_embedding(segment_pcm, sample_rate=_SAMPLE_RATE)
            vector = self._normalize_embedding(result.get("embedding"))
            if model_id is None:
                model_id = str(result.get("model_id") or "xvector")
                version = result.get("model_version")
                model_version = None if version is None else str(version)
            vectors.append(vector)

        reference = self._aggregate_embeddings(vectors)
        embedding_bytes = struct.pack(f"<{len(reference)}f", *reference)
        existing = voiceprint_repo.get_suspect(self.db, case_id, active_only=False)
        if existing is None:
            row = voiceprint_repo.enroll_suspect(
                self.db,
                case_id=case_id,
                embedding=embedding_bytes,
                embedding_dim=len(reference),
                model_id=model_id or "xvector",
                model_version=model_version,
                enrollment_quality="GOOD",
                usable_duration_ms=usable_duration_ms,
            )
            action = "SUSPECT_VOICEPRINT_ENROLL"
        else:
            row = voiceprint_repo.replace_suspect(
                self.db,
                case_id=case_id,
                embedding=embedding_bytes,
                embedding_dim=len(reference),
                model_id=model_id or "xvector",
                model_version=model_version,
                enrollment_quality="GOOD",
                usable_duration_ms=usable_duration_ms,
            )
            action = "SUSPECT_VOICEPRINT_REENROLL"

        audit_repo.add(
            self.db,
            case_id=case_id,
            actor_id=actor_id,
            action=action,
            target_type="SUSPECT_VOICEPRINT",
            target_id=row.id,
            detail={
                "dimension": row.embedding_dim,
                "model_id": row.model_id,
                "model_version": row.model_version,
                "usable_duration_ms": row.usable_duration_ms,
                "quality": row.enrollment_quality,
                "segment_count": len(vectors),
            },
        )
        self.db.commit()
        return {
            "caseId": case_id,
            "voiceprintId": row.id,
            "ready": True,
            "usableDurationMs": row.usable_duration_ms,
            "embeddingDim": row.embedding_dim,
            "modelId": row.model_id,
            "modelVersion": row.model_version,
            "quality": row.enrollment_quality,
        }

    @staticmethod
    def _validate_pcm16(pcm: bytes) -> bytes:
        if not isinstance(pcm, (bytes, bytearray, memoryview)):
            raise DomainError("VOICEPRINT_AUDIO_INVALID", "声纹录音必须为PCM16音频", 400)
        audio = bytes(pcm)
        if not audio or len(audio) % 2:
            raise DomainError("VOICEPRINT_AUDIO_INVALID", "声纹录音必须为完整PCM16采样", 400)
        samples = memoryview(audio).cast("h")
        if all(sample == 0 for sample in samples):
            raise DomainError("VOICEPRINT_AUDIO_SILENT", "未检测到有效声音，请重新录制声纹", 400)
        return audio

    @staticmethod
    def _pcm_duration_ms(pcm: bytes) -> int:
        return len(pcm) * 1000 // (_SAMPLE_RATE * 2)

    @staticmethod
    def _embedding_chunks(segments: list[list[int]], *, total_ms: int) -> list[tuple[int, int]]:
        chunks: list[tuple[int, int]] = []
        for raw_start, raw_end in segments:
            start = max(0, int(raw_start))
            end = min(total_ms, int(raw_end))
            cursor = start
            while end - cursor >= _MIN_SEGMENT_MS:
                chunk_end = min(end, cursor + _MAX_SEGMENT_MS)
                if chunk_end - cursor >= _MIN_SEGMENT_MS:
                    chunks.append((cursor, chunk_end))
                cursor = chunk_end
        return chunks

    @staticmethod
    def _slice_pcm(pcm: bytes, start_ms: int, end_ms: int) -> bytes:
        start_sample = start_ms * _SAMPLE_RATE // 1000
        end_sample = end_ms * _SAMPLE_RATE // 1000
        return pcm[start_sample * 2 : end_sample * 2]

    @staticmethod
    def _normalize_embedding(value: Any) -> list[float]:
        if not isinstance(value, (list, tuple)) or not value:
            raise DomainError("VOICEPRINT_EMBEDDING_INVALID", "声纹模型返回了无效向量", 500)
        try:
            vector = [float(item) for item in value]
        except (TypeError, ValueError) as exc:
            raise DomainError("VOICEPRINT_EMBEDDING_INVALID", "声纹模型返回了非数值向量", 500) from exc
        if not all(math.isfinite(item) for item in vector):
            raise DomainError("VOICEPRINT_EMBEDDING_INVALID", "声纹模型返回了非法数值", 500)
        norm = math.sqrt(sum(item * item for item in vector))
        if norm <= 0.0:
            raise DomainError("VOICEPRINT_EMBEDDING_INVALID", "声纹模型返回了零向量", 500)
        return [item / norm for item in vector]

    @classmethod
    def _aggregate_embeddings(cls, vectors: list[list[float]]) -> list[float]:
        if len(vectors) < _MIN_EMBEDDING_SEGMENTS:
            raise DomainError("VOICEPRINT_INSUFFICIENT_SEGMENTS", "有效声纹片段不足", 400)
        dimension = len(vectors[0])
        if dimension <= 0 or any(len(vector) != dimension for vector in vectors):
            raise DomainError("VOICEPRINT_EMBEDDING_INVALID", "声纹向量维度不一致", 500)

        centroid = cls._normalize_embedding(
            [sum(vector[index] for vector in vectors) for index in range(dimension)]
        )
        similarities = [sum(a * b for a, b in zip(vector, centroid)) for vector in vectors]
        median_score = statistics.median(similarities)
        cutoff = median_score - 0.20
        kept = [vector for vector, score in zip(vectors, similarities) if score >= cutoff]
        if len(kept) < _MIN_EMBEDDING_SEGMENTS:
            raise DomainError("VOICEPRINT_INCONSISTENT_SAMPLES", "声纹样本差异过大，请重新录制", 400)

        reference = [sum(vector[index] for vector in kept) / len(kept) for index in range(dimension)]
        normalized = cls._normalize_embedding(reference)
        packed = struct.pack(f"<{len(normalized)}f", *normalized)
        if len(packed) != len(normalized) * _FLOAT32_BYTES:
            raise DomainError("VOICEPRINT_EMBEDDING_INVALID", "声纹向量序列化失败", 500)
        return normalized
