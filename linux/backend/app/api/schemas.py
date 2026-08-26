from pydantic import BaseModel, ConfigDict, Field


class FlexibleModel(BaseModel):
    model_config = ConfigDict(extra="ignore")


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
