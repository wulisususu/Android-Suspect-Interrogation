import importlib.util
import hashlib
import json
import subprocess

import numpy as np
import pytest
import torch


def test_runtime_hashing_supports_python310(tmp_path, monkeypatch):
    from tools.moss_rk3588.validate_bundle import sha256_file
    path = tmp_path / 'artifact'
    path.write_bytes(b'actual bytes' * 100000)
    monkeypatch.delattr(hashlib, 'file_digest', raising=False)
    assert sha256_file(path) == hashlib.sha256(path.read_bytes()).hexdigest()


def test_window_policy_tiering_matches_2026_09_09_user_approval():
    # User-approved final tiering: target 10 min, fallback 8 min, minimum 8 min;
    # context 16384 / reserve 5120 / safety 512 are unchanged.
    from tools.moss_rk3588.validate_bundle import POLICY
    assert POLICY == {'compiled_context_limit': 16384, 'generation_reserve': 5120,
                      'safety_margin': 512, 'target_window_minutes': 10,
                      'fallback_window_minutes': 8, 'minimum_window_minutes': 8,
                      'overlap_minutes': 2, 'logical_chunk_minutes': 60}


def test_export_exact_little_endian_table(tmp_path):
    assert importlib.util.find_spec('tools.moss_rk3588.export_token_embedding') is not None
    from tools.moss_rk3588.export_token_embedding import export_table
    weight = torch.arange(2048, dtype=torch.float32).reshape(1024, 2).T
    result = export_table(weight, 'sha256:' + 'a' * 64, tmp_path / 'table')
    data = (tmp_path / 'table/moss_token_embedding_fp16.bin').read_bytes()
    assert data == np.ascontiguousarray(weight.numpy(), dtype='<f2').tobytes()
    assert result['rows'] == 2 and result['hidden_size'] == 1024
    assert result['sha256'] == hashlib.sha256(data).hexdigest()
    assert result['dtype'] == 'float16' and result['byte_order'] == 'little'
    with pytest.raises(FileExistsError):
        export_table(weight, 'sha256:' + 'a' * 64, tmp_path / 'table')


def test_export_refuses_wrong_shape_and_nonfinite(tmp_path):
    from tools.moss_rk3588.export_token_embedding import export_table
    for weight in (torch.zeros(2, 4), torch.full((2, 1024), float('nan')),
                   torch.full((2, 1024), 1e8)):
        with pytest.raises(ValueError):
            export_table(weight, 'sha256:' + 'a' * 64, tmp_path / 'table')
    assert not (tmp_path / 'table').exists()


def test_component_hashes_change_with_exact_tensor_contents():
    from tools.moss_rk3588.export_token_embedding import component_fingerprints
    state = {name: torch.ones(2, dtype=torch.bfloat16) for name in (
        'model.whisper_encoder.a', 'model.vq_adaptor.a',
        'model.language_model.embed_tokens.weight', 'lm_head.weight')}
    before = component_fingerprints(state)
    state['model.vq_adaptor.a'][0] = 2
    after = component_fingerprints(state)
    assert before['whisper_encoder'] == after['whisper_encoder']
    assert before['vq_adaptor'] != after['vq_adaptor']
    with pytest.raises(ValueError):
        component_fingerprints({'unexpected.weight': torch.ones(2)})


@pytest.fixture
def bundle_inputs(tmp_path):
    from tools.moss_rk3588 import validate_bundle as v
    from tools.moss_rk3588.export_token_embedding import export_table
    source, checkpoint, assets = (tmp_path / x for x in ('source', 'checkpoint', 'assets'))
    source.mkdir(); checkpoint.mkdir()
    subprocess.run(['git', 'init', str(source)], check=True, capture_output=True)
    (source / 'README').write_text('test source')
    subprocess.run(['git', '-C', str(source), 'add', '.'], check=True)
    subprocess.run(['git', '-C', str(source), '-c', 'user.name=Test', '-c',
                    'user.email=test@example.invalid', 'commit', '-m', 'fixture'],
                   check=True, capture_output=True)
    config = {'text_config': {'hidden_size': 1024, 'vocab_size': 4},
              'audio_token_id': 3, 'audio_merge_size': 4}
    (checkpoint / 'config.json').write_text(json.dumps(config))
    (checkpoint / 'model.safetensors').write_bytes(b'test-only checkpoint')
    from tools.moss_rk3588.capture_input_embeds import fingerprint_model
    fingerprint = fingerprint_model(checkpoint)
    metadata = export_table(torch.ones(4, 1024), fingerprint, assets)
    metadata['source_components'] = {k: 'a' * 64 for k in
                                     ('whisper_encoder', 'vq_adaptor', 'language_model', 'tokenizer')}
    (assets / 'token_embedding.json').write_text(json.dumps(metadata))
    for name in (v.ENCODER, v.DECODER):
        (assets / name).write_bytes(name.encode())
    (checkpoint / 'chat_template.jinja').write_text('actual fixture template')
    fingerprint = fingerprint_model(checkpoint)
    metadata['source_fingerprint'] = fingerprint
    (assets / 'token_embedding.json').write_text(json.dumps(metadata))
    configs = {'tokenizer.json': {'added_tokens': [{'id': 3, 'content': '<|audio_pad|>'}]},
               'tokenizer_config.json': {'tokenizer_class': 'TokenizersBackend'},
               'special_tokens_map.json': {'additional_special_tokens': ['<|audio_pad|>']},
               'generation_config.json': {'max_new_tokens': 5120, 'eos_token_id': 2},
               'processor_config.json': {'audio_tokens_per_second': 12.5, 'audio_merge_size': 4,
                                        'enable_time_marker': True, 'time_marker_every_seconds': 5}}
    for name, value in configs.items():
        (assets / name).write_text(json.dumps(value))
        (checkpoint / name).write_text(json.dumps(value))
    feature_extractor = {'sampling_rate': 16000, 'feature_size': 80}
    (checkpoint / 'preprocessor_config.json').write_text(json.dumps(feature_extractor))
    configs['processor_config.json']['feature_extractor'] = feature_extractor
    (assets / 'processor_config.json').write_text(json.dumps(configs['processor_config.json']))
    metadata['tokenizer_source_files'] = {name: v.sha256_file(checkpoint / name) for name in
        ('tokenizer.json', 'tokenizer_config.json', 'special_tokens_map.json')}
    metadata['source_components']['tokenizer'] = hashlib.sha256(json.dumps(
        metadata['tokenizer_source_files'], sort_keys=True, separators=(',', ':')).encode()).hexdigest()
    fingerprint = fingerprint_model(checkpoint)
    metadata['source_fingerprint'] = fingerprint
    (assets / 'token_embedding.json').write_text(json.dumps(metadata))
    (assets / 'selftest').mkdir()
    np.save(assets / 'selftest/encoder_input.npy', np.zeros((1, 80, 3000), dtype='<f4'))
    (assets / 'selftest/encoder_expected.json').write_text(json.dumps(
        {'shape': [1, 375, 1024], 'dtype': 'float32', 'source_fingerprint': fingerprint,
         'values': np.zeros((1, 375, 1024)).tolist(), 'cosine_min': 0.995, 'mae_max': 0.03}))
    (assets / 'selftest/decoder_input.f32').write_bytes(bytes(1024 * 4))
    (assets / 'selftest/decoder_expected.json').write_text(json.dumps(
        {'input_shape': [1, 1, 1024], 'output_text': '[0][S01]fixture[1]',
         'source_fingerprint': fingerprint}))
    decoder_sha = hashlib.sha256((assets / v.DECODER).read_bytes()).hexdigest()
    provenance = {'checkpoint_revision': 'b' * 40,
                  'encoder': {'model_sha256': hashlib.sha256((assets / v.ENCODER).read_bytes()).hexdigest(),
                              'toolkit_version': '2.3.2', 'gate_b_runtime_confirmed': '2.3.2',
                              'runtime_sha256': 'c' * 64},
                  'decoder': {'model_sha256': decoder_sha, 'compiled_context_limit': 16384,
                              'toolkit_version': '1.3.0', 'runtime_version': '1.3.0',
                              'runtime_sha256': 'd' * 64, 'runtime_model_sha256': decoder_sha,
                              'runtime_log': 'max_context_limit: 16384\n'}}
    return source, checkpoint, assets, provenance


def test_build_and_validate_actual_staged_layout(bundle_inputs, tmp_path):
    from tools.moss_rk3588.build_manifest import build_bundle
    from tools.moss_rk3588.validate_bundle import validate_bundle
    source, checkpoint, assets, provenance = bundle_inputs
    output = tmp_path / 'bundle'
    manifest = build_bundle(assets, source, checkpoint, provenance, output)
    assert validate_bundle(output) == []
    assert manifest['checkpoint_config'] == json.loads((checkpoint / 'config.json').read_text())
    assert manifest['source']['commit'] == subprocess.check_output(
        ['git', '-C', str(source), 'rev-parse', 'HEAD'], text=True).strip()
    assert manifest['processor_config']['time_marker_every_seconds'] == 5
    saved_tokenizer = json.loads((output / 'tokenizer_config.json').read_text())
    assert saved_tokenizer['chat_template'] == (checkpoint / 'chat_template.jinja').read_text()
    assert saved_tokenizer['tokenizer_class'] == 'TokenizersBackend'
    assert manifest['derived_configs']['chat_template']['source_sha256'] == hashlib.sha256(
        (checkpoint / 'chat_template.jinja').read_bytes()).hexdigest()
    assert 'chat_template' not in json.loads((assets / 'tokenizer_config.json').read_text())
    with pytest.raises(FileExistsError):
        build_bundle(assets, source, checkpoint, provenance, output)


@pytest.mark.parametrize('change', ['missing', 'hash', 'metadata', 'traversal', 'context',
                                    'evidence', 'runtime_sha', 'bytecount', 'audio_token',
                                    'marker', 'malformed', 'decoder_bytes'])
def test_rejects_corrupt_bundle(bundle_inputs, tmp_path, change):
    from tools.moss_rk3588.build_manifest import build_bundle
    from tools.moss_rk3588.validate_bundle import validate_bundle, DECODER
    source, checkpoint, assets, provenance = bundle_inputs
    output = tmp_path / 'bundle'
    manifest = build_bundle(assets, source, checkpoint, provenance, output)
    if change == 'missing':
        (output / 'selftest/encoder_input.npy').unlink()
    elif change == 'hash':
        (output / 'tokenizer.json').write_text('{}')
    elif change == 'metadata':
        meta = json.loads((output / 'token_embedding.json').read_text())
        meta['rows'] = 5
        (output / 'token_embedding.json').write_text(json.dumps(meta))
    elif change == 'traversal':
        manifest['artifacts']['../outside'] = 'a' * 64
    elif change == 'context':
        manifest['provenance']['decoder']['compiled_context_limit'] = 4096
    elif change == 'evidence':
        manifest['provenance']['decoder']['runtime_log'] = 'max_context_limit: 4096'
    elif change == 'runtime_sha':
        manifest['provenance']['decoder']['runtime_model_sha256'] = 'e' * 64
    elif change == 'bytecount':
        (output / 'moss_token_embedding_fp16.bin').write_bytes(b'bad')
    elif change == 'audio_token':
        manifest['checkpoint_config']['audio_token_id'] = 2
    elif change == 'marker':
        manifest['processor_config']['time_marker_every_seconds'] = 0
    elif change == 'decoder_bytes':
        (output / 'selftest/decoder_input.f32').write_bytes(b'bad')
    elif change == 'malformed':
        manifest['provenance'] = []
    (output / 'manifest.json').write_text(json.dumps(manifest))
    assert validate_bundle(output)


def test_build_refuses_dirty_source_missing_asset_and_old_context(bundle_inputs, tmp_path):
    from tools.moss_rk3588.build_manifest import build_bundle
    source, checkpoint, assets, provenance = bundle_inputs
    (source / 'untracked').write_text('dirty')
    with pytest.raises(ValueError, match='dirty'):
        build_bundle(assets, source, checkpoint, provenance, tmp_path / 'dirty')
    assert not (tmp_path / 'dirty').exists()
    build_bundle(assets, source, checkpoint, provenance, tmp_path / 'allowed', allow_dirty=True)
    provenance['decoder']['compiled_context_limit'] = 4096
    with pytest.raises(ValueError):
        build_bundle(assets, source, checkpoint, provenance, tmp_path / 'old', allow_dirty=True)
    assert not (tmp_path / 'old').exists()
    (assets / 'selftest/encoder_input.npy').unlink()
    with pytest.raises(ValueError):
        build_bundle(assets, source, checkpoint, provenance, tmp_path / 'missing', allow_dirty=True)
    assert not (tmp_path / 'missing').exists()


@pytest.mark.parametrize('change', ['embedding_bytes', 'embedding_dtype', 'decoder_nonfinite',
                                    'encoder_expected_missing_values', 'template_source_hash',
                                    'embedding_nan', 'embedding_inf'])
def test_semantics_rejected_even_with_updated_artifact_hashes(bundle_inputs, tmp_path, change):
    from tools.moss_rk3588.build_manifest import build_bundle
    from tools.moss_rk3588.validate_bundle import validate_bundle, EMBEDDING, sha256_file
    source, checkpoint, assets, provenance = bundle_inputs
    output = tmp_path / 'bundle'
    manifest = build_bundle(assets, source, checkpoint, provenance, output)
    if change in ('embedding_bytes', 'embedding_nan', 'embedding_inf'):
        if change == 'embedding_bytes':
            (output / EMBEDDING).write_bytes(b'bad')
        else:
            with (output / EMBEDDING).open('r+b') as stream:
                stream.write(np.asarray([np.nan if change == 'embedding_nan' else np.inf], dtype='<f2').tobytes())
        manifest['token_embedding']['sha256'] = sha256_file(output / EMBEDDING)
        (output / 'token_embedding.json').write_text(json.dumps(manifest['token_embedding']))
    elif change == 'embedding_dtype':
        manifest['token_embedding']['dtype'] = 'bfloat16'
        (output / 'token_embedding.json').write_text(json.dumps(manifest['token_embedding']))
    elif change == 'decoder_nonfinite':
        np.full((1, 1, 1024), np.nan, dtype='<f4').tofile(output / 'selftest/decoder_input.f32')
    elif change == 'template_source_hash':
        manifest['derived_configs']['chat_template']['source_sha256'] = '0' * 64
    else:
        expected = json.loads((output / 'selftest/encoder_expected.json').read_text())
        expected.pop('values', None)
        (output / 'selftest/encoder_expected.json').write_text(json.dumps(expected))
    manifest['artifacts'] = {name: sha256_file(output / name) for name in manifest['artifacts']}
    (output / 'manifest.json').write_text(json.dumps(manifest))
    assert validate_bundle(output)


def test_required_bundle_assets():
    assert importlib.util.find_spec('tools.moss_rk3588.validate_bundle') is not None, 'bundle validator is missing'
    from tools.moss_rk3588.validate_bundle import validate_manifest

    errors = '\n'.join(validate_manifest({'artifacts': {}}, set()))
    for name in ('moss_audio_encoder_fp16_rk3588.rknn',
                 'moss_qwen3_0.6b_w8a8_rk3588.rkllm',
                 'selftest/encoder_input.npy', 'selftest/decoder_input.f32'):
        assert name in errors


@pytest.mark.parametrize('change', ['cadence', 'rate', 'feature_extractor', 'tokenizer.json',
                                   'tokenizer_config.json', 'special_tokens_map.json',
                                   'missing_binding', 'mismatched_binding', 'component'])
def test_builder_rejects_assets_unbound_to_checkpoint(bundle_inputs, tmp_path, change):
    from tools.moss_rk3588.build_manifest import build_bundle
    source, checkpoint, assets, provenance = bundle_inputs
    if change in ('cadence', 'rate', 'feature_extractor'):
        path = assets / 'processor_config.json'
        value = json.loads(path.read_text())
        if change == 'cadence':
            value['time_marker_every_seconds'] = 999
        elif change == 'rate':
            value['audio_tokens_per_second'] = 1
        else:
            value['feature_extractor']['sampling_rate'] = 8000
    elif change.endswith('.json'):
        path = assets / change
        value = json.loads(path.read_text())
        value['foreign_field'] = 'changed staged tokenizer'
    else:
        path = assets / 'token_embedding.json'
        value = json.loads(path.read_text())
        if change == 'missing_binding':
            value.pop('tokenizer_source_files')
        elif change == 'mismatched_binding':
            value['tokenizer_source_files']['tokenizer.json'] = '0' * 64
        else:
            value['source_components']['tokenizer'] = '0' * 64
    path.write_text(json.dumps(value))
    with pytest.raises(ValueError):
        build_bundle(assets, source, checkpoint, provenance, tmp_path / 'rejected')
    assert not (tmp_path / 'rejected').exists()


@pytest.mark.parametrize('change', ['valid', 'hash', 'shape', 'bytes'])
def test_decoder_validation_never_allocates_full_untrusted_file(bundle_inputs, tmp_path, monkeypatch, change):
    from tools.moss_rk3588.build_manifest import build_bundle
    from tools.moss_rk3588.validate_bundle import validate_bundle, sha256_file
    source, checkpoint, assets, provenance = bundle_inputs
    output = tmp_path / 'bundle'
    manifest = build_bundle(assets, source, checkpoint, provenance, output)
    if change in ('hash', 'bytes'):
        (output / 'selftest/decoder_input.f32').write_bytes(b'bad')
    elif change == 'shape':
        path = output / 'selftest/decoder_expected.json'
        expected = json.loads(path.read_text())
        expected['input_shape'] = [1, 1000000000, 1024]
        path.write_text(json.dumps(expected))
    if change != 'hash':
        manifest['artifacts'] = {name: sha256_file(output / name) for name in manifest['artifacts']}
    (output / 'manifest.json').write_text(json.dumps(manifest))
    def forbidden_full_read(*args, **kwargs):
        raise AssertionError('Must not allocate entire decoder input')
    original_memmap = np.memmap
    def guarded_memmap(path, *args, **kwargs):
        if str(path).endswith('decoder_input.f32') and change != 'valid':
            raise AssertionError('Must reject invalid decoder before mapping it')
        return original_memmap(path, *args, **kwargs)
    monkeypatch.setattr(np, 'fromfile', forbidden_full_read)
    monkeypatch.setattr(np, 'memmap', guarded_memmap)
    errors = validate_bundle(output)
    assert bool(errors) is (change != 'valid')


def test_template_preserves_crlf_source_bytes(bundle_inputs, tmp_path):
    from tools.moss_rk3588.build_manifest import build_bundle
    from tools.moss_rk3588.capture_input_embeds import fingerprint_model
    source, checkpoint, assets, provenance = bundle_inputs
    template = b'line one\r\nline two\r\n'
    (checkpoint / 'chat_template.jinja').write_bytes(template)
    fingerprint = fingerprint_model(checkpoint)
    for name in ('token_embedding.json', 'selftest/encoder_expected.json', 'selftest/decoder_expected.json'):
        path = assets / name
        value = json.loads(path.read_text())
        value['source_fingerprint'] = fingerprint
        path.write_text(json.dumps(value))
    output = tmp_path / 'bundle'
    manifest = build_bundle(assets, source, checkpoint, provenance, output)
    saved = json.loads((output / 'tokenizer_config.json').read_text())
    assert saved['chat_template'].encode() == template
    assert manifest['derived_configs']['chat_template']['source_sha256'] == hashlib.sha256(template).hexdigest()
