"""Add voiceprint and ASR speech-pipeline persistence.

Revision ID: 0002_voiceprint_speech_pipeline
Revises: 0001_linux_core_schema
"""

from alembic import op
import sqlalchemy as sa

revision = "0002_voiceprint_speech_pipeline"
down_revision = "0001_linux_core_schema"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "suspect_voiceprints",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("embedding", sa.LargeBinary(), nullable=False),
        sa.Column("embedding_dim", sa.Integer(), nullable=False),
        sa.Column("model_id", sa.String(length=128), nullable=False),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("enrollment_quality", sa.String(length=64), nullable=False),
        sa.Column("usable_duration_ms", sa.Integer(), nullable=False),
        sa.Column("active", sa.Boolean(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.UniqueConstraint("case_id", name="uq_suspect_voiceprints_case_id"),
    )

    op.create_table(
        "officer_voiceprints",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("officer_id", sa.String(length=128), nullable=False),
        sa.Column("officer_name", sa.String(length=128), nullable=False),
        sa.Column("embedding", sa.LargeBinary(), nullable=False),
        sa.Column("embedding_dim", sa.Integer(), nullable=False),
        sa.Column("model_id", sa.String(length=128), nullable=False),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("enrollment_quality", sa.String(length=64), nullable=False),
        sa.Column("usable_duration_ms", sa.Integer(), nullable=False),
        sa.Column("active", sa.Boolean(), nullable=False),
        sa.Column("revoked_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index("ix_officer_voiceprints_officer_id", "officer_voiceprints", ["officer_id"], unique=True)

    op.create_table(
        "session_voice_assignments",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("session_id", sa.String(length=64), nullable=False),
        sa.Column("suspect_voiceprint_id", sa.String(length=64), nullable=False),
        sa.Column("interrogator_officer_id", sa.String(length=128), nullable=True),
        sa.Column("interrogator_voiceprint_id", sa.String(length=64), nullable=True),
        sa.Column("recorder_officer_id", sa.String(length=128), nullable=True),
        sa.Column("recorder_voiceprint_id", sa.String(length=64), nullable=True),
        sa.Column("recognition_mode", sa.String(length=64), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["session_id"], ["interrogation_sessions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["suspect_voiceprint_id"], ["suspect_voiceprints.id"], ondelete="RESTRICT"),
        sa.ForeignKeyConstraint(["interrogator_voiceprint_id"], ["officer_voiceprints.id"], ondelete="RESTRICT"),
        sa.ForeignKeyConstraint(["recorder_voiceprint_id"], ["officer_voiceprints.id"], ondelete="RESTRICT"),
        sa.UniqueConstraint("session_id", name="uq_session_voice_assignments_session_id"),
    )

    op.create_table(
        "asr_capture_sessions",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("interrogation_session_id", sa.String(length=64), nullable=True),
        sa.Column("status", sa.String(length=32), nullable=False),
        sa.Column("sample_rate", sa.Integer(), nullable=False),
        sa.Column("started_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("ended_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["interrogation_session_id"], ["interrogation_sessions.id"], ondelete="SET NULL"),
    )
    op.create_index("ix_asr_capture_sessions_case_id", "asr_capture_sessions", ["case_id"], unique=False)
    op.create_index(
        "ix_asr_capture_sessions_interrogation_session_id",
        "asr_capture_sessions",
        ["interrogation_session_id"],
        unique=False,
    )

    op.create_table(
        "asr_fragments",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("capture_session_id", sa.String(length=64), nullable=False),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("ordinal", sa.Integer(), nullable=False),
        sa.Column("started_at_ms", sa.Integer(), nullable=False),
        sa.Column("ended_at_ms", sa.Integer(), nullable=False),
        sa.Column("raw_text", sa.Text(), nullable=False),
        sa.Column("edited_text", sa.Text(), nullable=False),
        sa.Column("asr_confidence", sa.Float(), nullable=True),
        sa.Column("speaker", sa.String(length=32), nullable=False),
        sa.Column("speaker_id", sa.String(length=128), nullable=True),
        sa.Column("speaker_name", sa.String(length=128), nullable=True),
        sa.Column("speaker_score", sa.Float(), nullable=True),
        sa.Column("second_best_score", sa.Float(), nullable=True),
        sa.Column("speaker_threshold", sa.Float(), nullable=True),
        sa.Column("speaker_margin", sa.Float(), nullable=True),
        sa.Column("speaker_source", sa.String(length=64), nullable=False),
        sa.Column("voiceprint_verified", sa.Boolean(), nullable=False),
        sa.Column("low_confidence", sa.Boolean(), nullable=False),
        sa.Column("state", sa.String(length=32), nullable=False),
        sa.Column("model_id", sa.String(length=128), nullable=False),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("confirmed_message_id", sa.String(length=64), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["capture_session_id"], ["asr_capture_sessions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["confirmed_message_id"], ["messages.id"], ondelete="SET NULL"),
        sa.UniqueConstraint("capture_session_id", "ordinal", name="uq_asr_fragments_capture_ordinal"),
    )
    op.create_index("ix_asr_fragments_capture_session_id", "asr_fragments", ["capture_session_id"], unique=False)
    op.create_index("ix_asr_fragments_case_id", "asr_fragments", ["case_id"], unique=False)
    op.create_index("ix_asr_fragments_confirmed_message_id", "asr_fragments", ["confirmed_message_id"], unique=False)


def downgrade() -> None:
    op.drop_index("ix_asr_fragments_confirmed_message_id", table_name="asr_fragments")
    op.drop_index("ix_asr_fragments_case_id", table_name="asr_fragments")
    op.drop_index("ix_asr_fragments_capture_session_id", table_name="asr_fragments")
    op.drop_table("asr_fragments")

    op.drop_index("ix_asr_capture_sessions_interrogation_session_id", table_name="asr_capture_sessions")
    op.drop_index("ix_asr_capture_sessions_case_id", table_name="asr_capture_sessions")
    op.drop_table("asr_capture_sessions")

    op.drop_table("session_voice_assignments")

    op.drop_index("ix_officer_voiceprints_officer_id", table_name="officer_voiceprints")
    op.drop_table("officer_voiceprints")
    op.drop_table("suspect_voiceprints")
