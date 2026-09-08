from dataclasses import replace

from moss_worker.types import MergeStatus, ParseStatus, WindowSpec
from test_moss_speaker_remap import seg, P, C


def test_midpoint_ownership_and_provenance():
    from moss_worker.merger import merge_adjacent
    a = (seg(650000, 651000), seg(670000, 671000))
    b = tuple(replace(s, window_id='c', segment_id='c'+s.segment_id) for s in a)
    out = merge_adjacent(a, b, P, C)
    assert [s.window_id for s in out] == ['p', 'c']
    assert all(s.model_manifest_sha256 == 'manifest' for s in out)


def test_material_text_conflict_retains_full_alternate():
    from moss_worker.merger import merge_adjacent
    a = seg(650000, 651000, '我十点半到的')
    b = seg(650000, 651000, '我十点到的', window='c')
    out, = merge_adjacent((a,), (b,), P, C)
    assert out.merge_status is MergeStatus.CONFLICT
    assert {out.text, out.alternate.text} == {a.text, b.text}
    assert out.alternate.window_id == 'c'


def test_crossing_utterance_never_split_and_unmatched_survives():
    from moss_worker.merger import merge_adjacent
    a = seg(659000, 663000)
    b = seg(659000, 663000, window='c')
    lone = seg(610000, 612000, '独有', window='c')
    out = merge_adjacent((a,), (lone, b), P, C)
    assert len(out) == 2
    assert (out[1].start_ms, out[1].end_ms, out[1].window_id) == (659000, 663000, 'c')


def test_tie_prefers_valid_then_owner_and_no_overlap_keeps_both():
    from moss_worker.merger import merge_adjacent
    a = replace(seg(659000, 661000), parse_status=ParseStatus.REPAIRED)
    b = seg(659000, 661000, window='c')
    assert merge_adjacent((a,), (b,), P, C)[0].window_id == 'c'
    distant = WindowSpec(720000, 1440000, 0, 12)
    assert len(merge_adjacent((a,), (b,), P, distant)) == 2


def test_distinct_known_speakers_same_text_are_not_duplicates():
    from moss_worker.merger import merge_adjacent
    a = seg(global_='GS01')
    b = seg(global_='GS02', window='c')
    assert merge_adjacent((a,), (b,), P, C) == (b, a)


def test_simultaneous_speakers_match_same_global_before_consuming_pairs():
    from moss_worker.merger import merge_adjacent
    a = (replace(seg(global_='GS01'), segment_id='a'),
         replace(seg(global_='GS02'), segment_id='b'))
    b = (replace(seg(global_='GS02', window='c'), segment_id='a'),
         replace(seg(global_='GS01', window='c'), segment_id='b'))
    out = merge_adjacent(a, b, P, C)
    assert len(out) == 2
    assert {s.global_speaker for s in out} == {'GS01', 'GS02'}


def test_equal_edge_and_parse_quality_prefers_fewer_timeline_conflicts():
    from moss_worker.merger import merge_adjacent
    a = seg(659000, 661000, '我十点半到的', global_='GS01')
    b = seg(659000, 661000, '我十点到的', global_='GS01', window='c')
    extra = seg(660000, 662000, '另一句', local='S02', global_='GS02', window='c')
    out = merge_adjacent((a,), (b, extra), P, C)
    primary, preserved = out
    # At the exact midpoint default ownership favors current, but its extra
    # timeline conflict makes the complete previous version preferable.
    assert primary == replace(a, merge_status=MergeStatus.CONFLICT, alternate=b)
    assert (primary.window_id, primary.segment_id, primary.model_manifest_sha256) == (
        a.window_id, a.segment_id, a.model_manifest_sha256)
    assert primary.alternate.to_dict() == b.to_dict()
    assert preserved == extra
