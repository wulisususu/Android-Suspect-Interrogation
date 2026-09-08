import json

import numpy as np
import pytest

from moss_worker.embedding_builder import MossEmbeddingBuilder, TokenEmbeddingTable
from moss_worker.windowing import ContextBudgetExceeded, plan_windows


class FakeTokenizer:
    def encode(self, text, add_special_tokens=False):
        assert not add_special_tokens
        return [10] if text else []


class FakeTable:
    def lookup(self, ids):
        return np.repeat(np.asarray(ids, dtype=np.float32)[:, None], 8, axis=1)


def builder(tokenizer=None):
    return MossEmbeddingBuilder(
        tokenizer or FakeTokenizer(), FakeTable(), hidden_size=8, audio_token_id=99,
        digit_token_ids={str(i): 200 + i for i in range(10)},
        hop_length=160, chunk_samples=480000, audio_merge_size=4,
    )


def test_integer_marker_placement():
    assert builder().build_audio_span_ids(125) == [99] * 62 + [205] + [99] * 62 + [201, 200] + [99]


def test_only_audio_positions_replaced():
    ids = [10, 99, 11, 99, 99, 99, 12]
    audio = np.arange(32, dtype=np.float32).reshape(4, 8)
    result = builder().build_from_ids(ids, audio)
    np.testing.assert_array_equal(result.input_ids, ids)
    np.testing.assert_array_equal(result.audio_positions, [1, 3, 4, 5])
    np.testing.assert_array_equal(result.embeds[result.audio_positions], audio)
    np.testing.assert_array_equal(result.embeds[[0, 2, 6]], FakeTable().lookup([10, 11, 12]))
    assert result.embeds.dtype == np.float32 and result.embeds.flags.c_contiguous


@pytest.mark.parametrize('audio', [np.zeros((3, 8)), np.zeros((4, 7)), np.zeros((1, 4, 8)), np.full((4, 8), np.nan), np.full((4, 8), np.inf)])
def test_rejects_invalid_audio(audio):
    with pytest.raises(ValueError):
        builder().build_from_ids([99] * 4, audio)


def test_complete_prompt_expands_once_and_tokenizes_each_side():
    result = builder().build('before<|audio_pad|>after', np.zeros((125, 8)))
    assert result.input_ids.tolist() == [10] + builder().build_audio_span_ids(125) + [10]
    for prompt in ('missing', '<|audio_pad|><|audio_pad|>'):
        with pytest.raises(ValueError, match='exactly one'):
            builder().build(prompt, np.zeros((1, 8)))


@pytest.mark.parametrize('count, fits', [(10752, True), (10753, False)])
def test_actual_context_boundary(count, fits):
    if fits:
        assert builder().build_from_ids([10] * count, np.empty((0, 8))).embeds.shape == (count, 8)
    else:
        with pytest.raises(ContextBudgetExceeded):
            builder().build_from_ids([10] * count, np.empty((0, 8)))


def test_real_interval_counter_rejects_twelve_and_counts_clipped_tail():
    class ExpensiveTokenizer(FakeTokenizer):
        def encode(self, text, add_special_tokens=False):
            return [10] * 1500 if text else []

    subject = builder(ExpensiveTokenizer())
    calls = []
    def samples(start, end):
        calls.append((start, end))
        return (end - start) * 16
    counter = subject.interval_counter('before<|audio_pad|>', samples)
    assert 1500 + 12 * 60 * 12.5 < 10752  # Estimate misses timestamp digits.
    windows = plan_windows(13 * 60000, counter)
    assert windows[0].window_minutes == 10
    assert calls[:2] == [(0, 720000), (0, 600000)]
    assert calls[-1] == (480000, 780000)
    assert counter(0, 30001) == len(subject.expand_input_ids('before<|audio_pad|>', 376))


def test_table_reads_fp16_little_endian_rows_only(tmp_path):
    values = np.arange(40, dtype='<f2').reshape(5, 8)
    path = tmp_path / 'table.bin'
    values.tofile(path)
    table = TokenEmbeddingTable(path, rows=5, hidden_size=8)
    result = table.lookup([4, 1, 4])
    np.testing.assert_array_equal(result, values[[4, 1, 4]].astype(np.float32))
    assert result.dtype == np.float32 and result.flags.c_contiguous
    for ids in ([-1], [5], [1.5], [[1]]):
        with pytest.raises(ValueError):
            table.lookup(ids)


def test_table_rejects_truncated_file_and_nonfinite_rows(tmp_path):
    path = tmp_path / 'table.bin'
    np.array([np.nan] * 8, dtype='<f2').tofile(path)
    with pytest.raises(ValueError):
        TokenEmbeddingTable(path, rows=2, hidden_size=8)
    with pytest.raises(ValueError):
        TokenEmbeddingTable(path, rows=1, hidden_size=8).lookup([0])


def test_from_bundle_uses_local_tokenizer_and_required_metadata(tmp_path):
    from tokenizers import Tokenizer
    from tokenizers.models import WordLevel

    vocab = {str(i): i for i in range(10)} | {'<|audio_pad|>': 10, 'hello': 11}
    tokenizer = Tokenizer(WordLevel(vocab, unk_token='hello'))
    tokenizer.save(str(tmp_path / 'tokenizer.json'))
    np.zeros((12, 1024), dtype='<f2').tofile(tmp_path / 'moss_token_embedding_fp16.bin')
    (tmp_path / 'token_embedding.json').write_text(json.dumps({
        'rows': 12, 'hidden_size': 1024, 'dtype': 'float16', 'byte_order': 'little', 'order': 'C',
    }))
    config = {'audio_tokens_per_second': 12.5, 'audio_merge_size': 4,
              'time_marker_every_seconds': 5, 'enable_time_marker': True,
              'feature_extractor': {'hop_length': 160, 'n_samples': 480000, 'sampling_rate': 16000}}
    (tmp_path / 'processor_config.json').write_text(json.dumps(config))
    subject = MossEmbeddingBuilder.from_bundle(tmp_path)
    assert subject.expand_input_ids('hello<|audio_pad|>', 1) == [11, 10]
    assert subject.build('hello<|audio_pad|>', np.ones((1, 1024))).embeds.shape == (2, 1024)
    assert subject.interval_counter('<|audio_pad|>', lambda start, end: 480001)(0, 30001) == len(subject.build_audio_span_ids(376))
    del config['feature_extractor']['hop_length']
    (tmp_path / 'processor_config.json').write_text(json.dumps(config))
    with pytest.raises(ValueError, match='metadata'):
        MossEmbeddingBuilder.from_bundle(tmp_path)


def test_interval_counter_requires_real_samples_and_metadata():
    subject = builder()
    with pytest.raises(ValueError):
        subject.interval_counter('<|audio_pad|>', None)
    subject.hop_length = None
    with pytest.raises(ValueError):
        subject.interval_counter('<|audio_pad|>', lambda start, end: 16000)
