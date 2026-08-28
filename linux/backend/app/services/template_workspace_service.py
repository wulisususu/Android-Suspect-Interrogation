from __future__ import annotations

import json

from sqlalchemy.orm import Session

from app.domain.errors import DomainError
from app.repositories import cases as case_repo
from app.repositories import question_rounds as round_repo
from app.repositories import template_questions as question_repo
from app.services.serializers import (
    case_question_dict,
    pending_question_dict,
    question_round_dict,
    standard_question_dict,
)


_ALLOWED_SOURCES = {"STANDARD", "CASE", "LIVE"}


def _clean_text(value: str, *, code: str = "EMPTY_QUESTION") -> str:
    clean = str(value or "").strip()
    if not clean:
        raise DomainError(code, "问题内容不能为空", 400)
    return clean


def _clean_list(values: list[str] | None) -> list[str]:
    result: list[str] = []
    for value in values or []:
        clean = str(value or "").strip()
        if clean and clean not in result:
            result.append(clean)
    return result


def _load_list(raw: str) -> list[str]:
    try:
        value = json.loads(raw or "[]")
    except (TypeError, ValueError):
        return []
    return [str(item) for item in value if str(item).strip()] if isinstance(value, list) else []


class TemplateWorkspaceService:
    def __init__(self, db: Session):
        self.db = db

    def workspace(self, case_id: str) -> dict:
        case_repo.get(self.db, case_id)
        rounds = round_repo.list_for_case(self.db, case_id)
        rounds_by_question: dict[str, list] = {}
        for row in rounds:
            rounds_by_question.setdefault(row.case_question_id, []).append(row)
        return {
            "caseId": case_id,
            "questions": [
                case_question_dict(row, rounds=rounds_by_question.get(row.id, []))
                for row in question_repo.list_case(self.db, case_id)
            ],
            "rounds": [question_round_dict(row) for row in rounds],
            "pendingQuestions": [
                pending_question_dict(row)
                for row in round_repo.list_pending_for_case(self.db, case_id)
            ],
        }

    def list_library(self, category: str | None = None) -> list[dict]:
        return [standard_question_dict(row) for row in question_repo.list_standard(self.db, category)]

    def add_case_question(
        self,
        case_id: str,
        *,
        text: str,
        source: str,
        standard_question_id: str | None = None,
        regex_patterns: list[str] | None = None,
        after_question_id: str | None = None,
    ) -> dict:
        case_repo.get(self.db, case_id)
        normalized_source = str(source or "").strip().upper()
        if normalized_source not in _ALLOWED_SOURCES:
            raise DomainError("INVALID_QUESTION_SOURCE", "无效的问题来源", 400)
        if standard_question_id is not None:
            question_repo.get_standard(self.db, standard_question_id)

        row = question_repo.create_case(
            self.db,
            case_id=case_id,
            source=normalized_source,
            text=_clean_text(text),
            standard_question_id=standard_question_id,
            regex_patterns_json=json.dumps(_clean_list(regex_patterns), ensure_ascii=False),
            aliases_json="[]",
        )

        if after_question_id is not None:
            rows = [item for item in question_repo.list_case(self.db, case_id) if item.id != row.id]
            after = next((item for item in rows if item.id == after_question_id), None)
            if after is None:
                raise DomainError("CASE_QUESTION_NOT_FOUND", "插入位置对应的问题不存在", 404)
            index = rows.index(after) + 1
            rows.insert(index, row)
            self._apply_order(rows)
        return case_question_dict(row, rounds=[])

    def update_case_question(
        self,
        case_id: str,
        question_id: str,
        *,
        text: str | None = None,
        regex_patterns: list[str] | None = None,
    ) -> dict:
        row = question_repo.get_case(self.db, case_id, question_id)
        if text is not None:
            clean = _clean_text(text)
            if clean != row.text:
                aliases = _load_list(row.aliases_json)
                if row.text not in aliases:
                    aliases.append(row.text)
                aliases = [alias for alias in aliases if alias != clean]
                row.aliases_json = json.dumps(aliases, ensure_ascii=False)
                row.text = clean
        if regex_patterns is not None:
            row.regex_patterns_json = json.dumps(_clean_list(regex_patterns), ensure_ascii=False)
        self.db.flush()
        return case_question_dict(row, rounds=round_repo.list_for_question(self.db, case_id, row.id))

    def reorder(self, case_id: str, ordered_ids: list[str]) -> list[dict]:
        case_repo.get(self.db, case_id)
        rows = question_repo.list_case(self.db, case_id)
        expected = {row.id for row in rows}
        supplied = [str(value) for value in ordered_ids]
        if len(supplied) != len(set(supplied)) or set(supplied) != expected:
            raise DomainError("INVALID_QUESTION_ORDER", "问题排序必须包含本案全部问题且不能重复", 400)
        by_id = {row.id: row for row in rows}
        ordered = [by_id[row_id] for row_id in supplied]
        self._apply_order(ordered)
        return [case_question_dict(row, rounds=round_repo.list_for_question(self.db, case_id, row.id)) for row in ordered]

    def save_to_library(self, case_id: str, question_id: str, category: str) -> dict:
        row = question_repo.get_case(self.db, case_id, question_id)
        standard = question_repo.create_standard(
            self.db,
            text=row.text,
            category=str(category or "通用").strip() or "通用",
            regex_patterns_json=row.regex_patterns_json or "[]",
            aliases_json=row.aliases_json or "[]",
        )
        row.standard_question_id = standard.id
        self.db.flush()
        return standard_question_dict(standard)

    def _apply_order(self, rows: list) -> None:
        for index, row in enumerate(rows, start=1):
            row.sort_order = -(index * 10)
        self.db.flush()
        for index, row in enumerate(rows, start=1):
            row.sort_order = index * 10
        self.db.flush()
