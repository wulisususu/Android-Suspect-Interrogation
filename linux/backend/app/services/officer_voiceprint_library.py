from __future__ import annotations

import math
import struct
from datetime import datetime, timezone
from typing import Any
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.ai.errors import AIError, BackendUnavailableError
from app.database.models import OfficerVoiceprint
from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.services.voiceprint_service import VoiceprintService


_FLOAT32_BYTES = 4
_SNAPSHOT_PREFIX = "__session_snapshot__:"
_ALLOWED_SOURCES = {"ALSA", "BROWSER"}
_QUALITY_WEIGHTS = {"GOOD": 1.0, "FAIR": 0.75}
_XVECTOR = "xvector"
_ERES2NET_LARGE = "eres2net_large"
_ENROLLMENT_BACKENDS = (_XVECTOR, _ERES2NET_LARGE)


class OfficerVoiceprintLibraryService:
    """System-level, model-isolated officer voiceprint sample library."""

    def __init__(self, db: Session, *, speech_client: Any):
        self.db = db
        self.speech_client = speech_client

    def list_profiles(self, *, active_only: bool = True) -> list[dict[str, Any]]:
        self._materialize_legacy_profiles()
        # Keep the established API one-row-per-officer. XVector remains the
        # compatibility primary until Task 6 makes session selection explicit.
        stmt = select(OfficerVoiceProfile).where(OfficerVoiceProfile.model_key == _XVECTOR)
        if active_only:
            stmt = stmt.where(
                OfficerVoiceProfile.active.is_(True),
                OfficerVoiceProfile.revoked_at.is_(None),
                OfficerVoiceProfile.sample_count > 0,
            )
        stmt = stmt.order_by(OfficerVoiceProfile.officer_id.asc())
        return [self._profile_with_backend_status(profile) for profile in self.db.scalars(stmt)]

    def get_profile(self, officer_id: str, *, include_inactive: bool = True) -> dict[str, Any]:
        profile = self._profile_or_error(
            officer_id,
            model_key=_XVECTOR,
            include_inactive=include_inactive,
        )
        result = self._profile_with_backend_status(profile)
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
        references, failures = VoiceprintService(
            self.db,
            speech_client=self.speech_client,
        )._build_dual_references(pcm)

        primary_profile, primary_sample, primary_bridge, primary_created = self._store_reference_sample(
            officer_id=officer_id,
            officer_name=officer_name,
            reference=references[_XVECTOR],
            actor_id=actor_id,
            source=source,
            device_id=device_id,
            device_name=device_name,
            microphone_fingerprint=microphone_fingerprint,
            microphone_fingerprint_certainty=microphone_fingerprint_certainty,
        )
        self._audit_sample(
            profile=primary_profile,
            sample=primary_sample,
            actor_id=actor_id,
            created_profile=primary_created,
        )
        self.db.commit()

        backend_results: dict[str, dict[str, Any]] = {
            _XVECTOR: self._ready_backend_result(
                primary_profile,
                primary_sample,
                primary_bridge,
            )
        }

        optional_reference = references.get(_ERES2NET_LARGE)
        if optional_reference is not None:
            try:
                profile, sample, bridge, created = self._store_reference_sample(
                    officer_id=officer_id,
                    officer_name=officer_name,
                    reference=optional_reference,
                    actor_id=actor_id,
                    source=source,
                    device_id=device_id,
                    device_name=device_name,
                    microphone_fingerprint=microphone_fingerprint,
                    microphone_fingerprint_certainty=microphone_fingerprint_certainty,
                )
                self._audit_sample(
                    profile=profile,
                    sample=sample,
                    actor_id=actor_id,
                    created_profile=created,
                )
                self.db.commit()
                backend_results[_ERES2NET_LARGE] = self._ready_backend_result(
                    profile,
                    sample,
                    bridge,
                )
            except (AIError, DomainError) as exc:
                self.db.rollback()
                backend_results[_ERES2NET_LARGE] = self._not_ready_backend_result(exc)
        else:
            backend_results[_ERES2NET_LARGE] = self._not_ready_backend_result(
                failures.get(_ERES2NET_LARGE)
                or BackendUnavailableError(
                    "ERes2Net-large officer reference is unavailable",
                    details={"backend_key": _ERES2NET_LARGE},
                )
            )

        result = self._profile_dict(primary_profile, bridge=primary_bridge)
        result["latestSampleId"] = primary_sample.id
        result["dualReady"] = all(
            backend_results[key].get("ready") is True for key in _ENROLLMENT_BACKENDS
        )
        result["backends"] = backend_results
        return result

    def _store_reference_sample(
        self,
        *,
        officer_id: str,
        officer_name: str,
        reference: dict[str, Any],
        actor_id: str | None,
        source: str,
        device_id: str | None,
        device_name: str | None,
        microphone_fingerprint: str | None,
        microphone_fingerprint_certainty: str | None,
    ) -> tuple[OfficerVoiceProfile, OfficerVoiceSample, OfficerVoiceprint, bool]:
        model_key = str(reference["model_key"])
        profile = self.db.scalar(
            select(OfficerVoiceProfile).where(
                OfficerVoiceProfile.officer_id == officer_id,
                OfficerVoiceProfile.model_key == model_key,
            )
        )
        created_profile = profile is None
        if profile is None:
            profile = OfficerVoiceProfile(
                id=str(uuid4()),
                officer_id=officer_id,
                model_key=model_key,
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

        model_fingerprint = self._optional_text(reference.get("model_fingerprint"))
        if model_fingerprint is None:
            model_fingerprint = self._current_model_fingerprint(model_key)
        sample = OfficerVoiceSample(
            id=str(uuid4()),
            profile_id=profile.id,
            model_key=model_key,
            embedding=bytes(reference["bytes"]),
            embedding_dim=int(reference["dimension"]),
            model_id=str(reference["model_id"]),
            model_version=reference["model_version"],
            model_fingerprint=model_fingerprint,
            quality=str(reference["quality"]),
            usable_duration_ms=int(reference["usable_duration_ms"]),
            segment_count=int(reference["segment_count"]),
            audio_source=source,
            device_id=self._optional_text(device_id) or (
                "browser-default" if source == "BROWSER" else "alsa-default"
            ),
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
        return profile, sample, bridge, created_profile

    def _audit_sample(
        self,
        *,
        profile: OfficerVoiceProfile,
        sample: OfficerVoiceSample,
        actor_id: str | None,
        created_profile: bool,
    ) -> None:
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
                "model_key": sample.model_key,
                "model_id": sample.model_id,
                "model_version": sample.model_version,
                "model_fingerprint": sample.model_fingerprint,
                "microphone_fingerprint": sample.microphone_fingerprint,
                "microphone_fingerprint_certainty": sample.microphone_fingerprint_certainty,
            },
        )

    def disable_sample(
        self,
        officer_id: str,
        sample_id: str,
        *,
        reason: str | None = None,
        actor_id: str | None = None,
    ) -> dict[str, Any]:
        normalized = str(officer_id or "").strip()
        if not normalized:
            raise DomainError("OFFICER_IDENTITY_REQUIRED", "民警编号不能为空", 400)
        self._materialize_legacy_profiles()
        sample = self.db.get(OfficerVoiceSample, str(sample_id))
        profile = self.db.get(OfficerVoiceProfile, sample.profile_id) if sample is not None else None
        if sample is None or profile is None or profile.officer_id != normalized:
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
                    "model_key": sample.model_key,
                    "disabled_reason": sample.disabled_reason,
                    "aggregate_version": profile.aggregate_version,
                    "sample_count": profile.sample_count,
                },
            )
            self.db.commit()
        else:
            bridge = self._bridge(profile.officer_id, model_key=profile.model_key)
        return self._profile_dict(profile, bridge=bridge)

    def revoke_profile(self, officer_id: str, *, actor_id: str | None = None) -> dict[str, Any]:
        normalized = str(officer_id or "").strip()
        if not normalized:
            raise DomainError("OFFICER_IDENTITY_REQUIRED", "民警编号不能为空", 400)
        self._materialize_legacy_profiles()
        profiles = list(
            self.db.scalars(
                select(OfficerVoiceProfile).where(OfficerVoiceProfile.officer_id == normalized)
            )
        )
        if not profiles:
            raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "民警声纹档案不存在", 404)
        revoked_at = datetime.now(timezone.utc)
        for profile in profiles:
            profile.active = False
            profile.revoked_at = revoked_at
            bridge = self._bridge(profile.officer_id, model_key=profile.model_key)
            if bridge is not None:
                bridge.active = False
                bridge.revoked_at = revoked_at
        audit_repo.add(
            self.db,
            case_id=None,
            actor_id=actor_id,
            action="OFFICER_VOICEPRINT_REVOKE",
            target_type="OFFICER_VOICE_PROFILE",
            target_id=next((p.id for p in profiles if p.model_key == _XVECTOR), profiles[0].id),
            detail={
                "officer_id": normalized,
                "model_keys": sorted(profile.model_key for profile in profiles),
            },
        )
        self.db.commit()
        primary = next((profile for profile in profiles if profile.model_key == _XVECTOR), profiles[0])
        return self._profile_with_backend_status(primary)

    def _profile_or_error(
        self,
        officer_id: str,
        *,
        model_key: str = _XVECTOR,
        include_inactive: bool,
    ) -> OfficerVoiceProfile:
        normalized = str(officer_id or "").strip()
        key = str(model_key or "").strip().lower()
        if not normalized:
            raise DomainError("OFFICER_IDENTITY_REQUIRED", "民警编号不能为空", 400)
        if not key:
            raise DomainError("VOICEPRINT_MODEL_KEY_REQUIRED", "声纹模型标识不能为空", 400)
        self._materialize_legacy_profiles()
        profile = self.db.scalar(
            select(OfficerVoiceProfile).where(
                OfficerVoiceProfile.officer_id == normalized,
                OfficerVoiceProfile.model_key == key,
            )
        )
        if profile is None:
            raise DomainError("OFFICER_VOICEPRINT_NOT_FOUND", "民警声纹档案不存在", 404)
        if not include_inactive and (
            not profile.active or profile.revoked_at is not None or profile.sample_count <= 0
        ):
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
            key = str(bridge.model_key or _XVECTOR)
            exists = self.db.scalar(
                select(OfficerVoiceProfile.id).where(
                    OfficerVoiceProfile.officer_id == bridge.officer_id,
                    OfficerVoiceProfile.model_key == key,
                )
            )
            if exists is not None:
                continue
            profile = OfficerVoiceProfile(
                id=str(uuid4()),
                officer_id=bridge.officer_id,
                model_key=key,
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
                    model_key=key,
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

    def _current_model_fingerprint(self, model_key: str) -> str | None:
        health_fn = getattr(self.speech_client, "health", None)
        if not callable(health_fn):
            return None
        try:
            health = health_fn()
        except Exception:
            return None
        if not isinstance(health, dict):
            return None
        backend_map = health.get("speaker_backends")
        if isinstance(backend_map, dict):
            backend = backend_map.get(model_key)
            if isinstance(backend, dict):
                value = backend.get("model_fingerprint")
                if value:
                    return self._optional_text(value)
        if model_key == _XVECTOR:
            return self._optional_text(health.get("speaker_model_fingerprint"))
        return None

    def _validate_reference_compatibility(
        self,
        profile: OfficerVoiceProfile,
        reference: dict[str, Any],
    ) -> None:
        if profile.model_key != str(reference["model_key"]):
            raise DomainError("OFFICER_VOICEPRINT_MODEL_MISMATCH", "新样本声纹模型空间与现有档案不一致", 409)
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
        model_key = samples[0].model_key
        model_id = samples[0].model_id
        model_version = samples[0].model_version
        weighted = [0.0] * dimension
        total_weight = 0.0
        for sample in samples:
            if (
                sample.model_key != model_key
                or sample.model_key != profile.model_key
                or sample.embedding_dim != dimension
                or sample.model_id != model_id
            ):
                raise DomainError("OFFICER_VOICEPRINT_MODEL_MISMATCH", "启用样本包含不兼容的声纹模型", 409)
            vector = self._normalize(self._decode_embedding(sample.embedding, sample.embedding_dim))
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
        bridge = self._bridge(profile.officer_id, model_key=profile.model_key)
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
                model_key=profile.model_key,
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

    def _bridge(self, officer_id: str, *, model_key: str = _XVECTOR) -> OfficerVoiceprint | None:
        return self.db.scalar(
            select(OfficerVoiceprint).where(
                OfficerVoiceprint.officer_id == officer_id,
                OfficerVoiceprint.model_key == model_key,
            )
        )

    def _profile_with_backend_status(self, profile: OfficerVoiceProfile) -> dict[str, Any]:
        result = self._profile_dict(profile)
        profiles = list(
            self.db.scalars(
                select(OfficerVoiceProfile).where(
                    OfficerVoiceProfile.officer_id == profile.officer_id
                )
            )
        )
        result["backends"] = {
            item.model_key: {
                "ready": bool(item.active and item.revoked_at is None and item.sample_count > 0),
                "status": "READY" if item.active and item.revoked_at is None and item.sample_count > 0 else "NOT_READY",
                "profileId": item.id,
                "modelKey": item.model_key,
                "modelId": item.model_id,
                "modelVersion": item.model_version,
                "embeddingDim": item.embedding_dim,
                "sampleCount": item.sample_count,
            }
            for item in profiles
        }
        result["dualReady"] = all(
            result["backends"].get(key, {}).get("ready") is True for key in _ENROLLMENT_BACKENDS
        )
        return result

    def _profile_dict(
        self,
        profile: OfficerVoiceProfile,
        *,
        bridge: OfficerVoiceprint | None = None,
    ) -> dict[str, Any]:
        if bridge is None:
            bridge = self._bridge(profile.officer_id, model_key=profile.model_key)
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
            "modelKey": profile.model_key,
            "modelId": profile.model_id,
            "modelVersion": profile.model_version,
            "quality": "AGGREGATED" if profile.sample_count > 1 else (
                active_samples[0].quality if active_samples else "UNAVAILABLE"
            ),
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
            "modelKey": sample.model_key,
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
    def _ready_backend_result(
        profile: OfficerVoiceProfile,
        sample: OfficerVoiceSample,
        bridge: OfficerVoiceprint,
    ) -> dict[str, Any]:
        return {
            "ready": True,
            "status": "READY",
            "profileId": profile.id,
            "voiceprintId": bridge.id,
            "sampleId": sample.id,
            "modelKey": profile.model_key,
            "modelId": profile.model_id,
            "modelVersion": profile.model_version,
            "modelFingerprint": sample.model_fingerprint,
            "embeddingDim": profile.embedding_dim,
            "sampleCount": profile.sample_count,
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
