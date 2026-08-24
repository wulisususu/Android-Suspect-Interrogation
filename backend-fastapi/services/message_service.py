from repositories.message_repository import list_messages, add_message


def get_messages(case_id: str):
    return list_messages(case_id)


def create_message(case_id: str, payload: dict):
    return add_message(case_id, payload)
