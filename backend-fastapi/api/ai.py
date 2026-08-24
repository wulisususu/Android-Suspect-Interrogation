from fastapi import APIRouter

router=APIRouter(prefix='/api/ai')

@router.get('/status')
def status():
    return {'ok':True,'engine':'local_pending'}

@router.post('/analyze')
def analyze(payload:dict):
    return {'ok':True,'status':'MODEL_NOT_CONNECTED'}
