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
* :func:`resolve_runtime_speaker_mode` -- the operating point the runtime will really
  use, resolved from the runtime's own sources in the runtime's own order.
* :class:`SpeakerModeConfig` -- that operating point plus whether the mode derived from
  it could be checked against the runtime at all.

The single degradation predicate is ``margin is None``: it is exactly the condition
``AsrCaptureService._narrow_decision`` narrows on. A threshold -- including a
``MODEL_BASELINE`` fallback constant -- is reported as information and never changes
the mode.
"""

from __future__ import annotations

import logging
from dataclasses import dataclass
from typing import Any, Iterable, Mapping, Sequence

from app.services.speaker_policy import SpeakerRole


logger = logging.getLogger(__name__)

SUSPECT_ONLY = "SUSPECT_ONLY"
SUSPECT_PLUS_INTERROGATOR = "SUSPECT_PLUS_INTERROGATOR"
SUSPECT_PLUS_RECORDER = "SUSPECT_PLUS_RECORDER"
FULL = "FULL"

#: The runtime cannot compare several enrolled references without a calibrated
#: decision margin, so any multi-reference declaration collapses onto this mode.
DEGRADED_MODE = SUSPECT_ONLY

DEGRADED_REASON_MARGIN_CALIBRATION_MISSING = "MARGIN_CALIBRATION_MISSING"
# NOTE: ``THRESHOLD_NOT_CONFIGURED`` is deliberately gone. The runtime narrows on
# ``margin is None`` only, so the rule can no longer produce that reason. Persisted
# audit rows written before Task 17B-1 keep the string and stay readable.

#: The threshold provenance value a runtime reports when it fell back to the model
#: baseline constant because the device carries no calibration.
MODEL_BASELINE_SOURCE = "MODEL_BASELINE"

#: How a reported operating point was established. ``UNVERIFIED`` means the
#: consumer could not check the mode against the resolver the runtime actually
#: uses, so neither the effective mode nor the degradation flag may be claimed.
VERIFICATION_LIVE_CAPTURE = "LIVE_CAPTURE"
VERIFICATION_DEVICE_CALIBRATION = "DEVICE_CALIBRATION"
VERIFICATION_UNVERIFIED = "UNVERIFIED"

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
MODE_VERIFIED_KEY = "recognitionModeVerified"
MODE_VERIFICATION_SOURCE_KEY = "recognitionModeVerificationSource"
MODE_DECISION_KEY = MODE_EFFECTIVE_KEY


def resolve_effective_recognition_mode(
    *,
    declared_mode: str,
    margin: float | None,
    threshold: float | None = None,
) -> tuple[str, str | None]:
    """Return ``(effective_mode, degraded_reason)`` for one device configuration.

    ``declared_mode`` is what the operator's bindings would allow. The effective mode
    is what the runtime can actually enforce:

    * missing ``margin`` -> ``SUSPECT_ONLY`` + ``MARGIN_CALIBRATION_MISSING``
    * margin present -> the declared mode, no reason
    * ``declared_mode`` already ``SUSPECT_ONLY`` -> returned untouched, never degraded

    ``threshold`` is accepted only so audit/readiness callers can pass the operating
    point they report: it is **informational**. ``AsrCaptureService`` narrows its
    candidate references on ``margin is None`` alone (see ``_narrow_decision``), and a
    ``MODEL_BASELINE`` threshold is still the number ``decide_speaker`` compares
    against. Deriving a degradation from the threshold's provenance made readiness
    announce a suspect-only narrowing the runtime does not perform.
    """

    declared = _validate_mode(declared_mode)
    if declared == SUSPECT_ONLY:
        return SUSPECT_ONLY, None
    if margin is None:
        # Margins are the only documented degradation channel: they are exactly the
        # condition the capture runtime narrows on.
        return DEGRADED_MODE, DEGRADED_REASON_MARGIN_CALIBRATION_MISSING
    return declared, None


def decision_roles(
    *,
    declared_mode: str,
    margin: float | None,
    threshold: float | None = None,
) -> set[SpeakerRole]:
    """The roles the runtime may attribute to under this operating point."""
    effective, _reason = resolve_effective_recognition_mode(
        declared_mode=declared_mode, margin=margin, threshold=threshold
    )
    if effective == SUSPECT_ONLY:
        return {SpeakerRole.SUSPECT}
    return {SpeakerRole(role) for role in _MODE_ROLES[effective]}


def is_degraded(
    *, declared_mode: str, margin: float | None, threshold: float | None = None
) -> bool:
    return resolve_effective_recognition_mode(
        declared_mode=declared_mode, margin=margin, threshold=threshold
    )[1] is not None


def narrow_decision_roles(
    *,
    declared_mode: str,
    margin: float | None,
    threshold: float | None = None,
    enabled_roles: Iterable[SpeakerRole],
    candidates: Sequence[Mapping[str, Any]],
) -> tuple[set[SpeakerRole], list[Mapping[str, Any]]]:
    """Narrow bound roles/candidates to what this operating point can enforce.

    When the effective mode is suspect-only, officer candidates are dropped *before*
    scoring so an uncalibrated device can never attribute a fragment to an officer.

    A candidate only participates when its ``role`` is a :class:`SpeakerRole` member.
    A string role (or any other shape) carries no binding and is dropped, so a
    caller cannot smuggle an officer attribution past the narrowing with a raw
    string -- the historical runtime predicate compared against the enum too.
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
    threshold: float | None = None,
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


def resolve_runtime_speaker_mode(
    *,
    app_state: Any,
    case_id: str | None = None,
    db: Any | None = None,
) -> SpeakerModeConfig:
    """The operating point the runtime will use for ``case_id``, resolved in its order.

    This is the only entry point a "what will really happen" consumer may use, and it
    asks exactly the places the capture runtime asks:

    1. the live capture's own status payload (a running capture already fixed its
       operating point when ``start()`` resolved the calibration);
    2. the device-calibration resolver the capture service was built with -- the very
       same closure ``AsrCaptureService._resolve_calibration`` calls;
    3. only then the AI supervisor / process settings, reported as **unverified**
       because that is not where a calibration-configured runtime reads from.

    Reading the supervisor first is the defect this function exists to prevent: on a
    device whose DB calibration went STALE the supervisor still advertises
    ``SUSPECT_SPEAKER_MARGIN`` while the runtime resolves ``margin=None``.
    """

    live_failed = False
    if case_id:
        live, live_failed = _live_capture_config(
            getattr(app_state, "asr_capture_service", None), case_id
        )
        if live is not None:
            return live

    resolved = _device_calibration_config(
        app_state,
        db,
        # A capture whose status could not be read may be running on a snapshot older
        # than the DB calibration, so the resolver's answer is not proof either.
        verification_source=(
            VERIFICATION_UNVERIFIED if live_failed else VERIFICATION_DEVICE_CALIBRATION
        ),
    )
    if resolved is not None:
        return resolved

    logger.info(
        "speaker operating point unresolved for case %s: reporting supervisor/settings as UNVERIFIED",
        case_id,
    )
    return SpeakerModeConfig.from_sources(
        [
            getattr(app_state, "ai_supervisor", None),
            getattr(app_state, "runtime_settings", None),
        ],
        verification_source=VERIFICATION_UNVERIFIED,
    )


def _live_capture_config(
    capture_service: Any, case_id: str
) -> tuple[SpeakerModeConfig | None, bool]:
    """Operating point of the capture running for ``case_id``.

    Returns ``(config, failed)``. ``config`` is ``None`` when there is nothing to read
    (no service, no capture for this case, or a stopped capture whose status payload
    degenerated to ``caseId/active/status/...``). ``failed`` says the status call itself
    raised, which the caller must not treat as "no capture running".

    ``status`` is called with the case id it requires. The previous implementation
    called ``status()`` with no argument against a production
    ``SourceAwareAsrCaptureService.status(self, case_id)`` and swallowed the resulting
    ``TypeError``, so this source could never produce a value.
    """

    status_fn = getattr(capture_service, "status", None)
    if not callable(status_fn):
        return None, False
    try:
        payload = status_fn(case_id)
    except Exception:
        # Never block readiness, and never hide the failure either: the caller reports
        # whatever it falls back to as unverified instead of standing in for the runtime.
        logger.warning("capture status(%s) failed", case_id, exc_info=True)
        return None, True
    return SpeakerModeConfig.from_runtime_status(payload), False


def _device_calibration_config(
    app_state: Any,
    db: Any | None,
    *,
    verification_source: str = VERIFICATION_DEVICE_CALIBRATION,
) -> SpeakerModeConfig | None:
    """Resolve the device calibration with the runtime's own resolver closure."""

    factory = getattr(app_state, "speaker_calibration_resolver_factory", None)
    if not callable(factory):
        return None
    resolver = None
    try:
        resolver = factory(_request_audio_source())
    except Exception:
        logger.warning("speaker calibration resolver could not be built", exc_info=True)
        return None
    if not callable(resolver):
        return None

    try:
        if db is not None:
            resolved = resolver(db)
        else:
            # /health/* has no request-scoped session; borrow the app's factory so the
            # capability report still reflects the DB the runtime reads.
            session_factory = getattr(app_state, "session_factory", None)
            if not callable(session_factory):
                return None
            with session_factory() as session:
                resolved = resolver(session)
    except Exception:
        logger.warning("speaker calibration resolution failed", exc_info=True)
        return None
    return SpeakerModeConfig.from_resolved_calibration(resolved).with_verification_source(
        verification_source
    )


def _request_audio_source() -> str:
    """The audio source this request will capture from (imported lazily: no cycles)."""

    from app.request_audio_context import current_request_audio_source

    return current_request_audio_source("ALSA")


@dataclass(frozen=True)
class SpeakerModeConfig:
    """Resolved runtime speaker operating point (threshold + margin + provenance).

    ``verification_source`` records how the operating point was established. It is
    ``UNVERIFIED`` unless a caller resolved it from the same place the runtime
    resolves it (a live capture, or the device-calibration resolver the capture
    service was built with). An unverified configuration must never be reported as
    an effective mode or as "not degraded".
    """

    margin: float | None
    threshold: float | None
    threshold_source: str | None
    margin_source: str | None = None
    verification_source: str = VERIFICATION_UNVERIFIED

    @property
    def verified(self) -> bool:
        return self.verification_source != VERIFICATION_UNVERIFIED

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
    def from_sources(
        cls,
        sources: Iterable[Any],
        *,
        verification_source: str = VERIFICATION_UNVERIFIED,
    ) -> "SpeakerModeConfig":
        """Resolve the operating point from the first source that carries one.

        Sources are ordered by precedence: an active capture runtime wins over the
        AI supervisor, which wins over process settings. Both the snake_case
        supervisor/settings shape and the camelCase ``AsrCaptureService.status()``
        payload are understood so callers never re-derive the values themselves.

        The result is **unverified** unless the caller states how it established the
        operating point: a raw source list cannot prove it matches the runtime rule.
        """

        for source in sources:
            config = _config_from(source)
            if config is not None:
                return config.with_verification_source(verification_source)
        return cls(
            margin=None,
            threshold=None,
            threshold_source=None,
            verification_source=verification_source,
        )

    @classmethod
    def from_runtime_status(
        cls, payload: Mapping[str, Any] | None
    ) -> "SpeakerModeConfig | None":
        """Operating point of a live capture, or ``None`` when the payload has none.

        ``AsrCaptureService.status(case_id)`` reports the full operating point only
        while a capture is running; once it stopped the payload degenerates to
        ``caseId/active/status/...``. Callers must then resolve the device
        calibration instead of silently re-using whatever else is lying around.
        """

        if not isinstance(payload, Mapping):
            return None
        config = _config_from(payload)
        if config is None:
            return None
        return config.with_verification_source(VERIFICATION_LIVE_CAPTURE)

    @classmethod
    def from_resolved_calibration(cls, resolved: Any) -> "SpeakerModeConfig":
        """Operating point the capture runtime resolves at ``start()`` time."""
        margin = getattr(resolved, "margin", None)
        return cls(
            margin=None if margin is None else float(margin),
            threshold=_float_or_none(getattr(resolved, "threshold", None)),
            threshold_source=_optional_text(getattr(resolved, "source", None)),
            margin_source=_optional_text(getattr(resolved, "status", None)),
            verification_source=VERIFICATION_DEVICE_CALIBRATION,
        )

    def with_verification_source(self, verification_source: str) -> "SpeakerModeConfig":
        if verification_source == self.verification_source:
            return self
        return SpeakerModeConfig(
            margin=self.margin,
            threshold=self.threshold,
            threshold_source=self.threshold_source,
            margin_source=self.margin_source,
            verification_source=verification_source,
        )

    def as_readiness_fields(self, declared_mode: str) -> dict[str, Any]:
        """Readiness payload fields for this operating point.

        Verified: the rule outcome plus the operating point it was derived from.
        Unverified: the operating point is still reported (it is what is known), but
        ``effectiveRecognitionMode`` and ``recognitionModeDegraded`` are ``None``
        because the runtime's口径 could not be checked. A client must read
        ``recognitionModeVerified`` before showing either.
        """

        fields: dict[str, Any] = {
            "speakerMargin": self.margin,
            "speakerThreshold": self.threshold,
            "thresholdSource": self.threshold_source,
            "marginConfigured": self.margin_configured,
            "thresholdConfigured": self.threshold_configured,
            MODE_DECLARED_KEY: declared_mode,
            MODE_VERIFIED_KEY: self.verified,
            MODE_VERIFICATION_SOURCE_KEY: self.verification_source,
        }
        if not self.verified:
            fields.update(
                {
                    MODE_EFFECTIVE_KEY: None,
                    MODE_DEGRADED_KEY: None,
                    MODE_REASON_KEY: None,
                }
            )
            return fields

        effective, reason = self.resolve(declared_mode)
        fields.update(
            {
                MODE_EFFECTIVE_KEY: effective,
                MODE_DEGRADED_KEY: reason is not None,
                MODE_REASON_KEY: reason,
            }
        )
        return fields


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
    """The :class:`SpeakerRole` a candidate declares, or ``None``.

    A string role is **not** a binding: it is dropped rather than coerced, matching
    the runtime predicate this module replaced (``item.get("role") is
    SpeakerRole.SUSPECT``) and keeping a raw string from bypassing the narrowing.
    """

    raw = item.get("role") if hasattr(item, "get") else None
    return raw if isinstance(raw, SpeakerRole) else None


def _float_or_none(value: Any) -> float | None:
    if value is None or isinstance(value, bool):
        return None
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def _optional_text(value: Any) -> str | None:
    if value is None:
        return None
    text = str(value).strip()
    return text or None


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
    source_text = _optional_text(threshold_source)
    # The threshold is reported verbatim, provenance included. A MODEL_BASELINE
    # value is still the number the runtime compares every score against, and the
    # mode rule ignores the threshold entirely, so hiding it here only made the
    # readiness payload disagree with the runtime.

    return SpeakerModeConfig(
        margin=_float_or_none(margin_raw),
        threshold=threshold,
        threshold_source=source_text,
    )
