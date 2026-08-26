from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.api.deps import get_db
from app.api.responses import envelope
from app.api.schemas import ActorRequest, MessageCreateRequest, MessageMarkRequest, MessageUpdateRequest, StageRequest
from app.services.message_service import MessageService
from app.services.session_service import SessionService

router = APIRouter(tags=["interrogation"])


def _actor(body: ActorRequest | None) -> str | None:
    return body.actor_id if body else None


@router.get("/cases/{case_id}/session")
def get_session(case_id: str, db: Session = Depends(get_db)):
    return envelope(SessionService(db).get_state(case_id))


@router.post("/cases/{case_id}/session/start")
def start_session(case_id: str, body: ActorRequest | None = None, db: Session = Depends(get_db)):
    return envelope(SessionService(db).start(case_id, _actor(body)), "审讯已开始")


@router.post("/cases/{case_id}/session/pause")
def pause_session(case_id: str, body: ActorRequest | None = None, db: Session = Depends(get_db)):
    return envelope(SessionService(db).pause(case_id, _actor(body)), "审讯已暂停")


@router.post("/cases/{case_id}/session/resume")
def resume_session(case_id: str, body: ActorRequest | None = None, db: Session = Depends(get_db)):
    return envelope(SessionService(db).resume(case_id, _actor(body)), "审讯已恢复")


@router.post("/cases/{case_id}/session/finish")
def finish_session(case_id: str, body: ActorRequest | None = None, db: Session = Depends(get_db)):
    return envelope(SessionService(db).finish(case_id, _actor(body)), "审讯已结束，进入复核")


@router.post("/cases/{case_id}/session/stage")
def change_stage(case_id: str, body: StageRequest, db: Session = Depends(get_db)):
    return envelope(SessionService(db).change_stage(case_id, body.stage, body.actor_id), "审讯阶段已切换")


@router.get("/cases/{case_id}/messages")
def list_messages(case_id: str, limit: int = Query(1000, ge=1, le=5000), db: Session = Depends(get_db)):
    return envelope(MessageService(db).list(case_id, limit))


@router.post("/cases/{case_id}/messages")
def create_message(case_id: str, body: MessageCreateRequest, db: Session = Depends(get_db)):
    return envelope(MessageService(db).create(case_id, text=body.text, speaker=body.speaker, actor_id=body.actor_id), "问答已保存")


@router.put("/cases/{case_id}/messages/{message_id}")
def revise_message(case_id: str, message_id: str, body: MessageUpdateRequest, db: Session = Depends(get_db)):
    return envelope(MessageService(db).revise(case_id, message_id, text=body.text, reason=body.reason, actor_id=body.actor_id), "笔录已修订并生成版本")


@router.post("/cases/{case_id}/messages/{message_id}/mark")
def mark_message(case_id: str, message_id: str, body: MessageMarkRequest, db: Session = Depends(get_db)):
    return envelope(MessageService(db).mark(case_id, message_id, body.mark, body.actor_id), "标记已保存")


@router.get("/cases/{case_id}/messages/{message_id}/revisions")
def message_revisions(case_id: str, message_id: str, db: Session = Depends(get_db)):
    return envelope(MessageService(db).revisions(case_id, message_id))


@router.get("/cases/{case_id}/revisions")
def case_revisions(case_id: str, db: Session = Depends(get_db)):
    return envelope(MessageService(db).revisions(case_id))
