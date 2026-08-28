from __future__ import annotations

import json
from datetime import datetime, timedelta, timezone

from sqlalchemy.orm import Session

from app.database.session import init_database, make_engine
from app.hardware_gateway.mock import MockHardwareGateway
from app.repositories import documents as document_repo
from app.repositories import question_rounds as round_repo
from app.repositories import template_questions as question_repo
from app.services.case_service import CaseService
from app.services.document_service import DocumentService
from app.services.identity_service import IdentityService
from app.services.message_service import MessageService
from app.services.session_service import SessionService


def make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'template-document.sqlite3'}")
    init_database(engine)
    return engine, Session(engine)


def start_ready_session(db, enroll_test_suspect_voiceprint):
    case = CaseService(db).create(
        {"operator_id": "officer-1", "suspectName": "测试对象", "officerName": "测试警官"}
    )
    IdentityService(db, MockHardwareGateway(simulated=True)).read(case["id"], actor_id="officer-1")
    enroll_test_suspect_voiceprint(db, case["id"])
    session = SessionService(db).start(case["id"], actor_id="officer-1")
    return case, session


def snapshot_payload(db, case_id: str) -> dict:
    snapshot = document_repo.latest_snapshot(db, case_id)
    assert snapshot is not None
    return json.loads(snapshot.content_json)


def test_template_snapshot_expands_rounds_in_real_time_order(tmp_path, enroll_test_suspect_voiceprint):
    engine, db = make_db(tmp_path)
    try:
        case, session = start_ready_session(db, enroll_test_suspect_voiceprint)

        arrival = question_repo.create_case(
            db,
            case_id=case["id"],
            source="STANDARD",
            text="你何时到达案发现场？",
            standard_question_id=None,
            regex_patterns_json="[]",
            aliases_json="[]",
        )
        companion = question_repo.create_case(
            db,
            case_id=case["id"],
            source="CASE",
            text="当时和谁一起去的？",
            standard_question_id=None,
            regex_patterns_json="[]",
            aliases_json="[]",
        )

        first_arrival = round_repo.create_round(
            db,
            case_id=case["id"],
            session_id=session["id"],
            case_question_id=arrival.id,
            actual_question_text="你第一次什么时候到现场？",
            officer_fragment_id=None,
            answer_text="下午三点左右。",
            answer_fragment_ids=["suspect-1"],
            status="CLOSED",
        )
        companion_round = round_repo.create_round(
            db,
            case_id=case["id"],
            session_id=session["id"],
            case_question_id=companion.id,
            actual_question_text="第一次去现场的时候跟谁一起？",
            officer_fragment_id=None,
            answer_text="我一个人去的。",
            answer_fragment_ids=["suspect-2"],
            status="CLOSED",
        )
        second_arrival = round_repo.create_round(
            db,
            case_id=case["id"],
            session_id=session["id"],
            case_question_id=arrival.id,
            actual_question_text="你第二次又什么时候回到现场？",
            officer_fragment_id=None,
            answer_text="晚上九点左右。",
            answer_fragment_ids=["suspect-3"],
            status="CLOSED",
        )

        base = datetime(2026, 8, 28, 8, 0, tzinfo=timezone.utc)
        first_arrival.started_at = base
        companion_round.started_at = base + timedelta(minutes=2)
        second_arrival.started_at = base + timedelta(minutes=5)
        db.commit()

        SessionService(db).finish(case["id"], actor_id="officer-1")
        DocumentService(db).freeze(case["id"], actor_id="officer-1")
        payload = snapshot_payload(db, case["id"])

        transcript = payload["transcript"]
        assert transcript["source"] == "TEMPLATE_ROUNDS"
        entries = transcript["entries"]
        assert [item["roundId"] for item in entries] == [
            first_arrival.id,
            companion_round.id,
            second_arrival.id,
        ]
        assert [item["formalQuestionText"] for item in entries] == [
            "你何时到达案发现场？",
            "当时和谁一起去的？",
            "你何时到达案发现场？",
        ]
        assert entries[0]["actualQuestionText"] == "你第一次什么时候到现场？"
        assert entries[0]["answerText"] == "下午三点左右。"
        assert entries[2]["actualQuestionText"] == "你第二次又什么时候回到现场？"
        assert entries[2]["answerText"] == "晚上九点左右。"
        assert "messages" not in transcript
    finally:
        db.close()
        engine.dispose()


def test_legacy_snapshot_falls_back_to_messages_when_no_case_questions(
    tmp_path,
    enroll_test_suspect_voiceprint,
):
    engine, db = make_db(tmp_path)
    try:
        case, _session = start_ready_session(db, enroll_test_suspect_voiceprint)
        messages = MessageService(db)
        messages.create(case["id"], text="请说明你的姓名。", speaker="民警", actor_id="officer-1")
        messages.create(case["id"], text="我叫测试对象。", speaker="嫌疑人", actor_id="officer-1")

        SessionService(db).finish(case["id"], actor_id="officer-1")
        DocumentService(db).freeze(case["id"], actor_id="officer-1")
        payload = snapshot_payload(db, case["id"])

        transcript = payload["transcript"]
        assert transcript["source"] == "LEGACY_MESSAGES"
        assert [item["text"] for item in transcript["messages"]] == [
            "请说明你的姓名。",
            "我叫测试对象。",
        ]
        assert "entries" not in transcript
    finally:
        db.close()
        engine.dispose()
