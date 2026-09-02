from __future__ import annotations

from dataclasses import dataclass

from app.services.formal_record_router import (
    FormalRecordRouteDecision,
    RouteClass,
    canonicalize_existing_target_decision,
    precheck_routing_decision,
    preserve_existing_answer_facts,
    repair_existing_target_intent_mismatch,
)


@dataclass
class TargetQuestion:
    locked: bool
    source: str
    template_key: str | None = None
    text: str = ""


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


def test_operational_chatter_is_ignored_before_model_routing():
    prechecked = precheck_routing_decision(
        raw_question="声音大一点。",
        recent_target_ids=(),
    )

    assert prechecked is not None
    assert prechecked.classification is RouteClass.IGNORE
    assert prechecked.target_question_id is None
    assert prechecked.formal_question is None
    assert prechecked.formal_answer is None
    assert prechecked.confidence == 1.0
    assert prechecked.reason_code == "OPERATIONAL_CHATTER_PRECHECK"
    assert prechecked.model_id is None


def test_deictic_time_reference_with_multiple_recent_targets_requires_review_before_model():
    prechecked = precheck_routing_decision(
        raw_question="那个时间你再说准确一点。",
        recent_target_ids=("case-time", "case-leave", "case-time"),
    )

    assert prechecked is not None
    assert prechecked.classification is RouteClass.NEEDS_REVIEW
    assert prechecked.target_question_id is None
    assert prechecked.formal_question is None
    assert prechecked.formal_answer is None
    assert prechecked.candidate_question_ids == ("case-time", "case-leave")
    assert prechecked.reason_code == "AMBIGUOUS_REFERENCE_PRECHECK"
    assert prechecked.model_id is None


def test_deictic_reference_with_only_one_recent_target_does_not_force_review():
    assert precheck_routing_decision(
        raw_question="那个时间你再说准确一点。",
        recent_target_ids=("case-time", "case-time"),
    ) is None


def test_non_operational_substantive_question_is_not_short_circuited():
    assert precheck_routing_decision(
        raw_question="你离开以后有没有又回来？",
        recent_target_ids=(),
    ) is None


def test_existing_time_target_is_rejected_when_real_spoken_question_is_not_asking_time():
    routed = decision(RouteClass.MATCH_EXISTING, answer="回来过一次，手机落里面了。")
    target = TargetQuestion(
        locked=False,
        source="CASE",
        text="你什么时候离开现场？",
    )

    repaired = repair_existing_target_intent_mismatch(
        routed,
        target,
        raw_question="你离开以后有没有又回来？",
        raw_answer="回来过一次，手机落里面了。",
    )

    assert repaired.classification is RouteClass.CREATE_LIVE_FROM_SPEECH
    assert repaired.target_question_id is None
    assert repaired.formal_question == "你离开以后有没有又回来？"
    assert repaired.formal_answer == "回来过一次，手机落里面了。"
    assert repaired.candidate_question_ids == ()
    assert repaired.reason_code == "TARGET_INTENT_MISMATCH_CREATE_LIVE"
    assert repaired.model_id == routed.model_id


def test_existing_time_target_is_kept_when_real_question_also_asks_time():
    routed = decision(RouteClass.MATCH_EXISTING, answer="约20时15分到达现场。")
    target = TargetQuestion(
        locked=False,
        source="CASE",
        text="你什么时候到现场？",
    )

    assert repair_existing_target_intent_mismatch(
        routed,
        target,
        raw_question="那你准确几点到现场的？",
        raw_answer="大概晚上八点十五分。",
    ) == routed
