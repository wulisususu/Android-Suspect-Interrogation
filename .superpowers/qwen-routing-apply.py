# commit: test: cover qwen formal routing end to end
from __future__ import annotations

from pathlib import Path


def replace_once(path: str, old: str, new: str) -> None:
    target = Path(path)
    text = target.read_text(encoding="utf-8")
    if old not in text:
        raise SystemExit(f"expected source block missing in {path}: {old[:180]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


coordinator = "linux/backend/app/services/qa_routing_coordinator.py"
replace_once(
    coordinator,
    "PublishEvent = Callable[[str, str, dict[str, Any]], None]\n",
    "PublishEvent = Callable[[str, str, dict[str, Any]], None]\nRouterFactory = Callable[[Any, Any], Any]\n",
)
replace_once(
    coordinator,
    "        queue_size: int = 256,\n    ) -> None:\n",
    "        queue_size: int = 256,\n        router_factory: RouterFactory | None = None,\n    ) -> None:\n",
)
replace_once(
    coordinator,
    "        self.publish_event = publish_event\n        self.idle_close_seconds = max(0.01, float(idle_close_seconds))\n",
    "        self.publish_event = publish_event\n        # Injection is intentionally limited to semantic classification. The\n        # deterministic write service remains production-owned, so tests can\n        # drive A/B/C/D/E without granting a fake router database write access.\n        self.router_factory = router_factory or (lambda db, ai: FormalRecordRouter(db, ai_supervisor=ai))\n        self.idle_close_seconds = max(0.01, float(idle_close_seconds))\n",
)
replace_once(
    coordinator,
    "                decision = FormalRecordRouter(db, ai_supervisor=self.ai_supervisor).route(unit.id)\n",
    "                decision = self.router_factory(db, self.ai_supervisor).route(unit.id)\n",
)

projection = "linux/backend/app/services/interrogation_projection_service.py"
replace_once(
    projection,
    "class InterrogationProjectionService:\n    def __init__(self, db: Session):\n",
    "class InterrogationProjectionService:\n    \"\"\"Legacy deterministic regex projection compatibility path.\n\n    Production ASR capture reaches this service only when\n    ``formal_routing_mode == 'legacy'`` (AsrCaptureService has no Qwen fragment\n    sink). The explicit ``/speech-fragments/{id}/process`` API also keeps this\n    path available for rollback/manual compatibility. Qwen mode must not invoke\n    it in parallel with QARoutingCoordinator, otherwise one raw fragment could\n    produce two formal projections.\n    \"\"\"\n\n    def __init__(self, db: Session):\n",
)

# Strengthen the E2E wait condition and commit-visibility assertion while adding
# the injectable seam that made the RED test fail.
test_e2e = "linux/backend/tests/test_qwen_formal_routing_e2e.py"
replace_once(
    test_e2e,
    "                assert unit.target_question_id == payload[\"targetQuestionId\"]\n                assert CaseQuestion.__table__.c.formal_answer_text is not None\n",
    "                assert unit.target_question_id == payload[\"targetQuestionId\"]\n                question = db.get(CaseQuestion, payload[\"targetQuestionId\"])\n                assert question is not None and question.formal_answer_text\n",
)
replace_once(
    test_e2e,
    "                rows = qa_repo.list_for_case(db, case_id)\n                return len(rows) == 6 and all(row.status != \"OPEN\" for row in rows)\n",
    "                rows = qa_repo.list_for_case(db, case_id)\n                terminal = {\"APPLIED\", \"NEEDS_REVIEW\", \"IGNORED\"}\n                return len(rows) == 6 and all(row.status in terminal for row in rows)\n",
)

# Keep the manual fragment process endpoint as an explicit rollback contract.
workspace_test = "linux/backend/tests/test_template_workspace_api.py"
replace_once(
    workspace_test,
    "    with TestClient(app) as client:\n        case_id = create_case(client)\n        first = payload(\n",
    "    with TestClient(app) as client:\n        # This endpoint intentionally remains even after Qwen routing is added:\n        # operators/releases can use it as the explicit legacy/manual fallback.\n        assert \"/api/v1/cases/{case_id}/speech-fragments/{fragment_id}/process\" in app.openapi()[\"paths\"]\n        case_id = create_case(client)\n        first = payload(\n",
)
