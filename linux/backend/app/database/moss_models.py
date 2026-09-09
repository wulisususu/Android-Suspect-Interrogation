"""MOSS interrogation-business tables (Task 16).

These tables belong exclusively to the MOSS long-audio transcription path.
The realtime ASR path keeps its own tables untouched: a MOSS failure can never
overwrite interrogation text because this module adds no columns and no rows
anywhere else. ``GSxx`` labels are stored verbatim as anonymous speakers; the
case-level mapping is display-only and never rewrites stored revisions.
"""
from __future__ import annotations

from datetime import datetime

from sqlalchemy import DateTime, ForeignKey, Integer, String, Text, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.database.base import Base, TimestampMixin, utc_now


class MossTranscription(TimestampMixin, Base):
    """One submission attempt of one case recording to the MOSS worker."""

    __tablename__ = "moss_transcriptions"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    audio_path: Mapped[str] = mapped_column(Text, nullable=False)
    audio_sha256: Mapped[str] = mapped_column(String(64), nullable=False, index=True)
    job_id: Mapped[str | None] = mapped_column(String(64), nullable=True, index=True)
    model_manifest_sha256: Mapped[str | None] = mapped_column(String(64), nullable=True)
    # Mirrors the worker job states (JobState), including RECOVERY_REQUIRED.
    state: Mapped[str] = mapped_column(String(32), default="QUEUED", nullable=False, index=True)
    error: Mapped[str | None] = mapped_column(Text, nullable=True)
    # Last observed per-window snapshot: [{windowId, state, segmentCount, ...}]
    windows_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)

    revisions = relationship(
        "MossTranscriptionRevision",
        back_populates="transcription",
        cascade="all, delete-orphan",
        order_by="MossTranscriptionRevision.revision_no",
    )


class MossTranscriptionRevision(Base):
    """Append-only transcript revision; a failure never rewrites history."""

    __tablename__ = "moss_transcription_revisions"
    __table_args__ = (
        UniqueConstraint("transcription_id", "revision_no", name="uq_moss_revision_no"),
    )

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    transcription_id: Mapped[str] = mapped_column(
        ForeignKey("moss_transcriptions.id", ondelete="CASCADE"), nullable=False, index=True
    )
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    job_id: Mapped[str] = mapped_column(String(64), nullable=False)
    revision_no: Mapped[int] = mapped_column(Integer, nullable=False)
    audio_sha256: Mapped[str] = mapped_column(String(64), nullable=False)
    model_manifest_sha256: Mapped[str] = mapped_column(String(64), nullable=False)
    # [{segmentId, windowId, startMs, endMs, gs, text, parseStatus, mergeStatus, ...}]
    segments_json: Mapped[str] = mapped_column(Text, nullable=False)
    # Per-window provenance: [{windowId, startMs, endMs, state, segmentCount, manifest}]
    provenance_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    # GS→role mapping snapshot captured when this revision was written.
    mapping_snapshot_json: Mapped[str] = mapped_column(Text, default="{}", nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)

    transcription = relationship("MossTranscription", back_populates="revisions")


class MossSpeakerMapping(TimestampMixin, Base):
    """Manual case-level anonymous-speaker mapping (GS01→民警, GS02→嫌疑人)."""

    __tablename__ = "moss_speaker_mappings"
    __table_args__ = (
        UniqueConstraint("case_id", "global_speaker", name="uq_moss_speaker_mapping_case_gs"),
    )

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    global_speaker: Mapped[str] = mapped_column(String(16), nullable=False)
    role: Mapped[str] = mapped_column(String(64), nullable=False)
