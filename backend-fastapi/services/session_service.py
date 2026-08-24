from time import time
from repositories.case_repository import get_case_repository


def start_session(case_id: str):
    repo = get_case_repository()
    now = int(time()*1000)
    return repo.start_session(case_id, now)


def update_session(case_id: str, status: str, stage: str | None = None):
    repo = get_case_repository()
    now = int(time()*1000)
    return repo.update_session(case_id, status, stage, now)
