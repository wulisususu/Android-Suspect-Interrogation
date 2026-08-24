from datetime import datetime
from uuid import uuid4


def now():
    return int(datetime.now().timestamp()*1000)


class SessionRepository:
    def __init__(self):
        self.sessions = {}

    def create(self, case_id: str):
        item = {
            'id': str(uuid4()),
            'caseId': case_id,
            'status': 'RUNNING',
            'stage': 'IDENTITY',
            'startedAt': now(),
            'updatedAt': now()
        }
        self.sessions[case_id] = item
        return item

    def get(self, case_id: str):
        return self.sessions.get(case_id, {
            'id': None,
            'caseId': case_id,
            'status': 'READY',
            'stage': 'IDENTITY'
        })

    def update(self, case_id: str, data: dict):
        session = self.sessions.get(case_id)
        if not session:
            session = self.create(case_id)
        session.update(data)
        session['updatedAt'] = now()
        return session


session_repository = SessionRepository()
