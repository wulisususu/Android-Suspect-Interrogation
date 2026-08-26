from datetime import datetime

from sqlalchemy import Boolean, DateTime, ForeignKey, Integer, String, Text, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.database.base import Base, TimestampMixin, utc_now
from app.domain.enums import InterrogationStage, SessionStatus, WorkflowState


class Case(TimestampMixin, Base):
    __tablename__ = "cases"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    operator_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    case_type: Mapped[str] = mapped_column(String(64), default="suspect_interrogation", nullable=False)
    suspect_name: Mapped[str] = mapped_column(String(128), default="待录入", nullable=False)
    gender: Mapped[str | None] = mapped_column(String(32), nullable=True)
    age: Mapped[str | None] = mapped_column(String(32), nullable=True)
    officer_name: Mapped[str] = mapped_column(String(128), default="当前警官", nullable=False)
    workflow_state: Mapped[str] = mapped_column(String(32), default=WorkflowState.IDENTITY_REQUIRED.value, nullable=False, index=True)
    stage: Mapped[str] = mapped_column(String(32), default=InterrogationStage.IDENTITY.value, nullable=False)
    document_status: Mapped[str] = mapped_column(String(32), default="DRAFT", nullable=False)
    report_status: Mapped[str] = mapped_column(String(32), default="PENDING", nullable=False)

    persons = relationship("Person", back_populates="case", cascade="all, delete-orphan")
    sessions = relationship("InterrogationSession", back_populates="case", cascade="all, delete-orphan")
    messages = relationship("Message", back_populates="case", cascade="all, delete-orphan")


class Person(TimestampMixin, Base):
    __tablename__ = "persons"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str | None] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=True, index=True)
    role: Mapped[str] = mapped_column(String(32), default="suspect", nullable=False)
    name: Mapped[str] = mapped_column(String(128), nullable=False)
    id_number: Mapped[str] = mapped_column(String(64), nullable=False, index=True)
    gender: Mapped[str | None] = mapped_column(String(32), nullable=True)
    nation: Mapped[str | None] = mapped_column(String(64), nullable=True)
    birth_date: Mapped[str | None] = mapped_column(String(32), nullable=True)
    address: Mapped[str | None] = mapped_column(String(512), nullable=True)
    source: Mapped[str] = mapped_column(String(32), default="idcard", nullable=False)

    case = relationship("Case", back_populates="persons")


class InterrogationSession(TimestampMixin, Base):
    __tablename__ = "interrogation_sessions"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    status: Mapped[str] = mapped_column(String(32), default=SessionStatus.READY.value, nullable=False, index=True)
    stage: Mapped[str] = mapped_column(String(32), default=InterrogationStage.IDENTITY.value, nullable=False)
    started_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)
    paused_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)
    ended_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)

    case = relationship("Case", back_populates="sessions")
    messages = relationship("Message", back_populates="session")


class Message(TimestampMixin, Base):
    __tablename__ = "messages"
    __table_args__ = (UniqueConstraint("case_id", "seq", name="uq_messages_case_seq"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    session_id: Mapped[str | None] = mapped_column(ForeignKey("interrogation_sessions.id", ondelete="SET NULL"), nullable=True, index=True)
    seq: Mapped[int] = mapped_column(Integer, nullable=False)
    speaker: Mapped[str] = mapped_column(String(32), nullable=False)
    text: Mapped[str] = mapped_column(Text, nullable=False)
    mark: Mapped[str] = mapped_column(String(32), default="", nullable=False)
    confirmed: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    current_version: Mapped[int] = mapped_column(Integer, default=1, nullable=False)

    case = relationship("Case", back_populates="messages")
    session = relationship("InterrogationSession", back_populates="messages")
    revisions = relationship("MessageRevision", back_populates="message", cascade="all, delete-orphan")


class MessageRevision(Base):
    __tablename__ = "message_revisions"
    __table_args__ = (UniqueConstraint("message_id", "version", name="uq_message_revision_version"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    message_id: Mapped[str] = mapped_column(ForeignKey("messages.id", ondelete="CASCADE"), nullable=False, index=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    version: Mapped[int] = mapped_column(Integer, nullable=False)
    old_text: Mapped[str] = mapped_column(Text, nullable=False)
    new_text: Mapped[str] = mapped_column(Text, nullable=False)
    reason: Mapped[str | None] = mapped_column(String(512), nullable=True)
    actor_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False)

    message = relationship("Message", back_populates="revisions")


class Fact(TimestampMixin, Base):
    __tablename__ = "facts"
    __table_args__ = (UniqueConstraint("case_id", "fact_key", name="uq_fact_case_key"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    fact_key: Mapped[str] = mapped_column(String(64), nullable=False)
    label: Mapped[str] = mapped_column(String(128), nullable=False)
    value: Mapped[str] = mapped_column(Text, nullable=False)
    status: Mapped[str] = mapped_column(String(32), nullable=False)
    suggestion: Mapped[str | None] = mapped_column(Text, nullable=True)


class TimelineEvent(Base):
    __tablename__ = "timeline_events"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    time_label: Mapped[str] = mapped_column(String(128), default="", nullable=False)
    title: Mapped[str] = mapped_column(String(256), nullable=False)
    detail: Mapped[str] = mapped_column(Text, default="", nullable=False)
    evidence_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)


class AuditLog(Base):
    __tablename__ = "audit_logs"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str | None] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=True, index=True)
    actor_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    action: Mapped[str] = mapped_column(String(64), nullable=False, index=True)
    target_type: Mapped[str | None] = mapped_column(String(64), nullable=True)
    target_id: Mapped[str | None] = mapped_column(String(64), nullable=True)
    before_json: Mapped[str] = mapped_column(Text, default="{}", nullable=False)
    after_json: Mapped[str] = mapped_column(Text, default="{}", nullable=False)
    detail_json: Mapped[str] = mapped_column(Text, default="{}", nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)


class DeviceEvent(Base):
    __tablename__ = "device_events"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str | None] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=True, index=True)
    session_id: Mapped[str | None] = mapped_column(ForeignKey("interrogation_sessions.id", ondelete="SET NULL"), nullable=True)
    device: Mapped[str] = mapped_column(String(64), nullable=False)
    event: Mapped[str] = mapped_column(String(64), nullable=False)
    payload_json: Mapped[str] = mapped_column(Text, default="{}", nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False, index=True)


class DocumentSnapshot(Base):
    __tablename__ = "document_snapshots"
    __table_args__ = (UniqueConstraint("case_id", "version", name="uq_document_case_version"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    session_id: Mapped[str | None] = mapped_column(ForeignKey("interrogation_sessions.id", ondelete="SET NULL"), nullable=True)
    version: Mapped[int] = mapped_column(Integer, nullable=False)
    status: Mapped[str] = mapped_column(String(32), default="FROZEN", nullable=False)
    content_json: Mapped[str] = mapped_column(Text, nullable=False)
    content_hash: Mapped[str] = mapped_column(String(64), nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False)


class SignatureRecord(Base):
    __tablename__ = "signature_records"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    session_id: Mapped[str | None] = mapped_column(ForeignKey("interrogation_sessions.id", ondelete="SET NULL"), nullable=True)
    snapshot_id: Mapped[str | None] = mapped_column(ForeignKey("document_snapshots.id", ondelete="SET NULL"), nullable=True)
    signer_role: Mapped[str] = mapped_column(String(64), nullable=False)
    signer_name: Mapped[str] = mapped_column(String(128), nullable=False)
    image_data: Mapped[str] = mapped_column(Text, nullable=False)
    strokes_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    status: Mapped[str] = mapped_column(String(32), default="SAVED", nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False)
