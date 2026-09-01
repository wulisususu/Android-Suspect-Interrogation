from __future__ import annotations

from dataclasses import dataclass

from app.services.formal_record_router import (
    FormalRecordRouteDecision,
    RouteClass,
    canonicalize_existing_target_decision,
    preserve_existing_answer_facts,
)


@dataclass
class TargetQuestion:
    locked: bool
    source: str
    template_key: str | None = None


def decision(kind: RouteClass, *, answer: str = "忠实整理后的完整回答") -> FormalRecordRouteDecision:
    return FormalRecordRouteDecision(
        classification=kind,
        target_question_id="Q-1",
        formal_question="模型重复返回的已有问题文本",
        formal_answer=answer,
        confidence=0.95,
        candidate_question_ids=("Q-1",),
        reason_code="MODEL_LABEL",
        model_id="qwen3:4b@rkllm-rk3588",
    )


def test_fixed_target_authoritatively_canonicalizes_route_class_and_question_text():
    normalized = canonicalize_existing_target_decision(
        decision(RouteClass.MATCH_EXISTING),
        TargetQuestion(locked=True, source="CASE", template_key="SUSPECT_INQUIRY_V1"),
    )

    assert normalized.classification is RouteClass.MATCH_FIXED
    assert normalized.target_question_id == "Q-1"
    assert normalized.formal_question is None
    assert normalized.formal_answer == "忠实整理后的完整回答"


def test_case_or_live_target_authoritatively_canonicalizes_route_class_and_question_text():
    for source in ("CASE", "LIVE"):
        normalized = canonicalize_existing_target_decision(
            decision(RouteClass.MATCH_FIXED),
            TargetQuestion(locked=False, source=source),
        )

        assert normalized.classification is RouteClass.MATCH_EXISTING
        assert normalized.target_question_id == "Q-1"
        assert normalized.formal_question is None
        assert normalized.formal_answer == "忠实整理后的完整回答"


def test_non_existing_route_classes_are_not_reinterpreted():
    original = FormalRecordRouteDecision(
        classification=RouteClass.NEEDS_REVIEW,
        target_question_id="Q-1",
        formal_question=None,
        formal_answer=None,
        confidence=0.55,
        candidate_question_ids=("Q-1",),
        reason_code="AMBIGUOUS",
        model_id="qwen3:4b@rkllm-rk3588",
    )

    assert canonicalize_existing_target_decision(
        original,
        TargetQuestion(locked=False, source="CASE"),
    ) == original


def test_existing_route_falls_back_to_raw_answer_when_model_drops_minute_precision():
    routed = decision(RouteClass.MATCH_EXISTING, answer="约20时到达现场。")

    safe = preserve_existing_answer_facts(routed, raw_answer="大概晚上八点十五分。")

    assert safe.classification is RouteClass.MATCH_EXISTING
    assert safe.target_question_id == "Q-1"
    assert safe.formal_answer == "大概晚上八点十五分。"
    assert safe.reason_code == "FACT_LOSS_RAW_FALLBACK"
    assert safe.model_id == routed.model_id


def test_existing_route_keeps_model_answer_when_equivalent_time_precision_is_preserved():
    routed = decision(RouteClass.MATCH_EXISTING, answer="约20时15分到达现场。")

    safe = preserve_existing_answer_facts(routed, raw_answer="大概晚上八点十五分。")

    assert safe.formal_answer == "约20时15分到达现场。"
    assert safe.reason_code == "MODEL_LABEL"


def test_existing_route_falls_back_when_explicit_arabic_quantity_is_lost():
    routed = decision(RouteClass.MATCH_EXISTING, answer="当时现场有几个人。")

    safe = preserve_existing_answer_facts(routed, raw_answer="当时现场有3个人。")

    assert safe.formal_answer == "当时现场有3个人。"
    assert safe.reason_code == "FACT_LOSS_RAW_FALLBACK"


def test_review_and_ignore_decisions_are_not_rewritten_by_fact_guard():
    for kind in (RouteClass.NEEDS_REVIEW, RouteClass.IGNORE):
        routed = FormalRecordRouteDecision(
            classification=kind,
            target_question_id=None,
            formal_question=None,
            formal_answer=None,
            confidence=0.5,
            candidate_question_ids=(),
            reason_code="UNCHANGED",
            model_id="qwen3:4b@rkllm-rk3588",
        )
        assert preserve_existing_answer_facts(routed, raw_answer="晚上八点十五分。") == routed
