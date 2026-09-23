"""Persist replay checkpoint separately from ASR progress."""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0018_asr_finalize_checkpoint"
down_revision = "0017_asr_unfinished_vad_replay"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.add_column(
        "asr_capture_sessions",
        sa.Column("asr_finalize_checkpoint_sample", sa.Integer(), nullable=True),
    )


def downgrade() -> None:
    op.drop_column("asr_capture_sessions", "asr_finalize_checkpoint_sample")
