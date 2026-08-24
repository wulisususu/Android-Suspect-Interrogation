from pydantic import BaseModel


class MessageCreate(BaseModel):
    speaker: str = ''
    text: str = ''
    mark: str = ''
    confirmed: bool = True


class MessageResponse(MessageCreate):
    id: str | None = None
    seq: int = 0
