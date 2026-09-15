"""Require one signature per role on each frozen snapshot.

Revision ID: 0014_signature_snapshot_role_unique
Revises: 0013_moss_transcription_integration
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0014_signature_snapshot_role_unique"
down_revision = "0013_moss_transcription_integration"
branch_labels = None
depends_on = None


def upgrade() -> None:
    duplicates = op.get_bind().execute(
        sa.text(
            """
            SELECT snapshot_id, signer_role
            FROM signature_records
            WHERE snapshot_id IS NOT NULL
            GROUP BY snapshot_id, signer_role
            HAVING COUNT(*) > 1
            """
        )
    ).fetchall()
    if duplicates:
        raise RuntimeError("存在重复快照签名角色，需先人工处理后再迁移")

    with op.batch_alter_table("signature_records") as batch_op:
        batch_op.create_unique_constraint(
            "uq_signature_snapshot_role", ["snapshot_id", "signer_role"]
        )


def downgrade() -> None:
    with op.batch_alter_table("signature_records") as batch_op:
        batch_op.drop_constraint("uq_signature_snapshot_role", type_="unique")
