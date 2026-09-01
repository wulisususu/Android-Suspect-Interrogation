from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def read(path: str) -> str:
    return (ROOT / path).read_text(encoding="utf-8")


def write(path: str, content: str) -> None:
    target = ROOT / path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content, encoding="utf-8")


def replace_once(path: str, old: str, new: str) -> None:
    text = read(path)
    count = text.count(old)
    if count != 1:
        raise RuntimeError(f"{path}: expected one anchor, found {count}: {old[:80]!r}")
    write(path, text.replace(old, new, 1))


# SQLAlchemy model extension: existing rows remain BODY; fixed sections are explicit and versioned.
replace_once(
    "linux/backend/app/database/models.py",
    '''    text: Mapped[str] = mapped_column(Text, nullable=False)\n    regex_patterns_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)\n    aliases_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)\n    sort_order: Mapped[int] = mapped_column(Integer, nullable=False)\n    active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)\n\n\nclass QuestionRound''',
    '''    text: Mapped[str] = mapped_column(Text, nullable=False)\n    regex_patterns_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)\n    aliases_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)\n    section_type: Mapped[str] = mapped_column(String(16), default="BODY", nullable=False, index=True)\n    template_key: Mapped[str | None] = mapped_column(String(64), nullable=True, index=True)\n    template_item_key: Mapped[str | None] = mapped_column(String(64), nullable=True)\n    locked: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)\n    sort_order: Mapped[int] = mapped_column(Integer, nullable=False)\n    active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)\n\n\nclass QuestionRound''',
)

write(
    "linux/backend/alembic/versions/0007_formal_record_sections.py",
    '''"""Add formal interrogation record sections and versioned fixed template metadata.\n\nRevision ID: 0007_formal_record_sections\nRevises: 0006_asr_recognition_evidence\n"""\n\nfrom alembic import op\nimport sqlalchemy as sa\n\nrevision = "0007_formal_record_sections"\ndown_revision = "0006_asr_recognition_evidence"\nbranch_labels = None\ndepends_on = None\n\n\ndef upgrade() -> None:\n    op.add_column("case_questions", sa.Column("section_type", sa.String(length=16), nullable=False, server_default="BODY"))\n    op.add_column("case_questions", sa.Column("template_key", sa.String(length=64), nullable=True))\n    op.add_column("case_questions", sa.Column("template_item_key", sa.String(length=64), nullable=True))\n    op.add_column("case_questions", sa.Column("locked", sa.Boolean(), nullable=False, server_default=sa.false()))\n    op.create_index("ix_case_questions_section_type", "case_questions", ["section_type"], unique=False)\n    op.create_index("ix_case_questions_template_key", "case_questions", ["template_key"], unique=False)\n\n\ndef downgrade() -> None:\n    op.drop_index("ix_case_questions_template_key", table_name="case_questions")\n    op.drop_index("ix_case_questions_section_type", table_name="case_questions")\n    op.drop_column("case_questions", "locked")\n    op.drop_column("case_questions", "template_item_key")\n    op.drop_column("case_questions", "template_key")\n    op.drop_column("case_questions", "section_type")\n''',
)

write(
    "linux/backend/app/repositories/template_questions.py",
    '''from __future__ import annotations\n\nfrom uuid import uuid4\n\nfrom sqlalchemy import func, select\nfrom sqlalchemy.orm import Session\n\nfrom app.database.models import CaseQuestion, StandardQuestion\nfrom app.domain.errors import DomainError\n\n\ndef list_standard(db: Session, category: str | None = None) -> list[StandardQuestion]:\n    stmt = select(StandardQuestion).where(StandardQuestion.active.is_(True))\n    if category:\n        stmt = stmt.where(StandardQuestion.category == category)\n    stmt = stmt.order_by(StandardQuestion.sort_order.asc(), StandardQuestion.created_at.asc())\n    return list(db.scalars(stmt))\n\n\ndef get_standard(db: Session, question_id: str) -> StandardQuestion:\n    row = db.get(StandardQuestion, question_id)\n    if row is None or not row.active:\n        raise DomainError("STANDARD_QUESTION_NOT_FOUND", "标准问题不存在", 404)\n    return row\n\n\ndef next_standard_sort_order(db: Session) -> int:\n    current = db.scalar(select(func.coalesce(func.max(StandardQuestion.sort_order), 0))) or 0\n    return int(current) + 10\n\n\ndef create_standard(db: Session, *, text: str, category: str, regex_patterns_json: str, aliases_json: str) -> StandardQuestion:\n    row = StandardQuestion(\n        id=str(uuid4()), text=text, category=category, regex_patterns_json=regex_patterns_json,\n        aliases_json=aliases_json, sort_order=next_standard_sort_order(db), active=True,\n    )\n    db.add(row)\n    db.flush()\n    return row\n\n\ndef list_case(db: Session, case_id: str) -> list[CaseQuestion]:\n    stmt = (\n        select(CaseQuestion)\n        .where(CaseQuestion.case_id == case_id, CaseQuestion.active.is_(True))\n        .order_by(CaseQuestion.sort_order.asc(), CaseQuestion.created_at.asc())\n    )\n    return list(db.scalars(stmt))\n\n\ndef get_case(db: Session, case_id: str, question_id: str) -> CaseQuestion:\n    row = db.scalar(select(CaseQuestion).where(\n        CaseQuestion.id == question_id, CaseQuestion.case_id == case_id, CaseQuestion.active.is_(True),\n    ))\n    if row is None:\n        raise DomainError("CASE_QUESTION_NOT_FOUND", "本案问题不存在", 404)\n    return row\n\n\ndef next_case_sort_order(db: Session, case_id: str) -> int:\n    current = db.scalar(select(func.coalesce(func.max(CaseQuestion.sort_order), 0)).where(CaseQuestion.case_id == case_id)) or 0\n    return int(current) + 10\n\n\ndef create_case(\n    db: Session, *, case_id: str, source: str, text: str, standard_question_id: str | None,\n    regex_patterns_json: str, aliases_json: str, section_type: str = "BODY",\n    template_key: str | None = None, template_item_key: str | None = None, locked: bool = False,\n) -> CaseQuestion:\n    row = CaseQuestion(\n        id=str(uuid4()), case_id=case_id, source=source, standard_question_id=standard_question_id, text=text,\n        regex_patterns_json=regex_patterns_json, aliases_json=aliases_json, section_type=section_type,\n        template_key=template_key, template_item_key=template_item_key, locked=locked,\n        sort_order=next_case_sort_order(db, case_id), active=True,\n    )\n    db.add(row)\n    db.flush()\n    return row\n''',
)

write(
    "linux/backend/app/services/template_workspace_service.py",
    '''from __future__ import annotations\n\nimport json\n\nfrom sqlalchemy.orm import Session\n\nfrom app.domain.errors import DomainError\nfrom app.repositories import cases as case_repo\nfrom app.repositories import question_rounds as round_repo\nfrom app.repositories import template_questions as question_repo\nfrom app.services.serializers import case_question_dict, pending_question_dict, question_round_dict, standard_question_dict\n\n_ALLOWED_SOURCES = {"STANDARD", "CASE", "LIVE"}\n_SECTION_RANK = {"OPENING": 0, "BODY": 1, "CLOSING": 2}\n\n# Wording is transcribed from the supplied Nantong Chongchuan inquiry-record samples.\n# The key is versioned so later legal/template changes never rewrite frozen historical records.\n_FORMAL_RECORD_TEMPLATES = {\n    "SUSPECT_INQUIRY_V1": {\n        "OPENING": [\n            ("opening-rights", "我们是南通市公安局崇川分局的民警，现依法对你进行询问，根据有关法律规定，对我们的提问你应当如实回答，对与本案无关的问题，你有拒绝回答的权利。听清楚没有？"),\n            ("opening-reason", "你因何事来公安机关？"),\n            ("opening-notice", "这是《行政案件权利义务告知书》，交给你阅读。如果你不识字，我们可以向你宣读。"),\n            ("opening-notice-confirm", "你看清楚了吗？有什么要求？"),\n            ("opening-recusal", "你是否申请回避？"),\n            ("opening-basic-info", "你的基本情况？"),\n        ],\n        "CLOSING": [\n            ("closing-supplement", "你还有什么要补充的？"),\n            ("closing-truth", "你以上说的是否属实？"),\n            ("closing-review-sign", "以上笔录你仔细阅看，若无误则签字捺印？"),\n        ],\n    },\n}\n\n\ndef _clean_text(value: str, *, code: str = "EMPTY_QUESTION") -> str:\n    clean = str(value or "").strip()\n    if not clean:\n        raise DomainError(code, "问题内容不能为空", 400)\n    return clean\n\n\ndef _clean_list(values: list[str] | None) -> list[str]:\n    result: list[str] = []\n    for value in values or []:\n        clean = str(value or "").strip()\n        if clean and clean not in result:\n            result.append(clean)\n    return result\n\n\ndef _load_list(raw: str) -> list[str]:\n    try:\n        value = json.loads(raw or "[]")\n    except (TypeError, ValueError):\n        return []\n    return [str(item) for item in value if str(item).strip()] if isinstance(value, list) else []\n\n\nclass TemplateWorkspaceService:\n    def __init__(self, db: Session):\n        self.db = db\n\n    def workspace(self, case_id: str) -> dict:\n        case_repo.get(self.db, case_id)\n        rows = question_repo.list_case(self.db, case_id)\n        rounds = round_repo.list_for_case(self.db, case_id)\n        rounds_by_question: dict[str, list] = {}\n        for row in rounds:\n            rounds_by_question.setdefault(row.case_question_id, []).append(row)\n        template_key = next((row.template_key for row in rows if row.template_key), None)\n        return {\n            "caseId": case_id,\n            "templateKey": template_key,\n            "questions": [case_question_dict(row, rounds=rounds_by_question.get(row.id, [])) for row in rows],\n            "rounds": [question_round_dict(row) for row in rounds],\n            "pendingQuestions": [pending_question_dict(row) for row in round_repo.list_pending_for_case(self.db, case_id)],\n        }\n\n    def ensure_formal_record(self, case_id: str, *, template_key: str = "SUSPECT_INQUIRY_V1") -> dict:\n        case_repo.get(self.db, case_id)\n        template = _FORMAL_RECORD_TEMPLATES.get(template_key)\n        if template is None:\n            raise DomainError("FORMAL_RECORD_TEMPLATE_NOT_FOUND", "正式笔录模板不存在", 404)\n        rows = question_repo.list_case(self.db, case_id)\n        existing_keys = {row.template_item_key for row in rows if row.template_key == template_key}\n        for section in ("OPENING", "CLOSING"):\n            for item_key, text in template[section]:\n                if item_key in existing_keys:\n                    continue\n                question_repo.create_case(\n                    self.db, case_id=case_id, source="CASE", text=text, standard_question_id=None,\n                    regex_patterns_json="[]", aliases_json="[]", section_type=section,\n                    template_key=template_key, template_item_key=item_key, locked=True,\n                )\n        self._apply_section_order(question_repo.list_case(self.db, case_id), template_key=template_key)\n        return self.workspace(case_id)\n\n    def list_library(self, category: str | None = None) -> list[dict]:\n        return [standard_question_dict(row) for row in question_repo.list_standard(self.db, category)]\n\n    def add_case_question(\n        self, case_id: str, *, text: str, source: str, standard_question_id: str | None = None,\n        regex_patterns: list[str] | None = None, after_question_id: str | None = None,\n    ) -> dict:\n        case_repo.get(self.db, case_id)\n        normalized_source = str(source or "").strip().upper()\n        if normalized_source not in _ALLOWED_SOURCES:\n            raise DomainError("INVALID_QUESTION_SOURCE", "无效的问题来源", 400)\n        if standard_question_id is not None:\n            question_repo.get_standard(self.db, standard_question_id)\n        row = question_repo.create_case(\n            self.db, case_id=case_id, source=normalized_source, text=_clean_text(text),\n            standard_question_id=standard_question_id, regex_patterns_json=json.dumps(_clean_list(regex_patterns), ensure_ascii=False),\n            aliases_json="[]", section_type="BODY", locked=False,\n        )\n        rows = question_repo.list_case(self.db, case_id)\n        template_key = next((item.template_key for item in rows if item.template_key), None)\n        if template_key:\n            body = [item for item in rows if item.section_type == "BODY" and item.id != row.id]\n            insert_at = len(body)\n            if after_question_id is not None:\n                after = next((item for item in rows if item.id == after_question_id), None)\n                if after is None:\n                    raise DomainError("CASE_QUESTION_NOT_FOUND", "插入位置对应的问题不存在", 404)\n                if after.section_type == "BODY":\n                    insert_at = body.index(after) + 1\n                elif after.section_type == "OPENING":\n                    insert_at = 0\n                else:\n                    raise DomainError("FIXED_SECTION_BOUNDARY", "动态问题不能插入固定结尾之后", 409)\n            body.insert(insert_at, row)\n            fixed = [item for item in rows if item.section_type != "BODY"]\n            self._apply_section_order(fixed + body, template_key=template_key, body_order=body)\n        elif after_question_id is not None:\n            other = [item for item in rows if item.id != row.id]\n            after = next((item for item in other if item.id == after_question_id), None)\n            if after is None:\n                raise DomainError("CASE_QUESTION_NOT_FOUND", "插入位置对应的问题不存在", 404)\n            index = other.index(after) + 1\n            other.insert(index, row)\n            self._apply_order(other)\n        return case_question_dict(row, rounds=[])\n\n    def update_case_question(self, case_id: str, question_id: str, *, text: str | None = None, regex_patterns: list[str] | None = None) -> dict:\n        row = question_repo.get_case(self.db, case_id, question_id)\n        if row.locked and (text is not None or regex_patterns is not None):\n            raise DomainError("FIXED_QUESTION_LOCKED", "固定笔录问题不可修改", 409)\n        if text is not None:\n            clean = _clean_text(text)\n            if clean != row.text:\n                aliases = _load_list(row.aliases_json)\n                if row.text not in aliases:\n                    aliases.append(row.text)\n                row.aliases_json = json.dumps([alias for alias in aliases if alias != clean], ensure_ascii=False)\n                row.text = clean\n        if regex_patterns is not None:\n            row.regex_patterns_json = json.dumps(_clean_list(regex_patterns), ensure_ascii=False)\n        self.db.flush()\n        return case_question_dict(row, rounds=round_repo.list_for_question(self.db, case_id, row.id))\n\n    def deactivate_case_question(self, case_id: str, question_id: str) -> dict:\n        row = question_repo.get_case(self.db, case_id, question_id)\n        if row.locked or row.section_type != "BODY":\n            raise DomainError("FIXED_QUESTION_LOCKED", "固定笔录问题不可移除", 409)\n        row.active = False\n        self.db.flush()\n        remaining = question_repo.list_case(self.db, case_id)\n        template_key = next((item.template_key for item in remaining if item.template_key), None)\n        if template_key:\n            self._apply_section_order(remaining, template_key=template_key)\n        else:\n            self._apply_order(remaining)\n        result = case_question_dict(row, rounds=round_repo.list_for_question(self.db, case_id, row.id))\n        result["active"] = False\n        return result\n\n    def reorder(self, case_id: str, ordered_ids: list[str]) -> list[dict]:\n        case_repo.get(self.db, case_id)\n        rows = question_repo.list_case(self.db, case_id)\n        template_key = next((row.template_key for row in rows if row.template_key), None)\n        supplied = [str(value) for value in ordered_ids]\n        if len(supplied) != len(set(supplied)):\n            raise DomainError("INVALID_QUESTION_ORDER", "问题排序不能重复", 400)\n        if template_key:\n            body = [row for row in rows if row.section_type == "BODY"]\n            expected = {row.id for row in body}\n            if set(supplied) != expected:\n                raise DomainError("INVALID_QUESTION_ORDER", "正式笔录只能对案件动态问题排序", 400)\n            by_id = {row.id: row for row in body}\n            body_order = [by_id[row_id] for row_id in supplied]\n            self._apply_section_order(rows, template_key=template_key, body_order=body_order)\n        else:\n            expected = {row.id for row in rows}\n            if set(supplied) != expected:\n                raise DomainError("INVALID_QUESTION_ORDER", "问题排序必须包含本案全部问题且不能重复", 400)\n            by_id = {row.id: row for row in rows}\n            self._apply_order([by_id[row_id] for row_id in supplied])\n        return [case_question_dict(row, rounds=round_repo.list_for_question(self.db, case_id, row.id)) for row in question_repo.list_case(self.db, case_id)]\n\n    def save_to_library(self, case_id: str, question_id: str, category: str) -> dict:\n        row = question_repo.get_case(self.db, case_id, question_id)\n        if row.locked:\n            raise DomainError("FIXED_QUESTION_LOCKED", "固定模板问题无需保存到常用问题库", 409)\n        standard = question_repo.create_standard(\n            self.db, text=row.text, category=str(category or "通用").strip() or "通用",\n            regex_patterns_json=row.regex_patterns_json or "[]", aliases_json=row.aliases_json or "[]",\n        )\n        row.standard_question_id = standard.id\n        self.db.flush()\n        return standard_question_dict(standard)\n\n    def _apply_section_order(self, rows: list, *, template_key: str, body_order: list | None = None) -> None:\n        template = _FORMAL_RECORD_TEMPLATES[template_key]\n        item_rank = {key: index for section in ("OPENING", "CLOSING") for index, (key, _) in enumerate(template[section])}\n        opening = sorted([row for row in rows if row.section_type == "OPENING"], key=lambda row: item_rank.get(row.template_item_key, 999))\n        closing = sorted([row for row in rows if row.section_type == "CLOSING"], key=lambda row: item_rank.get(row.template_item_key, 999))\n        body = body_order if body_order is not None else [row for row in rows if row.section_type == "BODY"]\n        self._apply_order(opening + list(body) + closing)\n\n    def _apply_order(self, rows: list) -> None:\n        for index, row in enumerate(rows, start=1):\n            row.sort_order = -(index * 10)\n        self.db.flush()\n        for index, row in enumerate(rows, start=1):\n            row.sort_order = index * 10\n        self.db.flush()\n''',
)

# Expose formal-record metadata on the existing serializer and frozen snapshot.
replace_once(
    "linux/backend/app/services/serializers.py",
    '''        "aliases": _json_list(row.aliases_json),\n        "sortOrder": row.sort_order,\n        "active": bool(row.active),\n        "rounds": [question_round_dict(item) for item in (rounds or [])],''',
    '''        "aliases": _json_list(row.aliases_json),\n        "sectionType": row.section_type or "BODY",\n        "templateKey": row.template_key,\n        "templateItemKey": row.template_item_key,\n        "locked": bool(row.locked),\n        "sortOrder": row.sort_order,\n        "active": bool(row.active),\n        "rounds": [question_round_dict(item) for item in (rounds or [])],''',
)

replace_once(
    "linux/backend/app/services/document_service.py",
    '''        entries = []\n        for round_row in rounds:\n            question = questions_by_id.get(round_row.case_question_id)\n            if question is None:\n                continue\n            serialized = question_round_dict(round_row)\n            entries.append(\n                {\n                    "roundId": round_row.id,\n                    "questionId": round_row.case_question_id,\n                    "questionText": question.text,\n                    "caseQuestionId": round_row.case_question_id,\n                    "roundNo": round_row.round_no,\n                    "formalQuestionText": question.text,\n                    "actualQuestionText": round_row.actual_question_text,\n                    "answerText": round_row.answer_text,\n                    "officerFragmentId": round_row.officer_fragment_id,\n                    "answerFragmentIds": serialized["answerFragmentIds"],\n                    "status": round_row.status,\n                    "startedAt": serialized["startedAt"],\n                    "endedAt": serialized["endedAt"],\n                }\n            )''',
    '''        entries = []\n        for question in case_questions:\n            for round_row in rounds_by_question.get(question.id, []):\n                serialized = question_round_dict(round_row)\n                entries.append(\n                    {\n                        "roundId": round_row.id,\n                        "questionId": round_row.case_question_id,\n                        "questionText": question.text,\n                        "sectionType": question.section_type or "BODY",\n                        "templateKey": question.template_key,\n                        "templateItemKey": question.template_item_key,\n                        "caseQuestionId": round_row.case_question_id,\n                        "roundNo": round_row.round_no,\n                        "formalQuestionText": question.text,\n                        "actualQuestionText": round_row.actual_question_text,\n                        "answerText": round_row.answer_text,\n                        "officerFragmentId": round_row.officer_fragment_id,\n                        "answerFragmentIds": serialized["answerFragmentIds"],\n                        "status": round_row.status,\n                        "startedAt": serialized["startedAt"],\n                        "endedAt": serialized["endedAt"],\n                    }\n                )''',
)

# API: explicit idempotent initializer + BODY soft remove.
api_path = "linux/backend/app/api/template_workspace.py"
api_text = read(api_path)
api_text += '''\n\n@router.post("/cases/{case_id}/formal-record/ensure")\ndef ensure_formal_record(case_id: str, db: Session = Depends(get_db)):\n    result = TemplateWorkspaceService(db).ensure_formal_record(case_id, template_key="SUSPECT_INQUIRY_V1")\n    db.commit()\n    return envelope(result, "正式询问笔录模板已就绪")\n\n\n@router.delete("/cases/{case_id}/questions/{question_id}")\ndef deactivate_case_question(case_id: str, question_id: str, db: Session = Depends(get_db)):\n    result = TemplateWorkspaceService(db).deactivate_case_question(case_id, question_id)\n    db.commit()\n    return envelope(result, "动态问题已从正式笔录移出")\n'''
write(api_path, api_text)

write(
    "webapp/src/types/templateInterrogation.ts",
    '''import type { TemporaryAsrFragment } from './interrogation'\n\nexport type FormalQuestionSource = 'STANDARD' | 'CASE' | 'LIVE'\nexport type FormalQuestionSection = 'OPENING' | 'BODY' | 'CLOSING'\nexport type PendingMatchStatus = 'UNMATCHED' | 'AMBIGUOUS' | 'MATCHED_EXISTING'\nexport type PendingStatus = 'PENDING' | 'DEFERRED' | 'ADDED' | 'LINKED' | 'IGNORED'\nexport type RoundStatus = 'ACTIVE' | 'CLOSED' | 'DETACHED'\n\nexport interface FormalQuestionRound {\n  id: string; caseId: string; sessionId: string | null; caseQuestionId: string; roundNo: number\n  actualQuestionText: string; officerFragmentId: string | null; answerText: string; answerFragmentIds: string[]\n  status: RoundStatus; startedAt: string | null; endedAt: string | null; createdAt: string | null; updatedAt: string | null\n}\n\nexport interface FormalQuestion {\n  id: string; caseId: string; source: FormalQuestionSource; standardQuestionId: string | null; text: string\n  regexPatterns: string[]; aliases: string[]; sectionType: FormalQuestionSection; templateKey: string | null\n  templateItemKey: string | null; locked: boolean; sortOrder: number; active: boolean; rounds: FormalQuestionRound[]\n  createdAt: string | null; updatedAt: string | null\n}\n\nexport interface PendingFormalQuestion {\n  id: string; caseId: string; sessionId: string | null; officerFragmentId: string; questionText: string\n  matchStatus: PendingMatchStatus; candidateQuestionIds: string[]; bufferedAnswerText: string; bufferedFragmentIds: string[]\n  status: PendingStatus; createdAt: string | null; updatedAt: string | null\n}\n\nexport interface StandardQuestion {\n  id: string; text: string; category: string; regexPatterns: string[]; aliases: string[]; sortOrder: number\n  active: boolean; createdAt: string | null; updatedAt: string | null\n}\n\nexport interface TemplateWorkspace {\n  caseId: string; templateKey?: string | null; questions: FormalQuestion[]; rounds: FormalQuestionRound[]; pendingQuestions: PendingFormalQuestion[]\n}\n\nexport type LiveDialogueItem = TemporaryAsrFragment\nexport interface CaseQuestionCreateInput { text: string; source?: FormalQuestionSource; standardQuestionId?: string | null; regexPatterns?: string[]; afterQuestionId?: string | null }\nexport interface CaseQuestionUpdateInput { text?: string; regexPatterns?: string[] }\nexport type PendingResolution =\n  | { action: 'ADD'; afterQuestionId?: string | null }\n  | { action: 'LINK'; caseQuestionId: string; roundMode: 'APPEND_EXISTING' | 'NEW_ROUND' }\n  | { action: 'IGNORE' }\nexport interface RoundReassociateInput { caseQuestionId?: string | null; newQuestionText?: string | null }\n''',
)

api_ts = read("webapp/src/api/templateInterrogation.ts")
api_ts += '''\n\nexport async function ensureFormalRecord(caseId: string): Promise<TemplateWorkspace> {\n  return unwrap(await http.post<BackendEnvelope<TemplateWorkspace>>(`/api/v1/cases/${encodeURIComponent(caseId)}/formal-record/ensure`))\n}\n\nexport async function deactivateCaseQuestion(caseId: string, questionId: string): Promise<FormalQuestion> {\n  return unwrap(await http.delete<BackendEnvelope<FormalQuestion>>(`/api/v1/cases/${encodeURIComponent(caseId)}/questions/${encodeURIComponent(questionId)}`))\n}\n'''
write("webapp/src/api/templateInterrogation.ts", api_ts)

# Store initializes the fixed template once and provides soft-remove.
replace_once(
    "webapp/src/stores/templateInterrogation.ts",
    '''  addPendingQuestion,\n  createCaseQuestion as createCaseQuestionApi,\n  fetchQuestionLibrary,''',
    '''  addPendingQuestion,\n  createCaseQuestion as createCaseQuestionApi,\n  deactivateCaseQuestion as deactivateCaseQuestionApi,\n  ensureFormalRecord,\n  fetchQuestionLibrary,''',
)
replace_once(
    "webapp/src/stores/templateInterrogation.ts",
    '''    try {\n      await Promise.all([loadTemplateWorkspace(scope), loadDialogueHistory(scope)])\n      if (!isCurrentScope(scope)) return''',
    '''    try {\n      await ensureFormalRecord(scope.caseId)\n      if (!isCurrentScope(scope)) return\n      await Promise.all([loadTemplateWorkspace(scope), loadDialogueHistory(scope)])\n      if (!isCurrentScope(scope)) return''',
)
replace_once(
    "webapp/src/stores/templateInterrogation.ts",
    '''  async function reorderCaseQuestions(questionIds: string[]) {\n    await runMutation((scope) => reorderCaseQuestionsApi(scope.caseId, questionIds))\n  }\n\n  async function resolvePendingQuestion''',
    '''  async function reorderCaseQuestions(questionIds: string[]) {\n    await runMutation((scope) => reorderCaseQuestionsApi(scope.caseId, questionIds))\n  }\n\n  async function deactivateCaseQuestion(questionId: string) {\n    await runMutation((scope) => deactivateCaseQuestionApi(scope.caseId, questionId))\n  }\n\n  async function resolvePendingQuestion''',
)
replace_once(
    "webapp/src/stores/templateInterrogation.ts",
    '''    reorderCaseQuestions,\n    resolvePendingQuestion,''',
    '''    reorderCaseQuestions,\n    deactivateCaseQuestion,\n    resolvePendingQuestion,''',
)

# Paper-style formal editor. Fixed sections are plain text; BODY stays editable/reorderable.
write(
    "webapp/src/components/FormalTemplatePanel.vue",
    r'''<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue'
import type { CaseSummary, DocumentSignerRole, DocumentSigningState, SessionState } from '../types/interrogation'
import type { CaseQuestionUpdateInput, FormalQuestion, FormalQuestionRound } from '../types/templateInterrogation'

const props = defineProps<{
  summary: CaseSummary
  session: SessionState
  questions: FormalQuestion[]
  rounds: FormalQuestionRound[]
  busy: boolean
  documentFrozen: boolean
  documentLocked: boolean
  signingState: DocumentSigningState | null
  signingBusy: string
  captureRunning: boolean
  aiBusy: boolean
  aiError: string
}>()

const emit = defineEmits<{
  updateQuestion: [questionId: string, input: CaseQuestionUpdateInput]
  reorder: [questionIds: string[]]
  removeQuestion: [questionId: string]
  updateAnswer: [roundId: string, answerText: string]
  saveLibrary: [questionId: string]
  insertPending: [pendingId: string, afterQuestionId: string | null]
  generateAi: []
  freeze: []
  sign: [role: DocumentSignerRole]
}>()

const questionDrafts = reactive<Record<string, string>>({})
const answerDrafts = reactive<Record<string, string>>({})
const draggingBodyId = ref('')
const dragOverKey = ref('')
const orderedQuestions = computed(() => [...props.questions].sort((a, b) => a.sortOrder - b.sortOrder))
const openingQuestions = computed(() => orderedQuestions.value.filter((q) => q.sectionType === 'OPENING'))
const bodyQuestions = computed(() => orderedQuestions.value.filter((q) => q.sectionType === 'BODY'))
const closingQuestions = computed(() => orderedQuestions.value.filter((q) => q.sectionType === 'CLOSING'))
const lastOpeningId = computed(() => openingQuestions.value.at(-1)?.id ?? null)

watch(() => props.questions, (items) => {
  for (const item of items) questionDrafts[item.id] = item.text
}, { immediate: true, deep: true })
watch(() => props.rounds, (items) => {
  for (const item of items) if (!(item.id in answerDrafts)) answerDrafts[item.id] = item.answerText
}, { immediate: true, deep: true })

function roundsFor(questionId: string) {
  return props.rounds.filter((r) => r.caseQuestionId === questionId && r.status !== 'DETACHED').sort((a, b) => a.roundNo - b.roundNo)
}
function latestRound(questionId: string) { return roundsFor(questionId).at(-1) }
function saveQuestion(question: FormalQuestion) {
  if (question.locked || props.documentFrozen || props.busy) return
  const text = (questionDrafts[question.id] || '').trim()
  if (text && text !== question.text.trim()) emit('updateQuestion', question.id, { text })
}
function saveAnswer(round: FormalQuestionRound) {
  if (props.documentFrozen || props.busy) return
  const answer = (answerDrafts[round.id] || '').trim()
  if (answer !== round.answerText.trim()) emit('updateAnswer', round.id, answer)
}
function signatureFor(role: DocumentSignerRole) { return props.signingState?.signatures.find((s) => s.signerRole === role) }
function formatSignedAt(value?: number) {
  return value ? new Intl.DateTimeFormat('zh-CN', { month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false }).format(new Date(value)) : ''
}
function formatRecordTime(value?: number | null) {
  if (!value) return '____年__月__日__时__分'
  const d = new Date(value)
  return `${d.getFullYear()}年${d.getMonth() + 1}月${d.getDate()}日 ${String(d.getHours()).padStart(2, '0')}时${String(d.getMinutes()).padStart(2, '0')}分`
}
function startBodyDrag(event: DragEvent, id: string) {
  if (props.documentFrozen || props.busy || !event.dataTransfer) return
  draggingBodyId.value = id
  event.dataTransfer.effectAllowed = 'move'
  event.dataTransfer.setData('application/x-formal-body-question', id)
}
function dropBody(event: DragEvent, targetId: string) {
  event.preventDefault()
  const sourceId = event.dataTransfer?.getData('application/x-formal-body-question') || draggingBodyId.value
  if (!sourceId || sourceId === targetId) return
  const ids = bodyQuestions.value.map((q) => q.id)
  const from = ids.indexOf(sourceId); const to = ids.indexOf(targetId)
  if (from < 0 || to < 0) return
  ids.splice(to, 0, ids.splice(from, 1)[0])
  emit('reorder', ids)
  draggingBodyId.value = ''; dragOverKey.value = ''
}
function allowPendingDrop(event: DragEvent, key: string) {
  if (!props.documentFrozen && event.dataTransfer?.types.includes('application/x-formal-pending-question')) {
    event.preventDefault(); event.dataTransfer.dropEffect = 'copy'; dragOverKey.value = key
  }
}
function dropPending(event: DragEvent, afterQuestionId: string | null) {
  event.preventDefault(); dragOverKey.value = ''
  const raw = event.dataTransfer?.getData('application/x-formal-pending-question')
  if (!raw || props.documentFrozen) return
  try { const payload = JSON.parse(raw) as { pendingId?: string }; if (payload.pendingId) emit('insertPending', payload.pendingId, afterQuestionId) } catch { /* invalid external drag */ }
}
</script>

<template>
  <section class="formal-record-shell">
    <article class="formal-record-paper" aria-label="正式询问笔录编辑器">
      <header class="record-paper-header">
        <div class="record-title-block"><h1>询问笔录</h1><span>第 1 次</span></div>
        <div class="record-top-actions record-no-print">
          <button :disabled="aiBusy" @click="emit('generateAi')">{{ aiBusy ? 'AI 梳理中…' : '案件 AI 梳理' }}</button>
          <button class="primary" :disabled="documentFrozen || signingBusy !== '' || captureRunning" @click="emit('freeze')">
            {{ signingBusy === 'freeze' ? '正在冻结…' : documentFrozen ? '笔录已冻结' : '结束并冻结笔录' }}
          </button>
          <button :disabled="!signingState || !!signatureFor('SUSPECT') || signingBusy !== '' || documentLocked" @click="emit('sign', 'SUSPECT')">
            {{ signatureFor('SUSPECT') ? `被询问人已签 ${formatSignedAt(signatureFor('SUSPECT')?.signedAt)}` : '被询问人签名' }}
          </button>
          <button :disabled="!signingState || !!signatureFor('OFFICER') || signingBusy !== '' || documentLocked" @click="emit('sign', 'OFFICER')">
            {{ signatureFor('OFFICER') ? `民警已签 ${formatSignedAt(signatureFor('OFFICER')?.signedAt)}` : '民警签名' }}
          </button>
        </div>
      </header>

      <p v-if="aiError" class="inline-error record-no-print">{{ aiError }}</p>
      <section class="record-meta-grid">
        <p><b>时间</b><span>{{ formatRecordTime(session.startedAt || summary.createdAt) }} 至 {{ session.endedAt ? formatRecordTime(session.endedAt) : '____________' }}</span></p>
        <p><b>地点</b><span>____________________________________________</span></p>
        <p><b>询问人</b><span>{{ summary.officerName || '________' }}　工作单位 ________________________</span></p>
        <p><b>记录人</b><span>________　工作单位 ______________________________</span></p>
        <p><b>被询问人</b><span>{{ summary.suspectName || '________' }}</span></p>
        <p><b>身份证证件种类及号码</b><span>身份证，{{ summary.idNumber || '________________________' }}</span></p>
        <p><b>性别</b><span>{{ summary.gender || '____' }}　出生日期 {{ summary.birthDate || '____________' }}</span></p>
        <p><b>联系方式</b><span>____________________________________________</span></p>
        <p><b>现住址</b><span>{{ summary.address || '____________________________________________' }}</span></p>
        <p><b>户籍所在地</b><span>____________________________________________</span></p>
      </section>

      <section class="record-qa-section fixed-opening">
        <div v-for="q in openingQuestions" :key="q.id" class="record-qa fixed-question">
          <p class="record-question"><b>问：</b><span>{{ q.text }}</span></p>
          <label v-if="latestRound(q.id)" class="record-answer"><b>答：</b><textarea v-model="answerDrafts[latestRound(q.id)!.id]" :disabled="busy || documentFrozen" rows="1" @blur="saveAnswer(latestRound(q.id)!)"></textarea></label>
          <p v-else class="record-answer blank-answer"><b>答：</b><span></span></p>
        </div>
      </section>

      <div class="record-section-label record-no-print"><span>案件动态问答区</span><small>右侧实时对话可拖入；本区可拖动排序、编辑或移出</small></div>
      <div class="record-drop-zone record-no-print" :class="{ active: dragOverKey === 'body-start' }" @dragover="allowPendingDrop($event, 'body-start')" @dragleave="dragOverKey = ''" @drop="dropPending($event, lastOpeningId)">拖到这里插入为第一条案件问题</div>

      <section class="record-qa-section body-section">
        <article v-for="q in bodyQuestions" :key="q.id" class="record-qa body-question" draggable="true" @dragstart="startBodyDrag($event, q.id)" @dragover.prevent @drop="dropBody($event, q.id)">
          <div class="body-question-tools record-no-print"><span class="drag-handle" title="拖动排序">⋮⋮</span><span>{{ q.source === 'LIVE' ? '实时对话' : q.source === 'STANDARD' ? '问题库' : '本案问题' }}</span><button :disabled="busy || documentFrozen" @click="emit('saveLibrary', q.id)">存入题库</button><button class="danger-link" :disabled="busy || documentFrozen" @click="emit('removeQuestion', q.id)">移出笔录</button></div>
          <label class="record-question editable-question"><b>问：</b><textarea v-model="questionDrafts[q.id]" :disabled="busy || documentFrozen" rows="1" @blur="saveQuestion(q)"></textarea></label>
          <template v-if="latestRound(q.id)">
            <label class="record-answer"><b>答：</b><textarea v-model="answerDrafts[latestRound(q.id)!.id]" :disabled="busy || documentFrozen" rows="2" @blur="saveAnswer(latestRound(q.id)!)"></textarea></label>
            <small v-if="latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text" class="actual-question record-no-print">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>
          </template>
          <p v-else class="record-answer blank-answer"><b>答：</b><span>等待现场回答</span></p>
          <div class="record-drop-zone compact record-no-print" :class="{ active: dragOverKey === q.id }" @dragover="allowPendingDrop($event, q.id)" @dragleave="dragOverKey = ''" @drop="dropPending($event, q.id)">拖到这里，插入在本题之后</div>
        </article>
        <div v-if="!bodyQuestions.length" class="record-body-empty record-no-print">案件动态问答区暂为空。将右侧民警提问拖到这里，或从问题准备区加入。</div>
      </section>

      <section class="record-qa-section fixed-closing">
        <div v-for="q in closingQuestions" :key="q.id" class="record-qa fixed-question">
          <p class="record-question"><b>问：</b><span>{{ q.text }}</span></p>
          <label v-if="latestRound(q.id)" class="record-answer"><b>答：</b><textarea v-model="answerDrafts[latestRound(q.id)!.id]" :disabled="busy || documentFrozen" rows="1" @blur="saveAnswer(latestRound(q.id)!)"></textarea></label>
          <p v-else class="record-answer blank-answer"><b>答：</b><span></span></p>
        </div>
      </section>

      <footer class="record-integrity-footer">
        <span v-if="signingState">冻结版本 {{ signingState.version }} · 完整性{{ signingState.integrityValid ? '已校验' : '异常' }}</span>
        <span v-else>正式问题 {{ orderedQuestions.length }} · 问答轮次 {{ rounds.filter((r) => r.status !== 'DETACHED').length }}</span>
      </footer>
    </article>
  </section>
</template>
''',
)

# Add drag payload to unresolved right-side dialogue turns.
replace_once(
    "webapp/src/components/LiveDialoguePanel.vue",
    '''function resolve(pending: PendingFormalQuestion, resolution: PendingResolution) {\n  emit('resolvePending', pending.id, resolution)\n}\n\nfunction correctionRole''',
    '''function resolve(pending: PendingFormalQuestion, resolution: PendingResolution) {\n  emit('resolvePending', pending.id, resolution)\n}\n\nfunction startPendingDrag(event: DragEvent, fragmentId: string) {\n  const pending = pendingFor(fragmentId)\n  if (!pending || !event.dataTransfer) return\n  event.dataTransfer.effectAllowed = 'copy'\n  event.dataTransfer.setData('application/x-formal-pending-question', JSON.stringify({ pendingId: pending.id }))\n}\n\nfunction correctionRole''',
)
replace_once(
    "webapp/src/components/LiveDialoguePanel.vue",
    '''          :class="`side-${dialoguePresentation(item).side}`"\n          :data-fragment-id="item.id"\n        >''',
    '''          :class="[`side-${dialoguePresentation(item).side}`, { 'pending-draggable': !!pendingFor(item.id) }]"\n          :data-fragment-id="item.id"\n          :draggable="!!pendingFor(item.id)"\n          @dragstart="startPendingDrag($event, item.id)"\n        >''',
)
replace_once(
    "webapp/src/components/LiveDialoguePanel.vue",
    '''              <p>未匹配正式笔录问题</p>''',
    '''              <p>未匹配正式笔录问题 · 可直接拖到左侧正式笔录指定位置</p>''',
)

# Parent wiring: paper gets case/session data; Q/A drop reuses the existing pending ADD mutation.
replace_once(
    "webapp/src/components/TemplateDrivenInterrogationPage.vue",
    '''          :questions="workspace.questions"\n          :rounds="workspace.rounds"''',
    '''          :summary="summary"\n          :session="session"\n          :questions="workspace.questions"\n          :rounds="workspace.rounds"''',
)
replace_once(
    "webapp/src/components/TemplateDrivenInterrogationPage.vue",
    '''          @update-question="(id, input) => emit('updateQuestion', id, input)"\n          @reorder="emit('reorderQuestions', $event)"\n          @update-answer''',
    '''          @update-question="(id, input) => emit('updateQuestion', id, input)"\n          @reorder="emit('reorderQuestions', $event)"\n          @remove-question="(id) => emit('removeQuestion', id)"\n          @insert-pending="(pendingId, afterQuestionId) => emit('resolvePending', pendingId, { action: 'ADD', afterQuestionId })"\n          @update-answer''',
)
replace_once(
    "webapp/src/components/TemplateDrivenInterrogationPage.vue",
    '''  reorderQuestions: [questionIds: string[]]\n  resolvePending:''',
    '''  reorderQuestions: [questionIds: string[]]\n  removeQuestion: [questionId: string]\n  resolvePending:''',
)
# Turn the old preparation card into a collapsed auxiliary drawer instead of the main editor.
replace_once(
    "webapp/src/components/TemplateDrivenInterrogationPage.vue",
    '''        <QuestionPreparationPanel\n          v-if="session.status === 'READY'"''',
    '''        <details v-if="session.status === 'READY'" class="record-preparation-drawer record-no-print">\n          <summary>问题准备 / 常用问题库</summary>\n        <QuestionPreparationPanel''',
)
replace_once(
    "webapp/src/components/TemplateDrivenInterrogationPage.vue",
    '''          @voice-stop="emit('questionDictationStop')"\n        />\n\n        <FormalTemplatePanel''',
    '''          @voice-stop="emit('questionDictationStop')"\n        />\n        </details>\n\n        <FormalTemplatePanel''',
)

# The component above is consumed by the interrogation workspace; wire the new remove event wherever the existing reorder handler is passed.
workspace_candidates = list((ROOT / "webapp/src/components").glob("*.vue"))
for candidate in workspace_candidates:
    text = candidate.read_text(encoding="utf-8")
    if "<TemplateDrivenInterrogationPage" not in text or "@reorder-questions" not in text:
        continue
    if "@remove-question" not in text:
        text = text.replace('@reorder-questions="templateStore.reorderCaseQuestions"', '@reorder-questions="templateStore.reorderCaseQuestions"\n      @remove-question="templateStore.deactivateCaseQuestion"')
    candidate.write_text(text, encoding="utf-8")

# Paper UI / print rules. Existing styles remain for the right dialogue/evidence panel.
css_path = "webapp/src/components/templateInterrogation.css"
css = read(css_path)
css += r'''

/* Formal interrogation record editor ------------------------------------------------ */
.formal-record-shell{padding:0;background:#e8edf2;border-radius:12px;overflow:auto}.formal-record-paper{position:relative;max-width:900px;min-height:1120px;margin:18px auto;padding:54px 62px 64px;background:#fff;color:#111;box-shadow:0 10px 28px rgba(15,23,42,.12);font-family:"FangSong","STFangsong","SimSun",serif;font-size:17px;line-height:1.85}.record-paper-header{position:relative;min-height:88px}.record-title-block{text-align:center}.record-title-block h1{font-size:32px;letter-spacing:8px;margin:0;font-weight:600}.record-title-block span{position:absolute;right:0;top:4px;font-size:18px;letter-spacing:4px}.record-top-actions{display:flex;flex-wrap:wrap;justify-content:flex-end;gap:6px;margin-top:18px}.record-top-actions button,.body-question-tools button{border:1px solid #b9c0c8;background:#fff;border-radius:5px;padding:6px 9px;cursor:pointer;font-family:system-ui,sans-serif;font-size:12px}.record-top-actions .primary{background:#173b68;color:#fff;border-color:#173b68}.record-meta-grid{margin:20px 0 28px}.record-meta-grid p{display:flex;align-items:flex-end;margin:0;min-height:34px;border-bottom:1px solid #222}.record-meta-grid b{flex:0 0 auto;margin-right:12px;font-weight:500}.record-meta-grid span{flex:1;min-width:0}.record-qa{position:relative}.record-question,.record-answer{display:flex;margin:0;min-height:38px;border-bottom:1px solid #333;align-items:flex-start}.record-question>b,.record-answer>b{flex:0 0 38px;font-weight:600}.record-question>span,.record-answer>span{flex:1}.record-question textarea,.record-answer textarea{flex:1;width:100%;border:0;outline:0;resize:none;background:transparent;color:#111;font:inherit;line-height:1.85;padding:0;overflow:hidden}.blank-answer span{min-height:33px;color:#8b8b8b}.record-section-label{display:flex;align-items:center;justify-content:space-between;margin:24px 0 6px;padding:7px 10px;border-left:3px solid #173b68;background:#f4f7fa;font-family:system-ui,sans-serif}.record-section-label small{color:#657387}.body-question{margin:4px 0 10px}.body-question:hover{background:#fbfcfd}.body-question-tools{display:flex;align-items:center;gap:8px;min-height:27px;font-family:system-ui,sans-serif;font-size:11px;color:#667589;opacity:.25;transition:opacity .15s}.body-question:hover .body-question-tools{opacity:1}.drag-handle{cursor:grab;font-size:15px}.danger-link{color:#9b2c2c}.actual-question{display:block;padding:3px 0 3px 38px;color:#6d7783;font-family:system-ui,sans-serif}.record-drop-zone{margin:6px 0;border:1px dashed #aab7c4;border-radius:5px;padding:7px;text-align:center;color:#738399;background:#f8fafc;font:12px system-ui,sans-serif;transition:.15s}.record-drop-zone.compact{padding:4px;opacity:.18}.body-question:hover .record-drop-zone.compact{opacity:1}.record-drop-zone.active{opacity:1;border-color:#1f5f9d;background:#e9f3ff;color:#173b68}.record-body-empty{padding:35px 20px;text-align:center;border:1px dashed #b7c0ca;color:#708095;font-family:system-ui,sans-serif}.record-integrity-footer{margin-top:36px;padding-top:10px;border-top:1px solid #999;text-align:right;color:#606a74;font:12px system-ui,sans-serif}.record-preparation-drawer{margin-bottom:10px;border:1px solid #cbd5df;border-radius:8px;background:#f7f9fb}.record-preparation-drawer>summary{cursor:pointer;padding:10px 13px;font:600 13px system-ui,sans-serif;color:#405267}.pending-draggable{cursor:grab}.pending-draggable:active{cursor:grabbing}
@media(max-width:1200px){.formal-record-paper{margin:10px;padding:38px 34px;font-size:15px}.record-title-block h1{font-size:27px}.record-top-actions{justify-content:center}}
@media print{.record-no-print,.live-dialogue-panel,.record-preparation-drawer{display:none!important}.template-interrogation-grid{display:block!important}.formal-column{width:100%!important}.formal-record-shell{background:#fff;overflow:visible}.formal-record-paper{max-width:none;min-height:0;margin:0;padding:18mm 16mm;box-shadow:none;font-size:12pt}.record-qa,.record-meta-grid p{break-inside:avoid}.record-title-block h1{font-size:22pt}}
'''
write(css_path, css)

# Static contract test protects the cross-panel drag protocol and paper UI from accidental regression.
write(
    "webapp/src/components/FormalRecordEditor.contract.test.ts",
    '''import { describe, expect, it } from 'vitest'\nimport fs from 'node:fs'\nimport path from 'node:path'\n\nconst root = path.resolve(__dirname)\nconst formal = fs.readFileSync(path.join(root, 'FormalTemplatePanel.vue'), 'utf8')\nconst live = fs.readFileSync(path.join(root, 'LiveDialoguePanel.vue'), 'utf8')\n\ndescribe('formal record editor source contract', () => {\n  it('renders paper-style fixed/body/closing sections and top-right signing controls', () => {\n    expect(formal).toContain('正式询问笔录编辑器')\n    expect(formal).toContain('openingQuestions')\n    expect(formal).toContain('bodyQuestions')\n    expect(formal).toContain('closingQuestions')\n    expect(formal).toContain('被询问人签名')\n    expect(formal).toContain('结束并冻结笔录')\n  })\n\n  it('shares one stable drag MIME between live dialogue and the formal BODY', () => {\n    const mime = 'application/x-formal-pending-question'\n    expect(live).toContain(mime)\n    expect(formal).toContain(mime)\n    expect(formal).toContain("emit('insertPending'")\n  })\n})\n''',
)

# Remove this bootstrap script from the implementation commit; the workflow file removes itself too.
Path(__file__).unlink()
