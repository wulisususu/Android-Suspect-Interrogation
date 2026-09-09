import json
from dataclasses import FrozenInstanceError

import pytest

from moss_worker import types
from moss_worker.windowing import WindowSpec


def segment(**changes):
    fields = dict(segment_id='s1', window_id='w1', start_ms=0, end_ms=1000,
                  local_speaker='S01', global_speaker=None, text='你好',
                  speaker_mapping_confidence=None, parse_status=types.ParseStatus.VALID,
                  merge_status=types.MergeStatus.PRIMARY, alternate=None,
                  model_manifest_sha256='manifest',
                  repair_reason=None, repair_original_end_ms=None)
    return types.NormalizedSegment(**(fields | changes))


def test_contract_exports_existing_window_spec_and_exact_states():
    assert types.WindowSpec is WindowSpec
    # Task 16: RECOVERY_REQUIRED is the persisted restart-scan state (V1
    # explicit-recovery ruling); it is terminal-adjacent and never auto-resumed.
    assert [s.name for s in types.JobState] == [
        'QUEUED', 'PREPARING', 'ENCODING', 'BUILDING_EMBEDS', 'DECODING',
        'PARSING', 'REMAPPING', 'MERGING', 'COMPLETED', 'FAILED', 'CANCELLED',
        'RECOVERY_REQUIRED']
    assert [s.name for s in types.WindowState] == ['PENDING', 'RUNNING', 'DONE', 'FAILED']
    assert [s.name for s in types.ParseStatus] == ['VALID', 'REPAIRED', 'INVALID']
    for enum in (types.JobState, types.WindowState, types.ParseStatus, types.MergeStatus):
        assert all(state.value == state.name for state in enum)


def test_segment_roundtrip_preserves_complete_alternate_and_enums():
    alternate = segment(segment_id='s2', text='另一版本', start_ms=20)
    original = segment(alternate=alternate, merge_status=types.MergeStatus.CONFLICT)
    encoded = original.to_dict()
    assert encoded['parse_status'] == 'VALID'
    assert encoded['merge_status'] == 'CONFLICT'
    assert encoded['alternate']['merge_status'] == 'PRIMARY'
    restored = types.NormalizedSegment.from_dict(json.loads(json.dumps(encoded)))
    assert restored == original
    assert restored.alternate == alternate
    assert restored.parse_status is types.ParseStatus.VALID
    assert restored.merge_status is types.MergeStatus.CONFLICT
    assert restored.to_dict() == encoded
    with pytest.raises(FrozenInstanceError):
        restored.text = 'changed'


def test_repair_metadata_roundtrip_and_legacy_checkpoint_compat():
    original = segment(parse_status=types.ParseStatus.REPAIRED,
                       repair_reason='END_TIMESTAMP_CLAMPED_TO_WINDOW_END',
                       repair_original_end_ms=2520010)
    encoded = json.loads(json.dumps(original.to_dict()))
    assert encoded['repair_reason'] == 'END_TIMESTAMP_CLAMPED_TO_WINDOW_END'
    assert encoded['repair_original_end_ms'] == 2520010
    restored = types.NormalizedSegment.from_dict(encoded)
    assert restored == original
    assert restored.to_dict() == encoded
    # Checkpoints written before the repair fields existed must keep loading.
    legacy = {key: value for key, value in encoded.items() if not key.startswith('repair_')}
    tolerant = types.NormalizedSegment.from_dict(legacy)
    assert tolerant.repair_reason is None and tolerant.repair_original_end_ms is None


def test_window_and_job_records_roundtrip_and_detach_mutable_inputs():
    segments = [segment()]
    window = types.WindowResult(
        window_id='w1', window=WindowSpec(0, 720000, 0, 10),
        state=types.WindowState.DONE, audio_sha256='audio',
        model_manifest_sha256='manifest', raw_generation='raw output',
        segments=segments, parse_status=types.ParseStatus.VALID, error=None)
    result = types.JobResult(job_id='j1', audio_sha256='audio',
                            model_manifest_sha256='manifest', segments=segments)
    snapshot = types.JobSnapshot(job_id='j1', state=types.JobState.PARSING,
                                audio_sha256='audio', model_manifest_sha256='manifest',
                                progress=0.5, error=None)
    segments.clear()
    for original in (window, result, snapshot):
        encoded = json.dumps(original.to_dict(), ensure_ascii=False, sort_keys=True)
        restored = type(original).from_dict(json.loads(encoded))
        assert restored == original
        assert json.dumps(restored.to_dict(), ensure_ascii=False, sort_keys=True) == encoded
        with pytest.raises(FrozenInstanceError):
            restored.model_manifest_sha256 = 'changed'
    assert isinstance(window.segments, tuple) and len(window.segments) == 1
    assert isinstance(result.segments, tuple) and len(result.segments) == 1
    assert types.WindowResult.from_dict(window.to_dict()).state is types.WindowState.DONE
    assert types.JobSnapshot.from_dict(snapshot.to_dict()).state is types.JobState.PARSING
    assert window.to_dict()['state'] == 'DONE'
    assert snapshot.to_dict()['state'] == 'PARSING'
    assert window.token_count is None and window.normal_termination is None
    evidence = window.to_dict() | {'token_count': 5120, 'normal_termination': False}
    assert types.WindowResult.from_dict(evidence).to_dict() == evidence


def test_missing_required_field_and_invalid_enum_fail_clearly():
    data = segment().to_dict()
    del data['segment_id']
    with pytest.raises((KeyError, TypeError), match='segment_id'):
        types.NormalizedSegment.from_dict(data)
    data = segment().to_dict()
    data['parse_status'] = 'not-a-status'
    with pytest.raises(ValueError, match='not-a-status'):
        types.NormalizedSegment.from_dict(data)
