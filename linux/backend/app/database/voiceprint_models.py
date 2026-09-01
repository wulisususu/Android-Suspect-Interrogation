from __future__ import annotations

from datetime import datetime

from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Integer, LargeBinary, String, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, utc_now


class OfficerVoiceProfile(TimestampMixin, Base):
    __tablename__ = "officer_voice_profiles"
    __table_args__ = (UniqueConstraint("officer_id", "model_key", name="uq_officer_voice_profile_officer_model"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    officer_id: Mapped[str] = mapped_column(String(128), nullable=False, index=True)
    model_key: Mapped[str] = mapped_column(String(64), default="xvector", nullable=False, index=True)
    officer_name: Mapped[str] = mapped_column(String(128), nullable=False)
    aggregate_embedding: Mapped[bytes] = mapped_column(LargeBinary, nullable=False)
    embedding_dim: Mapped[int] = mapped_column(Integer, nullable=False)
    model_id: Mapped[str] = mapped_column(String(128), nullable=False)
    model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    aggregate_version: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    sample_count: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    revoked_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)


class OfficerVoiceSample(TimestampMixin, Base):
    __tablename__ = "officer_voice_samples"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    profile_id: Mapped[str] = mapped_column(
        ForeignKey("officer_voice_profiles.id", ondelete="CASCADE"), nullable=False, index=True
    )
    model_key: Mapped[str] = mapped_column(String(64), default="xvector", nullable=False, index=True)
    embedding: Mapped[bytes] = mapped_column(LargeBinary, nullable=False)
    embedding_dim: Mapped[int] = mapped_column(Integer, nullable=False)
    model_id: Mapped[str] = mapped_column(String(128), nullable=False)
    model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    model_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True, index=True)
    quality: Mapped[str] = mapped_column(String(64), nullable=False)
    usable_duration_ms: Mapped[int] = mapped_column(Integer, nullable=False)
    segment_count: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    audio_source: Mapped[str] = mapped_column(String(32), nullable=False)
    device_id: Mapped[str | None] = mapped_column(String(256), nullable=True)
    device_name: Mapped[str | None] = mapped_column(String(256), nullable=True)
    microphone_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True, index=True)
    microphone_fingerprint_certainty: Mapped[str | None] = mapped_column(String(32), nullable=True)
    captured_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)
    active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False, index=True)
    disabled_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)
    disabled_reason: Mapped[str | None] = mapped_column(String(512), nullable=True)
    created_by: Mapped[str | None] = mapped_column(String(128), nullable=True)


class SessionOfficerVoiceSnapshot(Base):
    __tablename__ = "session_officer_voice_snapshots"
    __table_args__ = (UniqueConstraint("session_id", "role", name="uq_session_officer_voice_snapshot_role"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    session_id: Mapped[str] = mapped_column(
        ForeignKey("interrogation_sessions.id", ondelete="CASCADE"), nullable=False, index=True
    )
    role: Mapped[str] = mapped_column(String(32), nullable=False)
    officer_id: Mapped[str] = mapped_column(String(128), nullable=False)
    profile_id: Mapped[str | None] = mapped_column(
        ForeignKey("officer_voice_profiles.id", ondelete="SET NULL"), nullable=True
    )
    aggregate_version: Mapped[int] = mapped_column(Integer, nullable=False)
    voiceprint_snapshot_id: Mapped[str] = mapped_column(
        ForeignKey("officer_voiceprints.id", ondelete="RESTRICT"), nullable=False
    )
    model_key: Mapped[str] = mapped_column(String(64), default="xvector", nullable=False, index=True)
    model_id: Mapped[str] = mapped_column(String(128), nullable=False)
    model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False)


class SpeakerDeviceCalibration(Base):
    """Immutable device-specific speaker calibration history row."""

    __tablename__ = "speaker_device_calibrations"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    status_at_creation: Mapped[str] = mapped_column(String(32), nullable=False, index=True)
    threshold: Mapped[float] = mapped_column(Float, nullable=False)
    margin: Mapped[float | None] = mapped_column(Float, nullable=True)
    far: Mapped[float] = mapped_column(Float, nullable=False)
    frr: Mapped[float] = mapped_column(Float, nullable=False)
    eer: Mapped[float] = mapped_column(Float, nullable=False)
    eer_threshold: Mapped[float] = mapped_column(Float, nullable=False)
    eer_far: Mapped[float] = mapped_column(Float, nullable=False)
    eer_frr: Mapped[float] = mapped_column(Float, nullable=False)
    genuine_trial_count: Mapped[int] = mapped_column(Integer, nullable=False)
    impostor_trial_count: Mapped[int] = mapped_column(Integer, nullable=False)
    officer_count: Mapped[int] = mapped_column(Integer, nullable=False)
    sample_count: Mapped[int] = mapped_column(Integer, nullable=False)
    corpus_digest: Mapped[str] = mapped_column(String(64), nullable=False, index=True)
    algorithm_version: Mapped[str] = mapped_column(String(64), nullable=False)
    speaker_model_id: Mapped[str] = mapped_column(String(128), nullable=False)
    speaker_model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    speaker_model_fingerprint: Mapped[str] = mapped_column(String(64), nullable=False, index=True)
    audio_source: Mapped[str] = mapped_column(String(32), nullable=False)
    microphone_id: Mapped[str] = mapped_column(String(256), nullable=False)
    microphone_name: Mapped[str] = mapped_column(String(256), nullable=False)
    microphone_fingerprint: Mapped[str] = mapped_column(String(64), nullable=False, index=True)
    microphone_fingerprint_certainty: Mapped[str] = mapped_column(String(32), nullable=False)
    created_by: Mapped[str | None] = mapped_column(String(128), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)


class SessionSpeakerCalibrationSnapshot(Base):
    """Operating point frozen for one formal ASR capture session."""

    __tablename__ = "session_speaker_calibration_snapshots"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    capture_session_id: Mapped[str] = mapped_column(
        ForeignKey("asr_capture_sessions.id", ondelete="CASCADE"), nullable=False, unique=True, index=True
    )
    interrogation_session_id: Mapped[str | None] = mapped_column(
        ForeignKey("interrogation_sessions.id", ondelete="SET NULL"), nullable=True, index=True
    )
    calibration_id: Mapped[str | None] = mapped_column(
        ForeignKey("speaker_device_calibrations.id", ondelete="SET NULL"), nullable=True, index=True
    )
    threshold: Mapped[float] = mapped_column(Float, nullable=False)
    margin: Mapped[float | None] = mapped_column(Float, nullable=True)
    threshold_source: Mapped[str] = mapped_column(String(32), nullable=False)
    calibration_status: Mapped[str] = mapped_column(String(32), nullable=False)
    speaker_model_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True)
    microphone_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)