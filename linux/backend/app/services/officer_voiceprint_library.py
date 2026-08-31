from __future__ import annotations

import math
import struct
from datetime import datetime, timezone
from typing import Any
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import OfficerVoiceprint
from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.services.voiceprint_service import VoiceprintService


_FLOAT32_BYTES = 4
_SNAPSHOT_PREFIX = "__session_snapshot__:"
_ALLOWED_SOURCES = {"ALSA", "BROWSER"}
_QUALITY_WEIGHTS = {"GOOD": 1.0, "FAIR": 0.75}


class OfficerVoiceprintLibraryService:
    """System-level officer voiceprint profile and sample administration.

    The legacy ``officer_voiceprints`` table remains an internal compatibility
    bridge for the established ASR path. It always mirrors the latest aggregate
    reference for an officer. Session binding clones that bridge row, so active
    interrogations never follow later global-library updates.
    """

    def __init__(self, db: Session, *, speech_client: Any):
        self.db = db
        self.speech_client = speech_client

    def list_profiles(self, *, active_only: bool = True) -> list[dict[str, Any]]:
        self._materialize_legacy_profiles()
        stmt = select(OfficerVoiceProfile)
        if active_only:
            stmt = stmt.where(
                OfficerVoiceProfile.active.is_(True),
                OfficerVoiceProfile.revoked_at.is_(None),
                OfficerVoiceProfile.sample_count > 0,
            )
        stmt = stmt.order_by(OfficerVoiceProfile.officer_id.asc())
        return [self._profile_dict(profile) for profile in self.db.scalars(stmt)]

    def get_profile(self, officer_id: str, *, include_inactive: bool = True) -> dict[str, Any]:
        profile = self._profile_or_error(officer_id, include_inactive=include_inactive)
        result = self._profile_dict(profile)
        samples = list(
            self.db.scalars(
                select(OfficerVoiceSample)
                .where(OfficerVoiceSample.profile_id == profile.id)
                .order_by(OfficerVoiceSample.captured_at.desc(), OfficerVoiceSample.created_at.desc())
            )
        )
        result["samples"] = [self._sample_dict(sample) for sample in samples]
        return result

    def add_sample(
        self,
        officer_id: str,
        officer_name: str,
        pcm: bytes,
        *,
        actor_id: str | None = None,
        audio_source: str = "ALSA",
        device_id: str | None = None,
        device_name: str | None = None,
        microphone_fingerprint: str | None = None,
        microphone_fingerprint_certainty: str | None = None,
    ) -> dict[str, Any]:
        officer_id = str(officer_id or "").strip()
        officer_name = str(officer_name or "").strip()
        source = str(audio_source or "ALSA").strip().upper()
        if not officer_id or not officer_name:
            raise DomainError("OFFICER_IDENTITY_REQUIRED", "民警编号和姓名不能为空", 400)
        if source not in _ALLOWED_SOURCES:
            raise DomainError("VOICEPRINT_SOURCE_INVALID", "民警声纹录音音源无效", 400)

        self._materialize_legacy_profiles()
        reference = VoiceprintService(self.db, speech_client=self.speech_client)._build_reference(pcm)
        model_fingerprint = self._current_model_fingerprint()
        profile = self.db.scalar(
            select(OfficerVoiceProfile).where(OfficerVoiceProfile.officer_id == officer_id)
        )
        created_profile = profile is None
        if profile is None:
            profile = OfficerVoiceProfile(
                id=str(uuid4()),
                officer_id=officer_id,
                officer_name=officer_name,
                aggregate_embedding=reference["bytes"],
                embedding_dim=reference["dimension"],
                model_id=reference["model_id"],
                model_version=reference["model_version"],
                aggregate_version=0,
                sample_count=0,
                active=True,
                revoked_at=None,
            )
            self.db.add(profile)
            self.db.flush()
        else:
            self._validate_reference_compatibility(profile, reference)
            profile.officer_name = officer_name
            profile.active = True
            profile.revoked_at = None

        sample = OfficerVoiceSample(
            id=str(uuid4()),
            profile_id=profile.id,
            embedding=bytes(reference["bytes"]),
            embedding_dim=int(reference["dimension"]),
            model_id=str(reference["model_id"]),
            model_version=reference["model_version"],
            model_fingerprint=model_fingerprint,
            quality=str(reference["quality"]),
            usable_duration_ms=int(reference["usable_duration_ms"]),
            segment_count=int(reference["segment_count"]),
            audio_source=source,
            device_id=self._optional_text(device_id) or ("browser-default" if source == "BROWSER" else "alsa-default"),
            device_name=self._optional_text(device_name) or (
                "Windows Browser Microphone" if source == "BROWSER" else "Linux ALSA Microphone"
            ),
            microphone_fingerprint=self._optional_text(microphone_fingerprint),
            microphone_fingerprint_certainty=self._optional_text(microphone_fingerprint_certainty),
            captured_at=datetime.now(timezone.utc),
            active=True,
            disabled_at=None,
            disabled_reason=None,
            created_by=self._optional_text(actor_id),
        )
        self.db.add(sample)
        self.db.flush()

        self._rebuild_profile(profile, reactivate=True)
        bridge = self._sync_bridge(profile)
        audit_repo.add(
            self.db,
            case_id=None,
            actor_id=actor_id,
            action="OFFICER_VOICEPRINT_ENROLL" if created_profile else "OFFICER_VOICEPRINT_SAMPLE_ADD",
            target_type="OFFICER_VOICE_SAMPLE",
            target_id=sample.id,
            detail={
                "officer_id": profile.officer_id,
                "officer_name": profile.officer_name,
                "profile_id": profile.id,
                "sample_id": sample.id,
                "aggregate_version": profile.aggregate_version,
                "sample_count": profile.sample_count,
                "quality": sample.quality,
                "usable_duration_ms": sample.usable_duration_ms,
                "segment_count": sample.segment_count,
                "audio_source": sample.audio_source,
                "device_id": sample.device_id,
                "device_name": sample.device_name,
                "model_id": sample.model_id,
                "model_version": sample.model_version,
                "model_fingerprint": sample.model_fingerprint,
                "microphone_fingerprint": sample.microphone_fingerprint,
                "microphone_fingerprint_certainty": sample.microphone_fingerprint_certainty,
            },
        )
        self.db.commit()
        result = self._profile_dict(profile, bridge=bridge)
        result["latestSampleId"] = sample.id
        return result

    def disable_sample(
        self,
        officer_id: str,
        sample_id: str,
        *,
        reason: str | None = None,
        actor_id: str | None = None,
    ) -> dict[str, Any]:
        profile = self._profile_or_error(officer_id, include_inactive=True)
        sample = self.db.get(OfficerVoiceSample, str(sample_id))
        if sample is None or sample.profile_id != profile.id:
            raise DomainError("OFFICER_VOICEPRINT_SAMPLE_NOT_FOUND", "民警声纹样本不存在", 404)
        if sample.active:
            sample.active = False
            sample.disabled_at = datetime.now(timezone.utc)
            sample.disabled_reason = self._optional_text(reason) or "管理员停用"
            self._rebuild_profile(profile, reactivate=False)
            bridge = self._sync_bridge(profile)
            audit_repo.add(
                self.db,
                case_id=None,
                actor_id=actor_id,
                action="OFFICER_VOICEPRINT_SAMPLE_DISABLE",
                target_type="OFFICER_VOICE_SAMPLE",
                target_id=sample.id,
                detail={
                    "officer_id": profile.officer_id,
                    "profile_id": profile.id,
                    "sample_id": sample.id,
                    "disabled_reason": sample.disabled_reason,
                    "aggregate_version": profile.aggregate_version,
                    "sample_count": profile.sample_count,
                },
            )
            self.db.commit()
        else:
            bridge = self._bridge(profile.officer_id)
        return self._profile_dict(profile, bridge=bridge)

    def revoke_profile(self, officer_id: str, *, actor_id: str | None = None) -> dict[str, Any]:
        profile = self._profile_or_error(officer_id, include_inactive=True)
        profile.active = False
        profile.revoked_at = datetime.now(timezone.utc)
        bridge = self._bridge(profile.officer_id)
        if bridge is not None:
            bridge.active = False
            bridge.revoked_at = profile.revoked_at
        audit_repo.add(
            self.db,
            case_id=None,
            actor_id=actor_id,
            action="OFFICER_VOICEPRINT_REVOKE",
            target_type="OFFICER_VOICE_PROFILE",
            target_id=profile.id,
            detail={
                "officer_id": profile.officer_id,
                "officer_name": profile.officer_name,
                "aggregate_version": profile.aggregate_version,
                "sample_count": profile.sample_count,
            },
        )
        self.db.commit()
        return self._profile_dict(profile, bridge=bridge)

    def _profile_or_error(self, officer_id: str, *, include_inactive: bool) -> OfficerVoiceProfile:
        normalized = str(officer_id or "").strip()
        if not normalized:
            raise DomainError("OFFICER_IDENTITY_REQUIRED", "民警编号不能为空", 400)
        self._materialize_legacy_profiles()
        profile = self.db.scalar(
            select(OfficerVoiceProfile).where(OfficerVoiceProfile.officer_id == normalized)
        )
        if profile is None:
            raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "民警声纹档案不存在", 404)
        if not include_inactive and (not profile.active or profile.revoked_at is not None or profile.sample_count <= 0):
            raise DomainError("OFFICER_VOICEPRINT_NOT_ACTIVE", "民警声纹档案已停用", 409)
        return profile

    def _materialize_legacy_profiles(self) -> None:
        bridges = list(
            self.db.scalars(
                select(OfficerVoiceprint).where(
                    ~OfficerVoiceprint.officer_id.like(f"{_SNAPSHOT_PREFIX}%")
                )
            )
        )
        for bridge in bridges:
            exists = self.db.scalar(
                select(OfficerVoiceProfile.id).where(OfficerVoiceProfile.officer_id == bridge.officer_id)
            )
            if exists is not None:
                continue
            profile = OfficerVoiceProfile(
                id=str(uuid4()),
                officer_id=bridge.officer_id,
                officer_name=bridge.officer_name,
                aggregate_embedding=bytes(bridge.embedding),
                embedding_dim=bridge.embedding_dim,
                model_id=bridge.model_id,
                model_version=bridge.model_version,
                aggregate_version=1,
                sample_count=1,
                active=bool(bridge.active and bridge.revoked_at is None),
                revoked_at=bridge.revoked_at,
            )
            self.db.add(profile)
            self.db.flush()
            self.db.add(
                OfficerVoiceSample(
                    id=str(uuid4()),
                    profile_id=profile.id,
                    embedding=bytes(bridge.embedding),
                    embedding_dim=bridge.embedding_dim,
                    model_id=bridge.model_id,
                    model_version=bridge.model_version,
                    model_fingerprint=None,
                    quality=bridge.enrollment_quality,
                    usable_duration_ms=bridge.usable_duration_ms,
                    segment_count=0,
                    audio_source="LEGACY_MIGRATED",
                    device_id=None,
                    device_name="Legacy migrated reference",
                    microphone_fingerprint=None,
                    microphone_fingerprint_certainty=None,
                    captured_at=bridge.created_at,
                    active=True,
                    disabled_at=None,
                    disabled_reason=None,
                    created_by=None,
                )
            )
        self.db.flush()

    def _current_model_fingerprint(self) -> str | None:
        health_fn = getattr(self.speech_client, "health", None)
        if not callable(health_fn):
            return None
        try:
            health = health_fn()
        except Exception:
            return None
        if not isinstance(health, dict):
            return None
        value = health.get("speaker_model_fingerprint")
        return self._optional_text(value)

    def _validate_reference_compatibility(self, profile: OfficerVoiceProfile, reference: dict[str, Any]) -> None:
        if profile.embedding_dim != int(reference["dimension"]):
            raise DomainError("OFFICER_VOICEPRINT_MODEL_MISMATCH", "新样本声纹维度与现有档案不一致", 409)
        if profile.model_id != str(reference["model_id"]):
            raise DomainError("OFFICER_VOICEPRINT_MODEL_MISMATCH", "新样本声纹模型与现有档案不一致", 409)
        current_version = self._optional_text(profile.model_version)
        incoming_version = self._optional_text(reference.get("model_version"))
        if current_version and incoming_version and current_version != incoming_version:
            raise DomainError("OFFICER_VOICEPRINT_MODEL_MISMATCH", "新样本声纹模型版本与现有档案不一致", 409)

    def _rebuild_profile(self, profile: OfficerVoiceProfile, *, reactivate: bool) -> None:
        samples = list(
            self.db.scalars(
                select(OfficerVoiceSample)
                .where(
                    OfficerVoiceSample.profile_id == profile.id,
                    OfficerVoiceSample.active.is_(True),
                )
                .order_by(OfficerVoiceSample.captured_at.asc(), OfficerVoiceSample.id.asc())
            )
        )
        profile.aggregate_version = max(0, int(profile.aggregate_version or 0)) + 1
        profile.sample_count = len(samples)
        if not samples:
            profile.active = False
            self.db.flush()
            return

        dimension = samples[0].embedding_dim
        model_id = samples[0].model_id
        model_version = samples[0].model_version
        weighted = [0.0] * dimension
        total_weight = 0.0
        for sample in samples:
            if sample.embedding_dim != dimension or sample.model_id != model_id:
                raise DomainError("OFFICER_VOICEPRINT_MODEL_MISMATCH", "启用样本包含不兼容的声纹模型", 409)
            vector = self._decode_embedding(sample.embedding, sample.embedding_dim)
            vector = self._normalize(vector)
            weight = self._sample_weight(sample)
            for index, value in enumerate(vector):
                weighted[index] += value * weight
            total_weight += weight
        if total_weight <= 0.0:
            raise DomainError("OFFICER_VOICEPRINT_AGGREGATE_INVALID", "民警声纹样本无法聚合", 500)
        aggregate = self._normalize([value / total_weight for value in weighted])
        profile.aggregate_embedding = struct.pack(f"<{dimension}f", *aggregate)
        profile.embedding_dim = dimension
        profile.model_id = model_id
        profile.model_version = model_version
        if reactivate or profile.revoked_at is None:
            profile.active = True
        if reactivate:
            profile.revoked_at = None
        self.db.flush()

    def _sync_bridge(self, profile: OfficerVoiceProfile) -> OfficerVoiceprint:
        bridge = self._bridge(profile.officer_id)
        active_samples = list(
            self.db.scalars(
                select(OfficerVoiceSample).where(
                    OfficerVoiceSample.profile_id == profile.id,
                    OfficerVoiceSample.active.is_(True),
                )
            )
        )
        total_duration = sum(int(row.usable_duration_ms) for row in active_samples)
        if bridge is None:
            bridge = OfficerVoiceprint(
                id=str(uuid4()),
                officer_id=profile.officer_id,
                officer_name=profile.officer_name,
                embedding=bytes(profile.aggregate_embedding),
                embedding_dim=profile.embedding_dim,
                model_id=profile.model_id,
                model_version=profile.model_version,
                enrollment_quality="AGGREGATED",
                usable_duration_ms=total_duration,
                active=bool(profile.active and profile.sample_count > 0 and profile.revoked_at is None),
                revoked_at=profile.revoked_at,
            )
            self.db.add(bridge)
        else:
            bridge.officer_name = profile.officer_name
            bridge.embedding = bytes(profile.aggregate_embedding)
            bridge.embedding_dim = profile.embedding_dim
            bridge.model_id = profile.model_id
            bridge.model_version = profile.model_version
            bridge.enrollment_quality = "AGGREGATED"
            bridge.usable_duration_ms = total_duration
            bridge.active = bool(profile.active and profile.sample_count > 0 and profile.revoked_at is None)
            bridge.revoked_at = profile.revoked_at
        self.db.flush()
        return bridge

    def _bridge(self, officer_id: str) -> OfficerVoiceprint | None:
        return self.db.scalar(
            select(OfficerVoiceprint).where(OfficerVoiceprint.officer_id == officer_id)
        )

    def _profile_dict(self, profile: OfficerVoiceProfile, *, bridge: OfficerVoiceprint | None = None) -> dict[str, Any]:
        if bridge is None:
            bridge = self._bridge(profile.officer_id)
        active_samples = list(
            self.db.scalars(
                select(OfficerVoiceSample).where(
                    OfficerVoiceSample.profile_id == profile.id,
                    OfficerVoiceSample.active.is_(True),
                )
            )
        )
        return {
            "voiceprintId": profile.id,
            "profileId": profile.id,
            "bridgeVoiceprintId": bridge.id if bridge is not None else None,
            "officerId": profile.officer_id,
            "officerName": profile.officer_name,
            "active": bool(profile.active and profile.revoked_at is None and profile.sample_count > 0),
            "revokedAt": profile.revoked_at.isoformat() if profile.revoked_at is not None else None,
            "sampleCount": profile.sample_count,
            "aggregateVersion": profile.aggregate_version,
            "usableDurationMs": sum(int(row.usable_duration_ms) for row in active_samples),
            "embeddingDim": profile.embedding_dim,
            "modelId": profile.model_id,
            "modelVersion": profile.model_version,
            "quality": "AGGREGATED" if profile.sample_count > 1 else (active_samples[0].quality if active_samples else "UNAVAILABLE"),
            "updatedAt": profile.updated_at.isoformat() if profile.updated_at is not None else None,
        }

    @staticmethod
    def _sample_dict(sample: OfficerVoiceSample) -> dict[str, Any]:
        return {
            "sampleId": sample.id,
            "active": bool(sample.active),
            "quality": sample.quality,
            "usableDurationMs": sample.usable_duration_ms,
            "segmentCount": sample.segment_count,
            "audioSource": sample.audio_source,
            "deviceId": sample.device_id,
            "deviceName": sample.device_name,
            "modelId": sample.model_id,
            "modelVersion": sample.model_version,
            "modelFingerprint": sample.model_fingerprint,
            "microphoneFingerprint": sample.microphone_fingerprint,
            "microphoneFingerprintCertainty": sample.microphone_fingerprint_certainty,
            "capturedAt": sample.captured_at.isoformat() if sample.captured_at is not None else None,
            "disabledAt": sample.disabled_at.isoformat() if sample.disabled_at is not None else None,
            "disabledReason": sample.disabled_reason,
            "createdBy": sample.created_by,
        }

    @staticmethod
    def _sample_weight(sample: OfficerVoiceSample) -> float:
        quality_weight = _QUALITY_WEIGHTS.get(str(sample.quality or "").upper(), 0.5)
        duration_factor = max(0.75, min(1.25, float(sample.usable_duration_ms) / 20_000.0))
        return quality_weight * duration_factor

    @staticmethod
    def _decode_embedding(blob: bytes, dimension: int) -> list[float]:
        raw = bytes(blob)
        dimension = int(dimension)
        if dimension <= 0 or len(raw) != dimension * _FLOAT32_BYTES:
            raise DomainError("OFFICER_VOICEPRINT_EMBEDDING_INVALID", "民警声纹样本向量无效", 500)
        try:
            return [float(value) for value in struct.unpack(f"<{dimension}f", raw)]
        except struct.error as exc:
            raise DomainError("OFFICER_VOICEPRINT_EMBEDDING_INVALID", "民警声纹样本向量无法解析", 500) from exc

    @staticmethod
    def _normalize(vector: list[float]) -> list[float]:
        if not vector or not all(math.isfinite(value) for value in vector):
            raise DomainError("OFFICER_VOICEPRINT_EMBEDDING_INVALID", "民警声纹样本向量包含非法数值", 500)
        norm = math.sqrt(sum(value * value for value in vector))
        if norm <= 0.0:
            raise DomainError("OFFICER_VOICEPRINT_EMBEDDING_INVALID", "民警声纹样本向量范数无效", 500)
        return [value / norm for value in vector]

    @staticmethod
    def _optional_text(value: Any) -> str | None:
        if value is None:
            return None
        text = str(value).strip()
        return text or None
