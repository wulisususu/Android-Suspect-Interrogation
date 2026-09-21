from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.api.deps import get_db
from app.api.responses import envelope
from app.api.schemas import CaseCreateRequest, CaseIntakeRequest, CaseUpdateRequest, FactUpdateRequest
from app.services.case_service import CaseService

router = APIRouter(prefix="/cases", tags=["cases"])


@router.post("")
def create_case(body: CaseCreateRequest, db: Session = Depends(get_db)):
    return envelope(CaseService(db).create(body.model_dump(exclude_none=True)), "案件已创建")


@router.post("/intake")
def intake_case(body: CaseIntakeRequest, db: Session = Depends(get_db)):
    payload = body.model_dump(exclude={"identity"}, exclude_none=True)
    identity = body.identity.model_dump(exclude_none=True)
    actor_id = payload.get("operator_id") or payload.get("operatorId")
    return envelope(CaseService(db).intake(payload, identity, actor_id), "案件及身份信息已创建")


@router.get("")
def list_cases(
    limit: int = Query(100, ge=1, le=1000),
    query: str | None = Query(None, min_length=1, max_length=128),
    db: Session = Depends(get_db),
):
    return envelope(CaseService(db).list(limit, query))


@router.get("/{case_id}")
def get_case(case_id: str, db: Session = Depends(get_db)):
    return envelope(CaseService(db).get(case_id))


@router.put("/{case_id}")
def update_case(case_id: str, body: CaseUpdateRequest, db: Session = Depends(get_db)):
    patch = body.model_dump(exclude_none=True)
    actor_id = patch.pop("actor_id", None)
    return envelope(CaseService(db).update(case_id, patch, actor_id), "案件信息已保存")


@router.get("/{case_id}/facts")
def list_facts(case_id: str, db: Session = Depends(get_db)):
    return envelope(CaseService(db).list_facts(case_id))


@router.put("/{case_id}/facts/{fact_key}")
def update_fact(case_id: str, fact_key: str, body: FactUpdateRequest, db: Session = Depends(get_db)):
    patch = body.model_dump(exclude_none=True)
    actor_id = patch.pop("actor_id", None)
    return envelope(CaseService(db).update_fact(case_id, fact_key, patch, actor_id), "事实项已更新")


@router.get("/{case_id}/audit")
def list_audit(case_id: str, limit: int = Query(200, ge=1, le=1000), db: Session = Depends(get_db)):
    return envelope(CaseService(db).list_audit(case_id, limit))
