from __future__ import annotations

from dataclasses import dataclass

from app.services.formal_record_router import (
    FormalRecordRouteDecision,
    RouteClass,
    canonicalize_existing_target_decision,
)


@dataclass
class TargetQuestion:
    locked: bool
    source: str
    template_key: str | None = None


def decision(kind: RouteClass) -> FormalRecordRouteDecision:
    return FormalRecordRouteDecision(
        classification=kind,
        target_question_id="Q-1",
        formal_question="模型重复返回的已有问题文本",
        formal_answer="忠实整理后的完整回答",
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
