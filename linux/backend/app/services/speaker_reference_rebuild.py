from __future__ import annotations

import hashlib
import wave
from pathlib import Path
from typing import Any, Literal

from sqlalchemy.orm import Session

from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import voiceprints as voiceprint_repo
from app.services.voiceprint_service import VoiceprintService


_SAMPLE_RATE = 16_000
_TARGET_BACKEND = "eres2net_large"
_IDENTITY_TYPES = {"suspect", "officer"}
_AUDIO_FORMATS = {"wav", "pcm16"}


class SpeakerReferenceRebuildService:
    """Rebuild one model-specific voiceprint reference from explicit source audio.

    The service intentionally accepts PCM/WAV source material, not a pre-existing
    biometric vector. Model-specific embedding generation is delegated to the
    same VoiceprintService reference builder used by enrollment.
    """

    def __init__(self, db: Session, *, speech_client: Any) -> None:
        self.db = db
        self.speech_client = speech_client

    def rebuild(
        self,
        *,
        identity_type: str,
        identity_id: str,
        audio_path: str | Path,
        target_backend: str = _TARGET_BACKEND,
        audio_format: str | None = None,
        replace: bool = False,
        actor_id: str | None = None,
    ) -> dict[str, Any]:
        kind = str(identity_type or "").strip().lower()
        identity = str(identity_id or "").strip()
        backend = str(target_backend or "").strip().lower()
        if kind not in _IDENTITY_TYPES:
            raise DomainError(
                "SPEAKER_REFERENCE_IDENTITY_TYPE_INVALID",
                "identity_type 必须是 suspect 或 officer",
                400,
            )
        if not identity:
            raise DomainError("SPEAKER_REFERENCE_IDENTITY_REQUIRED", "identity_id 不能为空", 400)
        if backend != _TARGET_BACKEND:
            raise DomainError(
                "SPEAKER_REFERENCE_TARGET_UNSUPPORTED",
                "首版 reference rebuild 仅支持 eres2net_large 目标后端",
                400,
                data={"target_backend": backend},
            )

        path = Path(audio_path).expanduser()
        if not path.is_file():
            return {
                "status": "NEEDS_REENROLL",
                "identityType": kind,
                "identityId": identity,
                "targetBackend": backend,
                "reason": "SOURCE_AUDIO_UNAVAILABLE",
            }

        source_identity = self._resolve_identity(kind, identity, backend)
        existing = self._target_reference(kind, identity, backend)
        if existing is not None and not replace:
            raise DomainError(
                "SPEAKER_REFERENCE_TARGET_EXISTS",
                "目标模型 reference 已存在；如需从源音频重建必须显式使用 replace",
                409,
                data={"identity_type": kind, "identity_id": identity, "target_backend": backend},
            )

        pcm, path_class = self._load_source_audio(path, audio_format=audio_format)
        digest = hashlib.sha256(pcm).hexdigest()
        reference = VoiceprintService(
            self.db,
            speech_client=self.speech_client,
            speaker_model_key=backend,
        ).build_reference_for_backend(pcm, backend)

        if kind == "suspect":
            row = self._persist_suspect(identity, reference, existing=existing, replace=replace)
            case_id: str | None = identity
            target_type = "SUSPECT_VOICEPRINT"
        else:
            row = self._persist_officer(
                identity,
                str(source_identity["officer_name"]),
                reference,
                existing=existing,
                replace=replace,
            )
            case_id = None
            target_type = "OFFICER_VOICEPRINT"

        audit_repo.add(
            self.db,
            case_id=case_id,
            actor_id=actor_id,
            action="SPEAKER_REFERENCE_REBUILD",
            target_type=target_type,
            target_id=row.id,
            detail={
                "identity_type": kind,
                "identity_id": identity,
                "source_audio_sha256": digest,
                "source_path_class": path_class,
                "target_backend": backend,
                "target_model_id": reference["model_id"],
                "target_model_version": reference.get("model_version"),
                "target_model_fingerprint": reference.get("model_fingerprint"),
                "target_embedding_dim": int(reference["dimension"]),
                "usable_duration_ms": int(reference["usable_duration_ms"]),
                "segment_count": int(reference["segment_count"]),
                "replace": bool(replace),
            },
        )
        self.db.commit()

        return {
            "status": "REPLACED" if existing is not None else "REBUILT",
            "identityType": kind,
            "identityId": identity,
            "targetBackend": backend,
            "voiceprintId": row.id,
            "modelId": reference["model_id"],
            "modelVersion": reference.get("model_version"),
            "modelFingerprint": reference.get("model_fingerprint"),
            "embeddingDim": int(reference["dimension"]),
            "usableDurationMs": int(reference["usable_duration_ms"]),
            "sourceAudioSha256": digest,
            "sourcePathClass": path_class,
        }

    def _resolve_identity(self, kind: str, identity: str, backend: str) -> dict[str, Any]:
        if kind == "suspect":
            case_repo.get(self.db, identity)
            return {"case_id": identity}

        # Only identity metadata is reused. The pre-existing vector is never read
        # by the rebuild algorithm or supplied to the target backend.
        source = voiceprint_repo.get_officer(
            self.db,
            identity,
            model_key="xvector",
            active_only=False,
        )
        if source is None:
            source = voiceprint_repo.get_officer(
                self.db,
                identity,
                model_key=backend,
                active_only=False,
            )
        if source is None:
            raise DomainError(
                "OFFICER_VOICEPRINT_NOT_FOUND",
                "找不到该民警的已有身份元数据，无法执行 reference rebuild",
                404,
            )
        return {"officer_name": source.officer_name}

    def _target_reference(self, kind: str, identity: str, backend: str):
        if kind == "suspect":
            return voiceprint_repo.get_suspect(
                self.db,
                identity,
                model_key=backend,
                active_only=False,
            )
        return voiceprint_repo.get_officer(
            self.db,
            identity,
            model_key=backend,
            active_only=False,
        )

    def _persist_suspect(self, case_id: str, reference: dict[str, Any], *, existing, replace: bool):
        kwargs = {
            "case_id": case_id,
            "model_key": reference["model_key"],
            "embedding": reference["bytes"],
            "embedding_dim": int(reference["dimension"]),
            "model_id": reference["model_id"],
            "model_version": reference.get("model_version"),
            "enrollment_quality": reference["quality"],
            "usable_duration_ms": int(reference["usable_duration_ms"]),
        }
        if existing is None:
            return voiceprint_repo.enroll_suspect(self.db, **kwargs)
        if not replace:
            raise AssertionError("duplicate target must be rejected before persistence")
        return voiceprint_repo.replace_suspect(self.db, **kwargs)

    def _persist_officer(
        self,
        officer_id: str,
        officer_name: str,
        reference: dict[str, Any],
        *,
        existing,
        replace: bool,
    ):
        kwargs = {
            "officer_id": officer_id,
            "officer_name": officer_name,
            "model_key": reference["model_key"],
            "embedding": reference["bytes"],
            "embedding_dim": int(reference["dimension"]),
            "model_id": reference["model_id"],
            "model_version": reference.get("model_version"),
            "enrollment_quality": reference["quality"],
            "usable_duration_ms": int(reference["usable_duration_ms"]),
        }
        if existing is None:
            return voiceprint_repo.enroll_officer(self.db, **kwargs)
        if not replace:
            raise AssertionError("duplicate target must be rejected before persistence")
        return voiceprint_repo.update_officer(self.db, **kwargs)

    @staticmethod
    def _load_source_audio(path: Path, *, audio_format: str | None) -> tuple[bytes, str]:
        selected = str(audio_format or "").strip().lower()
        if not selected:
            selected = "wav" if path.suffix.lower() == ".wav" else "pcm16" if path.suffix.lower() in {".pcm", ".raw"} else ""
        if selected not in _AUDIO_FORMATS:
            raise DomainError(
                "SPEAKER_REFERENCE_AUDIO_FORMAT_REQUIRED",
                "无法从文件名判断源音频格式，请显式指定 wav 或 pcm16",
                400,
            )
        if selected == "pcm16":
            try:
                pcm = path.read_bytes()
            except OSError as exc:
                raise DomainError("SPEAKER_REFERENCE_AUDIO_UNAVAILABLE", "无法读取源 PCM 文件", 400) from exc
            if not pcm or len(pcm) % 2:
                raise DomainError("SPEAKER_REFERENCE_AUDIO_INVALID", "PCM16 源音频为空或字节长度非法", 400)
            return pcm, "EXPLICIT_PCM16_FILE"

        try:
            with wave.open(str(path), "rb") as handle:
                if (
                    handle.getnchannels() != 1
                    or handle.getsampwidth() != 2
                    or handle.getframerate() != _SAMPLE_RATE
                    or handle.getcomptype() != "NONE"
                ):
                    raise DomainError(
                        "SPEAKER_REFERENCE_AUDIO_INVALID",
                        "WAV 源音频必须是 16kHz、单声道、PCM16、未压缩格式",
                        400,
                    )
                pcm = handle.readframes(handle.getnframes())
        except DomainError:
            raise
        except (OSError, EOFError, wave.Error) as exc:
            raise DomainError("SPEAKER_REFERENCE_AUDIO_INVALID", "WAV 源音频无法解析", 400) from exc
        if not pcm or len(pcm) % 2:
            raise DomainError("SPEAKER_REFERENCE_AUDIO_INVALID", "WAV 源音频没有有效 PCM16 数据", 400)
        return pcm, "EXPLICIT_WAV_FILE"
