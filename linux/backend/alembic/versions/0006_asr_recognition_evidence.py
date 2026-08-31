"""Add independent ASR recognition evidence and human revision history.

Revision ID: 0006_asr_recognition_evidence
Revises: 0005_speaker_device_calibration
"""

from __future__ import annotations

import json
from uuid import uuid4

from alembic import op
import sqlalchemy as sa


revision = "0006_asr_recognition_evidence"
down_revision = "0005_speaker_device_calibration"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "asr_recognition_evidence",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("fragment_id", sa.String(length=64), sa.ForeignKey("asr_fragments.id", ondelete="CASCADE"), nullable=False, unique=True),
        sa.Column("capture_session_id", sa.String(length=64), sa.ForeignKey("asr_capture_sessions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("case_id", sa.String(length=64), sa.ForeignKey("cases.id", ondelete="CASCADE"), nullable=False),
        sa.Column("ai_speaker", sa.String(length=32), nullable=False),
        sa.Column("speaker_id", sa.String(length=128), nullable=True),
        sa.Column("speaker_name", sa.String(length=128), nullable=True),
        sa.Column("speaker_source", sa.String(length=64), nullable=False),
        sa.Column("score", sa.Float(), nullable=True),
        sa.Column("second_best_score", sa.Float(), nullable=True),
        sa.Column("threshold", sa.Float(), nullable=True),
        sa.Column("margin", sa.Float(), nullable=True),
        sa.Column("threshold_source", sa.String(length=64), nullable=True),
        sa.Column("voiceprint_verified", sa.Boolean(), nullable=False, server_default=sa.false()),
        sa.Column("low_confidence", sa.Boolean(), nullable=False, server_default=sa.false()),
        sa.Column("asr_model_id", sa.String(length=128), nullable=True),
        sa.Column("asr_model_version", sa.String(length=128), nullable=True),
        sa.Column("speaker_model_id", sa.String(length=128), nullable=True),
        sa.Column("speaker_model_version", sa.String(length=128), nullable=True),
        sa.Column("speaker_model_fingerprint", sa.String(length=64), nullable=True),
        sa.Column("microphone_fingerprint", sa.String(length=64), nullable=True),
        sa.Column("calibration_id", sa.String(length=64), nullable=True),
        sa.Column("calibration_status", sa.String(length=32), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index("ix_asr_recognition_evidence_fragment_id", "asr_recognition_evidence", ["fragment_id"], unique=True)
    op.create_index("ix_asr_recognition_evidence_capture_session_id", "asr_recognition_evidence", ["capture_session_id"], unique=False)
    op.create_index("ix_asr_recognition_evidence_case_id", "asr_recognition_evidence", ["case_id"], unique=False)
    op.create_index("ix_asr_recognition_evidence_created_at", "asr_recognition_evidence", ["created_at"], unique=False)

    op.create_table(
        "asr_recognition_revisions",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("fragment_id", sa.String(length=64), sa.ForeignKey("asr_fragments.id", ondelete="CASCADE"), nullable=False),
        sa.Column("case_id", sa.String(length=64), sa.ForeignKey("cases.id", ondelete="CASCADE"), nullable=False),
        sa.Column("revision_no", sa.Integer(), nullable=False),
        sa.Column("before_speaker", sa.String(length=32), nullable=False),
        sa.Column("after_speaker", sa.String(length=32), nullable=False),
        sa.Column("before_text", sa.Text(), nullable=False),
        sa.Column("after_text", sa.Text(), nullable=False),
        sa.Column("actor_id", sa.String(length=128), nullable=True),
        sa.Column("reason", sa.String(length=512), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.UniqueConstraint("fragment_id", "revision_no", name="uq_asr_recognition_revision_no"),
    )
    op.create_index("ix_asr_recognition_revisions_fragment_id", "asr_recognition_revisions", ["fragment_id"], unique=False)
    op.create_index("ix_asr_recognition_revisions_case_id", "asr_recognition_revisions", ["case_id"], unique=False)
    op.create_index("ix_asr_recognition_revisions_created_at", "asr_recognition_revisions", ["created_at"], unique=False)

    # Backfill existing fragments from their immutable ASR_SPEAKER_DECISION audit
    # where available. This preserves the original AI decision even when the
    # mutable fragment row was later corrected by a human.
    bind = op.get_bind()
    rows = bind.execute(sa.text("""
        SELECT f.id, f.capture_session_id, f.case_id, f.speaker, f.speaker_id,
               f.speaker_name, f.speaker_source, f.speaker_score,
               f.second_best_score, f.speaker_threshold, f.speaker_margin,
               f.voiceprint_verified, f.low_confidence, f.model_id,
               f.model_version, f.created_at,
               a.after_json, a.detail_json
        FROM asr_fragments f
        LEFT JOIN audit_logs a
          ON a.target_id = f.id AND a.action = 'ASR_SPEAKER_DECISION'
        ORDER BY f.created_at ASC
    """)).mappings().all()

    for row in rows:
        after = {}
        detail = {}
        try:
            after = json.loads(row["after_json"] or "{}")
        except Exception:
            pass
        try:
            detail = json.loads(row["detail_json"] or "{}")
        except Exception:
            pass
        bind.execute(
            sa.text("""
                INSERT INTO asr_recognition_evidence (
                    id, fragment_id, capture_session_id, case_id, ai_speaker,
                    speaker_id, speaker_name, speaker_source, score,
                    second_best_score, threshold, margin, threshold_source,
                    voiceprint_verified, low_confidence, asr_model_id,
                    asr_model_version, speaker_model_id, speaker_model_version,
                    speaker_model_fingerprint, microphone_fingerprint,
                    calibration_id, calibration_status, created_at
                ) VALUES (
                    :id, :fragment_id, :capture_session_id, :case_id, :ai_speaker,
                    :speaker_id, :speaker_name, :speaker_source, :score,
                    :second_best_score, :threshold, :margin, :threshold_source,
                    :voiceprint_verified, :low_confidence, :asr_model_id,
                    :asr_model_version, :speaker_model_id, :speaker_model_version,
                    :speaker_model_fingerprint, :microphone_fingerprint,
                    :calibration_id, :calibration_status, :created_at
                )
            """),
            {
                "id": str(uuid4()),
                "fragment_id": row["id"],
                "capture_session_id": row["capture_session_id"],
                "case_id": row["case_id"],
                "ai_speaker": after.get("speaker") or row["speaker"],
                "speaker_id": after.get("speaker_id") if "speaker_id" in after else row["speaker_id"],
                "speaker_name": after.get("speaker_name") if "speaker_name" in after else row["speaker_name"],
                "speaker_source": after.get("speaker_source") or row["speaker_source"],
                "score": detail.get("score", row["speaker_score"]),
                "second_best_score": detail.get("second_best_score", row["second_best_score"]),
                "threshold": detail.get("threshold", row["speaker_threshold"]),
                "margin": detail.get("margin", row["speaker_margin"]),
                "threshold_source": detail.get("threshold_source"),
                "voiceprint_verified": bool(after.get("voiceprint_verified", row["voiceprint_verified"])),
                "low_confidence": bool(after.get("low_confidence", row["low_confidence"])),
                "asr_model_id": detail.get("asr_model_id", row["model_id"]),
                "asr_model_version": detail.get("asr_model_version", row["model_version"]),
                "speaker_model_id": detail.get("speaker_model_id"),
                "speaker_model_version": detail.get("speaker_model_version"),
                "speaker_model_fingerprint": detail.get("speaker_model_fingerprint"),
                "microphone_fingerprint": detail.get("microphone_fingerprint"),
                "calibration_id": detail.get("calibration_id"),
                "calibration_status": detail.get("calibration_status"),
                "created_at": row["created_at"],
            },
        )


def downgrade() -> None:
    op.drop_index("ix_asr_recognition_revisions_created_at", table_name="asr_recognition_revisions")
    op.drop_index("ix_asr_recognition_revisions_case_id", table_name="asr_recognition_revisions")
    op.drop_index("ix_asr_recognition_revisions_fragment_id", table_name="asr_recognition_revisions")
    op.drop_table("asr_recognition_revisions")
    op.drop_index("ix_asr_recognition_evidence_created_at", table_name="asr_recognition_evidence")
    op.drop_index("ix_asr_recognition_evidence_case_id", table_name="asr_recognition_evidence")
    op.drop_index("ix_asr_recognition_evidence_capture_session_id", table_name="asr_recognition_evidence")
    op.drop_index("ix_asr_recognition_evidence_fragment_id", table_name="asr_recognition_evidence")
    op.drop_table("asr_recognition_evidence")
