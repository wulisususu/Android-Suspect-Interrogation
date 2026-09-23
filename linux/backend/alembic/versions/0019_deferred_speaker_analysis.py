"""Store append-only evidence for deferred speaker decisions."""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0019_deferred_speaker_analysis"
down_revision = "0018_asr_finalize_checkpoint"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "asr_speaker_analysis_results",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("analysis_job_id", sa.String(length=64), sa.ForeignKey("live_speech_jobs.id", ondelete="CASCADE"), nullable=False),
        sa.Column("fragment_id", sa.String(length=64), sa.ForeignKey("asr_fragments.id", ondelete="CASCADE"), nullable=False),
        sa.Column("role", sa.String(length=32), nullable=False),
        sa.Column("speaker_id", sa.String(length=128), nullable=True),
        sa.Column("speaker_name", sa.String(length=128), nullable=True),
        sa.Column("speaker_source", sa.String(length=64), nullable=False),
        sa.Column("score", sa.Float(), nullable=True),
        sa.Column("second_best_score", sa.Float(), nullable=True),
        sa.Column("threshold", sa.Float(), nullable=False),
        sa.Column("margin", sa.Float(), nullable=False),
        sa.Column("threshold_source", sa.String(length=64), nullable=False),
        sa.Column("calibration_id", sa.String(length=64), nullable=True),
        sa.Column("calibration_status", sa.String(length=32), nullable=True),
        sa.Column("voiceprint_verified", sa.Boolean(), nullable=False),
        sa.Column("low_confidence", sa.Boolean(), nullable=False),
        sa.Column("overlap", sa.Boolean(), nullable=False),
        sa.Column("usable_duration_ms", sa.Integer(), nullable=False),
        sa.Column("model_id", sa.String(length=128), nullable=True),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("model_fingerprint", sa.String(length=64), nullable=True),
        sa.Column("microphone_fingerprint", sa.String(length=64), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.UniqueConstraint("analysis_job_id", "fragment_id", name="uq_asr_speaker_analysis_job_fragment"),
    )
    op.create_index("ix_asr_speaker_analysis_results_analysis_job_id", "asr_speaker_analysis_results", ["analysis_job_id"])
    op.create_index("ix_asr_speaker_analysis_results_fragment_id", "asr_speaker_analysis_results", ["fragment_id"])
    op.create_index("ix_asr_speaker_analysis_results_created_at", "asr_speaker_analysis_results", ["created_at"])


def downgrade() -> None:
    op.drop_index("ix_asr_speaker_analysis_results_created_at", table_name="asr_speaker_analysis_results")
    op.drop_index("ix_asr_speaker_analysis_results_fragment_id", table_name="asr_speaker_analysis_results")
    op.drop_index("ix_asr_speaker_analysis_results_analysis_job_id", table_name="asr_speaker_analysis_results")
    op.drop_table("asr_speaker_analysis_results")
