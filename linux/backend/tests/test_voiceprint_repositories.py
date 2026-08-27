import struct

import pytest
from sqlalchemy.orm import Session

from app.database.models import Case, InterrogationSession
from app.database.session import init_database, make_engine
from app.domain.enums import InterrogationStage, SessionStatus
from app.domain.errors import DomainError
from app.repositories import asr_fragments as asr_repo
from app.repositories import messages as message_repo
from app.repositories import voiceprints as voiceprint_repo


def make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'voiceprints.sqlite3'}")
    init_database(engine)
    db = Session(engine)
    db.add(Case(id="CASE-1", officer_name="警官"))
    db.add(
        InterrogationSession(
            id="SESSION-1",
            case_id="CASE-1",
            status=SessionStatus.RUNNING.value,
            stage=InterrogationStage.IDENTITY.value,
        )
    )
    db.commit()
    return engine, db


def embedding(*values: float) -> bytes:
    return struct.pack(f"<{len(values)}f", *values)


def test_suspect_voiceprint_requires_explicit_replace_and_valid_dimension(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        first = voiceprint_repo.enroll_suspect(
            db,
            case_id="CASE-1",
            embedding=embedding(0.1, 0.2, 0.3),
            embedding_dim=3,
            model_id="xvector",
            model_version="v1",
            enrollment_quality="GOOD",
            usable_duration_ms=22000,
        )
        db.commit()

        with pytest.raises(DomainError) as duplicate:
            voiceprint_repo.enroll_suspect(
                db,
                case_id="CASE-1",
                embedding=embedding(0.4, 0.5, 0.6),
                embedding_dim=3,
                model_id="xvector",
                enrollment_quality="GOOD",
                usable_duration_ms=23000,
            )
        assert duplicate.value.code == "SUSPECT_VOICEPRINT_EXISTS"
        db.rollback()

        replaced = voiceprint_repo.replace_suspect(
            db,
            case_id="CASE-1",
            embedding=embedding(0.4, 0.5, 0.6),
            embedding_dim=3,
            model_id="xvector",
            model_version="v2",
            enrollment_quality="GOOD",
            usable_duration_ms=23000,
        )
        db.commit()
        assert replaced.id == first.id
        assert replaced.embedding == embedding(0.4, 0.5, 0.6)
        assert replaced.embedding_dim == 3
        assert replaced.model_version == "v2"

        with pytest.raises(DomainError) as invalid:
            voiceprint_repo.replace_suspect(
                db,
                case_id="CASE-1",
                embedding=embedding(1.0, 2.0),
                embedding_dim=3,
                model_id="xvector",
                enrollment_quality="GOOD",
                usable_duration_ms=23000,
            )
        assert invalid.value.code == "INVALID_VOICEPRINT_EMBEDDING"
    finally:
        db.close()
        engine.dispose()


def test_officer_profile_updates_and_revokes_without_deleting_identity(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        enrolled = voiceprint_repo.enroll_officer(
            db,
            officer_id="P-001",
            officer_name="张警官",
            embedding=embedding(0.1, 0.2),
            embedding_dim=2,
            model_id="xvector",
            model_version="v1",
            enrollment_quality="GOOD",
            usable_duration_ms=24000,
        )
        db.commit()
        original_id = enrolled.id

        updated = voiceprint_repo.update_officer(
            db,
            officer_id="P-001",
            officer_name="张警官",
            embedding=embedding(0.3, 0.4),
            embedding_dim=2,
            model_id="xvector",
            model_version="v2",
            enrollment_quality="GOOD",
            usable_duration_ms=25000,
        )
        db.commit()
        assert updated.id == original_id
        assert updated.embedding == embedding(0.3, 0.4)
        assert updated.active is True

        revoked = voiceprint_repo.revoke_officer(db, officer_id="P-001")
        db.commit()
        assert revoked.id == original_id
        assert revoked.active is False
        assert revoked.revoked_at is not None
        assert voiceprint_repo.get_officer(db, "P-001", active_only=False).id == original_id
        assert voiceprint_repo.get_officer(db, "P-001", active_only=True) is None
    finally:
        db.close()
        engine.dispose()


def test_session_assignment_rejects_revoked_officer_voiceprint(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        suspect = voiceprint_repo.enroll_suspect(
            db,
            case_id="CASE-1",
            embedding=embedding(0.1, 0.2),
            embedding_dim=2,
            model_id="xvector",
            enrollment_quality="GOOD",
            usable_duration_ms=22000,
        )
        voiceprint_repo.enroll_officer(
            db,
            officer_id="P-001",
            officer_name="主审民警",
            embedding=embedding(0.3, 0.4),
            embedding_dim=2,
            model_id="xvector",
            enrollment_quality="GOOD",
            usable_duration_ms=23000,
        )
        voiceprint_repo.revoke_officer(db, officer_id="P-001")
        db.commit()

        with pytest.raises(DomainError) as revoked:
            voiceprint_repo.assign_session_roles(
                db,
                session_id="SESSION-1",
                suspect_voiceprint_id=suspect.id,
                interrogator_officer_id="P-001",
                recorder_officer_id=None,
            )
        assert revoked.value.code == "OFFICER_VOICEPRINT_NOT_ACTIVE"
        db.rollback()

        assignment = voiceprint_repo.assign_session_roles(
            db,
            session_id="SESSION-1",
            suspect_voiceprint_id=suspect.id,
            interrogator_officer_id=None,
            recorder_officer_id=None,
        )
        db.commit()
        assert assignment.recognition_mode == "SUSPECT_ONLY"
        assert assignment.interrogator_voiceprint_id is None
        assert assignment.recorder_voiceprint_id is None
    finally:
        db.close()
        engine.dispose()


def test_asr_fragment_edit_preserves_raw_text_and_confirmation_links_message(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        capture = asr_repo.create_capture_session(
            db,
            case_id="CASE-1",
            interrogation_session_id="SESSION-1",
            sample_rate=16000,
        )
        fragment = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id="CASE-1",
            ordinal=1,
            started_at_ms=100,
            ended_at_ms=1400,
            raw_text="我昨晚在家",
            asr_confidence=0.83,
            speaker="UNKNOWN",
            speaker_source="XVECTOR",
            voiceprint_verified=False,
            low_confidence=True,
            model_id="paraformer",
            model_version="v1",
        )
        db.commit()
        raw = fragment.raw_text

        edited = asr_repo.update_fragment(
            db,
            fragment_id=fragment.id,
            edited_text="我昨晚一直在家。",
            speaker="SUSPECT",
            speaker_id="suspect:CASE-1",
            speaker_name="嫌疑人",
            speaker_source="MANUAL",
            voiceprint_verified=False,
            low_confidence=False,
        )
        db.commit()
        assert edited.raw_text == raw
        assert edited.edited_text == "我昨晚一直在家。"
        assert edited.speaker == "SUSPECT"

        message = message_repo.create(
            db,
            case_id="CASE-1",
            session_id="SESSION-1",
            speaker="嫌疑人",
            text=edited.edited_text,
        )
        confirmed = asr_repo.confirm_fragment(db, fragment_id=fragment.id, message_id=message.id)
        db.commit()
        assert confirmed.raw_text == raw
        assert confirmed.confirmed_message_id == message.id
        assert confirmed.state == "CONFIRMED"
    finally:
        db.close()
        engine.dispose()
