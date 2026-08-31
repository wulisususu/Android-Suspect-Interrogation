from __future__ import annotations

from datetime import datetime

from sqlalchemy import Boolean, DateTime, ForeignKey, Integer, LargeBinary, String, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, utc_now


class OfficerVoiceProfile(TimestampMixin, Base):
    __tablename__ = "officer_voice_profiles"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    officer_id: Mapped[str] = mapped_column(String(128), nullable=False, unique=True, index=True)
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
    embedding: Mapped[bytes] = mapped_column(LargeBinary, nullable=False)
    embedding_dim: Mapped[int] = mapped_column(Integer, nullable=False)
    model_id: Mapped[str] = mapped_column(String(128), nullable=False)
    model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    quality: Mapped[str] = mapped_column(String(64), nullable=False)
    usable_duration_ms: Mapped[int] = mapped_column(Integer, nullable=False)
    segment_count: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    audio_source: Mapped[str] = mapped_column(String(32), nullable=False)
    device_id: Mapped[str | None] = mapped_column(String(256), nullable=True)
    device_name: Mapped[str | None] = mapped_column(String(256), nullable=True)
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
    model_id: Mapped[str] = mapped_column(String(128), nullable=False)
    model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False)
