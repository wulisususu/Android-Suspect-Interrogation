from fastapi import APIRouter

router = APIRouter(prefix='/api/cases', tags=['case-details'])

@router.get('/{case_id}/facts')
def facts(case_id: str):
    return {'ok': True, 'data': []}

@router.get('/{case_id}/timeline')
def timeline(case_id: str):
    return {'ok': True, 'data': []}

@router.get('/{case_id}/audit')
def audit(case_id: str):
    return {'ok': True, 'data': []}

@router.get('/{case_id}/revisions')
def revisions(case_id: str):
    return {'ok': True, 'data': []}
