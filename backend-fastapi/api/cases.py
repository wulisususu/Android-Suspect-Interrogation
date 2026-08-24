from fastapi import APIRouter
from services.store import create_case,list_cases,get_case,add_message,list_messages,start_session,get_session

router=APIRouter(prefix='/api')

@router.get('/cases')
def cases(limit:int=100):
    return {'ok':True,'data':list_cases(limit)}

@router.post('/cases/create')
def new_case(payload:dict):
    return {'ok':True,'data':create_case(payload)}

@router.get('/cases/{case_id}')
def case(case_id:str):
    return {'ok':True,'data':get_case(case_id)}

@router.get('/cases/{case_id}/messages')
def messages(case_id:str):
    return {'ok':True,'data':list_messages(case_id)}

@router.post('/cases/{case_id}/messages')
def message(case_id:str,payload:dict):
    return {'ok':True,'data':add_message(case_id,payload)}

@router.get('/cases/{case_id}/session')
def session(case_id:str):
    return {'ok':True,'data':get_session(case_id)}

@router.post('/cases/{case_id}/session/start')
def start(case_id:str):
    return {'ok':True,'data':start_session(case_id)}
