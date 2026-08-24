from fastapi import APIRouter
from services.case_service import create_case,list_cases,get_case
from services.message_service import create_message,get_messages
from services.session_service import start_session,get_session,update_session

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
    return {'ok':True,'data':get_messages(case_id)}

@router.post('/cases/{case_id}/messages')
def message(case_id:str,payload:dict):
    return {'ok':True,'data':create_message(case_id,payload)}

@router.put('/cases/{case_id}/messages/{message_id}')
def update_message(case_id:str,message_id:str,payload:dict):
    payload['message_id']=message_id
    return {'ok':True,'data':create_message(case_id,payload)}

@router.post('/cases/{case_id}/messages/{message_id}/mark')
def mark_message(case_id:str,message_id:str,payload:dict):
    return {'ok':True,'data':create_message(case_id,{'message_id':message_id,'mark':payload.get('mark')})}

@router.get('/cases/{case_id}/session')
def session(case_id:str):
    return {'ok':True,'data':get_session(case_id)}

@router.post('/cases/{case_id}/session/start')
def start(case_id:str):
    return {'ok':True,'data':start_session(case_id)}

@router.post('/cases/{case_id}/session/pause')
def pause(case_id:str):
    return {'ok':True,'data':update_session(case_id,'PAUSED',None)}

@router.post('/cases/{case_id}/session/resume')
def resume(case_id:str):
    return {'ok':True,'data':update_session(case_id,'RUNNING',None)}

@router.post('/cases/{case_id}/session/finish')
def finish(case_id:str):
    return {'ok':True,'data':update_session(case_id,'FINISHED',None)}

@router.post('/cases/{case_id}/session/stage')
def stage(case_id:str,payload:dict):
    return {'ok':True,'data':update_session(case_id,'RUNNING',payload.get('stage'))}

@router.post('/cases/{case_id}/session/update')
def update(case_id:str,payload:dict):
    return {'ok':True,'data':update_session(case_id,payload.get('status','RUNNING'),payload.get('stage'))}
