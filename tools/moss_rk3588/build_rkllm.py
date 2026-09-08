"""Convert the verified MOSS Qwen3 repack with RKLLM Toolkit 1.3.0."""
import argparse
import hashlib
from importlib.metadata import version
import json
from pathlib import Path

MOSS_FINGERPRINT = 'sha256:2617e17cfec24f24b17979b7ba6d607ce259f727224757e8e5f88b6894b74855'


def verify_repack(model):
    model = Path(model).resolve()
    manifest = json.loads((model / 'repack_manifest.json').read_text(encoding='utf-8'))
    if (manifest.get('model_fingerprint') != MOSS_FINGERPRINT
            or manifest.get('architecture') != 'Qwen3ForCausalLM'
            or manifest.get('mapped_tensor_count') != 311):
        raise ValueError('Repack does not match the verified MOSS checkpoint identity')
    artifacts = manifest.get('artifacts', {})
    if 'config.json' not in artifacts or not any(name.endswith('.safetensors') for name in artifacts):
        raise ValueError('Repack manifest lacks config/weight hashes')
    for name, expected in artifacts.items():
        path = model / name
        if Path(name).name != name or not path.is_file():
            raise ValueError(f'Invalid or missing hashed artifact: {name}')
        with path.open('rb') as stream:
            actual = hashlib.file_digest(stream, 'sha256').hexdigest()
        if actual != expected:
            raise ValueError(f'Repack artifact hash mismatch: {name}')
    config = json.loads((model / 'config.json').read_text(encoding='utf-8'))
    if config.get('model_type') != 'qwen3' or config.get('hidden_size') != 1024:
        raise ValueError('MOSS repack must be Qwen3 with hidden size 1024')
    return manifest


def widen_loaded_model(llm):
    import torch

    # Pinned SDK 1.3.0 can retain the checkpoint's BF16 config dtype despite
    # load_huggingface's float32 default. Its first calibration layer then fails
    # against the captured FP32 inputs. Widen only the in-memory weights (lossless
    # for BF16); checkpoint files and captured calibration values stay unchanged.
    llm.base.model.float()
    if any(parameter.dtype != torch.float32 for parameter in llm.base.model.parameters()
           if parameter.is_floating_point()):
        raise RuntimeError('RKLLM loaded model still has non-FP32 floating parameters')


def build(args):
    if (type(args.max_context) is not int or not 0 < args.max_context <= 16384
            or args.max_context % 32 != 0):
        raise ValueError('max_context must be a positive integer multiple of 32, at most 16384')
    verify_repack(args.model)
    installed = version('rkllm-toolkit')
    if installed != '1.3.0':
        raise RuntimeError(f'RKLLM Toolkit must be exactly 1.3.0, got {installed}')
    if not Path(args.dataset).is_file():
        raise FileNotFoundError(args.dataset)
    if Path(args.output).exists():
        raise FileExistsError(args.output)
    from rkllm.api import RKLLM

    llm = RKLLM()
    result = llm.load_huggingface(model=args.model, device='cpu')
    if result != 0:
        raise RuntimeError(f'load_huggingface failed: {result}')
    widen_loaded_model(llm)
    result = llm.build(do_quantization=True, optimization_level=0,
                       quantized_dtype='w8a8', quantized_algorithm='normal',
                       target_platform='rk3588', num_npu_core=3, dataset=args.dataset,
                       max_context=args.max_context)
    if result != 0:
        raise RuntimeError(f'RKLLM build failed: {result}')
    result = llm.export_rkllm(args.output)
    if result != 0:
        raise RuntimeError(f'RKLLM export failed: {result}')
    if not Path(args.output).is_file() or Path(args.output).stat().st_size == 0:
        raise RuntimeError('RKLLM export produced no model')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--model', required=True)
    parser.add_argument('--dataset', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--max-context', type=int, default=16384,
                        help='Compiled context tokens: positive multiple of 32, at most 16384 (default: 16384)')
    build(parser.parse_args())
