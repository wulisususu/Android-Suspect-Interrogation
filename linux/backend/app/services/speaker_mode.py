"""The single authoritative rule for the effective speaker recognition mode.

Task 17B-1. Before this module the UI derived a recognition mode from the officer
voiceprint bindings while ``AsrCaptureService`` independently narrowed the runtime
decision to suspect-only whenever no calibrated margin was available. Two copies of
the same rule meant a deployment without a margin could advertise
"suspect + interrogating officer" in the interface while the runtime silently
verified suspects only.

Every consumer must now ask this module:

* :func:`resolve_effective_recognition_mode` -- the rule itself, pure and total.
* :func:`narrow_decision_roles` -- the predicate the capture runtime applies to its
  candidate references before asking :func:`~app.services.speaker_policy.decide_speaker`.
* :class:`SpeakerModeConfig` -- the runtime speaker operating point, resolved from
  whatever object happens to carry it (app settings, the AI supervisor, or the live
  capture runtime).
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Iterable, Mapping, Sequence

from app.services.speaker_policy import SpeakerRole

SUSPECT_ONLY = "SUSPECT_ONLY"
SUSPECT_PLUS_INTERROGATOR = "SUSPECT_PLUS_INTERROGATOR"
SUSPECT_PLUS_RECORDER = "SUSPECT_PLUS_RECORDER"
FULL = "FULL"

#: The runtime cannot compare several enrolled references without a calibrated
#: decision margin, so any multi-reference declaration collapses onto this mode.
DEGRADED_MODE = SUSPECT_ONLY

DEGRADED_REASON_MARGIN_CALIBRATION_MISSING = "MARGIN_CALIBRATION_MISSING"
DEGRADED_REASON_THRESHOLD_NOT_CONFIGURED = "THRESHOLD_NOT_CONFIGURED"

#: The threshold provenance value a runtime reports when it fell back to the model
#: baseline constant because the device carries no calibration.
MODEL_BASELINE_SOURCE = "MODEL_BASELINE"

RECOGNITION_MODES = (
    SUSPECT_ONLY,
    SUSPECT_PLUS_INTERROGATOR,
    SUSPECT_PLUS_RECORDER,
    FULL,
)

#: Stable keys shared by the audit trail, the API payload and the webapp.
MODE_DECLARED_KEY = "declaredRecognitionMode"
MODE_EFFECTIVE_KEY = "effectiveRecognitionMode"
MODE_DEGRADED_KEY = "recognitionModeDegraded"
MODE_REASON_KEY = "recognitionModeDegradedReason"
MODE_DECISION_KEY = MODE_EFFECTIVE_KEY


def resolve_effective_recognition_mode(
    *,
    declared_mode: str,
    margin: float | None,
    threshold: float | None,
) -> tuple[str, str | None]:
    """Return ``(effective_mode, degraded_reason)`` for one device configuration.

    ``declared_mode`` is what the operator's bindings would allow. The effective mode
    is what the runtime can actually enforce:

    * missing ``margin`` -> ``SUSPECT_ONLY`` + ``MARGIN_CALIBRATION_MISSING``
    * missing ``threshold`` -> ``SUSPECT_ONLY`` + ``THRESHOLD_NOT_CONFIGURED``
    * both present -> the declared mode, no reason
    * ``declared_mode`` already ``SUSPECT_ONLY`` -> returned untouched, never degraded
    """

    declared = _validate_mode(declared_mode)
    if declared == SUSPECT_ONLY:
        return SUSPECT_ONLY, None
    if margin is None:
        # Margins are the documented degradation channel; report it before the
        # threshold so a device that is missing both keeps a stable, actionable reason.
        return DEGRADED_MODE, DEGRADED_REASON_MARGIN_CALIBRATION_MISSING
    if threshold is None:
        return DEGRADED_MODE, DEGRADED_REASON_THRESHOLD_NOT_CONFIGURED
    return declared, None


def decision_roles(
    *,
    declared_mode: str,
    margin: float | None,
    threshold: float | None,
) -> set[SpeakerRole]:
    """The roles the runtime may attribute to under this operating point."""
    effective, _reason = resolve_effective_recognition_mode(
        declared_mode=declared_mode, margin=margin, threshold=threshold
    )
    if effective == SUSPECT_ONLY:
        return {SpeakerRole.SUSPECT}
    return {SpeakerRole(role) for role in _MODE_ROLES[effective]}


def is_degraded(*, declared_mode: str, margin: float | None, threshold: float | None) -> bool:
    return resolve_effective_recognition_mode(
        declared_mode=declared_mode, margin=margin, threshold=threshold
    )[1] is not None


def narrow_decision_roles(
    *,
    declared_mode: str,
    margin: float | None,
    threshold: float | None,
    enabled_roles: Iterable[SpeakerRole],
    candidates: Sequence[Mapping[str, Any]],
) -> tuple[set[SpeakerRole], list[Mapping[str, Any]]]:
    """Narrow bound roles/candidates to what this operating point can enforce.

    When the effective mode is suspect-only, officer candidates are dropped *before*
    scoring so an uncalibrated device can never attribute a fragment to an officer.
    """

    effective_roles = decision_roles(
        declared_mode=declared_mode, margin=margin, threshold=threshold
    )
    allowed = set(enabled_roles) & effective_roles
    narrowed_candidates = [item for item in candidates if _candidate_role(item) in allowed]
    return allowed, narrowed_candidates


def mode_decision_detail(
    *,
    declared_mode: str,
    margin: float | None,
    threshold: float | None,
) -> dict[str, Any]:
    """Audit-ready description of the rule outcome for one operating point."""
    effective, reason = resolve_effective_recognition_mode(
        declared_mode=declared_mode, margin=margin, threshold=threshold
    )
    return {
        MODE_DECLARED_KEY: declared_mode,
        MODE_EFFECTIVE_KEY: effective,
        MODE_DEGRADED_KEY: reason is not None,
        MODE_REASON_KEY: reason,
    }


@dataclass(frozen=True)
class SpeakerModeConfig:
    """Resolved runtime speaker operating point (threshold + margin + provenance)."""

    margin: float | None
    threshold: float | None
    threshold_source: str | None
    margin_source: str | None = None

    @property
    def margin_configured(self) -> bool:
        return self.margin is not None

    @property
    def threshold_configured(self) -> bool:
        return self.threshold is not None

    def resolve(self, declared_mode: str) -> tuple[str, str | None]:
        return resolve_effective_recognition_mode(
            declared_mode=declared_mode,
            margin=self.margin,
            threshold=self.threshold,
        )

    @classmethod
    def from_sources(cls, sources: Iterable[Any]) -> "SpeakerModeConfig":
        """Resolve the operating point from the first source that carries one.

        Sources are ordered by precedence: an active capture runtime wins over the
        AI supervisor, which wins over process settings. Both the snake_case
        supervisor/settings shape and the camelCase ``AsrCaptureService.status()``
        payload are understood so callers never re-derive the values themselves.
        """

        for source in sources:
            config = _config_from(source)
            if config is not None:
                return config
        return cls(margin=None, threshold=None, threshold_source=None)

    def as_readiness_fields(self, declared_mode: str) -> dict[str, Any]:
        effective, reason = self.resolve(declared_mode)
        return {
            "speakerMargin": self.margin,
            "speakerThreshold": self.threshold,
            "thresholdSource": self.threshold_source,
            "marginConfigured": self.margin_configured,
            "thresholdConfigured": self.threshold_configured,
            MODE_DECLARED_KEY: declared_mode,
            MODE_EFFECTIVE_KEY: effective,
            MODE_DEGRADED_KEY: reason is not None,
            MODE_REASON_KEY: reason,
        }


_MODE_ROLES: dict[str, tuple[str, ...]] = {
    SUSPECT_PLUS_INTERROGATOR: ("SUSPECT", "INTERROGATOR"),
    SUSPECT_PLUS_RECORDER: ("SUSPECT", "RECORDER"),
    FULL: ("SUSPECT", "INTERROGATOR", "RECORDER"),
}


def _validate_mode(value: str) -> str:
    normalized = str(value or "").strip().upper()
    if normalized not in RECOGNITION_MODES:
        raise ValueError(f"unknown recognition mode: {value!r}")
    return normalized


def _candidate_role(item: Mapping[str, Any]) -> SpeakerRole | None:
    raw = item.get("role") if hasattr(item, "get") else None
    if raw is None:
        return None
    if isinstance(raw, SpeakerRole):
        return raw
    try:
        return SpeakerRole(str(raw))
    except (TypeError, ValueError):
        return None


def _float_or_none(value: Any) -> float | None:
    if value is None or isinstance(value, bool):
        return None
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def _first(source: Any, *keys: str) -> Any:
    if source is None:
        return None
    for key in keys:
        if isinstance(source, Mapping):
            if key in source:
                return source[key]
            continue
        if hasattr(source, key):
            return getattr(source, key)
    return None


def _config_from(source: Any) -> SpeakerModeConfig | None:
    if source is None:
        return None
    if isinstance(source, SpeakerModeConfig):
        return source

    margin_raw = _first(source, "speaker_margin", "speakerMargin", "margin")
    threshold_raw = _first(
        source,
        "speaker_accept_threshold",
        "speaker_effective_threshold",
        "speaker_threshold",
        "speakerThreshold",
        "threshold",
    )
    threshold_configured = _first(source, "threshold_configured", "thresholdConfigured")
    margin_configured = _first(source, "margin_configured", "speakerMarginConfigured")
    threshold_source = _first(source, "speaker_threshold_source", "thresholdSource")

    if (
        margin_raw is None
        and threshold_raw is None
        and threshold_configured is None
        and margin_configured is None
        and threshold_source is None
    ):
        # The source carries no speaker operating point at all; keep looking.
        return None

    threshold = _float_or_none(threshold_raw)
    source_text = None if threshold_source is None else str(threshold_source)
    if threshold_configured is False or (
        threshold_configured is None and source_text == MODEL_BASELINE_SOURCE
    ):
        # A model-baseline threshold is a fallback constant, not a device
        # calibration: the operating point is not configured for this device.
        threshold = None

    return SpeakerModeConfig(
        margin=_float_or_none(margin_raw),
        threshold=threshold,
        threshold_source=source_text,
    )
