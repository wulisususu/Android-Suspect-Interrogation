"""Validate the portable MOSS RK3588 bundle before installation."""
import argparse
import hashlib
import json
import math
from pathlib import Path, PurePosixPath
import re

import numpy as np

ENCODER = 'moss_audio_encoder_fp16_rk3588.rknn'
DECODER = 'moss_qwen3_0.6b_w8a8_rk3588.rkllm'
EMBEDDING = 'moss_token_embedding_fp16.bin'
REQUIRED = {ENCODER, DECODER, EMBEDDING, 'token_embedding.json', 'tokenizer.json',
            'tokenizer_config.json', 'special_tokens_map.json', 'generation_config.json',
            'processor_config.json', 'selftest/encoder_input.npy',
            'selftest/encoder_expected.json', 'selftest/decoder_input.f32',
            'selftest/decoder_expected.json'}
POLICY = {'compiled_context_limit': 16384, 'generation_reserve': 5120,
          'safety_margin': 512, 'target_window_minutes': 10,
          'fallback_window_minutes': 8, 'minimum_window_minutes': 8,
          'overlap_minutes': 2, 'logical_chunk_minutes': 60}


def sha256_file(path):
    digest = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def valid_sha(value):
    return isinstance(value, str) and re.fullmatch('[0-9a-f]{64}', value) is not None


def safe_name(name):
    return (isinstance(name, str) and bool(name) and '\\' not in name and ':' not in name
            and not PurePosixPath(name).is_absolute()
            and all(part not in ('', '.', '..') for part in name.split('/')))


def finite_file(path, dtype):
    values = np.memmap(path, dtype=dtype, mode='r')
    try:
        return all(np.isfinite(values[start:start + 1024 * 1024]).all()
                   for start in range(0, values.size, 1024 * 1024))
    finally:
        del values


def validate_manifest(manifest, available):
    if not isinstance(manifest, dict):
        return ['Manifest must be a JSON object']
    artifacts = manifest.get('artifacts', {})
    if not isinstance(artifacts, dict):
        return ['artifacts must be an object']
    errors = [f'Missing required artifact: {name}' for name in sorted(REQUIRED)
              if name not in artifacts or name not in available]
    for name, digest in artifacts.items():
        if not safe_name(name) or name not in REQUIRED:
            errors.append(f'Invalid artifact path: {name}')
        if not valid_sha(digest):
            errors.append(f'Invalid artifact SHA256: {name}')
    for name in available - REQUIRED - {'manifest.json'}:
        errors.append(f'Unexpected bundle artifact: {name}')
    if manifest.get('policy') != POLICY:
        errors.append('Unapproved context/window policy; compiled context must be 16384')
    try:
        source = manifest['source']
        if not re.fullmatch('[0-9a-f]{40}', source['commit']) or type(source['dirty']) is not bool:
            errors.append('Invalid source commit/dirty status')
        if not re.fullmatch('sha256:[0-9a-f]{64}', manifest['checkpoint_fingerprint']):
            errors.append('Invalid checkpoint fingerprint')
        if not re.fullmatch('[0-9a-f]{40}', manifest['provenance']['checkpoint_revision']):
            errors.append('Invalid checkpoint revision')
        if not all(valid_sha(manifest['components'][key]) for key in
                   ('whisper_encoder', 'vq_adaptor', 'language_model', 'tokenizer')):
            errors.append('Invalid component fingerprints')
        metadata = manifest['token_embedding']
        tokenizer_hashes = metadata['tokenizer_source_files']
        if (set(tokenizer_hashes) != {'tokenizer.json', 'tokenizer_config.json', 'special_tokens_map.json'}
                or not all(valid_sha(value) for value in tokenizer_hashes.values())
                or hashlib.sha256(json.dumps(tokenizer_hashes, sort_keys=True, separators=(',', ':')).encode()).hexdigest()
                   != manifest['components']['tokenizer']
                or any(tokenizer_hashes[name] != artifacts.get(name) for name in
                       ('tokenizer.json', 'special_tokens_map.json'))
                or tokenizer_hashes['tokenizer_config.json'] != manifest['derived_configs']['chat_template']['staged_tokenizer_config_sha256']):
            errors.append('Tokenizer source/component hashes are not bound to bundle')
        rows = metadata['rows']
        if (type(rows) is not int or rows <= 0 or metadata['hidden_size'] != 1024
                or metadata['dtype'] != 'float16' or metadata['byte_order'] != 'little'
                or metadata['order'] != 'C' or metadata['bytes'] != rows * 1024 * 2
                or metadata['sha256'] != artifacts.get(EMBEDDING)
                or metadata['source_fingerprint'] != manifest['checkpoint_fingerprint']
                or metadata['source_components'] != manifest['components']):
            errors.append('Invalid token embedding metadata')
        config, processor = manifest['checkpoint_config'], manifest['processor_config']
        sources = manifest['configuration_sources']
        if (not all(valid_sha(sources[name]['sha256']) for name in
                    ('processor_config.json', 'preprocessor_config.json'))
                or processor != {**sources['processor_config.json']['config'],
                                  'feature_extractor': sources['preprocessor_config.json']['config']}):
            errors.append('Processor configuration differs from recorded checkpoint sources')
        if config['text_config']['hidden_size'] != 1024 or config['text_config']['vocab_size'] != rows:
            errors.append('Checkpoint text config does not match token table')
        audio_id = config['audio_token_id']
        if type(audio_id) is not int or not 0 <= audio_id < rows:
            errors.append('Invalid audio_token_id')
        if 'audio_token_id' in processor and processor['audio_token_id'] != audio_id:
            errors.append('Processor audio_token_id differs from checkpoint')
        if processor['audio_merge_size'] != config['audio_merge_size']:
            errors.append('Processor audio_merge_size differs from checkpoint')
        for key in ('audio_tokens_per_second', 'time_marker_every_seconds'):
            value = processor[key]
            if type(value) not in (int, float) or not math.isfinite(value) or value <= 0:
                errors.append(f'Invalid processor {key}')
        if processor['enable_time_marker'] is not True:
            errors.append('MOSS numeric time markers must be enabled')
        for component, artifact, version in (('encoder', ENCODER, '2.3.2'), ('decoder', DECODER, '1.3.0')):
            evidence = manifest['provenance'][component]
            runtime_version = evidence.get('runtime_version', evidence.get('gate_b_runtime_confirmed'))
            if (evidence['model_sha256'] != artifacts.get(artifact)
                    or evidence['toolkit_version'] != version or runtime_version != version
                    or not valid_sha(evidence['runtime_sha256'])):
                errors.append(f'Invalid {component} model/SDK/runtime evidence')
        decoder = manifest['provenance']['decoder']
        contexts = re.findall(r'max_context_limit\s*[:=]\s*(\d+)', decoder['runtime_log'])
        if (type(decoder['compiled_context_limit']) is not int
                or decoder['compiled_context_limit'] != 16384 or not contexts
                or any(int(value) != 16384 for value in contexts)
                or decoder['runtime_model_sha256'] != artifacts.get(DECODER)):
            errors.append('Decoder requires model-bound build and board runtime context 16384 evidence')
    except (KeyError, TypeError, ValueError, AttributeError) as exc:
        errors.append(f'Malformed or missing manifest metadata: {exc}')
    return errors


def validate_bundle(root, manifest=None, prepared_tokenizer_config=None):
    root = Path(root).resolve()
    try:
        if manifest is None:
            manifest = json.loads((root / 'manifest.json').read_text(encoding='utf-8'))
        paths = list(root.rglob('*'))
        available = {path.relative_to(root).as_posix() for path in paths if path.is_file()}
        errors = validate_manifest(manifest, available)
        if not isinstance(manifest, dict) or not isinstance(manifest.get('artifacts'), dict):
            return errors
        for path in paths:
            if path.is_symlink() or not path.resolve().is_relative_to(root):
                errors.append(f'Bundle symlink/escape rejected: {path.relative_to(root)}')
        if errors:
            return errors
        for name, digest in manifest['artifacts'].items():
            actual = (hashlib.sha256(prepared_tokenizer_config).hexdigest()
                      if name == 'tokenizer_config.json' and prepared_tokenizer_config is not None
                      else sha256_file(root / name))
            if actual != digest:
                errors.append(f'Artifact SHA256 mismatch: {name}')
        if errors:
            return errors
        metadata = json.loads((root / 'token_embedding.json').read_text(encoding='utf-8'))
        if metadata != manifest['token_embedding']:
            errors.append('token_embedding.json differs from manifest')
        if (root / EMBEDDING).stat().st_size != metadata['rows'] * 1024 * 2:
            errors.append('Embedding byte count must equal rows*1024*2')
        elif not finite_file(root / EMBEDDING, '<f2'):
            errors.append('Token embedding table must contain only finite FP16 values')
        processor = json.loads((root / 'processor_config.json').read_text(encoding='utf-8'))
        if processor != manifest['processor_config']:
            errors.append('processor_config.json differs from manifest')
        tokenizer = json.loads((root / 'tokenizer.json').read_text(encoding='utf-8'))
        tokens = {item['content']: item['id'] for item in tokenizer.get('added_tokens', [])}
        tokens.update(tokenizer.get('model', {}).get('vocab', {}))
        if tokens.get('<|audio_pad|>') != manifest['checkpoint_config']['audio_token_id']:
            errors.append('Tokenizer audio token differs from checkpoint')
        tokenizer_config = json.loads(prepared_tokenizer_config if prepared_tokenizer_config is not None
                                      else (root / 'tokenizer_config.json').read_bytes())
        if not tokenizer_config.get('chat_template'):
            errors.append('Missing MOSS chat template')
        derived = manifest['derived_configs']['chat_template']
        if (hashlib.sha256(tokenizer_config['chat_template'].encode('utf-8')).hexdigest()
                != derived['source_sha256']
                or derived['bundle_tokenizer_config_sha256'] != manifest['artifacts']['tokenizer_config.json']
                or not valid_sha(derived['staged_tokenizer_config_sha256'])):
            errors.append('Derived tokenizer configuration source/hash mismatch')
        generation = json.loads((root / 'generation_config.json').read_text(encoding='utf-8'))
        if generation.get('max_new_tokens') != POLICY['generation_reserve'] or not generation.get('eos_token_id'):
            errors.append('Invalid generation reserve/eos configuration')
        json.loads((root / 'special_tokens_map.json').read_text(encoding='utf-8'))
        encoder = np.load(root / 'selftest/encoder_input.npy', allow_pickle=False, mmap_mode='r')
        if encoder.shape != (1, 80, 3000) or encoder.dtype != np.dtype('<f4') or not np.isfinite(encoder).all():
            errors.append('Invalid encoder selftest input shape/dtype/values')
        for name in ('encoder', 'decoder'):
            expected = json.loads((root / f'selftest/{name}_expected.json').read_text(encoding='utf-8'))
            if expected['source_fingerprint'] != manifest['checkpoint_fingerprint']:
                errors.append(f'{name} selftest checkpoint fingerprint mismatch')
            if name == 'encoder':
                if expected['shape'] != [1, 375, 1024] or expected['dtype'] != 'float32':
                    errors.append('Invalid encoder expected shape/dtype')
                values = np.asarray(expected['values'], dtype=np.float32)
                if values.shape != (1, 375, 1024) or not np.isfinite(values).all():
                    errors.append('Invalid encoder expected values')
                if not (0 < expected['cosine_min'] <= 1 and 0 < expected['mae_max'] < 1):
                    errors.append('Invalid encoder selftest tolerances')
            else:
                shape = expected['input_shape']
                if (len(shape) != 3 or shape[0] != 1 or shape[2] != 1024
                        or type(shape[1]) is not int or shape[1] <= 0
                        or shape[1] + 5120 + 512 > 16384
                        or not isinstance(expected['output_text'], str) or not expected['output_text'].strip()
                        or (root / 'selftest/decoder_input.f32').stat().st_size != math.prod(shape) * 4):
                    errors.append('Invalid decoder selftest shape/bytes/expected text')
                    continue
                if not finite_file(root / 'selftest/decoder_input.f32', '<f4'):
                    errors.append('Decoder selftest embeddings must be finite')
    except (OSError, ValueError, TypeError, KeyError, AttributeError, EOFError) as exc:
        return [f'Invalid bundle: {exc}']
    return errors


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('bundle', type=Path)
    args = parser.parse_args()
    errors = validate_bundle(args.bundle)
    print(json.dumps({'valid': not errors, 'errors': errors}, indent=2))
    raise SystemExit(bool(errors))
