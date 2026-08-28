"""Add template-driven interrogation workspace persistence.

Revision ID: 0003_template_interrogation_workspace
Revises: 0002_voiceprint_speech_pipeline
"""

from alembic import op
import sqlalchemy as sa

revision = "0003_template_interrogation_workspace"
down_revision = "0002_voiceprint_speech_pipeline"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "standard_questions",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("text", sa.Text(), nullable=False),
        sa.Column("category", sa.String(length=64), nullable=False),
        sa.Column("regex_patterns_json", sa.Text(), nullable=False),
        sa.Column("aliases_json", sa.Text(), nullable=False),
        sa.Column("sort_order", sa.Integer(), nullable=False),
        sa.Column("active", sa.Boolean(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
    )
    op.create_index("ix_standard_questions_category", "standard_questions", ["category"], unique=False)

    op.create_table(
        "case_questions",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("source", sa.String(length=16), nullable=False),
        sa.Column("standard_question_id", sa.String(length=64), nullable=True),
        sa.Column("text", sa.Text(), nullable=False),
        sa.Column("regex_patterns_json", sa.Text(), nullable=False),
        sa.Column("aliases_json", sa.Text(), nullable=False),
        sa.Column("sort_order", sa.Integer(), nullable=False),
        sa.Column("active", sa.Boolean(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["standard_question_id"], ["standard_questions.id"], ondelete="SET NULL"),
        sa.UniqueConstraint("case_id", "sort_order", name="uq_case_questions_sort"),
    )
    op.create_index("ix_case_questions_case_id", "case_questions", ["case_id"], unique=False)

    op.create_table(
        "question_rounds",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("session_id", sa.String(length=64), nullable=True),
        sa.Column("case_question_id", sa.String(length=64), nullable=False),
        sa.Column("round_no", sa.Integer(), nullable=False),
        sa.Column("actual_question_text", sa.Text(), nullable=False),
        sa.Column("officer_fragment_id", sa.String(length=64), nullable=True),
        sa.Column("answer_text", sa.Text(), nullable=False),
        sa.Column("answer_fragment_ids_json", sa.Text(), nullable=False),
        sa.Column("status", sa.String(length=16), nullable=False),
        sa.Column("started_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("ended_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["session_id"], ["interrogation_sessions.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["case_question_id"], ["case_questions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["officer_fragment_id"], ["asr_fragments.id"], ondelete="SET NULL"),
        sa.UniqueConstraint("case_question_id", "round_no", name="uq_question_round_no"),
        sa.UniqueConstraint("officer_fragment_id", name="uq_question_rounds_officer_fragment_id"),
    )
    op.create_index("ix_question_rounds_case_id", "question_rounds", ["case_id"], unique=False)
    op.create_index("ix_question_rounds_session_id", "question_rounds", ["session_id"], unique=False)
    op.create_index("ix_question_rounds_case_question_id", "question_rounds", ["case_question_id"], unique=False)
    op.create_index("ix_question_rounds_status", "question_rounds", ["status"], unique=False)

    op.create_table(
        "pending_questions",
        sa.Column("id", sa.String(length=64), primary_key=True),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("session_id", sa.String(length=64), nullable=True),
        sa.Column("officer_fragment_id", sa.String(length=64), nullable=False),
        sa.Column("question_text", sa.Text(), nullable=False),
        sa.Column("match_status", sa.String(length=16), nullable=False),
        sa.Column("candidate_question_ids_json", sa.Text(), nullable=False),
        sa.Column("buffered_answer_text", sa.Text(), nullable=False),
        sa.Column("buffered_fragment_ids_json", sa.Text(), nullable=False),
        sa.Column("status", sa.String(length=16), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["session_id"], ["interrogation_sessions.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["officer_fragment_id"], ["asr_fragments.id"], ondelete="CASCADE"),
        sa.UniqueConstraint("officer_fragment_id", name="uq_pending_questions_officer_fragment_id"),
    )
    op.create_index("ix_pending_questions_case_id", "pending_questions", ["case_id"], unique=False)
    op.create_index("ix_pending_questions_session_id", "pending_questions", ["session_id"], unique=False)
    op.create_index("ix_pending_questions_status", "pending_questions", ["status"], unique=False)

    op.create_table(
        "processed_speech_fragments",
        sa.Column("fragment_id", sa.String(length=64), primary_key=True),
        sa.Column("case_id", sa.String(length=64), nullable=False),
        sa.Column("action", sa.String(length=32), nullable=False),
        sa.Column("target_id", sa.String(length=64), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["fragment_id"], ["asr_fragments.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["case_id"], ["cases.id"], ondelete="CASCADE"),
    )
    op.create_index("ix_processed_speech_fragments_case_id", "processed_speech_fragments", ["case_id"], unique=False)


def downgrade() -> None:
    op.drop_index("ix_processed_speech_fragments_case_id", table_name="processed_speech_fragments")
    op.drop_table("processed_speech_fragments")

    op.drop_index("ix_pending_questions_status", table_name="pending_questions")
    op.drop_index("ix_pending_questions_session_id", table_name="pending_questions")
    op.drop_index("ix_pending_questions_case_id", table_name="pending_questions")
    op.drop_table("pending_questions")

    op.drop_index("ix_question_rounds_status", table_name="question_rounds")
    op.drop_index("ix_question_rounds_case_question_id", table_name="question_rounds")
    op.drop_index("ix_question_rounds_session_id", table_name="question_rounds")
    op.drop_index("ix_question_rounds_case_id", table_name="question_rounds")
    op.drop_table("question_rounds")

    op.drop_index("ix_case_questions_case_id", table_name="case_questions")
    op.drop_table("case_questions")

    op.drop_index("ix_standard_questions_category", table_name="standard_questions")
    op.drop_table("standard_questions")
