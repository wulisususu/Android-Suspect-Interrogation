"""Merge adjacent windows without clipping utterances or hiding disagreements."""
from dataclasses import replace

from .speaker_remap import normalize_text, overlap_pairs
from .types import MergeStatus, ParseStatus


def merge_adjacent(previous, current, previous_window, current_window):
    previous, current = tuple(previous), tuple(current)
    pairs = overlap_pairs(previous, current, previous_window, current_window, same_global=True)
    matched = set()
    output = []
    for a, b, score, order in pairs:
        # Temporal overlap alone does not establish duplicate speech.
        intersection = min(a.end_ms, b.end_ms) - max(a.start_ms, b.start_ms)
        duration = max(a.end_ms-a.start_ms, b.end_ms-b.start_ms)
        if intersection / duration < .5:
            continue
        midpoint = (max(previous_window.start_ms, current_window.start_ms)
                    + min(previous_window.end_ms, current_window.end_ms)) / 2
        def quality(s, window, is_current):
            edge_distance = min(s.start_ms-window.start_ms, window.end_ms-s.end_ms)
            conflicts = sum(1 for other in previous + current
                            if other is not a and other is not b
                            and other.window_id == s.window_id
                            and min(s.end_ms, other.end_ms) > max(s.start_ms, other.start_ms))
            owner = ((s.start_ms+s.end_ms)/2 >= midpoint) == is_current
            return edge_distance, s.parse_status is ParseStatus.VALID, -conflicts, owner
        primary, alternate = (a, b) if quality(a, previous_window, False) >= quality(b, current_window, True) else (b, a)
        if normalize_text(a.text) != normalize_text(b.text) or a.global_speaker != b.global_speaker:
            primary = replace(primary, merge_status=MergeStatus.CONFLICT, alternate=alternate)
        output.append(primary)
        matched.update((id(a), id(b)))
    output.extend(s for s in previous + current if id(s) not in matched)
    return tuple(sorted(output, key=lambda s: (s.start_ms, s.end_ms, s.window_id, s.segment_id)))
