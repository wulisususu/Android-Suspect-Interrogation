"""Repository for the MOSS interrogation transcription tables (Task 16).

Only this module (and the coordinator above it) touches the ``moss_*``
tables; the realtime ASR path keeps its own tables untouched.
"""
from __future__ import annotations

import json
from uuid import uuid4

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.database.moss_models import (
    MossSpeakerMapping,
    MossTranscription,
    MossTranscriptionRevision,
)

__all__ = [
    "MossSpeakerMapping",
    "MossTranscription",
    "MossTranscriptionRevision",
    "append_revision",
    "create_transcription",
    "get_by_job",
    "get_latest",
    "latest_revision",
    "list_all",
    "list_by_states",
    "list_mappings",
    "set_state",
    "upsert_mapping",
]


def create_transcription(
    db: Session,
    *,
    case_id: str,
    audio_path: str,
    audio_sha256: str,
    job_id: str | None,
    model_manifest_sha256: str | None,
    state: str,
    windows: list[dict] | None = None,
) -> MossTranscription:
    row = MossTranscription(
        id=str(uuid4()),
        case_id=case_id,
        audio_path=audio_path,
        audio_sha256=audio_sha256,
        job_id=job_id,
        model_manifest_sha256=model_manifest_sha256,
        state=str(state),
        error=None,
        windows_json=json.dumps(windows or [], ensure_ascii=False),
    )
    db.add(row)
    db.flush()
    return row


def get_latest(db: Session, case_id: str) -> MossTranscription | None:
    """Newest submission of a case (created_at desc, id as tie-break)."""
    return db.scalar(
        select(MossTranscription)
        .where(MossTranscription.case_id == case_id)
        .order_by(MossTranscription.created_at.desc(), MossTranscription.id.desc())
        .limit(1)
    )


def get_by_job(db: Session, job_id: str) -> MossTranscription | None:
    return db.scalar(
        select(MossTranscription)
        .where(MossTranscription.job_id == job_id)
        .order_by(MossTranscription.created_at.desc())
        .limit(1)
    )


def list_all(db: Session, case_id: str) -> list[MossTranscription]:
    stmt = (
        select(MossTranscription)
        .where(MossTranscription.case_id == case_id)
        .order_by(MossTranscription.created_at.desc(), MossTranscription.id.desc())
    )
    return list(db.scalars(stmt))


def list_by_states(db: Session, states: list[str] | tuple[str, ...]) -> list[MossTranscription]:
    stmt = (
        select(MossTranscription)
        .where(MossTranscription.state.in_(list(states)))
        .order_by(MossTranscription.created_at.asc())
    )
    return list(db.scalars(stmt))


_UNSET = object()


def set_state(
    db: Session,
    row: MossTranscription,
    state: str,
    *,
    error=_UNSET,
    windows: list[dict] | None = None,
) -> MossTranscription:
    row.state = str(state)
    if error is not _UNSET:
        row.error = error
    if windows is not None:
        row.windows_json = json.dumps(windows, ensure_ascii=False)
    db.flush()
    return row


def append_revision(
    db: Session,
    *,
    transcription: MossTranscription,
    job_id: str,
    audio_sha256: str,
    model_manifest_sha256: str,
    segments: list[dict],
    provenance: list[dict],
    mapping_snapshot: dict,
) -> MossTranscriptionRevision:
    next_no = int(
        db.scalar(
            select(func.coalesce(func.max(MossTranscriptionRevision.revision_no), 0)).where(
                MossTranscriptionRevision.transcription_id == transcription.id
            )
        )
        or 0
    ) + 1
    row = MossTranscriptionRevision(
        id=str(uuid4()),
        transcription_id=transcription.id,
        case_id=transcription.case_id,
        job_id=job_id,
        revision_no=next_no,
        audio_sha256=audio_sha256,
        model_manifest_sha256=model_manifest_sha256,
        segments_json=json.dumps(segments, ensure_ascii=False),
        provenance_json=json.dumps(provenance, ensure_ascii=False),
        mapping_snapshot_json=json.dumps(mapping_snapshot, ensure_ascii=False),
    )
    db.add(row)
    db.flush()
    return row


def latest_revision(db: Session, transcription_id: str) -> MossTranscriptionRevision | None:
    return db.scalar(
        select(MossTranscriptionRevision)
        .where(MossTranscriptionRevision.transcription_id == transcription_id)
        .order_by(MossTranscriptionRevision.revision_no.desc())
        .limit(1)
    )


def list_mappings(db: Session, case_id: str) -> list[MossSpeakerMapping]:
    stmt = (
        select(MossSpeakerMapping)
        .where(MossSpeakerMapping.case_id == case_id)
        .order_by(MossSpeakerMapping.global_speaker.asc())
    )
    return list(db.scalars(stmt))


def get_mapping(db: Session, case_id: str, global_speaker: str) -> MossSpeakerMapping | None:
    return db.scalar(
        select(MossSpeakerMapping).where(
            MossSpeakerMapping.case_id == case_id,
            MossSpeakerMapping.global_speaker == global_speaker,
        )
    )


def upsert_mapping(db: Session, *, case_id: str, global_speaker: str, role: str) -> MossSpeakerMapping:
    row = get_mapping(db, case_id, global_speaker)
    if row is None:
        row = MossSpeakerMapping(id=str(uuid4()), case_id=case_id, global_speaker=global_speaker, role=role)
        db.add(row)
    else:
        row.role = role
    db.flush()
    return row
