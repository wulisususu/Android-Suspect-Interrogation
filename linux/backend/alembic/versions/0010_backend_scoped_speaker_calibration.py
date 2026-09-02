"""Scope speaker calibration history by backend/model/microphone.

Revision ID: 0010_backend_scoped_speaker_calibration
Revises: 0009_dual_speaker_backends
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0010_backend_scoped_speaker_calibration"
down_revision = "0009_dual_speaker_backends"
branch_labels = None
depends_on = None


_XVECTOR = "xvector"


def upgrade() -> None:
    with op.batch_alter_table("speaker_device_calibrations") as batch:
        batch.add_column(
            sa.Column("speaker_backend_key", sa.String(length=64), nullable=False, server_default=_XVECTOR)
        )
        batch.create_index(
            "ix_speaker_device_calibrations_speaker_backend_key",
            ["speaker_backend_key"],
            unique=False,
        )
        batch.create_index(
            "ix_speaker_device_calibration_scope",
            ["speaker_backend_key", "speaker_model_fingerprint", "microphone_fingerprint", "created_at"],
            unique=False,
        )

    with op.batch_alter_table("session_speaker_calibration_snapshots") as batch:
        batch.add_column(
            sa.Column("speaker_backend_key", sa.String(length=64), nullable=False, server_default=_XVECTOR)
        )
        batch.create_index(
            "ix_session_speaker_calibration_snapshots_speaker_backend_key",
            ["speaker_backend_key"],
            unique=False,
        )


def downgrade() -> None:
    with op.batch_alter_table("session_speaker_calibration_snapshots") as batch:
        batch.drop_index("ix_session_speaker_calibration_snapshots_speaker_backend_key")
        batch.drop_column("speaker_backend_key")

    with op.batch_alter_table("speaker_device_calibrations") as batch:
        batch.drop_index("ix_speaker_device_calibration_scope")
        batch.drop_index("ix_speaker_device_calibrations_speaker_backend_key")
        batch.drop_column("speaker_backend_key")
