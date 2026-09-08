"""Anonymous, overlap-only speaker continuity; never performs identity matching."""
from copy import deepcopy
from dataclasses import replace
from difflib import SequenceMatcher
from itertools import permutations
from math import perm
import re
from types import SimpleNamespace
import unicodedata


MAX_ASSIGNMENT_CANDIDATES = 1_000_000


class SpeakerAssignmentLimit(ValueError):
    pass


def normalize_text(text):
    return ''.join(c for c in unicodedata.normalize('NFKC', text)
                   if not c.isspace() and not unicodedata.category(c).startswith('P'))


def segment_match_score(a, b, order_score):
    a = SimpleNamespace(**a) if isinstance(a, dict) else a
    b = SimpleNamespace(**b) if isinstance(b, dict) else b
    intersection = max(0, min(a.end_ms, b.end_ms) - max(a.start_ms, b.start_ms))
    union = max(a.end_ms, b.end_ms) - min(a.start_ms, b.start_ms)
    da, db = a.end_ms - a.start_ms, b.end_ms - b.start_ms
    text = SequenceMatcher(None, normalize_text(a.text), normalize_text(b.text)).ratio()
    return (.45 * (intersection / union if union else 0) + .35 * text
            + .10 * (min(da, db) / max(da, db) if max(da, db) else 0)
            + .10 * max(0, min(1, order_score)))


def overlap_pairs(previous, current, previous_window, current_window, *, same_global=False):
    """Greedy deterministic utterance matching within the actual window overlap."""
    if previous_window is None:
        return []
    start = max(previous_window.start_ms, current_window.start_ms)
    end = min(previous_window.end_ms, current_window.end_ms)
    if start >= end:
        return []
    left = sorted((s for s in previous if s.start_ms < end and s.end_ms > start),
                  key=lambda s: (s.start_ms, s.end_ms, s.segment_id))
    right = sorted((s for s in current if s.start_ms < end and s.end_ms > start),
                   key=lambda s: (s.start_ms, s.end_ms, s.segment_id))
    candidates = []
    for i, a in enumerate(left):
        for j, b in enumerate(right):
            if same_global and a.global_speaker and b.global_speaker and a.global_speaker != b.global_speaker:
                continue
            if min(a.end_ms, b.end_ms) <= max(a.start_ms, b.start_ms):
                continue
            order = 1 - abs(i / max(1, len(left)-1) - j / max(1, len(right)-1))
            candidates.append((segment_match_score(a, b, order), i, j, order))
    used_left, used_right, pairs = set(), set(), []
    for score, i, j, order in sorted(candidates, key=lambda x: (-x[0], x[1], x[2])):
        if i not in used_left and j not in used_right:
            pairs.append((left[i], right[j], score, order))
            used_left.add(i)
            used_right.add(j)
    return pairs


class SpeakerRemapper:
    """Persist to_dict() between windows, including across logical hour boundaries.

    Each matrix cell is the mean of matched utterance scores, never their sum.
    Exact speaker assignment maximizes the sum of those bounded confidences.
    Low confidence allocates a new label and retains candidate evidence in state.
    """
    def __init__(self, state=None):
        self._state = deepcopy(state) if state is not None else {'next_global_id': 1, 'windows': {}}

    def to_dict(self):
        return deepcopy(self._state)

    def map_adjacent(self, previous, current, previous_window, current_window):
        previous, current = tuple(previous), tuple(current)
        for s in previous + current:
            if not re.fullmatch(r'S\d+', s.local_speaker):
                raise ValueError('Expected anonymous local speaker Sxx')
            if s.global_speaker:
                if not re.fullmatch(r'GS\d+', s.global_speaker):
                    raise ValueError('Expected anonymous global speaker GSxx')
        locals_ = sorted({s.local_speaker for s in current})
        existing = {s.local_speaker: deepcopy(self._state['windows'][s.window_id][s.local_speaker])
                    for s in current if s.local_speaker in self._state['windows'].get(s.window_id, {})}
        if current and all(s.local_speaker in self._state['windows'].get(s.window_id, {}) for s in current):
            return tuple(replace(s,
                global_speaker=self._state['windows'][s.window_id][s.local_speaker]['global_speaker'],
                speaker_mapping_confidence=self._state['windows'][s.window_id][s.local_speaker]['confidence'])
                for s in current)
        for s in previous + current:
            if s.global_speaker:
                self._state['next_global_id'] = max(self._state['next_global_id'], int(s.global_speaker[2:])+1)
        votes = {local: {} for local in locals_}
        evidence = {local: [] for local in locals_}
        for a, b, score, order in overlap_pairs(previous, current, previous_window, current_window):
            if a.global_speaker:
                votes[b.local_speaker].setdefault(a.global_speaker, []).append(score)
                evidence[b.local_speaker].append(dict(previous_segment_id=a.segment_id,
                    current_segment_id=b.segment_id, global_speaker=a.global_speaker,
                    score=score, order_score=order))
        matrix = {local: {g: sum(v)/len(v) for g, v in cells.items()} for local, cells in votes.items()}
        reserved = {entry['global_speaker'] for entry in existing.values()}
        locals_ = [local for local in locals_ if local not in existing]
        globals_ = sorted({g for local in locals_ for g in matrix[local] if g not in reserved})
        count = perm(max(len(locals_), len(globals_)), min(len(locals_), len(globals_)))
        if count > MAX_ASSIGNMENT_CANDIDATES:
            raise SpeakerAssignmentLimit(f'MOSS_SPEAKER_ASSIGNMENT_LIMIT: {count} candidates exceeds {MAX_ASSIGNMENT_CANDIDATES}')
        assignments = []
        if len(locals_) <= len(globals_):
            assignments = (dict(zip(locals_, p)) for p in permutations(globals_, len(locals_)))
        else:
            assignments = (dict(zip(p, globals_)) for p in permutations(locals_, len(globals_)))
        best, best_score = {}, -1
        for assignment in assignments:
            score = sum(matrix[l].get(g, 0) for l, g in assignment.items())
            if score > best_score:
                best, best_score = assignment, score
        mapping = existing
        for local in locals_:
            g = best.get(local)
            confidence = matrix[local].get(g, 0)
            if confidence < .85:
                g = f"GS{self._state['next_global_id']:02d}"
                self._state['next_global_id'] += 1
            mapping[local] = dict(global_speaker=g, confidence=confidence,
                                  candidates=matrix[local], evidence=evidence[local])
        for s in current:
            self._state['windows'].setdefault(s.window_id, {})[s.local_speaker] = deepcopy(mapping[s.local_speaker])
        return tuple(replace(s, global_speaker=mapping[s.local_speaker]['global_speaker'],
                             speaker_mapping_confidence=mapping[s.local_speaker]['confidence']) for s in current)
