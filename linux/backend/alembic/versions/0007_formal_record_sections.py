"""Add formal interrogation record sections and versioned fixed template metadata.

Revision ID: 0007_formal_record_sections
Revises: 0006_asr_recognition_evidence
"""

from alembic import op
import sqlalchemy as sa

revision = "0007_formal_record_sections"
down_revision = "0006_asr_recognition_evidence"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.add_column("case_questions", sa.Column("section_type", sa.String(length=16), nullable=False, server_default="BODY"))
    op.add_column("case_questions", sa.Column("template_key", sa.String(length=64), nullable=True))
    op.add_column("case_questions", sa.Column("template_item_key", sa.String(length=64), nullable=True))
    op.add_column("case_questions", sa.Column("locked", sa.Boolean(), nullable=False, server_default=sa.false()))
    op.create_index("ix_case_questions_section_type", "case_questions", ["section_type"], unique=False)
    op.create_index("ix_case_questions_template_key", "case_questions", ["template_key"], unique=False)


def downgrade() -> None:
    op.drop_index("ix_case_questions_template_key", table_name="case_questions")
    op.drop_index("ix_case_questions_section_type", table_name="case_questions")
    op.drop_column("case_questions", "locked")
    op.drop_column("case_questions", "template_item_key")
    op.drop_column("case_questions", "template_key")
    op.drop_column("case_questions", "section_type")
