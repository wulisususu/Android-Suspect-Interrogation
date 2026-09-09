"""Parse window-local MOSS text; generation-limit checks belong to the caller."""
from dataclasses import dataclass
from decimal import Decimal, ROUND_HALF_UP, localcontext
import re

from .types import MergeStatus, NormalizedSegment, ParseStatus, WindowSpec


_TIMESTAMP = re.compile(r'\[([0-9]+(?:\.[0-9]+)?)\]')
_SPEAKER = re.compile(r'\[(S[0-9]{2,})\]')

# The model emits timestamps on a 10 ms raster, so a window filled with audio
# can land its final end stamp one raster step past the window end.
# User-approved 2026-09-09: clamp exactly that overshoot; anything larger, and
# any start-timestamp overshoot, stays invalid without semantic guessing.
END_CLAMP_TOLERANCE = Decimal('0.010')

END_TIMESTAMP_CLAMPED_TO_WINDOW_END = 'END_TIMESTAMP_CLAMPED_TO_WINDOW_END'
END_MISSING_REPAIRED_FROM_NEXT_START = 'END_MISSING_REPAIRED_FROM_NEXT_START'
DANGLING_TRAILING_TIMESTAMP_DROPPED = 'DANGLING_TRAILING_TIMESTAMP_DROPPED'


@dataclass(frozen=True)
class InvalidFragment:
    raw: str
    reason: str
    parse_status: ParseStatus = ParseStatus.INVALID


@dataclass(frozen=True)
class ParsedGeneration:
    valid_segments: tuple[NormalizedSegment, ...]
    invalid_fragments: tuple[InvalidFragment, ...]
    raw_generation: str
    repair_reason: str | None = None
    repair_original_text: str | None = None


def _absolute_ms(seconds: Decimal, offset: int) -> int:
    # Preserve arbitrary fractional precision before rounding ties upward.
    with localcontext() as context:
        context.prec = max(28, len(seconds.as_tuple().digits) + 4)
        return offset + int((seconds * 1000).to_integral_value(rounding=ROUND_HALF_UP))


def parse_generation(
    raw: str, window: WindowSpec, *, window_id: str | None = None,
    model_manifest_sha256: str = '',
) -> ParsedGeneration:
    """Keep a valid prefix and retain the first invalid suffix verbatim.

    Only a shared timestamp immediately followed by a speaker can repair an
    omitted end. A segment end at most one raster half-step (10 ms) past the
    window end is clamped to the window end and keeps its original value for
    audit; a terminal fragment that is only a dangling timestamp is dropped
    with its verbatim text because it carries no semantic content. Every other
    defect keeps the strict first-error stop. Times must be ordered and inside
    the window before rounding to nearest milliseconds (half up). Empty
    provenance is explicitly unknown; the runtime must supply its actual
    manifest digest before publication.
    """
    if window.start_ms < 0 or window.end_ms < window.start_ms:
        raise ValueError('Window must have nonnegative ordered bounds')
    identity = window_id if window_id is not None else (
        f'{window.logical_chunk_index}:{window.start_ms}:{window.end_ms}:{window.window_minutes}')
    duration = Decimal(window.end_ms - window.start_ms) / 1000
    segments = []
    invalid = []
    position = 0
    previous_end = Decimal(0)
    while position < len(raw):
        if raw[position].isspace():
            position += 1
            continue
        fragment_start = position
        start_token = _TIMESTAMP.match(raw, position)
        reason = 'Expected a nonnegative decimal start timestamp'
        if start_token:
            start = Decimal(start_token[1])
            speaker = _SPEAKER.match(raw, start_token.end())
            reason = 'Start timestamp is decreasing or outside the window'
            if previous_end <= start <= duration:
                reason = 'Expected speaker S followed by at least two digits'
                if speaker:
                    text_end = raw.find('[', speaker.end())
                    text = raw[speaker.end():text_end] if text_end >= 0 else ''
                    end_token = _TIMESTAMP.match(raw, text_end) if text_end >= 0 else None
                    reason = 'Missing or malformed end timestamp, or empty text'
                    if end_token and text.strip() and ']' not in text:
                        end = Decimal(end_token[1])
                        reason = 'End timestamp is decreasing or outside the window'
                        if start <= end <= duration + END_CLAMP_TOLERANCE:
                            overshoot_ms = (_absolute_ms(end, window.start_ms)
                                            if end > duration else None)
                            if overshoot_ms is not None:
                                end = duration
                            shared = _SPEAKER.match(raw, end_token.end()) is not None
                            if overshoot_ms is not None:
                                repair_reason = END_TIMESTAMP_CLAMPED_TO_WINDOW_END
                            elif shared:
                                repair_reason = END_MISSING_REPAIRED_FROM_NEXT_START
                            else:
                                repair_reason = None
                            segments.append(NormalizedSegment(
                                segment_id=f'{identity}:{fragment_start}', window_id=identity,
                                start_ms=_absolute_ms(start, window.start_ms),
                                end_ms=_absolute_ms(end, window.start_ms),
                                local_speaker=speaker[1], global_speaker=None,
                                text=text.strip(), speaker_mapping_confidence=None,
                                parse_status=ParseStatus.REPAIRED if (shared or overshoot_ms is not None)
                                             else ParseStatus.VALID,
                                merge_status=MergeStatus.PRIMARY, alternate=None,
                                model_manifest_sha256=model_manifest_sha256,
                                repair_reason=repair_reason,
                                repair_original_end_ms=overshoot_ms))
                            previous_end = end
                            position = text_end if shared else end_token.end()
                            continue
        if start_token and not raw[start_token.end():].strip():
            # Terminal fragment is only a dangling timestamp: no speaker and no
            # text follows, so it carries no semantic content. Drop it without
            # guessing instead of invalidating the completed prefix.
            return ParsedGeneration(tuple(segments), tuple(invalid), raw,
                                    repair_reason=DANGLING_TRAILING_TIMESTAMP_DROPPED,
                                    repair_original_text=raw[fragment_start:])
        invalid.append(InvalidFragment(raw[fragment_start:], reason))
        break
    return ParsedGeneration(tuple(segments), tuple(invalid), raw)
