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
_DEPENDENT_TABLES = (
    "officer_voice_samples",
    "session_officer_voice_snapshots",
    "session_voice_assignments",
)


def _quoted(identifier: str) -> str:
    return '"' + identifier.replace('"', '""') + '"'


def _backup_and_clear_dependencies() -> dict[str, tuple[str, ...]]:
    """Move FK dependents aside before SQLite batch table recreation.

    Alembic's SQLite batch mode creates a replacement table and drops the old
    parent table. With foreign_keys=ON that DROP either cascades child rows or
    is rejected by RESTRICT FKs. A plain CTAS backup intentionally carries no
    foreign keys, so parent tables can be rebuilt without losing evidence.
    """

    bind = op.get_bind()
    inspector = sa.inspect(bind)
    columns_by_table: dict[str, tuple[str, ...]] = {}
    for table in _DEPENDENT_TABLES:
        backup = f"__0009_backup_{table}"
        if backup in inspector.get_table_names():
            pending_rows = bind.execute(sa.text(f"SELECT COUNT(*) FROM {_quoted(table)}")).scalar_one()
            if int(pending_rows) != 0:
                raise RuntimeError(
                    f"0009 cannot resume while {table} has rows beside its interrupted backup"
                )
            columns_by_table[table] = tuple(str(column["name"]) for column in inspector.get_columns(backup))
            continue

        columns_by_table[table] = tuple(str(column["name"]) for column in inspector.get_columns(table))
        bind.execute(sa.text(f"CREATE TABLE {_quoted(backup)} AS SELECT * FROM {_quoted(table)}"))
        bind.execute(sa.text(f"DELETE FROM {_quoted(table)}"))
    return columns_by_table


def _restore_dependencies(columns_by_table: dict[str, tuple[str, ...]]) -> None:
    """Restore only columns still present in the target schema.

    On upgrade the backup does not contain ``model_key`` and the new column's
    server default writes ``xvector``. On downgrade the backup does contain
    ``model_key`` while the target schema does not, so the intersection omits
    it. All legacy primary/foreign keys and embedding bytes are copied exactly.
    """

    bind = op.get_bind()
    inspector = sa.inspect(bind)
    for table in _DEPENDENT_TABLES:
        target_columns = {str(column["name"]) for column in inspector.get_columns(table)}
        columns = tuple(column for column in columns_by_table[table] if column in target_columns)
        if not columns:
            raise RuntimeError(f"0009 cannot restore dependency table without shared columns: {table}")
        rendered = ", ".join(_quoted(column) for column in columns)
        backup = f"__0009_backup_{table}"
        bind.execute(
            sa.text(
                f"INSERT INTO {_quoted(table)} ({rendered}) "
                f"SELECT {rendered} FROM {_quoted(backup)}"
            )
        )
        bind.execute(sa.text(f"DROP TABLE {_quoted(backup)}"))


def upgrade() -> None:
    dependent_columns = _backup_and_clear_dependencies()

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

    _restore_dependencies(dependent_columns)


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
    dependent_columns = _backup_and_clear_dependencies()

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

    _restore_dependencies(dependent_columns)
