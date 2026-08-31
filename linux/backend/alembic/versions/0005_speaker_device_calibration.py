"""Add speaker device calibration history and runtime snapshots.

Revision ID: 0005_speaker_device_calibration
Revises: 0004_global_officer_voiceprint_library
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


revision = "0005_speaker_device_calibration"
down_revision = "0004_global_officer_voiceprint_library"
branch_labels = None
depends_on = None


def upgrade() -> None:
    # Historical samples predate stable model/microphone fingerprints. Keep the
    # new columns nullable so migrated samples remain auditable but cannot be
    # silently treated as production-calibration-compatible.
    op.add_column("officer_voice_samples", sa.Column("model_fingerprint", sa.String(length=64), nullable=True))
    op.add_column("officer_voice_samples", sa.Column("microphone_fingerprint", sa.String(length=64), nullable=True))
    op.add_column(
        "officer_voice_samples",
        sa.Column("microphone_fingerprint_certainty", sa.String(length=32), nullable=True),
    )
    op.create_index(
        "ix_officer_voice_samples_model_fingerprint",
        "officer_voice_samples",
        ["model_fingerprint"],
        unique=False,
    )
    op.create_index(
        "ix_officer_voice_samples_microphone_fingerprint",
        "officer_voice_samples",
        ["microphone_fingerprint"],
        unique=False,
    )

    op.create_table(
        "speaker_device_calibrations",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("status_at_creation", sa.String(length=32), nullable=False),
        sa.Column("threshold", sa.Float(), nullable=False),
        sa.Column("margin", sa.Float(), nullable=True),
        sa.Column("far", sa.Float(), nullable=False),
        sa.Column("frr", sa.Float(), nullable=False),
        sa.Column("eer", sa.Float(), nullable=False),
        sa.Column("eer_threshold", sa.Float(), nullable=False),
        sa.Column("eer_far", sa.Float(), nullable=False),
        sa.Column("eer_frr", sa.Float(), nullable=False),
        sa.Column("genuine_trial_count", sa.Integer(), nullable=False),
        sa.Column("impostor_trial_count", sa.Integer(), nullable=False),
        sa.Column("officer_count", sa.Integer(), nullable=False),
        sa.Column("sample_count", sa.Integer(), nullable=False),
        sa.Column("corpus_digest", sa.String(length=64), nullable=False),
        sa.Column("algorithm_version", sa.String(length=64), nullable=False),
        sa.Column("speaker_model_id", sa.String(length=128), nullable=False),
        sa.Column("speaker_model_version", sa.String(length=128), nullable=True),
        sa.Column("speaker_model_fingerprint", sa.String(length=64), nullable=False),
        sa.Column("audio_source", sa.String(length=32), nullable=False),
        sa.Column("microphone_id", sa.String(length=256), nullable=False),
        sa.Column("microphone_name", sa.String(length=256), nullable=False),
        sa.Column("microphone_fingerprint", sa.String(length=64), nullable=False),
        sa.Column("microphone_fingerprint_certainty", sa.String(length=32), nullable=False),
        sa.Column("created_by", sa.String(length=128), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index(
        "ix_speaker_device_calibrations_status_at_creation",
        "speaker_device_calibrations",
        ["status_at_creation"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_device_calibrations_corpus_digest",
        "speaker_device_calibrations",
        ["corpus_digest"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_device_calibrations_model_fingerprint",
        "speaker_device_calibrations",
        ["speaker_model_fingerprint"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_device_calibrations_microphone_fingerprint",
        "speaker_device_calibrations",
        ["microphone_fingerprint"],
        unique=False,
    )
    op.create_index(
        "ix_speaker_device_calibrations_created_at",
        "speaker_device_calibrations",
        ["created_at"],
        unique=False,
    )

    op.create_table(
        "session_speaker_calibration_snapshots",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("capture_session_id", sa.String(length=64), nullable=False),
        sa.Column("interrogation_session_id", sa.String(length=64), nullable=True),
        sa.Column("calibration_id", sa.String(length=64), nullable=True),
        sa.Column("threshold", sa.Float(), nullable=False),
        sa.Column("margin", sa.Float(), nullable=True),
        sa.Column("threshold_source", sa.String(length=32), nullable=False),
        sa.Column("calibration_status", sa.String(length=32), nullable=False),
        sa.Column("speaker_model_fingerprint", sa.String(length=64), nullable=True),
        sa.Column("microphone_fingerprint", sa.String(length=64), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["capture_session_id"], ["asr_capture_sessions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(
            ["interrogation_session_id"], ["interrogation_sessions.id"], ondelete="SET NULL"
        ),
        sa.ForeignKeyConstraint(["calibration_id"], ["speaker_device_calibrations.id"], ondelete="SET NULL"),
        sa.UniqueConstraint("capture_session_id", name="uq_session_speaker_calibration_capture"),
    )
    op.create_index(
        "ix_session_speaker_calibration_snapshots_capture_session_id",
        "session_speaker_calibration_snapshots",
        ["capture_session_id"],
        unique=True,
    )
    op.create_index(
        "ix_session_speaker_calibration_snapshots_interrogation_session_id",
        "session_speaker_calibration_snapshots",
        ["interrogation_session_id"],
        unique=False,
    )
    op.create_index(
        "ix_session_speaker_calibration_snapshots_calibration_id",
        "session_speaker_calibration_snapshots",
        ["calibration_id"],
        unique=False,
    )
    op.create_index(
        "ix_session_speaker_calibration_snapshots_created_at",
        "session_speaker_calibration_snapshots",
        ["created_at"],
        unique=False,
    )


def downgrade() -> None:
    op.drop_index(
        "ix_session_speaker_calibration_snapshots_created_at",
        table_name="session_speaker_calibration_snapshots",
    )
    op.drop_index(
        "ix_session_speaker_calibration_snapshots_calibration_id",
        table_name="session_speaker_calibration_snapshots",
    )
    op.drop_index(
        "ix_session_speaker_calibration_snapshots_interrogation_session_id",
        table_name="session_speaker_calibration_snapshots",
    )
    op.drop_index(
        "ix_session_speaker_calibration_snapshots_capture_session_id",
        table_name="session_speaker_calibration_snapshots",
    )
    op.drop_table("session_speaker_calibration_snapshots")

    op.drop_index("ix_speaker_device_calibrations_created_at", table_name="speaker_device_calibrations")
    op.drop_index(
        "ix_speaker_device_calibrations_microphone_fingerprint",
        table_name="speaker_device_calibrations",
    )
    op.drop_index(
        "ix_speaker_device_calibrations_model_fingerprint",
        table_name="speaker_device_calibrations",
    )
    op.drop_index("ix_speaker_device_calibrations_corpus_digest", table_name="speaker_device_calibrations")
    op.drop_index(
        "ix_speaker_device_calibrations_status_at_creation",
        table_name="speaker_device_calibrations",
    )
    op.drop_table("speaker_device_calibrations")

    op.drop_index(
        "ix_officer_voice_samples_microphone_fingerprint",
        table_name="officer_voice_samples",
    )
    op.drop_index("ix_officer_voice_samples_model_fingerprint", table_name="officer_voice_samples")
    with op.batch_alter_table("officer_voice_samples") as batch:
        batch.drop_column("microphone_fingerprint_certainty")
        batch.drop_column("microphone_fingerprint")
        batch.drop_column("model_fingerprint")
