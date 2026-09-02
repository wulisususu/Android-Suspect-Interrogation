from __future__ import annotations

from datetime import datetime

from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Integer, String, Text, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, utc_now


class ASRRecognitionEvidence(Base):
    """Immutable AI recognition evidence captured when an ASR fragment is created."""

    __tablename__ = "asr_recognition_evidence"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    fragment_id: Mapped[str] = mapped_column(
        ForeignKey("asr_fragments.id", ondelete="CASCADE"), nullable=False, unique=True, index=True
    )
    capture_session_id: Mapped[str] = mapped_column(
        ForeignKey("asr_capture_sessions.id", ondelete="CASCADE"), nullable=False, index=True
    )
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    ai_speaker: Mapped[str] = mapped_column(String(32), nullable=False)
    speaker_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    speaker_name: Mapped[str | None] = mapped_column(String(128), nullable=True)
    speaker_source: Mapped[str] = mapped_column(String(64), nullable=False)
    score: Mapped[float | None] = mapped_column(Float, nullable=True)
    second_best_score: Mapped[float | None] = mapped_column(Float, nullable=True)
    threshold: Mapped[float | None] = mapped_column(Float, nullable=True)
    margin: Mapped[float | None] = mapped_column(Float, nullable=True)
    threshold_source: Mapped[str | None] = mapped_column(String(64), nullable=True)
    voiceprint_verified: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    low_confidence: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    asr_model_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    asr_model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    speaker_model_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    speaker_model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    speaker_model_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True)
    microphone_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True)
    calibration_id: Mapped[str | None] = mapped_column(String(64), nullable=True)
    calibration_status: Mapped[str | None] = mapped_column(String(32), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)


class ASRRecognitionRevision(Base):
    """Append-only human correction history; never overwrites AI evidence."""

    __tablename__ = "asr_recognition_revisions"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    fragment_id: Mapped[str] = mapped_column(
        ForeignKey("asr_fragments.id", ondelete="CASCADE"), nullable=False, index=True
    )
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    revision_no: Mapped[int] = mapped_column(Integer, nullable=False)
    before_speaker: Mapped[str] = mapped_column(String(32), nullable=False)
    after_speaker: Mapped[str] = mapped_column(String(32), nullable=False)
    before_text: Mapped[str] = mapped_column(Text, nullable=False)
    after_text: Mapped[str] = mapped_column(Text, nullable=False)
    actor_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    reason: Mapped[str | None] = mapped_column(String(512), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)


class SpeakerBackendComparisonEvidence(Base):
    """Diagnostic side-by-side speaker evidence; never a second business truth.

    The row intentionally stores only scalar/model/calibration metadata. Raw
    PCM/audio and speaker embeddings are transient inference inputs and have no
    columns in this table.
    """

    __tablename__ = "speaker_backend_comparison_evidence"
    __table_args__ = (
        UniqueConstraint("fragment_id", "backend_key", name="uq_speaker_compare_fragment_backend"),
    )

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    fragment_id: Mapped[str] = mapped_column(
        ForeignKey("asr_fragments.id", ondelete="CASCADE"), nullable=False, index=True
    )
    capture_session_id: Mapped[str] = mapped_column(
        ForeignKey("asr_capture_sessions.id", ondelete="CASCADE"), nullable=False, index=True
    )
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    backend_key: Mapped[str] = mapped_column(String(64), nullable=False, index=True)
    authoritative: Mapped[bool] = mapped_column(Boolean, nullable=False, index=True)
    available: Mapped[bool] = mapped_column(Boolean, nullable=False)
    role: Mapped[str] = mapped_column(String(32), nullable=False)
    speaker_source: Mapped[str] = mapped_column(String(64), nullable=False)
    voiceprint_verified: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    score: Mapped[float | None] = mapped_column(Float, nullable=True)
    second_best_score: Mapped[float | None] = mapped_column(Float, nullable=True)
    threshold: Mapped[float | None] = mapped_column(Float, nullable=True)
    margin: Mapped[float | None] = mapped_column(Float, nullable=True)
    calibration_id: Mapped[str | None] = mapped_column(String(64), nullable=True)
    calibration_status: Mapped[str | None] = mapped_column(String(32), nullable=True)
    model_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    model_version: Mapped[str | None] = mapped_column(String(128), nullable=True)
    model_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True)
    latency_ms: Mapped[float | None] = mapped_column(Float, nullable=True)
    error_code: Mapped[str | None] = mapped_column(String(64), nullable=True)
    candidate_scores_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)
