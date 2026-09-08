import pytest

from moss_worker.generation_policy import GENERATION_LIMIT_REACHED, classify_generation


def test_complete_generation_below_limit_requires_explicit_normal_end():
    assert classify_generation('[0.0][S01]你好[1.0]', 5119, True) is None
    assert classify_generation('[0.0][S01]甲[1.0][S02]乙[2.0]', 20, True) is None
    assert classify_generation('[0.0][S01]甲[1.0][1.2][S02]乙[2.0]', 20, True) is None


@pytest.mark.parametrize('count', [5120, 5121, None, -1, True])
def test_limit_or_missing_native_token_count_is_never_authoritative(count):
    assert classify_generation('[0.0][S01]你好[1.0]', count, True) == GENERATION_LIMIT_REACHED


@pytest.mark.parametrize('normal', [False, None, 1, 'eos'])
def test_normal_termination_must_be_explicit_boolean(normal):
    assert classify_generation('[0.0][S01]你好[1.0]', 20, normal) == GENERATION_LIMIT_REACHED


@pytest.mark.parametrize('text', [
    '', '[0.0][S01]未结束', '[0.0][S01]你好[1.0]garbage',
    '[0.0][S01]你好[1.0][S02]未结束', '[0.0][S1]你好[1.0]',
    '[0.0][S01][1.0]', '[2.0][S01]倒序[1.0]',
    '[0.0]', '[0.0][1.0][S01]重复起始时间[2.0]',
    '[0.0][S01]你好[1.0][2.0]',
])
def test_incomplete_or_invalid_full_generation_is_rejected(text):
    assert classify_generation(text, 20, True) == GENERATION_LIMIT_REACHED
