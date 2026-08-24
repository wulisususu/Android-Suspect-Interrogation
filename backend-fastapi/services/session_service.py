from repositories.session_repository import session_repository


def start_session(case_id: str):
    return session_repository.create(case_id)


def get_session(case_id: str):
    return session_repository.get(case_id)


def update_session(case_id: str, payload: dict):
    return session_repository.update(case_id, payload)
