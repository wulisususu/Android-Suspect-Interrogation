"""Make voiceprint persistence model-aware for dual speaker backends.

Revision ID: 0009_dual_speaker_backends
Revises: 0008_qwen_formal_record_routing
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0009_dual_speaker_backends"
down_revision = "0008_qwen_formal_record_routing"
branch_labels = None
depends_on = None


_XVECTOR = "xvector"


def upgrade() -> None:
    with op.batch_alter_table("suspect_voiceprints", recreate="always") as batch:
        batch.add_column(sa.Column("model_key", sa.String(length=64), nullable=False, server_default=_XVECTOR))
        batch.drop_constraint("uq_suspect_voiceprints_case_id", type_="unique")
        batch.create_unique_constraint("uq_suspect_voiceprint_case_model", ["case_id", "model_key"])
        batch.create_index("ix_suspect_voiceprints_case_id", ["case_id"], unique=False)
        batch.create_index("ix_suspect_voiceprints_model_key", ["model_key"], unique=False)

    with op.batch_alter_table("officer_voiceprints", recreate="always") as batch:
        batch.add_column(sa.Column("model_key", sa.String(length=64), nullable=False, server_default=_XVECTOR))
        batch.drop_index("ix_officer_voiceprints_officer_id")
        batch.create_unique_constraint("uq_officer_voiceprint_officer_model", ["officer_id", "model_key"])
        batch.create_index("ix_officer_voiceprints_officer_id", ["officer_id"], unique=False)
        batch.create_index("ix_officer_voiceprints_model_key", ["model_key"], unique=False)

    with op.batch_alter_table("officer_voice_profiles", recreate="always") as batch:
        batch.add_column(sa.Column("model_key", sa.String(length=64), nullable=False, server_default=_XVECTOR))
        batch.drop_index("ix_officer_voice_profiles_officer_id")
        batch.create_unique_constraint("uq_officer_voice_profile_officer_model", ["officer_id", "model_key"])
        batch.create_index("ix_officer_voice_profiles_officer_id", ["officer_id"], unique=False)
        batch.create_index("ix_officer_voice_profiles_model_key", ["model_key"], unique=False)

    with op.batch_alter_table("officer_voice_samples", recreate="always") as batch:
        batch.add_column(sa.Column("model_key", sa.String(length=64), nullable=False, server_default=_XVECTOR))
        batch.create_index("ix_officer_voice_samples_model_key", ["model_key"], unique=False)

    with op.batch_alter_table("session_officer_voice_snapshots", recreate="always") as batch:
        batch.add_column(sa.Column("model_key", sa.String(length=64), nullable=False, server_default=_XVECTOR))
        batch.create_index("ix_session_officer_voice_snapshots_model_key", ["model_key"], unique=False)


def _assert_downgrade_is_unambiguous() -> None:
    bind = op.get_bind()
    checks = (
        ("suspect_voiceprints", "case_id"),
        ("officer_voiceprints", "officer_id"),
        ("officer_voice_profiles", "officer_id"),
    )
    for table, identity_column in checks:
        duplicate = bind.execute(
            sa.text(
                f"SELECT {identity_column} FROM {table} "
                f"GROUP BY {identity_column} HAVING COUNT(*) > 1 LIMIT 1"
            )
        ).first()
        if duplicate is not None:
            raise RuntimeError(
                f"cannot downgrade 0009 while {table} contains multiple model references for one identity"
            )


def downgrade() -> None:
    _assert_downgrade_is_unambiguous()

    with op.batch_alter_table("session_officer_voice_snapshots", recreate="always") as batch:
        batch.drop_index("ix_session_officer_voice_snapshots_model_key")
        batch.drop_column("model_key")

    with op.batch_alter_table("officer_voice_samples", recreate="always") as batch:
        batch.drop_index("ix_officer_voice_samples_model_key")
        batch.drop_column("model_key")

    with op.batch_alter_table("officer_voice_profiles", recreate="always") as batch:
        batch.drop_index("ix_officer_voice_profiles_model_key")
        batch.drop_index("ix_officer_voice_profiles_officer_id")
        batch.drop_constraint("uq_officer_voice_profile_officer_model", type_="unique")
        batch.drop_column("model_key")
        batch.create_index("ix_officer_voice_profiles_officer_id", ["officer_id"], unique=True)

    with op.batch_alter_table("officer_voiceprints", recreate="always") as batch:
        batch.drop_index("ix_officer_voiceprints_model_key")
        batch.drop_index("ix_officer_voiceprints_officer_id")
        batch.drop_constraint("uq_officer_voiceprint_officer_model", type_="unique")
        batch.drop_column("model_key")
        batch.create_index("ix_officer_voiceprints_officer_id", ["officer_id"], unique=True)

    with op.batch_alter_table("suspect_voiceprints", recreate="always") as batch:
        batch.drop_index("ix_suspect_voiceprints_model_key")
        batch.drop_index("ix_suspect_voiceprints_case_id")
        batch.drop_constraint("uq_suspect_voiceprint_case_model", type_="unique")
        batch.drop_column("model_key")
        batch.create_unique_constraint("uq_suspect_voiceprints_case_id", ["case_id"])
