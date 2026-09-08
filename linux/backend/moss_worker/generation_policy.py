import re
from decimal import Decimal

from .context_budget import ContextBudget


GENERATION_LIMIT_REACHED = 'GENERATION_LIMIT_REACHED'

_TIME = r'\[([0-9]+(?:\.[0-9]+)?)\]'
_INITIAL_TIME = re.compile(_TIME)
_SEGMENT = re.compile(r'\[S[0-9]{2,}\]([^\[\]]+)' + _TIME)


def classify_generation(text, token_count, normal_termination):
    """Return an error code or None; never publish or discard partial raw output.

    Native token count and normal/EOS termination must come from the runtime.
    Missing metadata fails closed until the real adapter exposes it.
    """
    if (type(token_count) is not int or token_count < 0
            or token_count >= ContextBudget.output_reserve
            or normal_termination is not True):
        return GENERATION_LIMIT_REACHED
    text = text.strip()
    initial = _INITIAL_TIME.match(text)
    if initial is None:
        return GENERATION_LIMIT_REACHED
    position = initial.end()
    previous_end = Decimal(initial.group(1))
    segments = 0
    while position < len(text):
        # MOSS can share the previous end timestamp as the next segment start.
        explicit_start = _INITIAL_TIME.match(text, position) if segments else None
        if explicit_start:
            start = Decimal(explicit_start.group(1))
            if start < previous_end:
                return GENERATION_LIMIT_REACHED
            previous_end = start
            position = explicit_start.end()
        segment = _SEGMENT.match(text, position)
        if segment is None or not segment.group(1).strip():
            return GENERATION_LIMIT_REACHED
        end = Decimal(segment.group(2))
        if end < previous_end:
            return GENERATION_LIMIT_REACHED
        previous_end = end
        position = segment.end()
        segments += 1
    return None if segments else GENERATION_LIMIT_REACHED
