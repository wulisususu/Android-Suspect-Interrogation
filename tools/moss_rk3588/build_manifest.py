"""Build a new bundle from prestaged exact assets and measured conversion evidence.

Use separate --source (official Git checkout) and --checkpoint (local HF snapshot).
Selftest expected files must contain measured reference data, never placeholders.
"""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

from .validate_bundle import POLICY, REQUIRED, sha256_file, validate_bundle


def build_bundle(assets, source, checkpoint, provenance, output, allow_dirty=False):
    assets, source, checkpoint, output = (Path(p).resolve() for p in (assets, source, checkpoint, output))
    if output.exists():
        raise FileExistsError(output)
    if any(output == path or output.is_relative_to(path) or path.is_relative_to(output)
           for path in (assets, source, checkpoint)):
        raise ValueError('Output must not overlap assets, source or checkpoint')
    commit = subprocess.check_output(['git', '-C', str(source), 'rev-parse', 'HEAD'], text=True).strip()
    dirty = bool(subprocess.check_output(
        ['git', '-C', str(source), 'status', '--porcelain', '--untracked-files=all'], text=True).strip())
    if dirty and not allow_dirty:
        raise ValueError('Official MOSS source checkout is dirty; use --allow-dirty to record this explicitly')
    missing = sorted(name for name in REQUIRED if not (assets / name).is_file())
    if missing:
        raise ValueError(f'Missing staged assets: {missing}')
    from .capture_input_embeds import fingerprint_model

    metadata = json.loads((assets / 'token_embedding.json').read_text(encoding='utf-8'))
    tokenizer_hashes = {name: sha256_file(checkpoint / name) for name in
                        ('tokenizer.json', 'tokenizer_config.json', 'special_tokens_map.json')}
    if (metadata.get('tokenizer_source_files') != tokenizer_hashes
            or any(sha256_file(assets / name) != digest for name, digest in tokenizer_hashes.items())):
        raise ValueError('Staged/exported tokenizer source hashes differ from checkpoint')
    tokenizer_fingerprint = hashlib.sha256(json.dumps(
        tokenizer_hashes, sort_keys=True, separators=(',', ':')).encode()).hexdigest()
    if metadata.get('source_components', {}).get('tokenizer') != tokenizer_fingerprint:
        raise ValueError('Tokenizer component fingerprint differs from checkpoint source files')
    processor_source = json.loads((checkpoint / 'processor_config.json').read_text(encoding='utf-8'))
    feature_source = json.loads((checkpoint / 'preprocessor_config.json').read_text(encoding='utf-8'))
    processor_config = {**processor_source, 'feature_extractor': feature_source}
    if json.loads((assets / 'processor_config.json').read_text(encoding='utf-8')) != processor_config:
        raise ValueError('Staged processor/feature_extractor configuration differs from checkpoint')
    tokenizer_config = json.loads((assets / 'tokenizer_config.json').read_text(encoding='utf-8'))
    template_path = checkpoint / 'chat_template.jinja'
    template = template_path.read_bytes().decode('utf-8')
    if not template.strip():
        raise ValueError('Checkpoint chat_template.jinja is empty')
    tokenizer_config['chat_template'] = template
    prepared_tokenizer = json.dumps(tokenizer_config, ensure_ascii=False, indent=2).encode('utf-8')
    manifest = {'schema_version': 1, 'source': {'path': str(source), 'commit': commit, 'dirty': dirty},
                'checkpoint_path': str(checkpoint), 'checkpoint_fingerprint': fingerprint_model(checkpoint),
                'checkpoint_config': json.loads((checkpoint / 'config.json').read_text(encoding='utf-8')),
                'checkpoint_config_sha256': sha256_file(checkpoint / 'config.json'),
                'configuration_sources': {
                    'processor_config.json': {'config': processor_source,
                                              'sha256': sha256_file(checkpoint / 'processor_config.json')},
                    'preprocessor_config.json': {'config': feature_source,
                                                 'sha256': sha256_file(checkpoint / 'preprocessor_config.json')}},
                'derived_configs': {'chat_template': {'source_path': str(template_path),
                                    'source_sha256': sha256_file(template_path),
                                    'staged_tokenizer_config_sha256': sha256_file(assets / 'tokenizer_config.json'),
                                    'bundle_tokenizer_config_sha256': hashlib.sha256(prepared_tokenizer).hexdigest()}},
                'components': metadata['source_components'], 'token_embedding': metadata,
                'processor_config': processor_config,
                'policy': dict(POLICY), 'provenance': provenance,
                'artifacts': {name: sha256_file(assets / name) for name in sorted(REQUIRED)}}
    manifest['artifacts']['tokenizer_config.json'] = hashlib.sha256(prepared_tokenizer).hexdigest()
    errors = validate_bundle(assets, manifest, prepared_tokenizer)
    if errors:
        raise ValueError('\n'.join(errors))
    output.mkdir(parents=True, exist_ok=False)
    for name in sorted(REQUIRED):
        target = output / name
        target.parent.mkdir(parents=True, exist_ok=True)
        # Exclusive creation: never replace a file if another writer races the build.
        with target.open('xb') as dst:
            if name == 'tokenizer_config.json':
                dst.write(prepared_tokenizer)
            else:
                with (assets / name).open('rb') as src:
                    shutil.copyfileobj(src, dst)
    with (output / 'manifest.json').open('x', encoding='utf-8') as stream:
        json.dump(manifest, stream, indent=2, ensure_ascii=False)
    errors = validate_bundle(output)
    if errors:
        raise ValueError('Copied bundle failed verification (preserved for inspection): ' + '\n'.join(errors))
    return manifest


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for option in ('assets', 'source', 'checkpoint', 'provenance', 'output'):
        parser.add_argument('--' + option, required=True, type=Path)
    parser.add_argument('--allow-dirty', action='store_true')
    args = parser.parse_args()
    result = build_bundle(args.assets, args.source, args.checkpoint,
                          json.loads(args.provenance.read_text(encoding='utf-8')),
                          args.output, args.allow_dirty)
    print(json.dumps(result, indent=2, ensure_ascii=False))
