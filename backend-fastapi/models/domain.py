from enum import Enum
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy import String, Text

class Base(DeclarativeBase):
    pass

class InterrogationStage(str, Enum):
    IDENTITY = "IDENTITY"
    STATEMENT = "STATEMENT"
    FOLLOW_UP = "FOLLOW_UP"
    SIGNING = "SIGNING"

class SessionStatus(str, Enum):
    READY = "READY"
    RUNNING = "RUNNING"
    PAUSED = "PAUSED"
    COMPLETED = "COMPLETED"

class Case(Base):
    __tablename__ = "cases"
    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    suspect_name: Mapped[str] = mapped_column(String(128), default="")
    gender: Mapped[str] = mapped_column(String(32), default="")
    age: Mapped[str] = mapped_column(String(32), default="")
    id_number: Mapped[str] = mapped_column(String(64), default="")
    address: Mapped[str] = mapped_column(Text, default="")
    state: Mapped[str] = mapped_column(String(32), default="READY")
    stage: Mapped[str] = mapped_column(String(32), default="IDENTITY")
