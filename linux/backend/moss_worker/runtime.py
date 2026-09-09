"""Serial MOSS window inference; durable attempts belong to the supervisor."""
import hashlib
import json
import importlib.util
import re
from difflib import SequenceMatcher
from pathlib import Path

import numpy as np

from .context_budget import ContextBudget
from .generation_policy import classify_generation
from .parser import parse_generation
from .types import ParseStatus, WindowResult, WindowState
from .windowing import ContextBudgetExceeded, WindowSpec


DEFAULT_PROMPT = (
    '请将音频转写为文本，每一段需以起始时间戳和说话人编号'
    '（[S01]、[S02]、[S03]…）开头，正文为对应的语音内容，'
    '并在段末标注结束时间戳，以清晰标明该段语音范围。'
)


def render_prompt(bundle):
    from jinja2.sandbox import ImmutableSandboxedEnvironment

    config = json.loads((Path(bundle) / 'tokenizer_config.json').read_text(encoding='utf-8'))
    template = ImmutableSandboxedEnvironment(trim_blocks=True, lstrip_blocks=True).from_string(config['chat_template'])
    return template.render(messages=[{'role': 'user', 'content': [
        {'type': 'audio', 'audio': 'window.wav'}, {'type': 'text', 'text': DEFAULT_PROMPT}]}],
        add_generation_prompt=True)


def sha256_file(path):
    digest = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def run_selftests(bundle, encoder, decoder):
    from .audio_frontend import AudioChunk

    bundle = Path(bundle)
    expected = json.loads((bundle / 'selftest/encoder_expected.json').read_text(encoding='utf-8'))
    reference = np.asarray(expected['values'], dtype=np.float32).reshape(375, 1024)
    features = np.load(bundle / 'selftest/encoder_input.npy', allow_pickle=False)
    candidate = encoder.encode(AudioChunk(features, 375))
    a, b = reference.astype(np.float64).ravel(), candidate.astype(np.float64).ravel()
    cosine = float(np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b)))
    mae = float(np.mean(np.abs(a - b)))
    if not (cosine >= max(.995, expected['cosine_min']) and mae <= min(.03, expected['mae_max'])):
        raise RuntimeError('MOSS_SELFTEST_FAILED:encoder')
    expected = json.loads((bundle / 'selftest/decoder_expected.json').read_text(encoding='utf-8'))
    inputs = np.fromfile(bundle / 'selftest/decoder_input.f32', dtype='<f4').reshape(expected['input_shape'])[0]
    generation = decoder.decode(inputs)
    if generation.error or classify_generation(generation.text, generation.token_count, generation.normal_termination):
        raise RuntimeError('MOSS_SELFTEST_FAILED:decoder_termination')
    window = WindowSpec(0, 60000, 0, 10)
    parsed = parse_generation(generation.text, window)
    reference = parse_generation(expected['output_text'], window)
    def normalized(segments):
        return re.sub(r'[^\w]', '', ''.join(segment.text for segment in segments))
    similarity = SequenceMatcher(None, normalized(reference.valid_segments), normalized(parsed.valid_segments), autojunk=False).ratio()
    if (parsed.invalid_fragments or len(parsed.valid_segments) != 7
            or len({segment.local_speaker for segment in parsed.valid_segments})
                != len({segment.local_speaker for segment in reference.valid_segments})
            or similarity < max(.95, expected['normalized_character_similarity_min'])):
        raise RuntimeError('MOSS_SELFTEST_FAILED:decoder_content')
    return dict(encoder_cosine=cosine, encoder_mae=mae, decoder_segments=len(parsed.valid_segments),
                decoder_similarity=similarity, decoder_perf=generation.perf)


def validate_model_bundle(bundle, expected_manifest_sha256):
    bundle = Path(bundle).resolve(strict=True)
    if sha256_file(bundle / 'manifest.json') != expected_manifest_sha256:
        raise ValueError('MOSS_MANIFEST_HASH_MISMATCH')
    # Production runs with linux/backend on sys.path. Load the pure Task 4
    # validator explicitly from this release's repository, without Torch imports.
    validator_path = Path(__file__).resolve().parents[3] / 'tools/moss_rk3588/validate_bundle.py'
    spec = importlib.util.spec_from_file_location('moss_bundle_validator', validator_path)
    validator = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(validator)
    errors = validator.validate_bundle(bundle)
    if errors:
        raise ValueError('MOSS_BUNDLE_INVALID:' + '; '.join(errors))
    return json.loads((bundle / 'manifest.json').read_text(encoding='utf-8'))


class MossRuntime:
    def __init__(self, *, frontend, encoder, builder, decoder, rendered_prompt,
                 manifest_sha256, on_state=lambda state: None):
        self.frontend, self.encoder = frontend, encoder
        self.builder, self.decoder = builder, decoder
        self.rendered_prompt = rendered_prompt
        self.manifest_sha256 = manifest_sha256
        self.on_state = on_state
        self.last_generation = None

    @classmethod
    def from_bundle(cls, bundle, *, expected_manifest_sha256, rknn_library, rkllm_library, on_state=lambda state: None):
        manifest = validate_model_bundle(bundle, expected_manifest_sha256)
        from .audio_frontend import AudioFrontend
        from .embedding_builder import MossEmbeddingBuilder
        from .rknn_audio_encoder import RKNNEncoder
        from .rkllm_decoder import RKLLMDecoder

        bundle = Path(bundle)
        approved = dict(encoder='d31fc19c85b85f6091b2bd0f6af9d962d5264a4e410bfb536402ec92bac738e8',
                        decoder='6a9e4fc5324c68921c3a900340361e107af7599fe34dc8fa7759b2c5ae22a6e6')
        if any(manifest['provenance'][name]['runtime_sha256'] != digest for name, digest in approved.items()):
            raise ValueError('MOSS_NATIVE_LIBRARY_UNAPPROVED')
        frontend = AudioFrontend(manifest['processor_config'])
        builder = MossEmbeddingBuilder.from_bundle(bundle)
        prompt = render_prompt(bundle)
        encoder, decoder = None, None
        try:
            encoder = RKNNEncoder(bundle / 'moss_audio_encoder_fp16_rk3588.rknn',
                                  library=rknn_library, expected_sha256=approved['encoder'])
            generation = json.loads((bundle / 'generation_config.json').read_text(encoding='utf-8'))
            eos = generation['eos_token_id']
            decoder = RKLLMDecoder(bundle / 'moss_qwen3_0.6b_w8a8_rk3588.rkllm',
                                   library=rkllm_library, expected_sha256=approved['decoder'],
                                   eos_token_ids=eos if isinstance(eos, list) else [eos])
            selftests = run_selftests(bundle, encoder, decoder)
            runtime = cls(frontend=frontend, encoder=encoder, builder=builder, decoder=decoder,
                          rendered_prompt=prompt, manifest_sha256=expected_manifest_sha256, on_state=on_state)
            runtime.selftests = selftests
            return runtime
        except Exception:
            if decoder is not None:
                decoder.close()
            if encoder is not None:
                encoder.close()
            raise

    def close(self):
        self.decoder.close()
        self.encoder.close()

    def infer_window(self, window, wav, *, window_id=None):
        identity = window_id if window_id is not None else f'{window.logical_chunk_index}:{window.start_ms}:{window.end_ms}:{window.window_minutes}'
        self.last_generation = None
        audio_hash = ''
        raw, count, normal = '', None, None
        def result(error, segments=(), status=ParseStatus.INVALID):
            return WindowResult(identity, window, WindowState.FAILED if error else WindowState.DONE,
                                audio_hash, self.manifest_sha256, raw, segments, status, error,
                                count, normal)
        try:
            audio_hash = sha256_file(wav)
            self.on_state('ENCODING')
            audio = np.concatenate([self.encoder.encode(chunk) for chunk in self.frontend.chunks(wav, window)])
            self.on_state('BUILDING_EMBEDS')
            built = self.builder.build(self.rendered_prompt, audio)
            if not ContextBudget().fits(len(built.embeds)):
                return result('MOSS_CONTEXT_BUDGET_EXCEEDED')
            self.on_state('DECODING')
            generation = self.decoder.decode(built.embeds)
            self.last_generation = generation
            raw, count, normal = generation.text, generation.token_count, generation.normal_termination
            error = generation.error or classify_generation(raw, count, normal)
            if error:
                return result(error)
            self.on_state('PARSING')
            parsed = parse_generation(raw, window, window_id=identity,
                                      model_manifest_sha256=self.manifest_sha256)
            if parsed.invalid_fragments or not parsed.valid_segments:
                return result('MOSS_INVALID_GENERATION')
            status = (ParseStatus.REPAIRED if any(s.parse_status == ParseStatus.REPAIRED
                      for s in parsed.valid_segments) else ParseStatus.VALID)
            return result(None, parsed.valid_segments, status)
        except MemoryError:
            return result('MOSS_OOM')
        except ContextBudgetExceeded:
            return result('MOSS_CONTEXT_BUDGET_EXCEEDED')
        except (ValueError, RuntimeError, OSError) as exc:
            return result(str(exc) if str(exc).startswith('MOSS_') else f'MOSS_RUNTIME_ERROR:{exc}')
