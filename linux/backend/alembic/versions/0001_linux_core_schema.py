"""Create the authoritative Linux backend core schema.

Revision ID: 0001_linux_core_schema
Revises: None
"""

from alembic import op

from app.database.base import Base
import app.database.models  # noqa: F401 - registers metadata

revision = "0001_linux_core_schema"
down_revision = None
branch_labels = None
depends_on = None

CORE_TABLE_NAMES = (
    "cases",
    "persons",
    "interrogation_sessions",
    "messages",
    "message_revisions",
    "facts",
    "timeline_events",
    "audit_logs",
    "device_events",
    "document_snapshots",
    "signature_records",
)


def _core_tables():
    return [Base.metadata.tables[name] for name in CORE_TABLE_NAMES]


def upgrade() -> None:
    bind = op.get_bind()
    if bind.dialect.name == "sqlite":
        bind.exec_driver_sql("PRAGMA foreign_keys=ON")
    Base.metadata.create_all(bind=bind, tables=_core_tables())


def downgrade() -> None:
    bind = op.get_bind()
    if bind.dialect.name == "sqlite":
        bind.exec_driver_sql("PRAGMA foreign_keys=ON")
    Base.metadata.drop_all(bind=bind, tables=list(reversed(_core_tables())))
