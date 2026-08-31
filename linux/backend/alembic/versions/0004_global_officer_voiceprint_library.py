"""Add global multi-sample officer voiceprint library.

Revision ID: 0004_global_officer_voiceprint_library
Revises: 0003_template_interrogation_workspace
"""

from __future__ import annotations

from datetime import datetime, timezone
from uuid import uuid4

from alembic import op
import sqlalchemy as sa


revision = "0004_global_officer_voiceprint_library"
down_revision = "0003_template_interrogation_workspace"
branch_labels = None
depends_on = None


_SNAPSHOT_PREFIX = "__session_snapshot__:"


def _now() -> datetime:
    return datetime.now(timezone.utc)


def upgrade() -> None:
    op.create_table(
        "officer_voice_profiles",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("officer_id", sa.String(length=128), nullable=False),
        sa.Column("officer_name", sa.String(length=128), nullable=False),
        sa.Column("aggregate_embedding", sa.LargeBinary(), nullable=False),
        sa.Column("embedding_dim", sa.Integer(), nullable=False),
        sa.Column("model_id", sa.String(length=128), nullable=False),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("aggregate_version", sa.Integer(), nullable=False),
        sa.Column("sample_count", sa.Integer(), nullable=False),
        sa.Column("active", sa.Boolean(), nullable=False),
        sa.Column("revoked_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index("ix_officer_voice_profiles_officer_id", "officer_voice_profiles", ["officer_id"], unique=True)

    op.create_table(
        "officer_voice_samples",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("profile_id", sa.String(length=64), nullable=False),
        sa.Column("embedding", sa.LargeBinary(), nullable=False),
        sa.Column("embedding_dim", sa.Integer(), nullable=False),
        sa.Column("model_id", sa.String(length=128), nullable=False),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("quality", sa.String(length=64), nullable=False),
        sa.Column("usable_duration_ms", sa.Integer(), nullable=False),
        sa.Column("segment_count", sa.Integer(), nullable=False),
        sa.Column("audio_source", sa.String(length=32), nullable=False),
        sa.Column("device_id", sa.String(length=256), nullable=True),
        sa.Column("device_name", sa.String(length=256), nullable=True),
        sa.Column("captured_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("active", sa.Boolean(), nullable=False),
        sa.Column("disabled_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("disabled_reason", sa.String(length=512), nullable=True),
        sa.Column("created_by", sa.String(length=128), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["profile_id"], ["officer_voice_profiles.id"], ondelete="CASCADE"),
    )
    op.create_index("ix_officer_voice_samples_profile_id", "officer_voice_samples", ["profile_id"], unique=False)
    op.create_index("ix_officer_voice_samples_captured_at", "officer_voice_samples", ["captured_at"], unique=False)
    op.create_index("ix_officer_voice_samples_active", "officer_voice_samples", ["active"], unique=False)

    op.create_table(
        "session_officer_voice_snapshots",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("session_id", sa.String(length=64), nullable=False),
        sa.Column("role", sa.String(length=32), nullable=False),
        sa.Column("officer_id", sa.String(length=128), nullable=False),
        sa.Column("profile_id", sa.String(length=64), nullable=True),
        sa.Column("aggregate_version", sa.Integer(), nullable=False),
        sa.Column("voiceprint_snapshot_id", sa.String(length=64), nullable=False),
        sa.Column("model_id", sa.String(length=128), nullable=False),
        sa.Column("model_version", sa.String(length=128), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["session_id"], ["interrogation_sessions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["profile_id"], ["officer_voice_profiles.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["voiceprint_snapshot_id"], ["officer_voiceprints.id"], ondelete="RESTRICT"),
        sa.UniqueConstraint("session_id", "role", name="uq_session_officer_voice_snapshot_role"),
    )
    op.create_index("ix_session_officer_voice_snapshots_session_id", "session_officer_voice_snapshots", ["session_id"], unique=False)

    bind = op.get_bind()
    legacy = list(
        bind.execute(
            sa.text(
                "SELECT id, officer_id, officer_name, embedding, embedding_dim, model_id, model_version, "
                "enrollment_quality, usable_duration_ms, active, revoked_at, created_at, updated_at "
                "FROM officer_voiceprints WHERE officer_id NOT LIKE :prefix"
            ),
            {"prefix": f"{_SNAPSHOT_PREFIX}%"},
        ).mappings()
    )

    profile_by_officer: dict[str, tuple[str, int]] = {}
    for row in legacy:
        profile_id = str(uuid4())
        sample_id = str(uuid4())
        created_at = row["created_at"] or _now()
        updated_at = row["updated_at"] or created_at
        active = bool(row["active"])
        bind.execute(
            sa.text(
                "INSERT INTO officer_voice_profiles "
                "(id, officer_id, officer_name, aggregate_embedding, embedding_dim, model_id, model_version, "
                "aggregate_version, sample_count, active, revoked_at, created_at, updated_at) "
                "VALUES (:id, :officer_id, :officer_name, :embedding, :embedding_dim, :model_id, :model_version, "
                "1, 1, :active, :revoked_at, :created_at, :updated_at)"
            ),
            {
                "id": profile_id,
                "officer_id": row["officer_id"],
                "officer_name": row["officer_name"],
                "embedding": row["embedding"],
                "embedding_dim": row["embedding_dim"],
                "model_id": row["model_id"],
                "model_version": row["model_version"],
                "active": active,
                "revoked_at": row["revoked_at"],
                "created_at": created_at,
                "updated_at": updated_at,
            },
        )
        bind.execute(
            sa.text(
                "INSERT INTO officer_voice_samples "
                "(id, profile_id, embedding, embedding_dim, model_id, model_version, quality, usable_duration_ms, "
                "segment_count, audio_source, device_id, device_name, captured_at, active, disabled_at, "
                "disabled_reason, created_by, created_at, updated_at) "
                "VALUES (:id, :profile_id, :embedding, :embedding_dim, :model_id, :model_version, :quality, "
                ":usable_duration_ms, 0, 'LEGACY_MIGRATED', NULL, 'Legacy migrated reference', :captured_at, "
                "1, NULL, NULL, NULL, :created_at, :updated_at)"
            ),
            {
                "id": sample_id,
                "profile_id": profile_id,
                "embedding": row["embedding"],
                "embedding_dim": row["embedding_dim"],
                "model_id": row["model_id"],
                "model_version": row["model_version"],
                "quality": row["enrollment_quality"],
                "usable_duration_ms": row["usable_duration_ms"],
                "captured_at": created_at,
                "created_at": created_at,
                "updated_at": updated_at,
            },
        )
        profile_by_officer[str(row["officer_id"])] = (profile_id, 1)

    assignments = list(
        bind.execute(
            sa.text(
                "SELECT id, session_id, interrogator_officer_id, interrogator_voiceprint_id, "
                "recorder_officer_id, recorder_voiceprint_id FROM session_voice_assignments"
            )
        ).mappings()
    )
    for assignment in assignments:
        for role, officer_key, voiceprint_key in (
            ("INTERROGATOR", "interrogator_officer_id", "interrogator_voiceprint_id"),
            ("RECORDER", "recorder_officer_id", "recorder_voiceprint_id"),
        ):
            source_id = assignment[voiceprint_key]
            officer_id = assignment[officer_key]
            if not source_id or not officer_id:
                continue
            source = bind.execute(
                sa.text(
                    "SELECT officer_name, embedding, embedding_dim, model_id, model_version, enrollment_quality, "
                    "usable_duration_ms FROM officer_voiceprints WHERE id=:id"
                ),
                {"id": source_id},
            ).mappings().first()
            if source is None:
                continue
            snapshot_id = str(uuid4())
            snapshot_officer_id = f"{_SNAPSHOT_PREFIX}{uuid4().hex}"
            now = _now()
            bind.execute(
                sa.text(
                    "INSERT INTO officer_voiceprints "
                    "(id, officer_id, officer_name, embedding, embedding_dim, model_id, model_version, "
                    "enrollment_quality, usable_duration_ms, active, revoked_at, created_at, updated_at) "
                    "VALUES (:id, :officer_id, :officer_name, :embedding, :embedding_dim, :model_id, :model_version, "
                    ":quality, :usable_duration_ms, 1, NULL, :now, :now)"
                ),
                {
                    "id": snapshot_id,
                    "officer_id": snapshot_officer_id,
                    "officer_name": source["officer_name"],
                    "embedding": source["embedding"],
                    "embedding_dim": source["embedding_dim"],
                    "model_id": source["model_id"],
                    "model_version": source["model_version"],
                    "quality": source["enrollment_quality"],
                    "usable_duration_ms": source["usable_duration_ms"],
                    "now": now,
                },
            )
            profile_id, aggregate_version = profile_by_officer.get(str(officer_id), (None, 1))
            bind.execute(
                sa.text(
                    "INSERT INTO session_officer_voice_snapshots "
                    "(id, session_id, role, officer_id, profile_id, aggregate_version, voiceprint_snapshot_id, "
                    "model_id, model_version, created_at) "
                    "VALUES (:id, :session_id, :role, :officer_id, :profile_id, :aggregate_version, "
                    ":snapshot_id, :model_id, :model_version, :created_at)"
                ),
                {
                    "id": str(uuid4()),
                    "session_id": assignment["session_id"],
                    "role": role,
                    "officer_id": officer_id,
                    "profile_id": profile_id,
                    "aggregate_version": aggregate_version,
                    "snapshot_id": snapshot_id,
                    "model_id": source["model_id"],
                    "model_version": source["model_version"],
                    "created_at": now,
                },
            )
            column = "interrogator_voiceprint_id" if role == "INTERROGATOR" else "recorder_voiceprint_id"
            bind.execute(
                sa.text(f"UPDATE session_voice_assignments SET {column}=:snapshot_id WHERE id=:assignment_id"),
                {"snapshot_id": snapshot_id, "assignment_id": assignment["id"]},
            )


def downgrade() -> None:
    bind = op.get_bind()
    assignments = list(
        bind.execute(
            sa.text(
                "SELECT id, interrogator_officer_id, recorder_officer_id FROM session_voice_assignments"
            )
        ).mappings()
    )
    for assignment in assignments:
        for column, officer_key in (
            ("interrogator_voiceprint_id", "interrogator_officer_id"),
            ("recorder_voiceprint_id", "recorder_officer_id"),
        ):
            officer_id = assignment[officer_key]
            if not officer_id:
                continue
            bridge = bind.execute(
                sa.text("SELECT id FROM officer_voiceprints WHERE officer_id=:officer_id"),
                {"officer_id": officer_id},
            ).mappings().first()
            if bridge:
                bind.execute(
                    sa.text(f"UPDATE session_voice_assignments SET {column}=:voiceprint_id WHERE id=:assignment_id"),
                    {"voiceprint_id": bridge["id"], "assignment_id": assignment["id"]},
                )

    op.drop_index("ix_session_officer_voice_snapshots_session_id", table_name="session_officer_voice_snapshots")
    op.drop_table("session_officer_voice_snapshots")
    bind.execute(
        sa.text("DELETE FROM officer_voiceprints WHERE officer_id LIKE :prefix"),
        {"prefix": f"{_SNAPSHOT_PREFIX}%"},
    )
    op.drop_index("ix_officer_voice_samples_active", table_name="officer_voice_samples")
    op.drop_index("ix_officer_voice_samples_captured_at", table_name="officer_voice_samples")
    op.drop_index("ix_officer_voice_samples_profile_id", table_name="officer_voice_samples")
    op.drop_table("officer_voice_samples")
    op.drop_index("ix_officer_voice_profiles_officer_id", table_name="officer_voice_profiles")
    op.drop_table("officer_voice_profiles")
