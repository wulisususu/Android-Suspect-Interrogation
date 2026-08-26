"""Create the authoritative Linux backend schema.

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


def upgrade() -> None:
    bind = op.get_bind()
    if bind.dialect.name == "sqlite":
        bind.exec_driver_sql("PRAGMA foreign_keys=ON")
    Base.metadata.create_all(bind=bind)


def downgrade() -> None:
    Base.metadata.drop_all(bind=op.get_bind())
