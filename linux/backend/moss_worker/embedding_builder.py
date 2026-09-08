"""Build MOSS input embeddings without importing a model conversion runtime."""

import json
from dataclasses import dataclass
from pathlib import Path

import numpy as np

from .context_budget import ContextBudget
from .windowing import ContextBudgetExceeded


def _ids(ids):
    values = np.asarray(ids)
    if values.ndim != 1 or (values.size and values.dtype.kind not in 'iu'):
        raise ValueError('Token IDs must be a one-dimensional integer sequence')
    if values.size and (np.any(values < 0) or np.any(values > np.iinfo(np.int64).max)):
        raise ValueError('Token IDs must be non-negative int64 values')
    return values.astype(np.int64)


class TokenEmbeddingTable:
    def __init__(self, path, *, rows, hidden_size=1024):
        if type(rows) is not int or rows <= 0 or type(hidden_size) is not int or hidden_size <= 0:
            raise ValueError('Embedding dimensions must be positive integers')
        if Path(path).stat().st_size != rows * hidden_size * 2:
            raise ValueError('Embedding file size does not match metadata')
        self.rows = rows
        self.hidden_size = hidden_size
        self._table = np.memmap(path, dtype='<f2', mode='r', shape=(rows, hidden_size))

    def lookup(self, ids):
        ids = _ids(ids)
        if np.any(ids >= self.rows):
            raise ValueError('Token ID outside embedding table')
        values = np.ascontiguousarray(self._table[ids], dtype=np.float32)
        if not np.isfinite(values).all():
            raise ValueError('Token embeddings contain nonfinite values')
        return values


@dataclass(frozen=True)
class EmbeddingInput:
    embeds: np.ndarray
    audio_positions: np.ndarray
    input_ids: np.ndarray


class MossEmbeddingBuilder:
    def __init__(
        self, tokenizer, table, *, digit_token_ids, hidden_size=1024,
        audio_token_id=151671, audio_tokens_per_second=12.5,
        time_marker_every_seconds=5, enable_time_marker=True,
        hop_length=None, chunk_samples=None, audio_merge_size=None,
        budget=ContextBudget(),
    ):
        self.tokenizer = tokenizer
        self.table = table
        self.hidden_size = hidden_size
        self.audio_token_id = audio_token_id
        self.digit_token_ids = digit_token_ids
        self.audio_tokens_per_second = audio_tokens_per_second
        self.time_marker_every_seconds = time_marker_every_seconds
        self.enable_time_marker = enable_time_marker
        self.hop_length = hop_length
        self.chunk_samples = chunk_samples
        self.audio_merge_size = audio_merge_size
        self.budget = budget

    @classmethod
    def from_bundle(cls, path):
        """Load only local JSON, Rust tokenizer, and the FP16 embedding table."""
        from tokenizers import Tokenizer

        path = Path(path)
        metadata = json.loads((path / 'token_embedding.json').read_text(encoding='utf-8'))
        config = json.loads((path / 'processor_config.json').read_text(encoding='utf-8'))
        try:
            if (metadata['hidden_size'], metadata['dtype'], metadata['byte_order'], metadata['order']) != (1024, 'float16', 'little', 'C'):
                raise ValueError('Unsupported token embedding metadata')
            feature = config['feature_extractor']
            if feature['sampling_rate'] != 16000:
                raise ValueError('Feature extractor metadata must use 16000 Hz')
            feature_args = dict(hop_length=feature['hop_length'], chunk_samples=feature['n_samples'],
                                audio_merge_size=config['audio_merge_size'])
            if any(type(value) is not int or value <= 0 for value in feature_args.values()):
                raise ValueError('Invalid feature extractor metadata')
            marker_args = {key: config[key] for key in (
                'audio_tokens_per_second', 'time_marker_every_seconds', 'enable_time_marker')}
            rows = metadata['rows']
        except KeyError as exc:
            raise ValueError(f'Missing required bundle metadata: {exc}') from exc
        tokenizer = Tokenizer.from_file(str(path / 'tokenizer.json'))
        audio_id = tokenizer.token_to_id('<|audio_pad|>')
        digit_ids = {}
        for digit in '0123456789':
            encoded = tokenizer.encode(digit, add_special_tokens=False).ids
            if len(encoded) != 1:
                raise ValueError('Each timestamp digit must encode to one token')
            digit_ids[digit] = encoded[0]
        if audio_id is None:
            raise ValueError('Tokenizer is missing <|audio_pad|>')
        table = TokenEmbeddingTable(path / 'moss_token_embedding_fp16.bin', rows=rows)
        return cls(tokenizer, table, audio_token_id=audio_id, digit_token_ids=digit_ids,
                   **feature_args, **marker_args)

    def build_audio_span_ids(self, n_audio):
        if type(n_audio) is not int or n_audio < 0:
            raise ValueError('Audio token count must be a non-negative integer')
        cadence = self.time_marker_every_seconds
        per_marker = int(self.audio_tokens_per_second * cadence)
        if not self.enable_time_marker or not n_audio or cadence <= 0 or per_marker <= 0:
            return [self.audio_token_id] * n_audio
        output, consumed = [], 0
        for sec in range(cadence, int(n_audio / self.audio_tokens_per_second) + 1, cadence):
            position = (sec // cadence) * per_marker
            output.extend([self.audio_token_id] * (position - consumed))
            consumed = position
            output.extend(self.digit_token_ids[digit] for digit in str(sec))
        output.extend([self.audio_token_id] * (n_audio - consumed))
        return output

    def _encode(self, text):
        encoded = self.tokenizer.encode(text, add_special_tokens=False)
        return list(encoded.ids if hasattr(encoded, 'ids') else encoded)

    def expand_input_ids(self, prompt, n_audio):
        """Expand an already rendered complete chat template, without estimating."""
        if prompt.count('<|audio_pad|>') != 1:
            raise ValueError('Expected exactly one <|audio_pad|> in rendered prompt')
        before, after = prompt.split('<|audio_pad|>')
        return self._encode(before) + self.build_audio_span_ids(n_audio) + self._encode(after)

    def build_from_ids(self, ids, audio_embeds):
        ids = _ids(ids)
        if not self.budget.fits(len(ids)):
            raise ContextBudgetExceeded('Expanded input exceeds context budget')
        positions = np.flatnonzero(ids == self.audio_token_id)
        audio = np.asarray(audio_embeds, dtype=np.float32)
        if audio.shape != (len(positions), self.hidden_size) or not np.isfinite(audio).all():
            raise ValueError('Audio embeddings must be finite [audio tokens, hidden size]')
        embeds = np.array(self.table.lookup(ids), dtype=np.float32, order='C', copy=True)
        if embeds.shape != (len(ids), self.hidden_size) or not np.isfinite(embeds).all():
            raise ValueError('Token embeddings have invalid shape or nonfinite values')
        embeds[positions] = audio
        return EmbeddingInput(embeds, positions, ids)

    def build(self, prompt, audio_embeds):
        audio = np.asarray(audio_embeds)
        if audio.ndim != 2:
            raise ValueError('Audio embeddings must be two-dimensional')
        return self.build_from_ids(self.expand_input_ids(prompt, len(audio)), audio)

    def interval_counter(self, prompt, sample_count_provider):
        """Provider reads actual unpadded sample counts for each requested interval."""
        for value in (self.hop_length, self.chunk_samples, self.audio_merge_size):
            if type(value) is not int or value <= 0:
                raise ValueError('Actual feature extractor chunk/stride metadata is required')
        if not callable(sample_count_provider):
            raise ValueError('An actual sample count provider is required')
        stride = self.hop_length * 2 * self.audio_merge_size

        def count(start_ms, end_ms):
            samples = sample_count_provider(start_ms, end_ms)
            if type(samples) is not int or samples <= 0:
                raise ValueError('Actual sample count must be a positive integer')
            full, remainder = divmod(samples, self.chunk_samples)
            n_audio = full * ((self.chunk_samples - 1) // stride + 1)
            if remainder:
                n_audio += (remainder - 1) // stride + 1
            return len(self.expand_input_ids(prompt, n_audio))

        return count
