from dataclasses import dataclass
from datetime import datetime


@dataclass
class Case:
    case_id: str
    operator_id: str
    created_at: datetime = datetime.now()
    status: str = "created"
