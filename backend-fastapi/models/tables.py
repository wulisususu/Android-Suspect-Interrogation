from sqlalchemy import Column, String, Integer, BigInteger, Text, Boolean
from database.database import Base


class Case(Base):
    __tablename__ = 'cases'

    id = Column(String, primary_key=True)
    suspect_name = Column(String, default='待录入')
    gender = Column(String, nullable=True)
    age = Column(String, nullable=True)
    officer_name = Column(String, default='当前警官')
    state = Column(String, default='DRAFT')
    stage = Column(String, default='IDENTITY')
    created_at = Column(BigInteger)
    updated_at = Column(BigInteger)


class InterrogationSession(Base):
    __tablename__ = 'interrogation_sessions'

    id = Column(String, primary_key=True)
    case_id = Column(String, index=True)
    status = Column(String, default='READY')
    stage = Column(String, default='IDENTITY')
    started_at = Column(BigInteger, nullable=True)
    paused_at = Column(BigInteger, nullable=True)
    ended_at = Column(BigInteger, nullable=True)
    updated_at = Column(BigInteger)


class QARecord(Base):
    __tablename__ = 'qa_records'

    id = Column(String, primary_key=True)
    case_id = Column(String, index=True)
    session_id = Column(String)
    seq = Column(Integer)
    speaker = Column(String)
    text = Column(Text)
    mark = Column(String, default='')
    confirmed = Column(Boolean, default=True)
    created_at = Column(BigInteger)
    updated_at = Column(BigInteger)
