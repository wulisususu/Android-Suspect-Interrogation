from __future__ import annotations

from datetime import datetime, timedelta, timezone

from sqlalchemy.orm import Session

from app.database.models import Case, InterrogationSession
from app.database.session import init_database, make_engine
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.services.qa_unit_builder import QAUnitBuilder
from app.services.serializers import qa_unit_dict


def make_context(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'qa-builder.db'}")
    init_database(engine)
    db = Session(engine, expire_on_commit=False)
    case = Case(id="CASE-QA", officer_name="测试警官")
    session = InterrogationSession(id="SESSION-QA", case_id=case.id, status="RUNNING", stage="QUESTIONING")
    db.add_all([case, session])
    db.flush()
    capture = asr_repo.create_capture_session(
        db,
        case_id=case.id,
        interrogation_session_id=session.id,
        sample_rate=16000,
    )
    capture.started_at = datetime(2026, 9, 1, 8, 0, tzinfo=timezone.utc)
    db.commit()
    return engine, db, case, session, capture


def add_fragment(db, capture, *, ordinal: int, speaker: str, text: str, start_ms: int, end_ms: int):
    row = asr_repo.create_fragment(
        db,
        capture_session_id=capture.id,
        case_id=capture.case_id,
        ordinal=ordinal,
        started_at_ms=start_ms,
        ended_at_ms=end_ms,
        raw_text=text,
        speaker=speaker,
        speaker_source="MANUAL",
        voiceprint_verified=speaker != "UNKNOWN",
        low_confidence=False,
        model_id="test-asr",
    )
    db.commit()
    return row


def test_officer_then_two_suspect_fragments_forms_one_unit(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db, idle_close_seconds=4.0)
        q = add_fragment(db, capture, ordinal=1, speaker="INTERROGATOR", text="说一下昨晚的经过", start_ms=0, end_ms=800)
        a1 = add_fragment(db, capture, ordinal=2, speaker="SUSPECT", text="我八点左右到了。", start_ms=1000, end_ms=1800)
        a2 = add_fragment(db, capture, ordinal=3, speaker="SUSPECT", text="然后在门口等了一会儿。", start_ms=2000, end_ms=3000)

        assert builder.consume_fragment(case.id, q.id) == []
        assert builder.consume_fragment(case.id, a1.id) == []
        assert builder.consume_fragment(case.id, a2.id) == []

        active = qa_repo.active_for_session(db, case.id, session.id)
        assert active is not None
        assert [link.role for link in active.fragments] == ["QUESTION", "ANSWER", "ANSWER"]
    finally:
        db.close()
        engine.dispose()


def test_open_unit_exposes_merged_turn_text_without_closing(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db)
        q1 = add_fragment(db, capture, ordinal=1, speaker="INTERROGATOR", text="你叫什么名字？", start_ms=0, end_ms=700)
        q2 = add_fragment(db, capture, ordinal=2, speaker="INTERROGATOR", text="把基本情况说一下。", start_ms=800, end_ms=1500)
        a1 = add_fragment(db, capture, ordinal=3, speaker="SUSPECT", text="我叫张伟，男，二十八岁。", start_ms=1800, end_ms=2800)

        builder.consume_fragment(case.id, q1.id)
        builder.consume_fragment(case.id, q2.id)
        builder.consume_fragment(case.id, a1.id)

        unit = qa_repo.active_for_session(db, case.id, session.id)
        assert unit is not None and unit.status == "OPEN"
        assert unit.raw_question_text == "你叫什么名字？ 把基本情况说一下。"
        assert unit.raw_answer_text == "我叫张伟，男，二十八岁。"
        assert [link.fragment_id for link in unit.fragments] == [q1.id, q2.id, a1.id]
    finally:
        db.close()
        engine.dispose()


def test_next_officer_question_closes_previous_unit(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db)
        q1 = add_fragment(db, capture, ordinal=1, speaker="INTERROGATOR", text="你几点到现场？", start_ms=0, end_ms=500)
        a1 = add_fragment(db, capture, ordinal=2, speaker="SUSPECT", text="八点多。", start_ms=700, end_ms=1200)
        q2 = add_fragment(db, capture, ordinal=3, speaker="INTERROGATOR", text="后来去了哪里？", start_ms=1500, end_ms=2200)
        builder.consume_fragment(case.id, q1.id)
        builder.consume_fragment(case.id, a1.id)

        closed_ids = builder.consume_fragment(case.id, q2.id)

        assert len(closed_ids) == 1
        closed = qa_repo.get(db, closed_ids[0])
        assert closed.raw_question_text == "你几点到现场？"
        assert closed.raw_answer_text == "八点多。"
        next_unit = qa_repo.active_for_session(db, case.id, session.id)
        assert next_unit is not None and next_unit.id != closed.id
    finally:
        db.close()
        engine.dispose()


def test_operational_officer_prompt_keeps_continuing_suspect_answer_in_same_unit(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db)
        question = add_fragment(db, capture, ordinal=1, speaker="INTERROGATOR", text="你是怎么进去的？", start_ms=0, end_ms=500)
        first_answer = add_fragment(db, capture, ordinal=2, speaker="SUSPECT", text="我先翻了后面的围墙。", start_ms=700, end_ms=1200)
        continue_prompt = add_fragment(db, capture, ordinal=3, speaker="INTERROGATOR", text="嗯，继续说。", start_ms=1400, end_ms=1600)
        second_answer = add_fragment(db, capture, ordinal=4, speaker="SUSPECT", text="然后我从厨房窗户进去的。", start_ms=1800, end_ms=2500)

        builder.consume_fragment(case.id, question.id)
        builder.consume_fragment(case.id, first_answer.id)
        assert builder.consume_fragment(case.id, continue_prompt.id) == []
        assert builder.consume_fragment(case.id, second_answer.id) == []

        active = qa_repo.active_for_session(db, case.id, session.id)
        assert active is not None
        assert active.raw_question_text == "你是怎么进去的？"
        assert active.raw_answer_text == "我先翻了后面的围墙。 然后我从厨房窗户进去的。"
        assert [link.fragment_id for link in active.fragments] == [
            question.id,
            first_answer.id,
            continue_prompt.id,
            second_answer.id,
        ]
        assert [link.role for link in active.fragments] == ["QUESTION", "ANSWER", "CONTROL", "ANSWER"]
        assert qa_unit_dict(active)["controlFragmentIds"] == [continue_prompt.id]
    finally:
        db.close()
        engine.dispose()


def test_consecutive_officer_fragments_before_answer_stay_one_question(tmp_path):
    engine, db, case, _session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db)
        q1 = add_fragment(db, capture, ordinal=1, speaker="INTERROGATOR", text="昨天晚上", start_ms=0, end_ms=400)
        q2 = add_fragment(db, capture, ordinal=2, speaker="RECORDER", text="你去了什么地方？", start_ms=500, end_ms=1000)
        a = add_fragment(db, capture, ordinal=3, speaker="SUSPECT", text="去了商场。", start_ms=1200, end_ms=1800)
        builder.consume_fragment(case.id, q1.id)
        builder.consume_fragment(case.id, q2.id)
        builder.consume_fragment(case.id, a.id)
        unit = qa_repo.list_for_case(db, case.id)[0]
        assert [link.role for link in unit.fragments] == ["QUESTION", "QUESTION", "ANSWER"]
    finally:
        db.close()
        engine.dispose()


def test_unknown_fragment_is_not_assigned_or_recovered(tmp_path):
    engine, db, case, _session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db)
        unknown = add_fragment(db, capture, ordinal=1, speaker="UNKNOWN", text="听不清的话", start_ms=0, end_ms=500)
        assert builder.consume_fragment(case.id, unknown.id) == []
        assert qa_repo.list_for_case(db, case.id) == []
        assert asr_repo.list_unassigned_for_session(db, case.id, "SESSION-QA") == []
    finally:
        db.close()
        engine.dispose()


def test_recovery_keeps_capture_timeline_when_ordinals_restart_after_resume(tmp_path):
    engine, db, case, session, first_capture = make_context(tmp_path)
    try:
        second_capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=session.id,
            sample_rate=16000,
        )
        second_capture.started_at = first_capture.started_at + timedelta(minutes=5)
        db.commit()

        first_question = add_fragment(
            db, first_capture, ordinal=0, speaker="INTERROGATOR", text="第一次的问题？", start_ms=0, end_ms=500
        )
        first_answer = add_fragment(
            db, first_capture, ordinal=1, speaker="SUSPECT", text="第一次的回答。", start_ms=700, end_ms=1200
        )
        second_question = add_fragment(
            db, second_capture, ordinal=0, speaker="INTERROGATOR", text="第二次的问题？", start_ms=0, end_ms=500
        )
        second_answer = add_fragment(
            db, second_capture, ordinal=1, speaker="SUSPECT", text="第二次的回答。", start_ms=700, end_ms=1200
        )

        recovered = asr_repo.list_unassigned_for_session(db, case.id, session.id)
        assert [fragment.id for fragment in recovered] == [
            first_question.id,
            first_answer.id,
            second_question.id,
            second_answer.id,
        ]

        builder = QAUnitBuilder(db)
        for fragment in recovered:
            builder.consume_fragment(case.id, fragment.id)
        builder.flush_session(case.id, session.id)

        units = qa_repo.list_for_case(db, case.id)
        assert [(unit.raw_question_text, unit.raw_answer_text) for unit in units] == [
            ("第一次的问题？", "第一次的回答。"),
            ("第二次的问题？", "第二次的回答。"),
        ]
    finally:
        db.close()
        engine.dispose()


def test_recovery_orders_split_children_by_audio_time_when_ordinals_are_late(tmp_path):
    engine, db, case, _session, capture = make_context(tmp_path)
    try:
        question = add_fragment(
            db, capture, ordinal=1, speaker="INTERROGATOR", text="你几点到的？", start_ms=0, end_ms=400
        )
        first_child = add_fragment(
            db, capture, ordinal=100, speaker="SUSPECT", text="先到门口。", start_ms=500, end_ms=900
        )
        later_fragment = add_fragment(
            db, capture, ordinal=2, speaker="INTERROGATOR", text="之后呢？", start_ms=1200, end_ms=1500
        )

        recovered = asr_repo.list_unassigned_for_session(db, case.id, "SESSION-QA")

        assert [fragment.id for fragment in recovered] == [question.id, first_child.id, later_fragment.id]
    finally:
        db.close()
        engine.dispose()


def test_recovery_skips_known_legacy_raw_only_but_keeps_unknown_role_retry(tmp_path):
    engine, db, case, _session, capture = make_context(tmp_path)
    try:
        projected = add_fragment(
            db, capture, ordinal=1, speaker="INTERROGATOR", text="你叫什么？", start_ms=0, end_ms=400
        )
        known_raw_only = add_fragment(
            db, capture, ordinal=2, speaker="SUSPECT", text="张某。", start_ms=500, end_ms=900
        )
        unknown_role_retry = add_fragment(
            db, capture, ordinal=3, speaker="UNKNOWN", text="我叫张某。", start_ms=1000, end_ms=1400
        )
        unknown_role_retry.speaker = "SUSPECT"
        asr_repo.mark_processed(
            db,
            fragment_id=projected.id,
            case_id=case.id,
            action="ROUND_OPEN",
        )
        asr_repo.mark_processed(
            db,
            fragment_id=known_raw_only.id,
            case_id=case.id,
            action="RAW_ONLY",
        )
        asr_repo.mark_processed(
            db,
            fragment_id=unknown_role_retry.id,
            case_id=case.id,
            action="RAW_ONLY",
        )
        db.commit()

        recovered = asr_repo.list_unassigned_for_session(db, case.id, "SESSION-QA")
        sessions = asr_repo.list_unassigned_session_pairs(db)

        assert [fragment.id for fragment in recovered] == [unknown_role_retry.id]
        assert sessions == [(case.id, "SESSION-QA")]
    finally:
        db.close()
        engine.dispose()


def test_orphan_suspect_answer_becomes_review_unit(tmp_path):
    engine, db, case, _session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db)
        answer = add_fragment(db, capture, ordinal=1, speaker="SUSPECT", text="我当时在家。", start_ms=0, end_ms=800)
        closed_ids = builder.consume_fragment(case.id, answer.id)
        assert len(closed_ids) == 1
        unit = qa_repo.get(db, closed_ids[0])
        assert unit.status == "NEEDS_REVIEW"
        assert unit.classification == "NEEDS_REVIEW"
        assert unit.reason_code == "ORPHAN_ANSWER"
        assert unit.raw_question_text == ""
        assert unit.raw_answer_text == "我当时在家。"
    finally:
        db.close()
        engine.dispose()


def test_late_suspect_answer_reopens_recent_closed_question_instead_of_orphaning(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db, late_answer_window_seconds=30.0)
        question = add_fragment(
            db,
            capture,
            ordinal=1,
            speaker="INTERROGATOR",
            text="呃这是行政案件权利义务告知书交给你阅读",
            start_ms=0,
            end_ms=800,
        )
        assert builder.consume_fragment(case.id, question.id) == []
        unit = qa_repo.active_for_session(db, case.id, session.id)
        assert unit is not None
        qa_repo.close(
            db,
            unit,
            raw_question_text=unit.raw_question_text,
            raw_answer_text="",
            ended_at=capture.started_at + timedelta(milliseconds=800),
        )
        db.commit()

        answer = add_fragment(
            db,
            capture,
            ordinal=2,
            speaker="SUSPECT",
            text="好的我认字",
            start_ms=1500,
            end_ms=2200,
        )
        assert builder.consume_fragment(case.id, answer.id) == []

        units = qa_repo.list_for_case(db, case.id)
        assert len(units) == 1
        assert units[0].id == unit.id
        assert units[0].status == "OPEN"
        assert units[0].raw_question_text == "呃这是行政案件权利义务告知书交给你阅读"
        assert units[0].raw_answer_text == "好的我认字"
        assert [link.role for link in units[0].fragments] == ["QUESTION", "ANSWER"]
    finally:
        db.close()
        engine.dispose()


def test_late_answer_outside_window_remains_orphan_review(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db, late_answer_window_seconds=3.0)
        question = add_fragment(
            db,
            capture,
            ordinal=1,
            speaker="INTERROGATOR",
            text="这是一个没有及时回答的问题？",
            start_ms=0,
            end_ms=800,
        )
        assert builder.consume_fragment(case.id, question.id) == []
        unit = qa_repo.active_for_session(db, case.id, session.id)
        assert unit is not None
        qa_repo.close(
            db,
            unit,
            raw_question_text=unit.raw_question_text,
            raw_answer_text="",
            ended_at=capture.started_at + timedelta(milliseconds=800),
        )
        db.commit()

        answer = add_fragment(
            db,
            capture,
            ordinal=2,
            speaker="SUSPECT",
            text="现在才回答。",
            start_ms=10000,
            end_ms=10700,
        )
        closed_ids = builder.consume_fragment(case.id, answer.id)

        assert len(closed_ids) == 1
        orphan = qa_repo.get(db, closed_ids[0])
        assert orphan.id != unit.id
        assert orphan.reason_code == "ORPHAN_ANSWER"
    finally:
        db.close()
        engine.dispose()


def test_idle_close_after_four_seconds(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db, idle_close_seconds=4.0)
        q = add_fragment(db, capture, ordinal=1, speaker="OFFICER_FALLBACK", text="你什么时候离开的？", start_ms=0, end_ms=500)
        a = add_fragment(db, capture, ordinal=2, speaker="SUSPECT", text="九点左右。", start_ms=700, end_ms=1200)
        builder.consume_fragment(case.id, q.id)
        builder.consume_fragment(case.id, a.id)
        now = capture.started_at + timedelta(milliseconds=1200, seconds=4.1)
        closed_ids = builder.close_idle(now=now)
        assert len(closed_ids) == 1
        assert qa_repo.get(db, closed_ids[0]).status == "CLOSED"
        assert qa_repo.active_for_session(db, case.id, session.id) is None
    finally:
        db.close()
        engine.dispose()


def test_fragment_processing_is_idempotent_and_flush_closes_active_unit(tmp_path):
    engine, db, case, session, capture = make_context(tmp_path)
    try:
        builder = QAUnitBuilder(db)
        q = add_fragment(db, capture, ordinal=1, speaker="INTERROGATOR", text="说一下经过", start_ms=0, end_ms=600)
        a = add_fragment(db, capture, ordinal=2, speaker="SUSPECT", text="我就过去看了一下。", start_ms=800, end_ms=1600)
        builder.consume_fragment(case.id, q.id)
        builder.consume_fragment(case.id, q.id)
        builder.consume_fragment(case.id, a.id)
        links = qa_repo.active_for_session(db, case.id, session.id).fragments
        assert [item.fragment_id for item in links].count(q.id) == 1
        closed_ids = builder.flush_session(case.id, session.id)
        assert len(closed_ids) == 1
        assert qa_repo.get(db, closed_ids[0]).raw_answer_text == "我就过去看了一下。"
    finally:
        db.close()
        engine.dispose()
