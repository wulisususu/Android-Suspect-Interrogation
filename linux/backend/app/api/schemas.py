from typing import Literal

from pydantic import BaseModel, ConfigDict, Field


class FlexibleModel(BaseModel):
    model_config = ConfigDict(extra="ignore", populate_by_name=True)


class CaseCreateRequest(FlexibleModel):
    operator_id: str | None = None
    operatorId: str | None = None
    case_type: str = "suspect_interrogation"
    caseType: str | None = None
    suspectName: str | None = None
    gender: str | None = None
    age: str | int | None = None
    officerName: str | None = None


class CaseUpdateRequest(FlexibleModel):
    operator_id: str | None = None
    operatorId: str | None = None
    case_type: str | None = None
    caseType: str | None = None
    suspectName: str | None = None
    gender: str | None = None
    age: str | int | None = None
    officerName: str | None = None
    stage: str | None = None
    actor_id: str | None = None


class ActorRequest(FlexibleModel):
    actor_id: str | None = None


class IdentityReadRequest(ActorRequest):
    case_id: str | None = None


class IdentityConfirmRequest(ActorRequest):
    case_id: str
    name: str
    id_number: str = ""
    gender: str | None = None
    nation: str | None = None
    birth_date: str | None = None
    address: str | None = None
    source: str = "MANUAL"
    portrait: str | None = None
    issuer: str | None = None
    valid_from: str | None = None
    valid_to: str | None = None


class MessageCreateRequest(ActorRequest):
    text: str
    speaker: str


class MessageUpdateRequest(ActorRequest):
    text: str
    reason: str = "警官修订"


class MessageMarkRequest(ActorRequest):
    mark: str


class StageRequest(ActorRequest):
    stage: str


class FactUpdateRequest(ActorRequest):
    value: str | None = None
    status: str | None = None
    suggestion: str | None = None


class TimelineCreateRequest(ActorRequest):
    time: str = ""
    title: str = "时间线事件"
    detail: str = ""
    evidence: list[str] = Field(default_factory=list)


class DeviceActionRequest(FlexibleModel):
    type: str


class SignatureRequest(ActorRequest):
    signer_role: str
    signer_name: str
    image_data: str
    strokes_json: str = "[]"


class DocumentSignRequest(FlexibleModel):
    signer_role: Literal["SUSPECT", "OFFICER"] = Field(alias="signerRole")
    signer_name: str = Field(min_length=1, alias="signerName")
    image_data: str = Field(min_length=1, alias="imageDataUrl")
    strokes_json: str = Field(default="[]", alias="strokesJson")
    actor_id: str | None = Field(default=None, alias="actorId")


class LegacySignatureRequest(FlexibleModel):
    session_id: str | None = None
    data: str


class LegacyWorkMessageProfile(FlexibleModel):
    text: str
    from_: str = Field(alias="from")


class LegacyWorkMessageRequest(FlexibleModel):
    profile: LegacyWorkMessageProfile | None = None
    text: str | None = None
    from_: str | None = Field(default=None, alias="from")


class CaseQuestionCreateRequest(FlexibleModel):
    text: str
    source: Literal["STANDARD", "CASE", "LIVE"] = "CASE"
    standard_question_id: str | None = Field(default=None, alias="standardQuestionId")
    regex_patterns: list[str] = Field(default_factory=list, alias="regexPatterns")
    after_question_id: str | None = Field(default=None, alias="afterQuestionId")


class CaseQuestionUpdateRequest(FlexibleModel):
    text: str | None = None
    regex_patterns: list[str] | None = Field(default=None, alias="regexPatterns")


class QuestionReorderRequest(FlexibleModel):
    question_ids: list[str] = Field(alias="questionIds")


class PendingAddRequest(FlexibleModel):
    after_question_id: str | None = Field(default=None, alias="afterQuestionId")


class PendingLinkRequest(FlexibleModel):
    case_question_id: str = Field(alias="caseQuestionId")
    round_mode: Literal["APPEND_EXISTING", "NEW_ROUND"] = Field(alias="roundMode")


class RoundReassociateRequest(FlexibleModel):
    case_question_id: str | None = Field(default=None, alias="caseQuestionId")
    new_question_text: str | None = Field(default=None, alias="newQuestionText")


class RoundUpdateRequest(FlexibleModel):
    answer_text: str = Field(alias="answerText")


class SaveQuestionToLibraryRequest(FlexibleModel):
    category: str = "通用"
