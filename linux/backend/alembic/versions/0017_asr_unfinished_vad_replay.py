"""Persist the start of an unfinished live VAD range."""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0017_asr_unfinished_vad_replay"
down_revision = "0016_durable_live_speech"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.add_column(
        "asr_capture_sessions",
        sa.Column("asr_unfinished_start_sample", sa.Integer(), nullable=True),
    )


def downgrade() -> None:
    op.drop_column("asr_capture_sessions", "asr_unfinished_start_sample")
