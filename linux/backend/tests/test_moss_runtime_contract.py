import hashlib
import ctypes as C
import json
import wave
from types import SimpleNamespace

import numpy as np
import pytest

from moss_worker.types import WindowSpec, WindowState


def make_runtime(tmp_path, *, text='[0.0][S01]你好[1.0]', count=5119, normal=True):
    from moss_worker.runtime import MossRuntime

    trace = []
    wav = tmp_path / 'window.wav'
    wav.write_bytes(b'audio')
    chunks = [SimpleNamespace(features=np.ones((1, 80, 3000), np.float32), valid_tokens=2),
              SimpleNamespace(features=np.ones((1, 80, 3000), np.float32) * 2, valid_tokens=1)]
    def encode(chunk):
        return np.full((chunk.valid_tokens, 1024), chunk.features[0, 0, 0], np.float32)
    def build(prompt, audio):
        assert prompt == 'rendered'
        np.testing.assert_array_equal(audio[:, 0], [1, 1, 2])
        return SimpleNamespace(embeds=audio)
    generation = SimpleNamespace(text=text, token_count=count, normal_termination=normal,
                                 perf={}, error=None)
    runtime = MossRuntime(frontend=SimpleNamespace(chunks=lambda path, window: iter(chunks)),
                          encoder=SimpleNamespace(encode=encode, close=lambda: None),
                          builder=SimpleNamespace(build=build),
                          decoder=SimpleNamespace(decode=lambda embeds: generation, close=lambda: None),
                          rendered_prompt='rendered', manifest_sha256='a' * 64,
                          on_state=trace.append)
    return runtime, trace, wav


def test_serial_orchestration_and_provenance(tmp_path):
    runtime, trace, wav = make_runtime(tmp_path)
    result = runtime.infer_window(WindowSpec(1000, 3000, 0, 12), wav)
    assert trace == ['ENCODING', 'BUILDING_EMBEDS', 'DECODING', 'PARSING']
    assert result.state == WindowState.DONE
    assert result.segments[0].start_ms == 1000
    assert result.audio_sha256 == hashlib.sha256(b'audio').hexdigest()
    assert result.model_manifest_sha256 == 'a' * 64
    assert result.token_count == 5119 and result.normal_termination is True


@pytest.mark.parametrize('stage', ['encode', 'build', 'decode', 'parse'])
def test_python_allocation_oom_is_explicit_failed_attempt(tmp_path, monkeypatch, stage):
    import moss_worker.runtime as module
    runtime, trace, wav = make_runtime(tmp_path)
    def oom(*args, **kwargs):
        raise MemoryError('allocation failed')
    if stage == 'parse':
        monkeypatch.setattr(module, 'parse_generation', oom)
    else:
        owner = {'encode': runtime.encoder, 'build': runtime.builder, 'decode': runtime.decoder}[stage]
        monkeypatch.setattr(owner, stage, oom)
    result = runtime.infer_window(WindowSpec(0, 3000, 0, 12), wav)
    assert result.state is WindowState.FAILED
    assert result.error == 'MOSS_OOM'
    assert result.raw_generation == ('[0.0][S01]你好[1.0]' if stage == 'parse' else '')


@pytest.mark.parametrize('text,count,normal', [
    ('[0.0][S01]你好[1.0]', 5120, True),
    ('[0.0][S01]你好[1.0]', 20, None),
    ('[0.0][S01]你好[1.0][S02]未结束', 20, True),
])
def test_limit_classification_precedes_parser_and_preserves_raw(tmp_path, text, count, normal):
    runtime, trace, wav = make_runtime(tmp_path, text=text, count=count, normal=normal)
    result = runtime.infer_window(WindowSpec(0, 3000, 0, 12), wav)
    assert 'PARSING' not in trace
    assert result.state == WindowState.FAILED and result.segments == ()
    assert result.error == 'GENERATION_LIMIT_REACHED'
    assert (result.raw_generation, result.token_count, result.normal_termination) == (text, count, normal)


FEATURE = dict(chunk_length=30, dither=0.0, feature_extractor_type='WhisperFeatureExtractor',
               feature_size=80, hop_length=160, n_fft=400, n_samples=480000,
               nb_max_frames=3000, padding_side='right', padding_value=0.0,
               sampling_rate=16000)


def write_wav(path, samples, *, channels=1, width=2, rate=16000):
    with wave.open(str(path), 'wb') as stream:
        stream.setparams((channels, width, rate, 0, 'NONE', 'not compressed'))
        stream.writeframes(samples)


def test_frontend_normalizes_and_pads_actual_samples(tmp_path):
    from moss_worker.audio_frontend import AudioFrontend
    wav = tmp_path / 'audio.wav'
    write_wav(wav, np.array([-32768, 0, 32767], '<i2').tobytes())
    frontend = AudioFrontend(dict(feature_extractor=FEATURE, audio_merge_size=4))
    np.testing.assert_array_equal(frontend.read_samples(wav), [-1, 0, 32767 / 32768])
    chunks = list(frontend.chunks(wav))
    assert len(chunks) == 1 and chunks[0].valid_tokens == 1
    assert chunks[0].features.shape == (1, 80, 3000)
    assert chunks[0].features.dtype == np.float32
    assert np.isfinite(chunks[0].features).all()
    write_wav(wav, np.zeros(480001, '<i2').tobytes())
    chunks = list(frontend.chunks(wav))
    assert [c.valid_tokens for c in chunks] == [375, 1]
    np.testing.assert_allclose(chunks[0].features, -1.5, atol=1e-6)


@pytest.mark.parametrize('channels,width,rate', [(2, 2, 16000), (1, 1, 16000), (1, 2, 8000)])
def test_frontend_rejects_unsupported_wav(tmp_path, channels, width, rate):
    from moss_worker.audio_frontend import AudioFrontend
    wav = tmp_path / 'audio.wav'
    write_wav(wav, bytes(128), channels=channels, width=width, rate=rate)
    with pytest.raises(ValueError, match='MOSS_AUDIO_UNSUPPORTED_FORMAT'):
        list(AudioFrontend(dict(feature_extractor=FEATURE, audio_merge_size=4)).chunks(wav))


def test_frontend_rejects_unverified_feature_settings():
    from moss_worker.audio_frontend import AudioFrontend
    with pytest.raises(ValueError, match='MOSS_PROCESSOR_CONFIG_UNSUPPORTED'):
        AudioFrontend(dict(feature_extractor={**FEATURE, 'dither': 0.1}, audio_merge_size=4))


def test_render_uses_bundle_template_without_thinking_override(tmp_path):
    from moss_worker.runtime import render_prompt, DEFAULT_PROMPT
    config = {'chat_template': "{{ messages[0].content[1].text }}{{ '<think>' if enable_thinking is defined else '<|audio_pad|>' }}{{ add_generation_prompt }}"}
    (tmp_path / 'tokenizer_config.json').write_text(json.dumps(config), encoding='utf-8')
    assert render_prompt(tmp_path) == DEFAULT_PROMPT + '<|audio_pad|>True'


def test_rknn_scoped_private_load_hash_and_valid_prefix(tmp_path, monkeypatch):
    import sys
    from moss_worker.rknn_audio_encoder import RKNNEncoder
    from moss_worker.audio_frontend import AudioChunk
    import moss_worker.rknn_audio_encoder as module
    library = tmp_path / 'librknnrt.so'
    library.write_bytes(b'private')
    calls = []
    class Native:
        def _get_rknn_api_lib_path(self):
            return '/usr/lib/librknnrt.so'
    original = Native._get_rknn_api_lib_path
    class Lite:
        NPU_CORE_0_1_2 = 7
        def load_rknn(self, path):
            calls.append(('load', path))
            return 0
        def init_runtime(self, core_mask):
            calls.append(('init', core_mask))
            self.rknn_runtime = SimpleNamespace(lib=SimpleNamespace(_name=Native()._get_rknn_api_lib_path()))
            return 0
        def inference(self, inputs, data_format):
            calls.append(('infer', data_format))
            return [np.arange(375 * 1024, dtype=np.float32).reshape(1, 375, 1024)]
        def release(self):
            calls.append(('release',))
    monkeypatch.setitem(sys.modules, 'rknnlite.api', SimpleNamespace(RKNNLite=Lite))
    monkeypatch.setitem(sys.modules, 'rknnlite.api.rknn_runtime', SimpleNamespace(RKNNRuntime=Native))
    monkeypatch.setattr(module, 'version', lambda package: '2.3.2')
    encoder = RKNNEncoder('model.rknn', library=library, expected_sha256=hashlib.sha256(b'private').hexdigest())
    assert Native._get_rknn_api_lib_path is original
    chunk = AudioChunk(np.zeros((1, 80, 3000), np.float32), 2)
    output = encoder.encode(chunk)
    assert output.shape == (2, 1024) and output.flags.c_contiguous
    encoder.encode(chunk)
    assert [c[0] for c in calls].count('load') == 1
    assert ('init', 7) in calls
    encoder.close()
    with pytest.raises(ValueError, match='MOSS_NATIVE_LIBRARY_HASH_MISMATCH'):
        RKNNEncoder('model.rknn', library=library, expected_sha256='0' * 64)


def test_rkllm_exact_sdk_13_abi():
    from moss_worker import rkllm_decoder as rk
    for name, size in [('RKLLMParam', 184), ('RKLLMExtendParam', 120), ('RKLLMInput', 160),
                       ('RKLLMInferParam', 40), ('RKLLMResult', 72), ('RKLLMCallback', 48)]:
        assert C.sizeof(getattr(rk, name)) == size
    assert rk.RKLLMResult.perf.offset == 48
    assert rk.RKLLMInput.value.offset == 16


def native_fake(rk, *, eos=True, finish=True, error=False, waiting=False):
    class Function:
        def __init__(self, fn):
            self.fn = fn
        def __call__(self, *args):
            return self.fn(*args)
    class Library:
        def __init__(self):
            self.template_cleared = False
            self.cache_cleared = False
            self.rkllm_createDefaultParam = Function(rk.RKLLMParam)
            self.rkllm_init = Function(self.init)
            self.rkllm_run = Function(self.run)
            self.rkllm_destroy = Function(lambda handle: 0)
            self.rkllm_abort = Function(lambda handle: 0)
            self.rkllm_set_chat_template = Function(self.set_template)
            self.rkllm_clear_kv_cache = Function(self.clear_cache)
        def clear_cache(self, handle, keep_system, starts, ends):
            assert (keep_system, starts, ends) == (0, None, None)
            self.cache_cleared = True
            return 0
        def set_template(self, handle, system, prefix, postfix):
            assert (system, prefix, postfix) == (b'', b'', b'')
            self.template_cleared = True
            return 0
        def init(self, handle, params, callbacks):
            self.params = rk.RKLLMParam.from_buffer_copy(C.string_at(params, C.sizeof(rk.RKLLMParam)))
            self.callback = C.cast(callbacks, C.POINTER(rk.RKLLMCallback)).contents.result_callback
            C.cast(handle, C.POINTER(C.c_void_p))[0] = C.c_void_p(1)
            return 0
        def run(self, handle, input_ptr, infer_ptr, userdata):
            inputs = C.cast(input_ptr, C.POINTER(rk.RKLLMInput)).contents
            infer = C.cast(infer_ptr, C.POINTER(rk.RKLLMInferParam)).contents
            assert inputs.input_type == 2 and not inputs.enable_thinking
            assert self.template_cleared
            assert self.cache_cleared
            self.cache_cleared = False
            assert inputs.value.embed_input.n_tokens == 3
            assert infer.keep_history == 0 and infer.max_new_tokens == 5120
            assert self.params.max_new_tokens == 5120 and self.params.max_context_len == 16384
            assert self.params.repeat_penalty == 1
            assert self.params.frequency_penalty == self.params.presence_penalty == self.params.mirostat == 0
            for token_id, text, state in ([(123, b'\xe4\xbd', 1), (124, b'\xa0', 0)] if waiting else [(123, b'[0][S01]hello[1]', 0)]):
                result = rk.RKLLMResult()
                result.token_id, result.text = token_id, text
                self.callback(C.pointer(result), None, state)
            if eos:
                result = rk.RKLLMResult()
                result.token_id = 151645
                self.callback(C.pointer(result), None, 0)
            if finish:
                result = rk.RKLLMResult()
                result.perf.generate_tokens = (2 if waiting else 1) if eos else (1 if waiting else 0)
                result.perf.prefill_tokens = 3
                self.callback(C.pointer(result), None, 2)
            return -1 if error else 0
    return Library()


@pytest.mark.parametrize('eos,finish,error,normal', [(True, True, False, True), (False, True, False, False),
                                                  (True, False, False, False), (True, True, True, False)])
def test_decoder_requires_actual_eos_and_finish(tmp_path, monkeypatch, eos, finish, error, normal):
    from moss_worker import rkllm_decoder as rk
    library = tmp_path / 'librkllmrt.so'
    library.write_bytes(b'private')
    native = native_fake(rk, eos=eos, finish=finish, error=error)
    native._name = str(library)
    monkeypatch.setattr(rk.C, 'CDLL', lambda path: native)
    decoder = rk.RKLLMDecoder('model.rkllm', library=library,
                            expected_sha256=hashlib.sha256(b'private').hexdigest(), eos_token_ids=[151645])
    result = decoder.decode(np.zeros((3, 1024), np.float32))
    assert result.normal_termination is normal
    assert result.token_count == (2 if eos else 1)
    assert result.text == '[0][S01]hello[1]'
    assert bool(result.error) is error
    assert decoder.decode(np.zeros((3, 1024), np.float32)).normal_termination is normal
    decoder.close()


def test_decoder_preserves_split_utf8_and_rejects_nonfinite(tmp_path, monkeypatch):
    from moss_worker import rkllm_decoder as rk
    library = tmp_path / 'librkllmrt.so'
    library.write_bytes(b'private')
    native = native_fake(rk, waiting=True)
    native._name = str(library)
    monkeypatch.setattr(rk.C, 'CDLL', lambda path: native)
    decoder = rk.RKLLMDecoder('model.rkllm', library=library,
                            expected_sha256=hashlib.sha256(b'private').hexdigest(), eos_token_ids=[151645])
    result = decoder.decode(np.zeros((3, 1024), np.float32))
    assert result.text == '你' and result.token_count == 3 and result.normal_termination
    with pytest.raises(ValueError, match='MOSS_INVALID_EMBEDDINGS'):
        decoder.decode(np.full((3, 1024), np.nan, np.float32))


def test_frontend_reads_only_requested_interval(tmp_path):
    from moss_worker.audio_frontend import AudioFrontend
    wav = tmp_path / 'recording.wav'
    write_wav(wav, np.concatenate([np.full(16000, -32768, '<i2'), np.zeros(16000, '<i2')]).tobytes())
    frontend = AudioFrontend(dict(feature_extractor=FEATURE, audio_merge_size=4))
    window = WindowSpec(1000, 2000, 0, 12)
    chunks = list(frontend.chunks(wav, window))
    assert len(chunks) == 1 and chunks[0].valid_tokens == 13
    np.testing.assert_allclose(chunks[0].features, -1.5)


def test_runtime_maps_native_failure_and_clears_previous_metadata(tmp_path):
    runtime, trace, wav = make_runtime(tmp_path)
    result = runtime.infer_window(WindowSpec(0, 3000, 0, 12), wav)
    assert runtime.last_generation.token_count == result.token_count
    def fail(chunk):
        raise RuntimeError('MOSS_RKNN_RUN_FAILED:-1')
    runtime.encoder.encode = fail
    result = runtime.infer_window(WindowSpec(0, 3000, 0, 12), wav)
    assert result.state == WindowState.FAILED and result.error == 'MOSS_RKNN_RUN_FAILED:-1'
    assert runtime.last_generation is None and result.raw_generation == ''


def test_runtime_exact_context_guard_blocks_native_call(tmp_path):
    runtime, trace, wav = make_runtime(tmp_path)
    runtime.builder.build = lambda prompt, audio: SimpleNamespace(embeds=np.zeros((10753, 1024), np.float32))
    result = runtime.infer_window(WindowSpec(0, 3000, 0, 12), wav)
    assert result.error == 'MOSS_CONTEXT_BUDGET_EXCEEDED'
    assert 'DECODING' not in trace


def selftest_fixture(tmp_path):
    (tmp_path / 'selftest').mkdir()
    np.save(tmp_path / 'selftest/encoder_input.npy', np.zeros((1, 80, 3000), np.float32))
    expected = dict(values=np.ones((1, 375, 1024), np.float32).tolist(), cosine_min=.995, mae_max=.03)
    (tmp_path / 'selftest/encoder_expected.json').write_text(json.dumps(expected), encoding='utf-8')
    np.zeros((3, 1024), np.float32).tofile(tmp_path / 'selftest/decoder_input.f32')
    text = ''.join(f'[{i}][S01]hello[{i+1}]' for i in range(7))
    expected = dict(input_shape=[1, 3, 1024], output_text=text, normalized_character_similarity_min=.95)
    (tmp_path / 'selftest/decoder_expected.json').write_text(json.dumps(expected), encoding='utf-8')
    return text


@pytest.mark.parametrize('bad_encoder,bad_decoder', [(False, False), (True, False), (False, True)])
def test_startup_selftests_fail_closed(tmp_path, bad_encoder, bad_decoder):
    from moss_worker.runtime import run_selftests
    text = selftest_fixture(tmp_path)
    encoder = SimpleNamespace(encode=lambda chunk: np.full((375, 1024), -1 if bad_encoder else 1, np.float32))
    decoder = SimpleNamespace(decode=lambda inputs: SimpleNamespace(text=text, token_count=20,
                              normal_termination=not bad_decoder, perf={}, error=None))
    if bad_encoder or bad_decoder:
        with pytest.raises(RuntimeError, match='MOSS_SELFTEST_FAILED'):
            run_selftests(tmp_path, encoder, decoder)
    else:
        result = run_selftests(tmp_path, encoder, decoder)
        assert result['decoder_segments'] == 7 and result['encoder_cosine'] >= .995


def test_startup_rejects_wrong_manifest_before_native_import(tmp_path):
    from moss_worker.runtime import MossRuntime
    (tmp_path / 'manifest.json').write_text('{}')
    with pytest.raises(ValueError, match='MOSS_MANIFEST_HASH_MISMATCH'):
        MossRuntime.from_bundle(tmp_path, expected_manifest_sha256='0' * 64,
                                rknn_library='missing', rkllm_library='missing')


def test_child_protocol_startup_failure_exits_nonzero_without_ready():
    import io
    from moss_worker.child import serve
    output = io.StringIO()
    def fail():
        raise RuntimeError('MOSS_SELFTEST_FAILED:encoder')
    assert serve(io.StringIO(''), output, fail) != 0
    messages = [json.loads(line) for line in output.getvalue().splitlines()]
    assert messages == [{'type': 'not_ready', 'error': 'MOSS_SELFTEST_FAILED:encoder'}]


def test_child_protocol_infer_preserves_request_id_and_result(tmp_path):
    import io
    from moss_worker.child import serve
    runtime, trace, wav = make_runtime(tmp_path)
    commands = [dict(type='infer', request_id='attempt-2', wav=str(wav),
                     window=dict(start_ms=0, end_ms=3000, logical_chunk_index=0, window_minutes=12)),
                dict(type='shutdown')]
    output = io.StringIO()
    assert serve(io.StringIO(''.join(json.dumps(c) + '\n' for c in commands)), output, lambda: runtime) == 0
    messages = [json.loads(line) for line in output.getvalue().splitlines()]
    assert messages[0]['type'] == 'ready'
    done = next(m for m in messages if m['type'] == 'result')
    assert done['request_id'] == 'attempt-2' and done['result']['state'] == 'DONE'
    assert done['generation_metadata']['token_count'] == 5119


def test_child_cli_keeps_native_stdout_off_control_channel(tmp_path):
    import os
    import subprocess
    import sys
    script = "from moss_worker.child import control_channel; import os; c=control_channel(); os.write(1,b'native log\\n'); c.write('{\"type\":\"ready\"}\\n'); c.flush()"
    completed = subprocess.run([sys.executable, '-c', script], capture_output=True, text=True, check=True)
    assert completed.stdout == '{"type":"ready"}\n'
    assert 'native log' in completed.stderr


def test_audio_window_rejects_ghost_tail_but_accepts_submillisecond_tail(tmp_path):
    from moss_worker.audio_frontend import AudioFrontend
    wav = tmp_path / 'short.wav'
    write_wav(wav, np.zeros(16001, '<i2').tobytes())
    frontend = AudioFrontend(dict(feature_extractor=FEATURE, audio_merge_size=4))
    assert len(frontend.read_samples(wav, WindowSpec(1000, 1001, 0, 12))) == 1
    with pytest.raises(ValueError, match='MOSS_INVALID_AUDIO_WINDOW'):
        frontend.read_samples(wav, WindowSpec(1000, 1002, 0, 12))


def test_selftest_rejects_speaker_collapse(tmp_path):
    from moss_worker.runtime import run_selftests
    text = selftest_fixture(tmp_path)
    path = tmp_path / 'selftest/decoder_expected.json'
    expected = json.loads(path.read_text())
    expected['output_text'] = text.replace('[1][S01]', '[1][S02]')
    path.write_text(json.dumps(expected))
    encoder = SimpleNamespace(encode=lambda chunk: np.ones((375, 1024), np.float32))
    decoder = SimpleNamespace(decode=lambda inputs: SimpleNamespace(text=text, token_count=20,
                              normal_termination=True, perf={}, error=None))
    with pytest.raises(RuntimeError, match='MOSS_SELFTEST_FAILED:decoder_content'):
        run_selftests(tmp_path, encoder, decoder)


def test_child_result_keeps_unprovable_perf_as_json_null(tmp_path):
    import io
    from moss_worker.child import serve
    runtime, trace, wav = make_runtime(tmp_path, normal=False)
    runtime.decoder.decode = lambda embeds: SimpleNamespace(text='[0][S01]hello[1]', token_count=2,
                              normal_termination=False, perf={'generate_time_ms': float('nan')}, error=None)
    request = dict(type='infer', request_id='x', window_id='fresh-attempt', wav=str(wav),
                   window=dict(start_ms=0, end_ms=3000, logical_chunk_index=0, window_minutes=12))
    output = io.StringIO()
    assert serve(io.StringIO(json.dumps(request) + '\n'), output, lambda: runtime) == 0
    result = next(json.loads(line) for line in output.getvalue().splitlines() if json.loads(line)['type'] == 'result')
    assert result['generation_metadata']['perf']['generate_time_ms'] is None
    assert result['result']['raw_generation'] == '[0][S01]hello[1]'
    assert result['result']['window_id'] == 'fresh-attempt'


def test_runtime_attempt_identity_reaches_every_segment(tmp_path):
    runtime, trace, wav = make_runtime(tmp_path)
    result = runtime.infer_window(WindowSpec(0, 3000, 0, 12), wav, window_id='attempt-3')
    assert result.window_id == 'attempt-3'
    assert all(segment.window_id == 'attempt-3' and segment.segment_id.startswith('attempt-3:') for segment in result.segments)


def test_log_mel_matches_independent_whisper_torch_reference():
    from moss_worker.audio_frontend import AudioFrontend
    # Frozen from Transformers WhisperFeatureExtractor's Torch STFT, for the
    # three impulses below. CI needs neither Torch nor Transformers.
    samples = np.zeros(16000, np.float32)
    samples[0], samples[1000], samples[15999] = 1, -.5, .25
    features = AudioFrontend(dict(feature_extractor=FEATURE, audio_merge_size=4)).log_mel(samples)
    positions = [(0, 0), (0, 1), (10, 6), (40, 7), (79, 0), (79, 100), (20, 2999)]
    expected = [.5988866091, .0888689756, .4265779257, .2251885533,
                .5991602540, .2981168628, -1.3922092915]
    np.testing.assert_allclose([features[0, mel, time] for mel, time in positions], expected, atol=3e-5, rtol=0)


def test_child_nonobject_requests_are_structured_errors(tmp_path):
    import io
    from moss_worker.child import serve
    runtime, trace, wav = make_runtime(tmp_path)
    output = io.StringIO()
    assert serve(io.StringIO('[]\nnull\n{"type":"shutdown"}\n'), output, lambda: runtime) == 0
    messages = [json.loads(line) for line in output.getvalue().splitlines()]
    assert [message['type'] for message in messages] == ['ready', 'error', 'error']


@pytest.mark.parametrize('invalid_id', ['NaN', '1e309'])
def test_child_nonfinite_request_id_does_not_break_error_transport(tmp_path, invalid_id):
    import io
    from moss_worker.child import serve
    runtime, trace, wav = make_runtime(tmp_path)
    valid_request = dict(type='infer', request_id='valid-after-error', wav=str(wav),
                         window=dict(start_ms=0, end_ms=3000, logical_chunk_index=0, window_minutes=12))
    source = io.StringIO('{"type":"infer","request_id":' + invalid_id + '}\n'
                         + json.dumps(valid_request) + '\n{"type":"shutdown"}\n')
    output = io.StringIO()
    assert serve(source, output, lambda: runtime) == 0
    messages = [json.loads(line) for line in output.getvalue().splitlines()]
    assert [message['type'] for message in messages] == ['ready', 'error', 'state', 'state', 'state', 'state', 'result']
    assert messages[1]['request_id'] is None
    assert messages[1]['error'].startswith('MOSS_INVALID_REQUEST')
    assert messages[-1]['request_id'] == 'valid-after-error'
    assert messages[-1]['result']['state'] == 'DONE'
