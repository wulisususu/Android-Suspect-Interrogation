from __future__ import annotations

import struct

import pytest
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import Case, OfficerVoiceprint, SuspectVoiceprint
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.repositories import voiceprints as voiceprint_repo


XVECTOR = "xvector"
ERES2NET = "eres2net_large"


def _embedding(*values: float) -> bytes:
    return struct.pack(f"<{len(values)}f", *values)


def _make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'dual-speaker-voiceprints.sqlite3'}")
    init_database(engine)
    db = Session(engine)
    db.add(Case(id="CASE-1", officer_name="测试警官"))
    db.commit()
    return engine, db


def test_suspect_can_hold_one_reference_per_model_and_lookup_never_falls_back(tmp_path):
    engine, db = _make_db(tmp_path)
    try:
        xvector = voiceprint_repo.enroll_suspect(
            db,
            case_id="CASE-1",
            model_key=XVECTOR,
            embedding=_embedding(1.0, 0.0, 0.0),
            embedding_dim=3,
            model_id="xvector",
            model_version="legacy-v1",
            enrollment_quality="GOOD",
            usable_duration_ms=22_000,
        )
        eres2net = voiceprint_repo.enroll_suspect(
            db,
            case_id="CASE-1",
            model_key=ERES2NET,
            embedding=_embedding(0.0, 1.0, 0.0, 0.0),
            embedding_dim=4,
            model_id="iic/speech_eres2net_large_200k_sv_zh-cn_16k-common",
            model_version="modelscope-local",
            enrollment_quality="GOOD",
            usable_duration_ms=22_000,
        )
        db.commit()

        assert xvector.id != eres2net.id
        assert xvector.model_key == XVECTOR
        assert eres2net.model_key == ERES2NET
        assert voiceprint_repo.get_suspect(db, "CASE-1", model_key=XVECTOR).id == xvector.id
        assert voiceprint_repo.get_suspect(db, "CASE-1", model_key=ERES2NET).id == eres2net.id

        with pytest.raises(DomainError) as duplicate:
            voiceprint_repo.enroll_suspect(
                db,
                case_id="CASE-1",
                model_key=XVECTOR,
                embedding=_embedding(0.9, 0.1, 0.0),
                embedding_dim=3,
                model_id="xvector",
                enrollment_quality="GOOD",
                usable_duration_ms=23_000,
            )
        assert duplicate.value.code == "SUSPECT_VOICEPRINT_EXISTS"
        db.rollback()

        db.delete(eres2net)
        db.commit()
        assert voiceprint_repo.get_suspect(db, "CASE-1", model_key=ERES2NET) is None
        assert voiceprint_repo.get_suspect(db, "CASE-1", model_key=XVECTOR).id == xvector.id
    finally:
        db.close()
        engine.dispose()


def test_officer_can_hold_one_reference_per_model_and_same_model_duplicate_is_rejected(tmp_path):
    engine, db = _make_db(tmp_path)
    try:
        xvector = voiceprint_repo.enroll_officer(
            db,
            officer_id="P-001",
            officer_name="张警官",
            model_key=XVECTOR,
            embedding=_embedding(1.0, 0.0),
            embedding_dim=2,
            model_id="xvector",
            model_version="legacy-v1",
            enrollment_quality="GOOD",
            usable_duration_ms=24_000,
        )
        eres2net = voiceprint_repo.enroll_officer(
            db,
            officer_id="P-001",
            officer_name="张警官",
            model_key=ERES2NET,
            embedding=_embedding(0.0, 1.0, 0.0),
            embedding_dim=3,
            model_id="iic/speech_eres2net_large_200k_sv_zh-cn_16k-common",
            model_version="modelscope-local",
            enrollment_quality="GOOD",
            usable_duration_ms=24_000,
        )
        db.commit()

        assert xvector.id != eres2net.id
        assert voiceprint_repo.get_officer(db, "P-001", model_key=XVECTOR).id == xvector.id
        assert voiceprint_repo.get_officer(db, "P-001", model_key=ERES2NET).id == eres2net.id

        with pytest.raises(DomainError) as duplicate:
            voiceprint_repo.enroll_officer(
                db,
                officer_id="P-001",
                officer_name="张警官",
                model_key=ERES2NET,
                embedding=_embedding(0.0, 0.9, 0.1),
                embedding_dim=3,
                model_id="iic/speech_eres2net_large_200k_sv_zh-cn_16k-common",
                enrollment_quality="GOOD",
                usable_duration_ms=25_000,
            )
        assert duplicate.value.code == "OFFICER_VOICEPRINT_EXISTS"
        db.rollback()

        rows = list(db.scalars(select(OfficerVoiceprint).where(OfficerVoiceprint.officer_id == "P-001")))
        assert {row.model_key for row in rows} == {XVECTOR, ERES2NET}
    finally:
        db.close()
        engine.dispose()


def test_replace_update_and_revoke_are_scoped_to_requested_model(tmp_path):
    engine, db = _make_db(tmp_path)
    try:
        suspect_x = voiceprint_repo.enroll_suspect(
            db,
            case_id="CASE-1",
            model_key=XVECTOR,
            embedding=_embedding(1.0, 0.0),
            embedding_dim=2,
            model_id="xvector",
            enrollment_quality="GOOD",
            usable_duration_ms=21_000,
        )
        suspect_e = voiceprint_repo.enroll_suspect(
            db,
            case_id="CASE-1",
            model_key=ERES2NET,
            embedding=_embedding(0.0, 1.0, 0.0),
            embedding_dim=3,
            model_id="eres2net-large",
            enrollment_quality="GOOD",
            usable_duration_ms=21_000,
        )
        officer_x = voiceprint_repo.enroll_officer(
            db,
            officer_id="P-002",
            officer_name="李警官",
            model_key=XVECTOR,
            embedding=_embedding(1.0, 0.0),
            embedding_dim=2,
            model_id="xvector",
            enrollment_quality="GOOD",
            usable_duration_ms=21_000,
        )
        officer_e = voiceprint_repo.enroll_officer(
            db,
            officer_id="P-002",
            officer_name="李警官",
            model_key=ERES2NET,
            embedding=_embedding(0.0, 1.0, 0.0),
            embedding_dim=3,
            model_id="eres2net-large",
            enrollment_quality="GOOD",
            usable_duration_ms=21_000,
        )
        db.commit()

        replaced = voiceprint_repo.replace_suspect(
            db,
            case_id="CASE-1",
            model_key=ERES2NET,
            embedding=_embedding(0.1, 0.9, 0.0),
            embedding_dim=3,
            model_id="eres2net-large",
            model_version="v2",
            enrollment_quality="GOOD",
            usable_duration_ms=22_000,
        )
        updated = voiceprint_repo.update_officer(
            db,
            officer_id="P-002",
            officer_name="李警官",
            model_key=ERES2NET,
            embedding=_embedding(0.1, 0.9, 0.0),
            embedding_dim=3,
            model_id="eres2net-large",
            model_version="v2",
            enrollment_quality="GOOD",
            usable_duration_ms=22_000,
        )
        revoked = voiceprint_repo.revoke_officer(db, officer_id="P-002", model_key=ERES2NET)
        db.commit()

        assert replaced.id == suspect_e.id
        assert updated.id == officer_e.id
        assert revoked.id == officer_e.id
        assert voiceprint_repo.get_suspect(db, "CASE-1", model_key=XVECTOR).id == suspect_x.id
        assert voiceprint_repo.get_officer(db, "P-002", model_key=XVECTOR).id == officer_x.id
        assert voiceprint_repo.get_officer(db, "P-002", model_key=ERES2NET) is None
        assert voiceprint_repo.get_officer(db, "P-002", model_key=ERES2NET, active_only=False).id == officer_e.id
    finally:
        db.close()
        engine.dispose()


def test_fresh_schema_marks_officer_library_rows_with_model_key(tmp_path):
    engine, db = _make_db(tmp_path)
    try:
        from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample, SessionOfficerVoiceSnapshot

        assert hasattr(SuspectVoiceprint, "model_key")
        assert hasattr(OfficerVoiceprint, "model_key")
        assert hasattr(OfficerVoiceProfile, "model_key")
        assert hasattr(OfficerVoiceSample, "model_key")
        assert hasattr(SessionOfficerVoiceSnapshot, "model_key")
    finally:
        db.close()
        engine.dispose()
