"""Add MOSS interrogation transcription integration tables.

Revision ID: 0013_moss_transcription_integration
Revises: 0012_mark_xvector_voiceprints_for_reenrollment
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0013_moss_transcription_integration"
down_revision = "0012_mark_xvector_voiceprints_for_reenrollment"
branch_labels = None
depends_on = None


_TABLES = (
    "moss_transcriptions",
    "moss_transcription_revisions",
    "moss_speaker_mappings",
)
_INDEXES = (
    ("ix_moss_transcriptions_case_id", "moss_transcriptions", ["case_id"]),
    ("ix_moss_transcriptions_audio_sha256", "moss_transcriptions", ["audio_sha256"]),
    ("ix_moss_transcriptions_job_id", "moss_transcriptions", ["job_id"]),
    ("ix_moss_transcriptions_state", "moss_transcriptions", ["state"]),
    ("ix_moss_transcription_revisions_transcription_id", "moss_transcription_revisions", ["transcription_id"]),
    ("ix_moss_transcription_revisions_case_id", "moss_transcription_revisions", ["case_id"]),
    ("ix_moss_transcription_revisions_created_at", "moss_transcription_revisions", ["created_at"]),
    ("ix_moss_speaker_mappings_case_id", "moss_speaker_mappings", ["case_id"]),
)


def upgrade() -> None:
    op.create_table(
        "moss_transcriptions",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("audio_path", sa.Text(), nullable=False),
        sa.Column("audio_sha256", sa.String(length=64), nullable=False),
        sa.Column("job_id", sa.String(length=64), nullable=True),
        sa.Column("model_manifest_sha256", sa.String(length=64), nullable=True),
        sa.Column("state", sa.String(length=32), nullable=False, server_default="QUEUED"),
        sa.Column("error", sa.Text(), nullable=True),
        sa.Column("windows_json", sa.Text(), nullable=False, server_default="[]"),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "moss_transcription_revisions",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("transcription_id", sa.String(length=64), nullable=False),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("job_id", sa.String(length=64), nullable=False),
        sa.Column("revision_no", sa.Integer(), nullable=False),
        sa.Column("audio_sha256", sa.String(length=64), nullable=False),
        sa.Column("model_manifest_sha256", sa.String(length=64), nullable=False),
        sa.Column("segments_json", sa.Text(), nullable=False),
        sa.Column("provenance_json", sa.Text(), nullable=False, server_default="[]"),
        sa.Column("mapping_snapshot_json", sa.Text(), nullable=False, server_default="{}"),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["transcription_id"], ["moss_transcriptions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("transcription_id", "revision_no", name="uq_moss_revision_no"),
    )
    op.create_table(
        "moss_speaker_mappings",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("global_speaker", sa.String(length=16), nullable=False),
        sa.Column("role", sa.String(length=64), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("case_id", "global_speaker", name="uq_moss_speaker_mapping_case_gs"),
    )

    bind = op.get_bind()
    existing_indexes: set[str] = set()
    for name, table, columns in _INDEXES:
        if table not in existing_indexes:
            existing_indexes = {str(index["name"]) for index in sa.inspect(bind).get_indexes(table)}
        if name not in existing_indexes:
            op.create_index(name, table, columns, unique=False)


def downgrade() -> None:
    op.drop_index("ix_moss_speaker_mappings_case_id", table_name="moss_speaker_mappings")
    op.drop_table("moss_speaker_mappings")
    op.drop_index("ix_moss_transcription_revisions_created_at", table_name="moss_transcription_revisions")
    op.drop_index("ix_moss_transcription_revisions_case_id", table_name="moss_transcription_revisions")
    op.drop_index("ix_moss_transcription_revisions_transcription_id", table_name="moss_transcription_revisions")
    op.drop_table("moss_transcription_revisions")
    op.drop_index("ix_moss_transcriptions_state", table_name="moss_transcriptions")
    op.drop_index("ix_moss_transcriptions_job_id", table_name="moss_transcriptions")
    op.drop_index("ix_moss_transcriptions_audio_sha256", table_name="moss_transcriptions")
    op.drop_index("ix_moss_transcriptions_case_id", table_name="moss_transcriptions")
    op.drop_table("moss_transcriptions")
