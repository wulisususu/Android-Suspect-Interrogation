"""Mark legacy XVector voiceprints as incompatible with ERes2Net-large.

Revision ID: 0012_mark_xvector_voiceprints_for_reenrollment
Revises: 0011_speaker_backend_comparison_evidence
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0012_mark_xvector_voiceprints_for_reenrollment"
down_revision = "0011_speaker_backend_comparison_evidence"
branch_labels = None
depends_on = None


def upgrade() -> None:
    for table, quality_column in (
        ("suspect_voiceprints", "enrollment_quality"),
        ("officer_voiceprints", "enrollment_quality"),
        ("officer_voice_samples", "quality"),
    ):
        op.execute(
            sa.text(
                f"UPDATE {table} SET {quality_column} = 'NEEDS_REENROLL' "
                "WHERE model_key = 'xvector'"
            )
        )


def downgrade() -> None:
    # Do not rewrite historic compatibility status during a schema rollback.
    pass
