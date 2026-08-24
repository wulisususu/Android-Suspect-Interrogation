from datetime import datetime
from uuid import uuid4

CASES={}
SESSIONS={}
MESSAGES={}
FACTS={}
AUDIT=[]

STAGES=['IDENTITY','STATEMENT','FOLLOW_UP','SIGNING']


def now():
    return int(datetime.now().timestamp()*1000)


def create_case(data):
    cid=data.get('id') or f'CASE-{uuid4().hex[:8].upper()}'
    item={
        'id':cid,
        'suspectName':data.get('suspectName','待录入'),
        'gender':data.get('gender',''),
        'age':data.get('age',''),
        'officerName':data.get('officerName','当前警官'),
        'state':'DRAFT',
        'stage':'IDENTITY',
        'createdAt':now(),
        'updatedAt':now()
    }
    CASES[cid]=item
    MESSAGES[cid]=[]
    AUDIT.append({'action':'CASE_CREATE','caseId':cid})
    return item


def list_cases(limit=100):
    return list(CASES.values())[-limit:]


def get_case(cid):
    return CASES.get(cid)


def start_session(cid):
    if cid not in CASES:
        create_case({'id':cid})
    s={'id':str(uuid4()),'caseId':cid,'status':'RUNNING','stage':'IDENTITY','startedAt':now()}
    SESSIONS[cid]=s
    CASES[cid]['state']='INTERROGATING'
    return s


def get_session(cid):
    return SESSIONS.get(cid,{'id':None,'caseId':cid,'status':'READY','stage':'IDENTITY'})


def add_message(cid,data):
    msg={'id':str(uuid4()),'seq':len(MESSAGES.setdefault(cid,[]))+1,'speaker':data.get('from',''),'text':data.get('text',''),'mark':'','confirmed':True,'createdAt':now()}
    MESSAGES[cid].append(msg)
    return msg


def list_messages(cid):
    return MESSAGES.get(cid,[])
