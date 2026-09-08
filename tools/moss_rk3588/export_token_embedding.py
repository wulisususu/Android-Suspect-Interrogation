"""Export the exact local MOSS token table and checkpoint component fingerprints."""
import argparse
import hashlib
import json
from pathlib import Path

import numpy as np
import torch

from .capture_input_embeds import fingerprint_model, load_local_moss, sha256_file


def component_fingerprints(state):
    """Hash sorted names, shapes, dtypes and original tensor bytes (including BF16)."""
    digests = {name: hashlib.sha256() for name in
               ('whisper_encoder', 'vq_adaptor', 'language_model')}
    counts = dict.fromkeys(digests, 0)
    for name, tensor in sorted(state.items()):
        group = next((key for key in digests if name.startswith(f'model.{key}.')), None)
        if name == 'lm_head.weight':
            group = 'language_model'
        if group is None:
            raise ValueError(f'Unexpected MOSS state key: {name}')
        value = tensor.detach().cpu().contiguous()
        header = json.dumps([name, list(value.shape), str(value.dtype)], separators=(',', ':'))
        digests[group].update(header.encode() + b'\0')
        digests[group].update(value.reshape(-1).view(torch.uint8).numpy().tobytes())
        counts[group] += 1
    if not all(counts.values()):
        raise ValueError('Missing MOSS checkpoint component')
    return {name: digest.hexdigest() for name, digest in digests.items()}


def export_table(weight, source_fingerprint, output):
    output = Path(output)
    if output.exists():
        raise FileExistsError(output)
    if weight.ndim != 2 or weight.shape[0] <= 0 or weight.shape[1] != 1024:
        raise ValueError('MOSS token table must have positive rows and hidden_size=1024')
    value = weight.detach().cpu().to(torch.float16).contiguous()
    if not torch.isfinite(value).all():
        raise ValueError('MOSS embedding is not finite in FP16')
    array = np.ascontiguousarray(value.numpy(), dtype='<f2')
    output.mkdir(parents=True, exist_ok=False)
    binary = output / 'moss_token_embedding_fp16.bin'
    array.tofile(binary)
    metadata = {'rows': int(array.shape[0]), 'hidden_size': 1024, 'dtype': 'float16',
                'byte_order': 'little', 'order': 'C', 'source_fingerprint': source_fingerprint,
                'sha256': sha256_file(binary), 'bytes': binary.stat().st_size}
    (output / 'token_embedding.json').write_text(json.dumps(metadata, indent=2), encoding='utf-8')
    return metadata


def export_token_embedding(model_dir, output):
    model_dir, output = Path(model_dir).resolve(), Path(output).resolve()
    if output == model_dir or output.is_relative_to(model_dir) or model_dir.is_relative_to(output):
        raise ValueError('Model and output directories must not overlap')
    if output.exists():
        raise FileExistsError(output)
    fingerprint = fingerprint_model(model_dir)
    moss, _ = load_local_moss(model_dir)
    components = component_fingerprints(moss.state_dict())
    tokenizer_files = {name: sha256_file(model_dir / name) for name in
                       ('tokenizer.json', 'tokenizer_config.json', 'special_tokens_map.json')
                       if (model_dir / name).is_file()}
    if 'tokenizer.json' not in tokenizer_files or 'tokenizer_config.json' not in tokenizer_files:
        raise ValueError('Checkpoint tokenizer files missing')
    components['tokenizer'] = hashlib.sha256(json.dumps(
        tokenizer_files, sort_keys=True, separators=(',', ':')).encode()).hexdigest()
    metadata = export_table(moss.model.language_model.embed_tokens.weight, fingerprint, output)
    metadata.update(source_components=components, tokenizer_source_files=tokenizer_files,
                    component_hash_format='sorted tensor name, shape, dtype JSON + NUL + native tensor bytes')
    (output / 'token_embedding.json').write_text(json.dumps(metadata, indent=2), encoding='utf-8')
    return metadata


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--model', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    print(json.dumps(export_token_embedding(args.model, args.output), indent=2))
