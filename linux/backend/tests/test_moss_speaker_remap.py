import json

import pytest

from moss_worker.types import NormalizedSegment, ParseStatus, MergeStatus, WindowSpec


P = WindowSpec(0, 720000, 0, 12)
C = WindowSpec(600000, 1320000, 0, 12)


def seg(start=610000, end=611000, text='你几点到的', local='S01', global_=None, window='p'):
    return NormalizedSegment(f'{window}-{start}-{local}', window, start, end, local,
                             global_, text, None, ParseStatus.VALID,
                             MergeStatus.PRIMARY, None, 'manifest')


def test_score_exact_weights_and_normalization():
    from moss_worker.speaker_remap import segment_match_score
    a = seg(1000, 2000)
    b = seg(1020, 2010, '你是几点到的')
    assert segment_match_score(a, b, 1) > .80
    assert segment_match_score(a, seg(1000, 2000, '你 几点，到的！'), 1) == pytest.approx(1)
    assert segment_match_score(a, a, 0) == pytest.approx(.9)


def test_assignment_distinct_and_state_survives_hour_boundary():
    from moss_worker.speaker_remap import SpeakerRemapper
    r = SpeakerRemapper()
    previous = r.map_adjacent((), (seg(), seg(620000, 621000, '到了', 'S02')), P, P)
    current = r.map_adjacent(previous, (seg(local='S02', window='c'),
                            seg(620000, 621000, '到了', 'S01', window='c')), P, C)
    assert [s.global_speaker for s in current] == ['GS01', 'GS02']
    r = SpeakerRemapper(json.loads(json.dumps(r.to_dict())))
    late = WindowSpec(3480000, 4200000, 1, 12)
    out = r.map_adjacent((), (seg(3600000, 3601000, window='late'),), C, late)
    assert out[0].global_speaker == 'GS03'


def test_weak_votes_do_not_sum_into_inheritance_and_have_evidence():
    from moss_worker.speaker_remap import SpeakerRemapper
    r = SpeakerRemapper()
    previous = tuple(seg(610000+i*2000, 611000+i*2000, global_='GS09') for i in range(8))
    current = tuple(seg(s.start_ms, s.end_ms, '完全不同', window='c') for s in previous)
    out = r.map_adjacent(previous, current, P, C)
    assert {s.global_speaker for s in out} == {'GS10'}
    assert all(s.speaker_mapping_confidence < .85 for s in out)
    assert r.to_dict()['windows']['c']['S01']['candidates']['GS09'] < .85


def test_empty_no_overlap_and_identity_rejected():
    from moss_worker.speaker_remap import SpeakerRemapper
    r = SpeakerRemapper()
    assert r.map_adjacent((), (), P, C) == ()
    assert r.map_adjacent((), (seg(),), P, C)[0].global_speaker == 'GS01'
    with pytest.raises(ValueError, match='local'):
        r.map_adjacent((), (seg(local='张三'),), P, C)


def test_replay_preserves_weak_label_and_state_is_detached():
    from moss_worker.speaker_remap import SpeakerRemapper
    r = SpeakerRemapper()
    b = seg(window='c')
    first = r.map_adjacent((), (b,), None, C)
    state = r.to_dict()
    restored = SpeakerRemapper(state)
    state['next_global_id'] = 900
    before = restored.to_dict()
    replay = restored.map_adjacent((seg(global_='GS08'),), (b,), P, C)
    assert replay == first
    assert restored.to_dict() == before
    assert restored.to_dict()['next_global_id'] == 2


def test_two_locals_competing_for_one_global_do_not_collapse():
    from moss_worker.speaker_remap import SpeakerRemapper
    r = SpeakerRemapper()
    previous = (seg(global_='GS01'), seg(620000, 621000, global_='GS01'))
    current = (seg(local='S02', window='c'), seg(620000, 621000, local='S01', window='c'))
    out = r.map_adjacent(previous, current, P, C)
    assert [s.global_speaker for s in out] == ['GS02', 'GS01']


def test_real_cross_hour_overlap_inherits_existing_global():
    from moss_worker.speaker_remap import SpeakerRemapper
    before = WindowSpec(2880000, 3600000, 0, 12)
    after = WindowSpec(3480000, 4200000, 1, 12)
    old = seg(3500000, 3501000, global_='GS17')
    new = seg(3500000, 3501000, local='S09', window='after')
    out, = SpeakerRemapper().map_adjacent((old,), (new,), before, after)
    assert (out.global_speaker, out.speaker_mapping_confidence) == ('GS17', 1)


def test_partial_replay_never_rewrites_previously_allocated_label():
    from moss_worker.speaker_remap import SpeakerRemapper
    r = SpeakerRemapper()
    first = r.map_adjacent((), (seg(window='c'),), None, C)
    current = (seg(window='c'), seg(620000, 621000, local='S02', window='c'))
    out = r.map_adjacent((seg(global_='GS08'),), current, P, C)
    assert out[0].global_speaker == first[0].global_speaker
    assert out[1].global_speaker != out[0].global_speaker


def test_plan_dict_score_contract():
    from moss_worker.speaker_remap import segment_match_score
    assert segment_match_score(dict(start_ms=1000, end_ms=2000, text='你几点到的'),
                               dict(start_ms=1020, end_ms=2010, text='你是几点到的'), 1) > .80


def test_assignment_budget_fails_explicitly_before_factorial_work():
    from moss_worker.speaker_remap import SpeakerRemapper, SpeakerAssignmentLimit
    previous = tuple(seg(610000+i*2000, 611000+i*2000, local=f'S{i:02d}', global_=f'GS{i:02d}') for i in range(11))
    current = tuple(seg(s.start_ms, s.end_ms, local=s.local_speaker, window='c') for s in previous)
    with pytest.raises(SpeakerAssignmentLimit, match='MOSS_SPEAKER_ASSIGNMENT_LIMIT'):
        SpeakerRemapper().map_adjacent(previous, current, P, C)
