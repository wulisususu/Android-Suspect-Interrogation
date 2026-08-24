from sqlalchemy import Column, String, BigInteger, Text, Integer
from database.database import Base


class Fact(Base):
    __tablename__ = 'facts'

    id = Column(Integer, primary_key=True, autoincrement=True)
    case_id = Column(String, index=True)
    fact_key = Column(String)
    label = Column(String)
    value = Column(Text)
    status = Column(String)
    suggestion = Column(Text, nullable=True)
    updated_at = Column(BigInteger)


class TimelineEvent(Base):
    __tablename__ = 'timeline_events'

    id = Column(String, primary_key=True)
    case_id = Column(String, index=True)
    time_label = Column(String)
    title = Column(String)
    detail = Column(Text)
    evidence_json = Column(Text, default='[]')
    created_at = Column(BigInteger)


class AuditLog(Base):
    __tablename__ = 'audit_logs'

    id = Column(String, primary_key=True)
    case_id = Column(String, index=True, nullable=True)
    action = Column(String)
    target_type = Column(String, nullable=True)
    target_id = Column(String, nullable=True)
    detail_json = Column(Text)
    created_at = Column(BigInteger)


class QARevision(Base):
    __tablename__ = 'qa_revisions'

    id = Column(String, primary_key=True)
    qa_id = Column(String, index=True)
    case_id = Column(String, index=True)
    version = Column(Integer)
    old_text = Column(Text)
    new_text = Column(Text)
    reason = Column(Text)
    created_at = Column(BigInteger)
