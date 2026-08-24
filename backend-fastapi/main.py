from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from time import time
from api.cases import router as cases_router
from api.ai import router as ai_router
from api.details import router as details_router

app=FastAPI(title='Suspect Interrogation Backend',version='0.3.0')

app.add_middleware(CORSMiddleware,allow_origins=['*'],allow_methods=['*'],allow_headers=['*'])

app.include_router(cases_router)
app.include_router(ai_router)
app.include_router(details_router)

@app.get('/api/health')
def health():
    return {'ok':True,'code':'OK','data':{'service':'suspect-interrogation-fastapi','status':'ready','timestamp':int(time()*1000)}}
