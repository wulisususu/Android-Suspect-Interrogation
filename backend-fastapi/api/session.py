from fastapi import APIRouter
from services.session_service import start_session, update_session

router=APIRouter(prefix='/api')

@router.post('/cases/{case_id}/session/start')
def session_start(case_id:str):
    return {'ok':True,'data':start_session(case_id)}

@router.post('/cases/{case_id}/session/update')
def session_update(case_id:str,payload:dict):
    return {'ok':True,'data':update_session(case_id,payload.get('status','RUNNING'),payload.get('stage'))}
