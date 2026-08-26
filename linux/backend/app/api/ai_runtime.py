from __future__ import annotations

import asyncio
import base64
import json
import uuid
from dataclasses import asdict

from fastapi import APIRouter, HTTPException, Request, WebSocket, WebSocketDisconnect
from pydantic import BaseModel, Field
from starlette.responses import StreamingResponse

from ..ai.errors import AIError

router = APIRouter(prefix="/ai", tags=["ai-runtime"])

class LLMGenerateRequest(BaseModel):
    prompt: str = Field(min_length=1)
    session_id: str
    options: dict = Field(default_factory=dict)
class BinaryInferenceRequest(BaseModel):
    data_b64: str
    session_id: str
    options: dict = Field(default_factory=dict)
class OCRRequest(BinaryInferenceRequest):
    capability: str = "text"

def _supervisor(request: Request): return request.app.state.ai_supervisor

def _http_error(exc: AIError) -> HTTPException:
    status = {"MODEL_NOT_INSTALLED":503,"BACKEND_UNAVAILABLE":503,"WORKER_TIMEOUT":504,"RESOURCE_BUSY":409,"WORKER_CANCELLED":409,"WORKER_CRASHED":503}.get(exc.code,500)
    return HTTPException(status_code=status, detail={"code":exc.code,"message":exc.message,"details":exc.details})

@router.get("/health")
def ai_health(request: Request): return _supervisor(request).health()
@router.get("/capabilities")
def ai_capabilities(request: Request): return _supervisor(request).capabilities()
@router.post("/llm/generate")
async def llm_generate(body: LLMGenerateRequest, request: Request):
    try:
        result = await asyncio.to_thread(_supervisor(request).generate, body.prompt, session_id=body.session_id, options=body.options)
        return asdict(result)
    except AIError as exc: raise _http_error(exc) from exc
@router.post("/llm/stream")
def llm_stream(body: LLMGenerateRequest, request: Request):
    supervisor = _supervisor(request)
    def generate():
        try:
            for chunk in supervisor.stream_llm(body.prompt, session_id=body.session_id, options=body.options): yield json.dumps(asdict(chunk), ensure_ascii=False)+"\n"
        except AIError as exc: yield json.dumps({"error":{"code":exc.code,"message":exc.message,"details":exc.details}}, ensure_ascii=False)+"\n"
    return StreamingResponse(generate(), media_type="application/x-ndjson")
@router.post("/llm/cancel")
def llm_cancel(request: Request): _supervisor(request).cancel("llm"); return {"status":"cancelled"}
@router.post("/asr/transcribe")
async def asr_transcribe(body: BinaryInferenceRequest, request: Request):
    try: audio = base64.b64decode(body.data_b64, validate=True)
    except ValueError as exc: raise HTTPException(status_code=422, detail={"code":"INVALID_BASE64"}) from exc
    try: return asdict(await asyncio.to_thread(_supervisor(request).transcribe, audio, session_id=body.session_id, options=body.options))
    except AIError as exc: raise _http_error(exc) from exc
@router.websocket("/asr/stream")
async def asr_stream(websocket: WebSocket):
    await websocket.accept(); supervisor = websocket.app.state.ai_supervisor; session_id = websocket.query_params.get("session_id") or str(uuid.uuid4()); audio = bytearray()
    try:
        while True:
            message = await websocket.receive(); chunk = message.get("bytes"); text = message.get("text")
            if chunk is not None:
                audio.extend(chunk)
                try:
                    partials = await asyncio.to_thread(lambda: list(supervisor.stream_asr(bytes(audio), session_id=session_id)))
                    if partials:
                        payload = asdict(partials[-1]); payload["final"] = False; await websocket.send_json({"type":"partial","result":payload})
                except AIError as exc: await websocket.send_json({"type":"error","error":{"code":exc.code,"message":exc.message}})
            elif text is not None:
                try: command = json.loads(text)
                except json.JSONDecodeError: command = {"type":text}
                if command.get("type") == "cancel": supervisor.cancel("asr"); await websocket.send_json({"type":"cancelled","session_id":session_id}); audio.clear()
                elif command.get("type") in {"end","finalize"}:
                    try: result = await asyncio.to_thread(supervisor.transcribe, bytes(audio), session_id=session_id); await websocket.send_json({"type":"final","result":asdict(result)})
                    except AIError as exc: await websocket.send_json({"type":"error","error":{"code":exc.code,"message":exc.message}})
                    audio.clear()
                elif command.get("type") == "close": await websocket.close(); return
    except WebSocketDisconnect: return
@router.post("/ocr/recognize")
async def ocr_recognize(body: OCRRequest, request: Request):
    try: image = base64.b64decode(body.data_b64, validate=True)
    except ValueError as exc: raise HTTPException(status_code=422, detail={"code":"INVALID_BASE64"}) from exc
    try: return asdict(await asyncio.to_thread(_supervisor(request).recognize, image, capability=body.capability, session_id=body.session_id, options=body.options))
    except AIError as exc: raise _http_error(exc) from exc
