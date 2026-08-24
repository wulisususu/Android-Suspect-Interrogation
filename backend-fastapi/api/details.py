from fastapi import APIRouter
from services.detail_service import get_case_facts, get_case_timeline, get_case_audit, get_case_revisions

router = APIRouter(prefix='/api/cases', tags=['case-details'])


@router.get('/{case_id}/facts')
def facts(case_id: str):
    return {'ok': True, 'data': get_case_facts(case_id)}


@router.get('/{case_id}/timeline')
def timeline(case_id: str):
    return {'ok': True, 'data': get_case_timeline(case_id)}


@router.get('/{case_id}/audit')
def audit(case_id: str):
    return {'ok': True, 'data': get_case_audit(case_id)}


@router.get('/{case_id}/revisions')
def revisions(case_id: str):
    return {'ok': True, 'data': get_case_revisions(case_id)}
