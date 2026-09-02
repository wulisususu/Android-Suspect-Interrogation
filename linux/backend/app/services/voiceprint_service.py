from __future__ import annotations

import inspect
import math
import statistics
import struct
from typing import Any

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.ai.errors import AIError, BackendUnavailableError
from app.database.models import OfficerVoiceprint, SessionVoiceAssignment
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.repositories import voiceprints as voiceprint_repo


_SAMPLE_RATE = 16000
_MIN_USABLE_SPEECH_MS = 20000
_MIN_SEGMENT_MS = 1000
_MAX_SEGMENT_MS = 8000
_MIN_EMBEDDING_SEGMENTS = 3
_FLOAT32_BYTES = 4
_CLIP_LEVEL = 32760
_MAX_CLIPPED_SAMPLE_RATIO = 0.01
_XVECTOR = "xvector"
_ERES2NET_LARGE = "eres2net_large"
_ENROLLMENT_BACKENDS = (_XVECTOR, _ERES2NET_LARGE)


class VoiceprintService:
    def __init__(self, db: Session, *, speech_client: Any):
        self.db = db
        self.speech_client = speech_client

    def readiness(self, case_id: str) -> dict:
        case_repo.get(self.db, case_id)
        suspect = voiceprint_repo.get_suspect(self.db, case_id)
        interrogator_ready = False
        recorder_ready = False

        session = session_repo.active_for_case(self.db, case_id)
        if session is not None:
            assignment = self.db.scalar(
                select(SessionVoiceAssignment).where(SessionVoiceAssignment.session_id == session.id)
            )
            if assignment is not None:
                interrogator_ready = self._officer_active(assignment.interrogator_officer_id)
                recorder_ready = self._officer_active(assignment.recorder_officer_id)

        return {
            "suspectReady": suspect is not None,
            "interrogatorReady": interrogator_ready,
            "recorderReady": recorder_ready,
            "recognitionMode": self._recognition_mode(interrogator_ready, recorder_ready),
            "canStart": suspect is not None,
        }

    def enroll_suspect(self, case_id: str, pcm: bytes, actor_id: str | None = None) -> dict:
        case_repo.get(self.db, case_id)
        references, failures = self._build_dual_references(pcm)

        primary_reference = references[_XVECTOR]
        primary_row, primary_action = self._upsert_suspect_reference(
            case_id=case_id,
            reference=primary_reference,
        )
        audit_repo.add(
            self.db,
            case_id=case_id,
            actor_id=actor_id,
            action=primary_action,
            target_type="SUSPECT_VOICEPRINT",
            target_id=primary_row.id,
            detail=self._audit_reference_detail(
                primary_row,
                primary_reference["segment_count"],
                reference=primary_reference,
            ),
        )
        # XVector is the backward-compatible authoritative enrollment reference.
        # Commit it before attempting optional ERes2Net persistence so an optional
        # backend cannot erase a successfully refreshed XVector identity.
        self.db.commit()

        backend_results: dict[str, dict[str, Any]] = {
            _XVECTOR: self._ready_backend_result(primary_row, primary_reference)
        }

        optional_reference = references.get(_ERES2NET_LARGE)
        if optional_reference is not None:
            try:
                optional_row, optional_action = self._upsert_suspect_reference(
                    case_id=case_id,
                    reference=optional_reference,
                )
                audit_repo.add(
                    self.db,
                    case_id=case_id,
                    actor_id=actor_id,
                    action=optional_action,
                    target_type="SUSPECT_VOICEPRINT",
                    target_id=optional_row.id,
                    detail=self._audit_reference_detail(
                        optional_row,
                        optional_reference["segment_count"],
                        reference=optional_reference,
                    ),
                )
                self.db.commit()
                backend_results[_ERES2NET_LARGE] = self._ready_backend_result(
                    optional_row,
                    optional_reference,
                )
            except (AIError, DomainError) as exc:
                self.db.rollback()
                backend_results[_ERES2NET_LARGE] = self._not_ready_backend_result(exc)
        else:
            backend_results[_ERES2NET_LARGE] = self._not_ready_backend_result(
                failures.get(_ERES2NET_LARGE)
                or BackendUnavailableError(
                    "ERes2Net-large enrollment reference is unavailable",
                    details={"backend_key": _ERES2NET_LARGE},
                )
            )

        return {
            "caseId": case_id,
            "voiceprintId": primary_row.id,
            "ready": True,
            "dualReady": all(
                backend_results[key].get("ready") is True for key in _ENROLLMENT_BACKENDS
            ),
            "backends": backend_results,
            "usableDurationMs": primary_row.usable_duration_ms,
            "embeddingDim": primary_row.embedding_dim,
            "modelKey": primary_row.model_key,
            "modelId": primary_row.model_id,
            "modelVersion": primary_row.model_version,
            "modelFingerprint": primary_reference.get("model_fingerprint"),
            "quality": primary_row.enrollment_quality,
        }

    def _upsert_suspect_reference(
        self,
        *,
        case_id: str,
        reference: dict[str, Any],
    ) -> tuple[Any, str]:
        model_key = str(reference["model_key"])
        existing = voiceprint_repo.get_suspect(
            self.db,
            case_id,
            model_key=model_key,
            active_only=False,
        )
        if existing is None:
            row = voiceprint_repo.enroll_suspect(
                self.db,
                case_id=case_id,
                model_key=model_key,
                embedding=reference["bytes"],
                embedding_dim=reference["dimension"],
                model_id=reference["model_id"],
                model_version=reference["model_version"],
                enrollment_quality=reference["quality"],
                usable_duration_ms=reference["usable_duration_ms"],
            )
            action = "SUSPECT_VOICEPRINT_ENROLL"
        else:
            row = voiceprint_repo.replace_suspect(
                self.db,
                case_id=case_id,
                model_key=model_key,
                embedding=reference["bytes"],
                embedding_dim=reference["dimension"],
                model_id=reference["model_id"],
                model_version=reference["model_version"],
                enrollment_quality=reference["quality"],
                usable_duration_ms=reference["usable_duration_ms"],
            )
            action = "SUSPECT_VOICEPRINT_REENROLL"
        return row, action

    def enroll_officer(
        self,
        officer_id: str,
        officer_name: str,
        pcm: bytes,
        actor_id: str | None = None,
    ) -> dict:
        officer_id = str(officer_id).strip()
        officer_name = str(officer_name).strip()
        if not officer_id or not officer_name:
            raise DomainError("OFFICER_IDENTITY_REQUIRED", "民警编号和姓名不能为空", 400)
        reference = self._build_reference(pcm)
        row = voiceprint_repo.enroll_officer(
            self.db,
            officer_id=officer_id,
            officer_name=officer_name,
            model_key=reference["model_key"],
            embedding=reference["bytes"],
            embedding_dim=reference["dimension"],
            model_id=reference["model_id"],
            model_version=reference["model_version"],
            enrollment_quality=reference["quality"],
            usable_duration_ms=reference["usable_duration_ms"],
        )
        audit_repo.add(
            self.db,
            case_id=None,
            actor_id=actor_id,
            action="OFFICER_VOICEPRINT_ENROLL",
            target_type="OFFICER_VOICEPRINT",
            target_id=row.id,
            detail={
                "officer_id": row.officer_id,
                "officer_name": row.officer_name,
                **self._audit_reference_detail(
                    row,
                    reference["segment_count"],
                    reference=reference,
                ),
            },
        )
        self.db.commit()
        return self._officer_dict(row)

    def update_officer(self, officer_id: str, pcm: bytes, actor_id: str | None = None) -> dict:
        existing = voiceprint_repo.get_officer(self.db, officer_id, active_only=False)
        if existing is None:
            raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "民警声纹档案不存在", 404)
        reference = self._build_reference(pcm)
        row = voiceprint_repo.update_officer(
            self.db,
            officer_id=existing.officer_id,
            officer_name=existing.officer_name,
            model_key=reference["model_key"],
            embedding=reference["bytes"],
            embedding_dim=reference["dimension"],
            model_id=reference["model_id"],
            model_version=reference["model_version"],
            enrollment_quality=reference["quality"],
            usable_duration_ms=reference["usable_duration_ms"],
        )
        audit_repo.add(
            self.db,
            case_id=None,
            actor_id=actor_id,
            action="OFFICER_VOICEPRINT_UPDATE",
            target_type="OFFICER_VOICEPRINT",
            target_id=row.id,
            detail={
                "officer_id": row.officer_id,
                "officer_name": row.officer_name,
                **self._audit_reference_detail(
                    row,
                    reference["segment_count"],
                    reference=reference,
                ),
            },
        )
        self.db.commit()
        return self._officer_dict(row)

    def revoke_officer(self, officer_id: str, actor_id: str | None = None) -> dict:
        row = voiceprint_repo.revoke_officer(self.db, officer_id=officer_id)
        audit_repo.add(
            self.db,
            case_id=None,
            actor_id=actor_id,
            action="OFFICER_VOICEPRINT_REVOKE",
            target_type="OFFICER_VOICEPRINT",
            target_id=row.id,
            detail={"officer_id": row.officer_id, "officer_name": row.officer_name},
        )
        self.db.commit()
        return self._officer_dict(row)

    def list_officers(self, active_only: bool = True) -> list[dict]:
        # Legacy API remains XVector-centric through Task 5. Task 6 selects a
        # backend explicitly for session binding/readiness.
        stmt = select(OfficerVoiceprint).where(OfficerVoiceprint.model_key == _XVECTOR)
        if active_only:
            stmt = stmt.where(OfficerVoiceprint.active.is_(True), OfficerVoiceprint.revoked_at.is_(None))
        stmt = stmt.order_by(OfficerVoiceprint.officer_id.asc())
        return [self._officer_dict(row) for row in self.db.scalars(stmt)]

    def bind_roles(
        self,
        case_id: str,
        interrogator_officer_id: str | None,
        recorder_officer_id: str | None,
        actor_id: str | None = None,
    ) -> dict:
        case_repo.get(self.db, case_id)
        session = session_repo.active_for_case(self.db, case_id)
        if session is None:
            raise DomainError("SESSION_NOT_ACTIVE", "请先开始审讯再绑定民警声纹角色", 409)
        suspect = voiceprint_repo.get_suspect(self.db, case_id)
        if suspect is None:
            raise DomainError("SUSPECT_VOICEPRINT_REQUIRED", "请先完成嫌疑人声纹注册", 409)

        assignment = voiceprint_repo.assign_session_roles(
            self.db,
            session_id=session.id,
            suspect_voiceprint_id=suspect.id,
            interrogator_officer_id=self._optional_id(interrogator_officer_id),
            recorder_officer_id=self._optional_id(recorder_officer_id),
        )
        audit_repo.add(
            self.db,
            case_id=case_id,
            actor_id=actor_id,
            action="SESSION_VOICE_ROLE_BIND",
            target_type="SESSION_VOICE_ASSIGNMENT",
            target_id=assignment.id,
            detail={
                "session_id": session.id,
                "interrogator_officer_id": assignment.interrogator_officer_id,
                "recorder_officer_id": assignment.recorder_officer_id,
                "recognition_mode": assignment.recognition_mode,
            },
        )
        self.db.commit()
        return {
            "sessionId": session.id,
            "assignmentId": assignment.id,
            "suspectReady": True,
            "interrogatorReady": assignment.interrogator_voiceprint_id is not None,
            "recorderReady": assignment.recorder_voiceprint_id is not None,
            "recognitionMode": assignment.recognition_mode,
            "canStart": True,
        }

    def _build_reference(self, pcm: bytes) -> dict[str, Any]:
        prepared = self._prepare_reference_audio(pcm)
        return self._build_reference_for_backend(prepared, _XVECTOR)

    def _build_dual_references(
        self,
        pcm: bytes,
    ) -> tuple[dict[str, dict[str, Any]], dict[str, Exception]]:
        prepared = self._prepare_reference_audio(pcm)
        references: dict[str, dict[str, Any]] = {}
        failures: dict[str, Exception] = {}

        # XVector remains required for backward compatibility in Task 5.
        references[_XVECTOR] = self._build_reference_for_backend(prepared, _XVECTOR)

        try:
            references[_ERES2NET_LARGE] = self._build_reference_for_backend(
                prepared,
                _ERES2NET_LARGE,
            )
        except (AIError, DomainError) as exc:
            failures[_ERES2NET_LARGE] = exc
        return references, failures

    def _prepare_reference_audio(self, pcm: bytes) -> dict[str, Any]:
        audio = self._validate_pcm16(pcm)
        segments = self.speech_client.speech_segments(audio, sample_rate=_SAMPLE_RATE)
        usable_duration_ms = sum(max(0, int(end) - int(start)) for start, end in segments)
        if usable_duration_ms < _MIN_USABLE_SPEECH_MS:
            raise DomainError(
                "VOICEPRINT_INSUFFICIENT_SPEECH",
                "有效语音不足20秒，请重新录制声纹",
                400,
            )

        chunk_ranges = self._embedding_chunks(segments, total_ms=self._pcm_duration_ms(audio))
        if len(chunk_ranges) < _MIN_EMBEDDING_SEGMENTS:
            raise DomainError(
                "VOICEPRINT_INSUFFICIENT_SEGMENTS",
                "有效语音片段不足，请重新录制声纹",
                400,
            )
        chunks = [self._slice_pcm(audio, start_ms, end_ms) for start_ms, end_ms in chunk_ranges]
        return {
            "audio": audio,
            "chunks": chunks,
            "usable_duration_ms": usable_duration_ms,
        }

    def _build_reference_for_backend(
        self,
        prepared: dict[str, Any],
        backend: str,
    ) -> dict[str, Any]:
        vectors: list[list[float]] = []
        model_id: str | None = None
        model_version: str | None = None
        model_fingerprint: str | None = None
        for pcm_chunk in prepared["chunks"]:
            result = self._extract_embedding_for_backend(pcm_chunk, backend)
            result_backend = result.get("backend_key")
            if result_backend is not None and str(result_backend).strip().lower() != backend:
                raise DomainError(
                    "VOICEPRINT_BACKEND_MISMATCH",
                    "声纹运行时返回了错误的模型空间",
                    500,
                )
            vector = self._normalize_embedding(result.get("embedding"))
            current_model_id = str(result.get("model_id") or backend)
            version_value = result.get("model_version")
            current_version = None if version_value is None else str(version_value)
            fingerprint_value = result.get("model_fingerprint")
            current_fingerprint = None if fingerprint_value is None else str(fingerprint_value)
            if model_id is None:
                model_id = current_model_id
                model_version = current_version
                model_fingerprint = current_fingerprint
            else:
                if current_model_id != model_id:
                    raise DomainError(
                        "VOICEPRINT_MODEL_MISMATCH",
                        "同一次声纹登记返回了不一致的模型标识",
                        500,
                    )
                if model_version and current_version and current_version != model_version:
                    raise DomainError(
                        "VOICEPRINT_MODEL_MISMATCH",
                        "同一次声纹登记返回了不一致的模型版本",
                        500,
                    )
                if model_fingerprint and current_fingerprint and current_fingerprint != model_fingerprint:
                    raise DomainError(
                        "VOICEPRINT_MODEL_MISMATCH",
                        "同一次声纹登记返回了不一致的模型指纹",
                        500,
                    )
            vectors.append(vector)

        reference = self._aggregate_embeddings(vectors)
        return {
            "bytes": struct.pack(f"<{len(reference)}f", *reference),
            "dimension": len(reference),
            "model_key": backend,
            "model_id": model_id or backend,
            "model_version": model_version,
            "model_fingerprint": model_fingerprint,
            "quality": "GOOD",
            "usable_duration_ms": int(prepared["usable_duration_ms"]),
            "segment_count": len(vectors),
        }

    def _extract_embedding_for_backend(self, pcm: bytes, backend: str) -> dict[str, Any]:
        method = self.speech_client.extract_embedding
        supports_backend = True
        try:
            parameters = inspect.signature(method).parameters.values()
            supports_backend = any(
                parameter.name == "backend" or parameter.kind is inspect.Parameter.VAR_KEYWORD
                for parameter in parameters
            )
        except (TypeError, ValueError):
            pass
        if supports_backend:
            return method(pcm, sample_rate=_SAMPLE_RATE, backend=backend)
        if backend == _XVECTOR:
            # Compatibility seam for existing local fakes and pre-Task-5 clients.
            return method(pcm, sample_rate=_SAMPLE_RATE)
        raise BackendUnavailableError(
            "speech client does not support the requested speaker backend",
            details={"backend_key": backend},
        )

    def _officer_active(self, officer_id: str | None) -> bool:
        return bool(officer_id and voiceprint_repo.get_officer(self.db, officer_id) is not None)

    @staticmethod
    def _recognition_mode(interrogator_ready: bool, recorder_ready: bool) -> str:
        if interrogator_ready and recorder_ready:
            return "FULL"
        if interrogator_ready:
            return "SUSPECT_PLUS_INTERROGATOR"
        if recorder_ready:
            return "SUSPECT_PLUS_RECORDER"
        return "SUSPECT_ONLY"

    @staticmethod
    def _optional_id(value: str | None) -> str | None:
        if value is None:
            return None
        normalized = str(value).strip()
        return normalized or None

    @staticmethod
    def _officer_dict(row: OfficerVoiceprint) -> dict:
        return {
            "voiceprintId": row.id,
            "officerId": row.officer_id,
            "officerName": row.officer_name,
            "active": bool(row.active and row.revoked_at is None),
            "revokedAt": row.revoked_at.isoformat() if row.revoked_at is not None else None,
            "usableDurationMs": row.usable_duration_ms,
            "embeddingDim": row.embedding_dim,
            "modelKey": row.model_key,
            "modelId": row.model_id,
            "modelVersion": row.model_version,
            "quality": row.enrollment_quality,
        }

    @staticmethod
    def _audit_reference_detail(
        row: Any,
        segment_count: int,
        *,
        reference: dict[str, Any] | None = None,
    ) -> dict:
        return {
            "dimension": row.embedding_dim,
            "model_key": getattr(row, "model_key", _XVECTOR),
            "model_id": row.model_id,
            "model_version": row.model_version,
            "model_fingerprint": reference.get("model_fingerprint") if reference else None,
            "usable_duration_ms": row.usable_duration_ms,
            "quality": row.enrollment_quality,
            "segment_count": int(segment_count),
        }

    @staticmethod
    def _ready_backend_result(row: Any, reference: dict[str, Any]) -> dict[str, Any]:
        return {
            "ready": True,
            "status": "READY",
            "voiceprintId": row.id,
            "modelKey": row.model_key,
            "modelId": row.model_id,
            "modelVersion": row.model_version,
            "modelFingerprint": reference.get("model_fingerprint"),
            "embeddingDim": row.embedding_dim,
            "usableDurationMs": row.usable_duration_ms,
            "quality": row.enrollment_quality,
        }

    @staticmethod
    def _not_ready_backend_result(exc: Exception) -> dict[str, Any]:
        if isinstance(exc, AIError):
            code = exc.code
            message = exc.message
        elif isinstance(exc, DomainError):
            code = exc.code
            message = exc.message
        else:
            code = "BACKEND_UNAVAILABLE"
            message = str(exc)
        return {
            "ready": False,
            "status": "NOT_READY",
            "errorCode": code,
            "message": message,
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
        clipped_count = sum(1 for sample in samples if abs(int(sample)) >= _CLIP_LEVEL)
        if clipped_count / len(samples) >= _MAX_CLIPPED_SAMPLE_RATIO:
            raise DomainError("VOICEPRINT_AUDIO_CLIPPED", "录音存在明显削波，请降低输入增益后重新录制", 400)
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
