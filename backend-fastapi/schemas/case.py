from pydantic import BaseModel
from typing import Optional

class CaseCreate(BaseModel):
    suspect_name: Optional[str] = None
    officer_name: Optional[str] = None
    gender: Optional[str] = None
    age: Optional[int] = None

class CaseResponse(BaseModel):
    id: str
    suspect_name: Optional[str] = None

    class Config:
        from_attributes = True
