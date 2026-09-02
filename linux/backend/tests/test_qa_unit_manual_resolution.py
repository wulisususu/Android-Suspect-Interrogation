from __future__ import annotations

from datetime import datetime, timedelta, timezone

from fastapi.testclient import TestClient
from sqlalchemy import func, select

from app.database.models import CaseQuestion, InterrogationSession, QuestionRound
from app.hardware_gateway.mock import MockHardwareGateway
from app.main import create_app
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo


def payload(response):
    body = response.json()
    assert response.status_code == 200, body
    assert body["ok"] is True, body
    return body["data"]


def as_utc(value: datetime) -> datetime:
    if value.tzinfo is None:
        return value.replace(tzinfo=timezone.utc)
    return value.astimezone(timezone.utc)


def create_case(client: TestClient, suffix: str = "A") -> str:
    return payload(
        client.post(
            "/api/v1/cases",
            json={
                "operator_id": f"op-{suffix}",
                "suspectName": f"测试对象{suffix}",
                "officerName": "测试警官",
            },
        )
    )["id"]


def create_question(client: TestClient, case_id: str, text: str = "你几点到现场？") -> dict:
    return payload(
        client.post(
            f"/api/v1/cases/{case_id}/questions",
            json={"text": text, "source": "CASE", "regexPatterns": []},
        )
    )


def seed_review_unit(
    app,
    case_id: str,
    *,
    unit_id: str,
    raw_question: str | None = "你后来又回去了吗？",
    raw_answer: str | None = "回去拿了手机。",
    suggested_question: str | None = "你离开后是否再次返回现场？",
    suggested_answer: str | None = "离开后返回过一次，原因是取手机。",
    started_offset_ms: int = 2000,
):
    with app.state.session_factory() as db:
        session = db.scalar(
            select(InterrogationSession)
            .where(InterrogationSession.case_id == case_id)
            .order_by(InterrogationSession.created_at.desc())
            .limit(1)
        )
        if session is None:
            session = InterrogationSession(
                id=f"SESSION-{unit_id}",
                case_id=case_id,
                status="RUNNING",
                stage="QUESTIONING",
            )
            db.add(session)
            db.flush()
        capture = asr_repo.create_capture_session(
            db,
            case_id=case_id,
            interrogation_session_id=session.id,
            sample_rate=16000,
        )
        capture.started_at = datetime(2026, 9, 1, 8, 0, tzinfo=timezone.utc)
        db.flush()
        unit = qa_repo.create_open(
            db,
            case_id=case_id,
            session_id=session.id,
            started_at=capture.started_at + timedelta(milliseconds=started_offset_ms),
        )
        unit.id = unit_id
        position = 1
        question_fragment_id = None
        answer_fragment_id = None
        if raw_question is not None:
            q = asr_repo.create_fragment(
                db,
                capture_session_id=capture.id,
                case_id=case_id,
                ordinal=1,
                started_at_ms=started_offset_ms,
                ended_at_ms=started_offset_ms + 500,
                raw_text=raw_question,
                speaker="INTERROGATOR",
                speaker_source="MANUAL",
                voiceprint_verified=True,
                low_confidence=False,
                model_id="test-asr",
            )
            qa_repo.append_fragment(db, unit, fragment_id=q.id, role="QUESTION", position=position)
            question_fragment_id = q.id
            position += 1
        if raw_answer is not None:
            a = asr_repo.create_fragment(
                db,
                capture_session_id=capture.id,
                case_id=case_id,
                ordinal=2,
                started_at_ms=started_offset_ms + 700,
                ended_at_ms=started_offset_ms + 1400,
                raw_text=raw_answer,
                speaker="SUSPECT",
                speaker_source="MANUAL",
                voiceprint_verified=True,
                low_confidence=False,
                model_id="test-asr",
            )
            qa_repo.append_fragment(db, unit, fragment_id=a.id, role="ANSWER", position=position)
            answer_fragment_id = a.id
        qa_repo.close(
            db,
            unit,
            raw_question_text=raw_question or "",
            raw_answer_text=raw_answer or "",
            ended_at=capture.started_at + timedelta(milliseconds=started_offset_ms + 1400),
        )
        qa_repo.save_decision(
            db,
            unit,
            classification="NEEDS_REVIEW",
            target_question_id=None,
            formal_question_text=suggested_question,
            formal_answer_text=suggested_answer,
            confidence=0.55,
            model_id="qwen3-4b-test",
            reason_code="AMBIGUOUS",
            status="NEEDS_REVIEW",
            candidate_question_ids=[],
        )
        db.commit()
        return {
            "unitId": unit.id,
            "sessionId": session.id,
            "questionFragmentId": question_fragment_id,
            "answerFragmentId": answer_fragment_id,
            "startedAt": unit.started_at,
            "rawQuestion": unit.raw_question_text,
            "rawAnswer": unit.raw_answer_text,
        }


def make_app(tmp_path):
    return create_app(
        database_url=f"sqlite:///{tmp_path / 'qa-manual-resolution.db'}",
        hardware_gateway=MockHardwareGateway(simulated=True),
    )


def test_create_live_uses_formal_copy_but_preserves_real_raw_provenance(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        seeded = seed_review_unit(app, case_id, unit_id="QA-CREATE-LIVE")

        result = payload(
            client.post(
                f"/api/v1/cases/{case_id}/qa-units/{seeded['unitId']}/resolve",
                json={
                    "action": "CREATE_LIVE",
                    "formalQuestion": "你离开现场后是否再次返回？",
                    "formalAnswer": "离开后返回过一次，是为了取手机。",
                },
            )
        )

        assert result["status"] == "APPLIED"
        target_id = result["targetQuestionId"]
        with app.state.session_factory() as db:
            question = db.get(CaseQuestion, target_id)
            assert question is not None
            assert question.source == "LIVE"
            assert question.text == "你离开现场后是否再次返回？"
            assert question.formal_answer_text == "离开后返回过一次，是为了取手机。"
            round_row = db.scalar(select(QuestionRound).where(QuestionRound.case_question_id == target_id))
            assert round_row is not None
            assert round_row.actual_question_text == seeded["rawQuestion"]
            assert round_row.officer_fragment_id == seeded["questionFragmentId"]
            assert round_row.answer_text == seeded["rawAnswer"]
            assert seeded["answerFragmentId"] in round_row.answer_fragment_ids_json
            unit = qa_repo.get(db, seeded["unitId"])
            assert unit.raw_question_text == seeded["rawQuestion"]
            assert unit.raw_answer_text == seeded["rawAnswer"]


def test_create_live_defaults_to_stored_review_suggestion_then_raw_provenance(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        seeded = seed_review_unit(
            app,
            case_id,
            unit_id="QA-CREATE-DEFAULT",
            suggested_question="你离开后是否再次返回现场？",
            suggested_answer="返回过一次，原因是取手机。",
        )

        result = payload(
            client.post(
                f"/api/v1/cases/{case_id}/qa-units/{seeded['unitId']}/resolve",
                json={"action": "CREATE_LIVE"},
            )
        )
        with app.state.session_factory() as db:
            question = db.get(CaseQuestion, result["targetQuestionId"])
            assert question.text == "你离开后是否再次返回现场？"
            assert question.formal_answer_text == "返回过一次，原因是取手机。"
            round_row = db.scalar(select(QuestionRound).where(QuestionRound.case_question_id == question.id))
            assert round_row.actual_question_text == seeded["rawQuestion"]
            assert round_row.answer_text == seeded["rawAnswer"]


def test_link_qa_creates_real_provenance_round_updates_canonical_answer_and_order(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        target = create_question(client, case_id)
        seeded = seed_review_unit(
            app,
            case_id,
            unit_id="QA-LINK-QA",
            raw_question="你几点到的？",
            raw_answer="八点左右。",
            started_offset_ms=3500,
        )

        result = payload(
            client.post(
                f"/api/v1/cases/{case_id}/qa-units/{seeded['unitId']}/resolve",
                json={
                    "action": "LINK_QA",
                    "caseQuestionId": target["id"],
                    "formalAnswer": "八点左右到达现场。",
                },
            )
        )
        assert result["targetQuestionId"] == target["id"]
        with app.state.session_factory() as db:
            question = db.get(CaseQuestion, target["id"])
            assert question.formal_answer_text == "八点左右到达现场。"
            assert as_utc(question.first_asked_at) == as_utc(seeded["startedAt"])
            round_row = db.scalar(select(QuestionRound).where(QuestionRound.case_question_id == target["id"]))
            assert round_row.actual_question_text == "你几点到的？"
            assert round_row.officer_fragment_id == seeded["questionFragmentId"]
            assert round_row.answer_text == "八点左右。"
            assert as_utc(round_row.started_at) == as_utc(seeded["startedAt"])


def test_link_answer_has_answer_only_provenance_and_does_not_fabricate_question(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        target = create_question(client, case_id, "你当时在哪里？")
        seeded = seed_review_unit(
            app,
            case_id,
            unit_id="QA-LINK-ANSWER",
            raw_question=None,
            raw_answer="我当时在家。",
            suggested_question=None,
            suggested_answer="当时在家中。",
        )

        result = payload(
            client.post(
                f"/api/v1/cases/{case_id}/qa-units/{seeded['unitId']}/resolve",
                json={"action": "LINK_ANSWER", "caseQuestionId": target["id"]},
            )
        )
        assert result["status"] == "APPLIED"
        with app.state.session_factory() as db:
            question = db.get(CaseQuestion, target["id"])
            assert question.formal_answer_text == "当时在家中。"
            round_row = db.scalar(select(QuestionRound).where(QuestionRound.case_question_id == target["id"]))
            assert round_row is not None
            assert round_row.actual_question_text == ""
            assert round_row.officer_fragment_id is None
            assert round_row.answer_text == "我当时在家。"
            assert seeded["answerFragmentId"] in round_row.answer_fragment_ids_json
            unit = qa_repo.get(db, seeded["unitId"])
            assert unit.raw_question_text == ""
            assert unit.raw_answer_text == "我当时在家。"


def test_ignore_resolves_review_without_formal_mutation(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        create_question(client, case_id)
        seeded = seed_review_unit(app, case_id, unit_id="QA-IGNORE")
        with app.state.session_factory() as db:
            question_count = db.scalar(select(func.count()).select_from(CaseQuestion))
            round_count = db.scalar(select(func.count()).select_from(QuestionRound))

        result = payload(
            client.post(
                f"/api/v1/cases/{case_id}/qa-units/{seeded['unitId']}/resolve",
                json={"action": "IGNORE"},
            )
        )
        assert result["status"] == "IGNORED"
        with app.state.session_factory() as db:
            assert db.scalar(select(func.count()).select_from(CaseQuestion)) == question_count
            assert db.scalar(select(func.count()).select_from(QuestionRound)) == round_count


def test_resolved_or_ignored_unit_cannot_be_resolved_twice(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        target = create_question(client, case_id)
        applied = seed_review_unit(app, case_id, unit_id="QA-ONCE-APPLIED")
        first = client.post(
            f"/api/v1/cases/{case_id}/qa-units/{applied['unitId']}/resolve",
            json={"action": "LINK_QA", "caseQuestionId": target["id"]},
        )
        assert first.status_code == 200
        second = client.post(
            f"/api/v1/cases/{case_id}/qa-units/{applied['unitId']}/resolve",
            json={"action": "IGNORE"},
        )
        assert second.status_code == 409

        ignored = seed_review_unit(app, case_id, unit_id="QA-ONCE-IGNORED", started_offset_ms=8000)
        assert client.post(
            f"/api/v1/cases/{case_id}/qa-units/{ignored['unitId']}/resolve",
            json={"action": "IGNORE"},
        ).status_code == 200
        repeated = client.post(
            f"/api/v1/cases/{case_id}/qa-units/{ignored['unitId']}/resolve",
            json={"action": "IGNORE"},
        )
        assert repeated.status_code == 409


def test_unit_from_another_case_is_404(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_a = create_case(client, "A")
        case_b = create_case(client, "B")
        seeded = seed_review_unit(app, case_a, unit_id="QA-CROSS-CASE")
        response = client.post(
            f"/api/v1/cases/{case_b}/qa-units/{seeded['unitId']}/resolve",
            json={"action": "IGNORE"},
        )
        assert response.status_code == 404


def test_frozen_record_blocks_manual_formal_mutation_but_fixed_question_text_is_preserved(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        ensured = payload(client.post(f"/api/v1/cases/{case_id}/formal-record/ensure"))
        fixed = next(item for item in ensured["questions"] if item["locked"])
        original_text = fixed["text"]
        seeded = seed_review_unit(app, case_id, unit_id="QA-FIXED-LINK")

        linked = payload(
            client.post(
                f"/api/v1/cases/{case_id}/qa-units/{seeded['unitId']}/resolve",
                json={
                    "action": "LINK_QA",
                    "caseQuestionId": fixed["id"],
                    "formalAnswer": "已听清并理解。",
                },
            )
        )
        assert linked["status"] == "APPLIED"
        with app.state.session_factory() as db:
            assert db.get(CaseQuestion, fixed["id"]).text == original_text

        frozen = seed_review_unit(app, case_id, unit_id="QA-FROZEN", started_offset_ms=12000)
        with app.state.session_factory() as db:
            case = db.get(__import__("app.database.models", fromlist=["Case"]).Case, case_id)
            case.workflow_state = "FROZEN"
            db.commit()
        response = client.post(
            f"/api/v1/cases/{case_id}/qa-units/{frozen['unitId']}/resolve",
            json={"action": "CREATE_LIVE"},
        )
        assert response.status_code == 409


def test_create_live_requires_real_officer_fragment_and_link_answer_requires_real_answer_fragment(tmp_path):
    app = make_app(tmp_path)
    with TestClient(app) as client:
        case_id = create_case(client)
        target = create_question(client, case_id)
        orphan_answer = seed_review_unit(
            app,
            case_id,
            unit_id="QA-NO-OFFICER",
            raw_question=None,
            raw_answer="我在家。",
        )
        create_response = client.post(
            f"/api/v1/cases/{case_id}/qa-units/{orphan_answer['unitId']}/resolve",
            json={"action": "CREATE_LIVE", "formalQuestion": "你在哪里？"},
        )
        assert create_response.status_code == 400

        question_only = seed_review_unit(
            app,
            case_id,
            unit_id="QA-NO-ANSWER",
            raw_question="你在哪里？",
            raw_answer=None,
            suggested_answer=None,
            started_offset_ms=9000,
        )
        answer_response = client.post(
            f"/api/v1/cases/{case_id}/qa-units/{question_only['unitId']}/resolve",
            json={"action": "LINK_ANSWER", "caseQuestionId": target["id"], "formalAnswer": "在家。"},
        )
        assert answer_response.status_code == 400
