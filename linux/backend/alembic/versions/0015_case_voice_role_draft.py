"""Persist the selected voice roles at case scope before session start."""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0015_case_voice_role_draft"
down_revision = "0014_signature_snapshot_role_unique"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "case_voice_role_drafts",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("interrogator_officer_id", sa.String(length=128), nullable=True),
        sa.Column("recorder_officer_id", sa.String(length=128), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("case_id", name="uq_case_voice_role_draft_case"),
    )
    op.create_index("ix_case_voice_role_drafts_case_id", "case_voice_role_drafts", ["case_id"], unique=False)


def downgrade() -> None:
    op.drop_index("ix_case_voice_role_drafts_case_id", table_name="case_voice_role_drafts")
    op.drop_table("case_voice_role_drafts")
