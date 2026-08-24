from typing import Generic, TypeVar
from pydantic import BaseModel

T = TypeVar('T')


class ApiResponse(BaseModel, Generic[T]):
    ok: bool = True
    data: T | None = None
    message: str | None = None
