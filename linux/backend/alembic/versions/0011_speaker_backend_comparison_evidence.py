"""Add diagnostic speaker backend comparison evidence.

Revision ID: 0011_speaker_backend_comparison_evidence
Revises: 0010_backend_scoped_speaker_calibration
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0011_speaker_backend_comparison_evidence"
down_revision = "0010_backend_scoped_speaker_calibration"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "speaker_backend_comparison_evidence",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("fragment_id", sa.String(length=64), nullable=False),
        sa.Column("capture_session_id", sa.String(length=64), nullable=False),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("backend_key", sa.String(length=64), nullable=False),
        sa.Column("authoritative", sa.Boolean(), nullable=False),
        sa.Column("available", sa.Boolean(), nullable=False),
        sa.Column("role", sa.String(length=32), nullable=False),
        sa.Column("speaker_source", sa.String(length=64), nullable=False),
        sa.Column("voiceprint_verified", sa.Boolean(), nullable=False),
        sa.Column("score", sa.Float(), nullable=True),
        sa.Column("second_best_score", sa.Float(), nullable=True),
        sa.Column("threshold", sa.Float(), nullable=True),
        sa.Column("margin", sa.Float(), nullable=True),
        sa.Column("calibration_id", sa.String(length=64), nullable=True),
        sa.Column("calibration_status", sa.String(length=32), nullable=True),
        sa.Column("model_id", sa.String(length=128), nullable=True),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("model_fingerprint", sa.String(length=64), nullable=True),
        sa.Column("latency_ms", sa.Float(), nullable=True),
        sa.Column("error_code", sa.String(length=64), nullable=True),
        sa.Column("candidate_scores_json", sa.Text(), nullable=False, server_default="[]"),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["fragment_id"], ["asr_fragments.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["capture_session_id"], ["asr_capture_sessions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("fragment_id", "backend_key", name="uq_speaker_compare_fragment_backend"),
    )
    op.create_index(
        "ix_speaker_backend_comparison_evidence_fragment_id",
        "speaker_backend_comparison_evidence",
        ["fragment_id"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_backend_comparison_evidence_capture_session_id",
        "speaker_backend_comparison_evidence",
        ["capture_session_id"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_backend_comparison_evidence_case_id",
        "speaker_backend_comparison_evidence",
        ["case_id"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_backend_comparison_evidence_backend_key",
        "speaker_backend_comparison_evidence",
        ["backend_key"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_backend_comparison_evidence_authoritative",
        "speaker_backend_comparison_evidence",
        ["authoritative"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_backend_comparison_evidence_created_at",
        "speaker_backend_comparison_evidence",
        ["created_at"],
        unique=False,
    )


def downgrade() -> None:
    op.drop_index("ix_speaker_backend_comparison_evidence_created_at", table_name="speaker_backend_comparison_evidence")
    op.drop_index("ix_speaker_backend_comparison_evidence_authoritative", table_name="speaker_backend_comparison_evidence")
    op.drop_index("ix_speaker_backend_comparison_evidence_backend_key", table_name="speaker_backend_comparison_evidence")
    op.drop_index("ix_speaker_backend_comparison_evidence_case_id", table_name="speaker_backend_comparison_evidence")
    op.drop_index("ix_speaker_backend_comparison_evidence_capture_session_id", table_name="speaker_backend_comparison_evidence")
    op.drop_index("ix_speaker_backend_comparison_evidence_fragment_id", table_name="speaker_backend_comparison_evidence")
    op.drop_table("speaker_backend_comparison_evidence")
