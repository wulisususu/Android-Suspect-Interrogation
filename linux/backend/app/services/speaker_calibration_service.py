from __future__ import annotations

import hashlib
import math
import struct
from dataclasses import dataclass
from enum import Enum
from typing import Callable

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample, SpeakerDeviceCalibration
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import speaker_calibrations as calibration_repo
from app.services.speaker_calibration_math import CalibrationSample, build_trials, choose_operating_point, compute_eer


ALGORITHM_VERSION = "speaker-calibration-v1"
MIN_OFFICERS = 3
MIN_SAMPLES_PER_OFFICER = 3


class CalibrationStatus(str, Enum):
    NOT_CALIBRATED = "NOT_CALIBRATED"
    VALID = "VALID"
    STALE_MODEL = "STALE_MODEL"
    STALE_MIC = "STALE_MIC"
    RECOMPUTE_RECOMMENDED = "RECOMPUTE_RECOMMENDED"
    INSUFFICIENT_DATA = "INSUFFICIENT_DATA"


@dataclass(frozen=True)
class CurrentSpeakerModelIdentity:
    model_id: str
    model_version: str | None
    fingerprint: str
    backend_key: str = "eres2net_large"


@dataclass(frozen=True)
class CurrentMicrophoneIdentity:
    audio_source: str
    device_id: str
    device_name: str
    fingerprint: str
    certainty: str


@dataclass(frozen=True)
class _Corpus:
    samples: tuple[CalibrationSample, ...]
    sample_ids: tuple[str, ...]
    officer_count: int
    sample_count: int
    digest: str
    ready: bool


class SpeakerCalibrationService:
    def __init__(
        self,
        db: Session,
        *,
        model_provider: Callable[[], CurrentSpeakerModelIdentity],
        microphone_provider: Callable[[], CurrentMicrophoneIdentity],
    ) -> None:
        self.db = db
        self.model_provider = model_provider
        self.microphone_provider = microphone_provider

    def status(self) -> dict:
        model = self.model_provider()
        microphone = self.microphone_provider()
        corpus = self._compatible_corpus(model, microphone)
        backend_key = str(model.backend_key or "eres2net_large").strip().lower()
        exact = calibration_repo.latest_calibration(
            self.db,
            speaker_backend_key=backend_key,
            speaker_model_fingerprint=model.fingerprint,
            microphone_fingerprint=microphone.fingerprint,
        )
        latest = exact

        if exact is None:
            same_backend_mic = calibration_repo.latest_calibration(
                self.db,
                speaker_backend_key=backend_key,
                microphone_fingerprint=microphone.fingerprint,
            )
            same_backend_model = calibration_repo.latest_calibration(
                self.db,
                speaker_backend_key=backend_key,
                speaker_model_fingerprint=model.fingerprint,
            )
            backend_latest = calibration_repo.latest_calibration(
                self.db,
                speaker_backend_key=backend_key,
            )
            if backend_latest is None:
                status = CalibrationStatus.NOT_CALIBRATED
                usable = False
                reason = "尚未完成当前声纹后端的设备校准"
            elif same_backend_mic is not None:
                latest = same_backend_mic
                status = CalibrationStatus.STALE_MODEL
                usable = False
                reason = "当前声纹模型指纹已更换，需要重新校准"
            elif same_backend_model is not None:
                latest = same_backend_model
                status = CalibrationStatus.STALE_MIC
                usable = False
                reason = "检测到麦克风已更换，请重新校准"
            else:
                latest = backend_latest
                status = (
                    CalibrationStatus.STALE_MODEL
                    if backend_latest.speaker_model_fingerprint != model.fingerprint
                    else CalibrationStatus.STALE_MIC
                )
                usable = False
                reason = (
                    "当前声纹模型指纹已更换，需要重新校准"
                    if status is CalibrationStatus.STALE_MODEL
                    else "检测到麦克风已更换，请重新校准"
                )
        elif not corpus.ready:
            status = CalibrationStatus.INSUFFICIENT_DATA
            usable = False
            reason = "当前兼容民警声纹样本不足，无法形成完整设备校准"
        elif self._material_growth(exact, corpus):
            status = CalibrationStatus.RECOMPUTE_RECOMMENDED
            usable = True
            reason = "民警声纹库有效样本明显增加，建议重新计算校准"
        else:
            status = CalibrationStatus.VALID
            usable = True
            reason = "当前设备校准有效"

        return {
            "status": status.value,
            "calibrationUsable": usable,
            "reason": reason,
            "minimumOfficers": MIN_OFFICERS,
            "minimumSamplesPerOfficer": MIN_SAMPLES_PER_OFFICER,
            "currentCorpus": {
                "officerCount": corpus.officer_count,
                "sampleCount": corpus.sample_count,
                "digest": corpus.digest,
                "ready": corpus.ready,
            },
            "currentModel": {
                "backendKey": backend_key,
                "modelId": model.model_id,
                "modelVersion": model.model_version,
                "fingerprint": model.fingerprint,
            },
            "currentMicrophone": {
                "audioSource": microphone.audio_source,
                "deviceId": microphone.device_id,
                "deviceName": microphone.device_name,
                "fingerprint": microphone.fingerprint,
                "fingerprintCertainty": microphone.certainty,
            },
            "calibration": None if latest is None else self._calibration_dict(latest),
        }

    def history(self, *, limit: int = 100) -> list[dict]:
        model = self.model_provider()
        backend_key = str(model.backend_key or "eres2net_large").strip().lower()
        return [
            self._calibration_dict(row)
            for row in calibration_repo.list_calibrations(
                self.db, limit=limit, speaker_backend_key=backend_key
            )
        ]

    def recompute(self, *, actor_id: str | None = None) -> dict:
        model = self.model_provider()
        microphone = self.microphone_provider()
        corpus = self._compatible_corpus(model, microphone)
        if not corpus.ready:
            raise DomainError(
                "SPEAKER_CALIBRATION_INSUFFICIENT_DATA",
                f"设备校准至少需要{MIN_OFFICERS}名民警且每人至少{MIN_SAMPLES_PER_OFFICER}个当前设备兼容样本",
                409,
                data={"officerCount": corpus.officer_count, "sampleCount": corpus.sample_count},
            )

        probes = build_trials(corpus.samples)
        operating = choose_operating_point(probes)
        eer = compute_eer(probes)
        row = calibration_repo.create_calibration(
            self.db,
            status_at_creation=CalibrationStatus.VALID.value,
            threshold=operating.threshold,
            margin=operating.margin,
            far=operating.far,
            frr=operating.frr,
            eer=eer.eer,
            eer_threshold=eer.threshold,
            eer_far=eer.far,
            eer_frr=eer.frr,
            genuine_trial_count=operating.genuine_trial_count,
            impostor_trial_count=operating.impostor_trial_count,
            officer_count=corpus.officer_count,
            sample_count=corpus.sample_count,
            corpus_digest=corpus.digest,
            algorithm_version=ALGORITHM_VERSION,
            speaker_backend_key=str(model.backend_key or "eres2net_large").strip().lower(),
            speaker_model_id=model.model_id,
            speaker_model_version=model.model_version,
            speaker_model_fingerprint=model.fingerprint,
            audio_source=microphone.audio_source,
            microphone_id=microphone.device_id,
            microphone_name=microphone.device_name,
            microphone_fingerprint=microphone.fingerprint,
            microphone_fingerprint_certainty=microphone.certainty,
            created_by=actor_id,
        )
        audit_repo.add(
            self.db,
            case_id=None,
            actor_id=actor_id,
            action="SPEAKER_DEVICE_CALIBRATION_RECOMPUTE",
            target_type="SPEAKER_DEVICE_CALIBRATION",
            target_id=row.id,
            detail={
                "threshold": row.threshold,
                "margin": row.margin,
                "observed_far": row.far,
                "observed_frr": row.frr,
                "observed_eer": row.eer,
                "officer_count": row.officer_count,
                "sample_count": row.sample_count,
                "speaker_backend_key": row.speaker_backend_key,
                "model_fingerprint": row.speaker_model_fingerprint,
                "microphone_fingerprint": row.microphone_fingerprint,
                "metric_scope": "LOCAL_FINITE_CORPUS_ESTIMATE",
            },
        )
        self.db.commit()
        result = self.status()
        result["calibration"] = self._calibration_dict(row)
        return result

    def _compatible_corpus(
        self,
        model: CurrentSpeakerModelIdentity,
        microphone: CurrentMicrophoneIdentity,
    ) -> _Corpus:
        rows = self.db.execute(
            select(OfficerVoiceSample, OfficerVoiceProfile.officer_id)
            .join(OfficerVoiceProfile, OfficerVoiceProfile.id == OfficerVoiceSample.profile_id)
            .where(
                OfficerVoiceProfile.active.is_(True),
                OfficerVoiceProfile.revoked_at.is_(None),
                OfficerVoiceSample.active.is_(True),
                OfficerVoiceSample.model_key == str(model.backend_key or "eres2net_large").strip().lower(),
                OfficerVoiceSample.audio_source == microphone.audio_source,
                OfficerVoiceSample.model_fingerprint == model.fingerprint,
                OfficerVoiceSample.microphone_fingerprint == microphone.fingerprint,
            )
            .order_by(OfficerVoiceProfile.officer_id.asc(), OfficerVoiceSample.id.asc())
        ).all()

        grouped: dict[str, list[OfficerVoiceSample]] = {}
        for sample, officer_id in rows:
            grouped.setdefault(str(officer_id), []).append(sample)
        eligible = {identity: samples for identity, samples in grouped.items() if len(samples) >= MIN_SAMPLES_PER_OFFICER}

        calibration_samples: list[CalibrationSample] = []
        sample_ids: list[str] = []
        digest = hashlib.sha256()
        for identity in sorted(eligible):
            for sample in sorted(eligible[identity], key=lambda item: item.id):
                vector = self._decode_embedding(sample)
                calibration_samples.append(CalibrationSample(identity, vector))
                sample_ids.append(sample.id)
                digest.update(identity.encode("utf-8"))
                digest.update(b"\0")
                digest.update(sample.id.encode("utf-8"))
                digest.update(b"\0")
                digest.update(hashlib.sha256(bytes(sample.embedding)).digest())
                digest.update(b"\n")

        officer_count = len(eligible)
        sample_count = len(calibration_samples)
        return _Corpus(
            samples=tuple(calibration_samples),
            sample_ids=tuple(sample_ids),
            officer_count=officer_count,
            sample_count=sample_count,
            digest=digest.hexdigest(),
            ready=officer_count >= MIN_OFFICERS and sample_count >= MIN_OFFICERS * MIN_SAMPLES_PER_OFFICER,
        )

    @staticmethod
    def _decode_embedding(sample: OfficerVoiceSample) -> tuple[float, ...]:
        dimension = int(sample.embedding_dim)
        raw = bytes(sample.embedding)
        if dimension <= 0 or len(raw) != dimension * 4:
            raise DomainError("SPEAKER_CALIBRATION_EMBEDDING_INVALID", "民警声纹样本向量无效", 500)
        try:
            vector = tuple(float(value) for value in struct.unpack(f"<{dimension}f", raw))
        except struct.error as exc:
            raise DomainError("SPEAKER_CALIBRATION_EMBEDDING_INVALID", "民警声纹样本向量无法解析", 500) from exc
        if not all(math.isfinite(value) for value in vector):
            raise DomainError("SPEAKER_CALIBRATION_EMBEDDING_INVALID", "民警声纹样本包含非法数值", 500)
        return vector

    @staticmethod
    def _material_growth(latest: SpeakerDeviceCalibration, corpus: _Corpus) -> bool:
        sample_delta = corpus.sample_count - int(latest.sample_count)
        officer_delta = corpus.officer_count - int(latest.officer_count)
        relative_trigger = corpus.sample_count >= math.ceil(int(latest.sample_count) * 1.25)
        return officer_delta >= 1 or sample_delta >= 3 or relative_trigger

    @staticmethod
    def _calibration_dict(row: SpeakerDeviceCalibration) -> dict:
        return {
            "calibrationId": row.id,
            "statusAtCreation": row.status_at_creation,
            "threshold": row.threshold,
            "margin": row.margin,
            "far": row.far,
            "frr": row.frr,
            "eer": row.eer,
            "eerThreshold": row.eer_threshold,
            "eerFar": row.eer_far,
            "eerFrr": row.eer_frr,
            "genuineTrialCount": row.genuine_trial_count,
            "impostorTrialCount": row.impostor_trial_count,
            "officerCount": row.officer_count,
            "sampleCount": row.sample_count,
            "corpusDigest": row.corpus_digest,
            "algorithmVersion": row.algorithm_version,
            "speakerBackendKey": row.speaker_backend_key,
            "speakerModelId": row.speaker_model_id,
            "speakerModelVersion": row.speaker_model_version,
            "speakerModelFingerprint": row.speaker_model_fingerprint,
            "audioSource": row.audio_source,
            "microphoneId": row.microphone_id,
            "microphoneName": row.microphone_name,
            "microphoneFingerprint": row.microphone_fingerprint,
            "microphoneFingerprintCertainty": row.microphone_fingerprint_certainty,
            "createdBy": row.created_by,
            "createdAt": row.created_at.isoformat() if row.created_at is not None else None,
            "metricScope": "LOCAL_FINITE_CORPUS_ESTIMATE",
        }
