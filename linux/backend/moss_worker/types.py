"""Immutable records shared by the MOSS parser, spool, and runtime."""
from dataclasses import asdict, dataclass
from enum import Enum

from .windowing import WindowSpec


class JobState(str, Enum):
    QUEUED = 'QUEUED'
    PREPARING = 'PREPARING'
    ENCODING = 'ENCODING'
    BUILDING_EMBEDS = 'BUILDING_EMBEDS'
    DECODING = 'DECODING'
    PARSING = 'PARSING'
    REMAPPING = 'REMAPPING'
    MERGING = 'MERGING'
    COMPLETED = 'COMPLETED'
    FAILED = 'FAILED'
    CANCELLED = 'CANCELLED'
    # Set only by the startup spool scan: a restart found this job in a
    # non-terminal state. Persisted and reported verbatim; the worker never
    # auto-resumes it (V1 ruling) — resolution is an explicit business-layer
    # resubmission on the same immutable audio, or cancel_job.
    RECOVERY_REQUIRED = 'RECOVERY_REQUIRED'


class WindowState(str, Enum):
    PENDING = 'PENDING'
    RUNNING = 'RUNNING'
    DONE = 'DONE'
    FAILED = 'FAILED'


class ParseStatus(str, Enum):
    VALID = 'VALID'
    REPAIRED = 'REPAIRED'
    INVALID = 'INVALID'


class MergeStatus(str, Enum):
    PRIMARY = 'PRIMARY'
    CONFLICT = 'CONFLICT'
    DUPLICATE = 'DUPLICATE'


@dataclass(frozen=True)
class NormalizedSegment:
    segment_id: str
    window_id: str
    start_ms: int
    end_ms: int
    local_speaker: str
    global_speaker: str | None
    text: str
    speaker_mapping_confidence: float | None
    parse_status: ParseStatus
    merge_status: MergeStatus
    alternate: 'NormalizedSegment | None'
    model_manifest_sha256: str
    repair_reason: str | None = None
    repair_original_end_ms: int | None = None

    def to_dict(self) -> dict:
        data = asdict(self)
        data['parse_status'] = self.parse_status.value
        data['merge_status'] = self.merge_status.value
        data['alternate'] = self.alternate.to_dict() if self.alternate else None
        return data

    @classmethod
    def from_dict(cls, data: dict) -> 'NormalizedSegment':
        fields = dict(data)
        fields['parse_status'] = ParseStatus(fields['parse_status'])
        fields['merge_status'] = MergeStatus(fields['merge_status'])
        alternate = fields['alternate']
        fields['alternate'] = cls.from_dict(alternate) if alternate is not None else None
        # Checkpoints written before the repair fields existed load as None.
        fields.setdefault('repair_reason', None)
        fields.setdefault('repair_original_end_ms', None)
        return cls(**fields)


@dataclass(frozen=True)
class WindowResult:
    window_id: str
    window: WindowSpec
    state: WindowState
    audio_sha256: str
    model_manifest_sha256: str
    raw_generation: str
    segments: tuple[NormalizedSegment, ...]
    parse_status: ParseStatus
    error: str | None
    token_count: int | None = None
    normal_termination: bool | None = None

    def __post_init__(self):
        object.__setattr__(self, 'segments', tuple(self.segments))

    def to_dict(self) -> dict:
        return dict(window_id=self.window_id, window=asdict(self.window),
                    state=self.state.value, audio_sha256=self.audio_sha256,
                    model_manifest_sha256=self.model_manifest_sha256,
                    raw_generation=self.raw_generation,
                    segments=[segment.to_dict() for segment in self.segments],
                    parse_status=self.parse_status.value, error=self.error,
                    token_count=self.token_count, normal_termination=self.normal_termination)

    @classmethod
    def from_dict(cls, data: dict) -> 'WindowResult':
        fields = dict(data)
        fields['window'] = WindowSpec(**fields['window'])
        fields['state'] = WindowState(fields['state'])
        fields['parse_status'] = ParseStatus(fields['parse_status'])
        fields['segments'] = tuple(NormalizedSegment.from_dict(s) for s in fields['segments'])
        return cls(**fields)


@dataclass(frozen=True)
class JobSnapshot:
    job_id: str
    state: JobState
    audio_sha256: str
    model_manifest_sha256: str
    progress: float
    error: str | None

    def to_dict(self) -> dict:
        return dict(job_id=self.job_id, state=self.state.value,
                    audio_sha256=self.audio_sha256,
                    model_manifest_sha256=self.model_manifest_sha256,
                    progress=self.progress, error=self.error)

    @classmethod
    def from_dict(cls, data: dict) -> 'JobSnapshot':
        fields = dict(data)
        fields['state'] = JobState(fields['state'])
        return cls(**fields)


@dataclass(frozen=True)
class JobResult:
    job_id: str
    audio_sha256: str
    model_manifest_sha256: str
    segments: tuple[NormalizedSegment, ...]

    def __post_init__(self):
        object.__setattr__(self, 'segments', tuple(self.segments))

    def to_dict(self) -> dict:
        return dict(job_id=self.job_id, audio_sha256=self.audio_sha256,
                    model_manifest_sha256=self.model_manifest_sha256,
                    segments=[segment.to_dict() for segment in self.segments])

    @classmethod
    def from_dict(cls, data: dict) -> 'JobResult':
        fields = dict(data)
        fields['segments'] = tuple(NormalizedSegment.from_dict(s) for s in fields['segments'])
        return cls(**fields)
