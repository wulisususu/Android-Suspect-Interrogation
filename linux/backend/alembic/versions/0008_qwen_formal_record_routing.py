"""Persist Qwen formal-record QA routing provenance.

Revision ID: 0008_qwen_formal_record_routing
Revises: 0007_formal_record_sections
"""

from alembic import op
import sqlalchemy as sa

revision = "0008_qwen_formal_record_routing"
down_revision = "0007_formal_record_sections"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.add_column(
        "case_questions",
        sa.Column("formal_answer_text", sa.Text(), nullable=False, server_default=""),
    )
    op.add_column("case_questions", sa.Column("first_asked_at", sa.DateTime(timezone=True), nullable=True))
    op.create_index("ix_case_questions_first_asked_at", "case_questions", ["first_asked_at"], unique=False)

    op.create_table(
        "qa_units",
        sa.Column("id", sa.String(length=64), nullable=False),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("session_id", sa.String(length=64), nullable=True),
        sa.Column("status", sa.String(length=32), nullable=False),
        sa.Column("raw_question_text", sa.Text(), nullable=False),
        sa.Column("raw_answer_text", sa.Text(), nullable=False),
        sa.Column("classification", sa.String(length=64), nullable=True),
        sa.Column("target_question_id", sa.String(length=64), nullable=True),
        sa.Column("formal_question_text", sa.Text(), nullable=True),
        sa.Column("formal_answer_text", sa.Text(), nullable=True),
        sa.Column("candidate_question_ids_json", sa.Text(), nullable=False),
        sa.Column("confidence", sa.Float(), nullable=True),
        sa.Column("model_id", sa.String(length=128), nullable=True),
        sa.Column("reason_code", sa.String(length=64), nullable=True),
        sa.Column("started_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("ended_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["session_id"], ["interrogation_sessions.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["target_question_id"], ["case_questions.id"], ondelete="SET NULL"),
        sa.PrimaryKeyConstraint("id"),
    )
    for name, columns in (
        ("ix_qa_units_case_id", ["case_id"]),
        ("ix_qa_units_session_id", ["session_id"]),
        ("ix_qa_units_status", ["status"]),
        ("ix_qa_units_classification", ["classification"]),
        ("ix_qa_units_target_question_id", ["target_question_id"]),
        ("ix_qa_units_started_at", ["started_at"]),
        ("ix_qa_units_ended_at", ["ended_at"]),
    ):
        op.create_index(name, "qa_units", columns, unique=False)

    op.create_table(
        "qa_unit_fragments",
        sa.Column("qa_unit_id", sa.String(length=64), nullable=False),
        sa.Column("fragment_id", sa.String(length=64), nullable=False),
        sa.Column("role", sa.String(length=16), nullable=False),
        sa.Column("position", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["fragment_id"], ["asr_fragments.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["qa_unit_id"], ["qa_units.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("qa_unit_id", "fragment_id"),
        sa.UniqueConstraint("fragment_id", name="uq_qa_unit_fragments_fragment_id"),
        sa.UniqueConstraint("qa_unit_id", "position", name="uq_qa_unit_fragments_position"),
    )


def downgrade() -> None:
    op.drop_table("qa_unit_fragments")
    op.drop_table("qa_units")
    op.drop_index("ix_case_questions_first_asked_at", table_name="case_questions")
    op.drop_column("case_questions", "first_asked_at")
    op.drop_column("case_questions", "formal_answer_text")
