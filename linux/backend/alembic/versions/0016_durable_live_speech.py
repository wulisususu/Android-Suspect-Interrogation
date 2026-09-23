"""Add durable audio metadata and replayable live speech jobs."""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0016_durable_live_speech"
down_revision = "0015_case_voice_role_draft"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.add_column("asr_capture_sessions", sa.Column("audio_sample_count", sa.Integer(), nullable=False, server_default="0"))
    op.add_column("asr_capture_sessions", sa.Column("asr_cursor_sample", sa.Integer(), nullable=False, server_default="0"))
    op.add_column("asr_capture_sessions", sa.Column("voiced_ms", sa.Integer(), nullable=False, server_default="0"))
    op.add_column("asr_capture_sessions", sa.Column("recording_status", sa.String(length=32), nullable=False, server_default="PENDING"))
    op.add_column("asr_capture_sessions", sa.Column("asr_status", sa.String(length=32), nullable=False, server_default="PENDING"))
    op.add_column("asr_capture_sessions", sa.Column("speaker_status", sa.String(length=32), nullable=False, server_default="PENDING"))
    op.add_column("asr_fragments", sa.Column("asr_idempotency_key", sa.String(length=128), nullable=True))
    op.create_index(
        "uq_asr_fragments_asr_idempotency_key",
        "asr_fragments",
        ["asr_idempotency_key"],
        unique=True,
    )
    # Protect confirmed transcript parents without rebuilding the legacy table.
    op.execute(
        "CREATE TRIGGER tr_asr_fragments_superseded_unconfirmed_insert "
        "BEFORE INSERT ON asr_fragments "
        "WHEN NEW.state = 'SUPERSEDED' AND NEW.confirmed_message_id IS NOT NULL "
        "BEGIN SELECT RAISE(ABORT, 'confirmed fragments cannot be superseded'); END"
    )
    op.execute(
        "CREATE TRIGGER tr_asr_fragments_superseded_unconfirmed_update "
        "BEFORE UPDATE OF state, confirmed_message_id ON asr_fragments "
        "WHEN NEW.state = 'SUPERSEDED' AND NEW.confirmed_message_id IS NOT NULL "
        "BEGIN SELECT RAISE(ABORT, 'confirmed fragments cannot be superseded'); END"
    )

    op.create_table(
        "asr_audio_segments",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("capture_session_id", sa.String(length=64), nullable=False),
        sa.Column("sequence", sa.Integer(), nullable=False),
        sa.Column("relative_path", sa.String(length=512), nullable=False),
        sa.Column("start_sample", sa.Integer(), nullable=False),
        sa.Column("committed_samples", sa.Integer(), nullable=False),
        sa.Column("finalized_samples", sa.Integer(), nullable=False),
        sa.Column("sha256", sa.String(length=64), nullable=False),
        sa.Column("status", sa.String(length=32), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["capture_session_id"], ["asr_capture_sessions.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("capture_session_id", "sequence", name="uq_asr_audio_segments_capture_sequence"),
    )
    op.create_index("ix_asr_audio_segments_capture_session_id", "asr_audio_segments", ["capture_session_id"])
    op.create_index("ix_asr_audio_segments_status", "asr_audio_segments", ["status"])

    op.create_table(
        "asr_audio_frames",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("capture_session_id", sa.String(length=64), nullable=False),
        sa.Column("source_sequence", sa.Integer(), nullable=False),
        sa.Column("start_sample", sa.Integer(), nullable=False),
        sa.Column("end_sample", sa.Integer(), nullable=False),
        sa.Column("payload_sha256", sa.String(length=64), nullable=False),
        sa.Column("durable_sample_end", sa.Integer(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["capture_session_id"], ["asr_capture_sessions.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("capture_session_id", "source_sequence", name="uq_asr_audio_frames_capture_source_sequence"),
    )
    op.create_index("ix_asr_audio_frames_capture_session_id", "asr_audio_frames", ["capture_session_id"])

    op.create_table(
        "live_speech_jobs",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("idempotency_key", sa.String(length=128), nullable=False),
        sa.Column("kind", sa.String(length=16), nullable=False),
        sa.Column("capture_session_id", sa.String(length=64), nullable=False),
        sa.Column("fragment_id", sa.String(length=64), nullable=True),
        sa.Column("start_sample", sa.Integer(), nullable=False),
        sa.Column("end_sample", sa.Integer(), nullable=False),
        sa.Column("state", sa.String(length=32), nullable=False),
        sa.Column("attempts", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("last_error_code", sa.String(length=64), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.CheckConstraint("kind IN ('ASR', 'SPEAKER')", name="ck_live_speech_jobs_kind"),
        sa.ForeignKeyConstraint(["capture_session_id"], ["asr_capture_sessions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["fragment_id"], ["asr_fragments.id"], ondelete="SET NULL"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("idempotency_key", name="uq_live_speech_jobs_idempotency_key"),
    )
    op.create_index("ix_live_speech_jobs_kind", "live_speech_jobs", ["kind"])
    op.create_index("ix_live_speech_jobs_capture_session_id", "live_speech_jobs", ["capture_session_id"])
    op.create_index("ix_live_speech_jobs_fragment_id", "live_speech_jobs", ["fragment_id"])
    op.create_index("ix_live_speech_jobs_state", "live_speech_jobs", ["state"])

    op.create_table(
        "asr_fragment_lineage",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("analysis_job_id", sa.String(length=64), nullable=False),
        sa.Column("parent_fragment_id", sa.String(length=64), nullable=False),
        sa.Column("child_fragment_id", sa.String(length=64), nullable=False),
        sa.Column("relation", sa.String(length=32), nullable=False, server_default="SUPERSEDES"),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.CheckConstraint("relation = 'SUPERSEDES'", name="ck_asr_fragment_lineage_relation"),
        sa.ForeignKeyConstraint(["analysis_job_id"], ["live_speech_jobs.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["parent_fragment_id"], ["asr_fragments.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["child_fragment_id"], ["asr_fragments.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("parent_fragment_id", "child_fragment_id", name="uq_asr_fragment_lineage_parent_child"),
    )
    op.create_index("ix_asr_fragment_lineage_analysis_job_id", "asr_fragment_lineage", ["analysis_job_id"])
    op.create_index("ix_asr_fragment_lineage_parent_fragment_id", "asr_fragment_lineage", ["parent_fragment_id"])
    op.create_index("ix_asr_fragment_lineage_child_fragment_id", "asr_fragment_lineage", ["child_fragment_id"])


def downgrade() -> None:
    op.execute("DROP TRIGGER tr_asr_fragments_superseded_unconfirmed_update")
    op.execute("DROP TRIGGER tr_asr_fragments_superseded_unconfirmed_insert")

    op.drop_index("ix_asr_fragment_lineage_child_fragment_id", table_name="asr_fragment_lineage")
    op.drop_index("ix_asr_fragment_lineage_parent_fragment_id", table_name="asr_fragment_lineage")
    op.drop_index("ix_asr_fragment_lineage_analysis_job_id", table_name="asr_fragment_lineage")
    op.drop_table("asr_fragment_lineage")

    op.drop_index("ix_live_speech_jobs_state", table_name="live_speech_jobs")
    op.drop_index("ix_live_speech_jobs_fragment_id", table_name="live_speech_jobs")
    op.drop_index("ix_live_speech_jobs_capture_session_id", table_name="live_speech_jobs")
    op.drop_index("ix_live_speech_jobs_kind", table_name="live_speech_jobs")
    op.drop_table("live_speech_jobs")

    op.drop_index("ix_asr_audio_frames_capture_session_id", table_name="asr_audio_frames")
    op.drop_table("asr_audio_frames")

    op.drop_index("ix_asr_audio_segments_status", table_name="asr_audio_segments")
    op.drop_index("ix_asr_audio_segments_capture_session_id", table_name="asr_audio_segments")
    op.drop_table("asr_audio_segments")

    op.drop_index("uq_asr_fragments_asr_idempotency_key", table_name="asr_fragments")
    op.drop_column("asr_fragments", "asr_idempotency_key")
    op.drop_column("asr_capture_sessions", "speaker_status")
    op.drop_column("asr_capture_sessions", "asr_status")
    op.drop_column("asr_capture_sessions", "recording_status")
    op.drop_column("asr_capture_sessions", "voiced_ms")
    op.drop_column("asr_capture_sessions", "asr_cursor_sample")
    op.drop_column("asr_capture_sessions", "audio_sample_count")
