from collections.abc import Generator

from fastapi import Request
from sqlalchemy.orm import Session


def get_db(request: Request) -> Generator[Session, None, None]:
    db = request.app.state.session_factory()
    try:
        yield db
    except Exception:
        db.rollback()
        raise
    finally:
        db.close()


def get_hardware(request: Request):
    return request.app.state.hardware_gateway


def get_ai(request: Request):
    return request.app.state.ai_gateway
