import json

from app.database.models import (
    AuditLog, Case, CaseQuestion, DocumentSnapshot, Fact, InterrogationSession, Message,
    MessageRevision, PendingQuestion, Person, QuestionRound, SignatureRecord, StandardQuestion, TimelineEvent,
)
from app.domain.enums import WorkflowState


def _iso(value):
    return value.isoformat() if value else None


def _json_list(value: str) -> list[str]:
    try:
        loaded = json.loads(value or "[]")
    except (TypeError, ValueError):
        return []
    return [str(item) for item in loaded] if isinstance(loaded, list) else []


def legacy_case_state(workflow_state: str) -> str:
    if workflow_state in {WorkflowState.QUESTIONING.value, WorkflowState.PAUSED.value}:
        return "INTERROGATING"
    if workflow_state in {WorkflowState.SUMMARY.value, WorkflowState.FROZEN.value, WorkflowState.SIGNED.value, WorkflowState.REPORT_GENERATED.value}:
        return "REVIEWING"
    return "DRAFT"


def case_dict(row: Case) -> dict:
    return {
        "id": row.id, "case_id": row.id, "operator_id": row.operator_id,
        "case_type": row.case_type, "suspectName": row.suspect_name, "gender": row.gender or "",
        "age": row.age or "", "officerName": row.officer_name,
        "state": legacy_case_state(row.workflow_state), "workflowState": row.workflow_state,
        "stage": row.stage, "status": "created" if row.workflow_state not in {"SUMMARY", "FROZEN", "SIGNED", "REPORT_GENERATED"} else "reviewing",
        "documentStatus": row.document_status, "reportStatus": row.report_status,
        "createdAt": _iso(row.created_at), "updatedAt": _iso(row.updated_at),
    }


def person_dict(row: Person) -> dict:
    return {
        "id": row.id, "caseId": row.case_id, "role": row.role, "name": row.name,
        "id_number": row.id_number, "idNumber": row.id_number, "gender": row.gender or "",
        "nation": row.nation or "", "birth_date": row.birth_date or "", "birthDate": row.birth_date or "",
        "address": row.address or "", "source": row.source,
    }


def session_dict(row: InterrogationSession | None, case: Case) -> dict:
    if row is None:
        return {
            "id": None, "session_id": None, "caseId": case.id, "case_id": case.id,
            "status": "READY", "state": case.workflow_state, "stage": case.stage,
            "startedAt": None, "pausedAt": None, "endedAt": None, "updatedAt": _iso(case.updated_at),
        }
    return {
        "id": row.id, "session_id": row.id, "caseId": row.case_id, "case_id": row.case_id,
        "status": row.status, "state": case.workflow_state, "stage": row.stage,
        "startedAt": _iso(row.started_at), "pausedAt": _iso(row.paused_at), "endedAt": _iso(row.ended_at),
        "updatedAt": _iso(row.updated_at),
    }


def message_dict(row: Message) -> dict:
    return {
        "id": row.id, "seq": row.seq, "speaker": row.speaker, "from": row.speaker,
        "text": row.text, "mark": row.mark or "", "confirmed": bool(row.confirmed),
        "version": row.current_version, "createdAt": _iso(row.created_at), "updatedAt": _iso(row.updated_at),
    }


def revision_dict(row: MessageRevision) -> dict:
    return {
        "id": row.id, "qaId": row.message_id, "messageId": row.message_id,
        "version": row.version, "oldText": row.old_text, "newText": row.new_text,
        "reason": row.reason or "", "actorId": row.actor_id, "createdAt": _iso(row.created_at),
    }


def fact_dict(row: Fact) -> dict:
    data = {"key": row.fact_key, "label": row.label, "value": row.value, "status": row.status}
    if row.suggestion is not None:
        data["suggestion"] = row.suggestion
    return data


def timeline_dict(row: TimelineEvent) -> dict:
    return {"id": row.id, "time": row.time_label, "title": row.title, "detail": row.detail, "evidence": json.loads(row.evidence_json or "[]")}


def audit_dict(row: AuditLog) -> dict:
    return {
        "id": row.id, "action": row.action, "targetType": row.target_type, "targetId": row.target_id,
        "actorId": row.actor_id, "before": json.loads(row.before_json or "{}"),
        "after": json.loads(row.after_json or "{}"), "detail": json.loads(row.detail_json or "{}"),
        "createdAt": _iso(row.created_at),
    }


def snapshot_dict(row: DocumentSnapshot) -> dict:
    return {"id": row.id, "caseId": row.case_id, "sessionId": row.session_id, "version": row.version,
            "status": row.status, "contentHash": row.content_hash, "createdAt": _iso(row.created_at)}


def signature_dict(row: SignatureRecord) -> dict:
    return {"id": row.id, "caseId": row.case_id, "sessionId": row.session_id, "snapshotId": row.snapshot_id,
            "signerRole": row.signer_role, "signerName": row.signer_name, "status": row.status,
            "createdAt": _iso(row.created_at)}


def standard_question_dict(row: StandardQuestion) -> dict:
    return {
        "id": row.id,
        "text": row.text,
        "category": row.category,
        "regexPatterns": _json_list(row.regex_patterns_json),
        "aliases": _json_list(row.aliases_json),
        "sortOrder": row.sort_order,
        "active": bool(row.active),
        "createdAt": _iso(row.created_at),
        "updatedAt": _iso(row.updated_at),
    }


def question_round_dict(row: QuestionRound) -> dict:
    return {
        "id": row.id,
        "caseId": row.case_id,
        "sessionId": row.session_id,
        "caseQuestionId": row.case_question_id,
        "roundNo": row.round_no,
        "actualQuestionText": row.actual_question_text,
        "officerFragmentId": row.officer_fragment_id,
        "answerText": row.answer_text,
        "answerFragmentIds": _json_list(row.answer_fragment_ids_json),
        "status": row.status,
        "startedAt": _iso(row.started_at),
        "endedAt": _iso(row.ended_at),
        "createdAt": _iso(row.created_at),
        "updatedAt": _iso(row.updated_at),
    }


def pending_question_dict(row: PendingQuestion) -> dict:
    return {
        "id": row.id,
        "caseId": row.case_id,
        "sessionId": row.session_id,
        "officerFragmentId": row.officer_fragment_id,
        "questionText": row.question_text,
        "matchStatus": row.match_status,
        "candidateQuestionIds": _json_list(row.candidate_question_ids_json),
        "bufferedAnswerText": row.buffered_answer_text,
        "bufferedFragmentIds": _json_list(row.buffered_fragment_ids_json),
        "status": row.status,
        "createdAt": _iso(row.created_at),
        "updatedAt": _iso(row.updated_at),
    }


def case_question_dict(row: CaseQuestion, *, rounds: list[QuestionRound] | None = None) -> dict:
    return {
        "id": row.id,
        "caseId": row.case_id,
        "source": row.source,
        "standardQuestionId": row.standard_question_id,
        "text": row.text,
        "regexPatterns": _json_list(row.regex_patterns_json),
        "aliases": _json_list(row.aliases_json),
        "sectionType": row.section_type or "BODY",
        "templateKey": row.template_key,
        "templateItemKey": row.template_item_key,
        "locked": bool(row.locked),
        "sortOrder": row.sort_order,
        "active": bool(row.active),
        "rounds": [question_round_dict(item) for item in (rounds or [])],
        "createdAt": _iso(row.created_at),
        "updatedAt": _iso(row.updated_at),
    }
