from repositories.timeline_repository import list_timeline
from repositories.audit_repository import list_audit
from repositories.revision_repository import list_revisions


def get_case_timeline(case_id: str):
    return list_timeline(case_id)


def get_case_audit(case_id: str):
    return list_audit(case_id)


def get_case_revisions(case_id: str):
    return list_revisions(case_id)


def get_case_facts(case_id: str):
    return []
