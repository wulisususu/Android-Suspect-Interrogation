"""Gate B: compare fixed MOSS audio embeddings locally or on RK3588."""
import argparse
from contextlib import contextmanager
from importlib.metadata import version
import json
from pathlib import Path

import numpy as np

INPUT_SHAPE = (1, 80, 3000)
OUTPUT_SHAPE = (1, 375, 1024)


def compare(reference, candidate):
    report = {'passed': False, 'reference_shape': list(reference.shape),
              'candidate_shape': list(candidate.shape), 'cosine_min': .995, 'mae_max': .03}
    if reference.shape != OUTPUT_SHAPE or candidate.shape != OUTPUT_SHAPE:
        return dict(report, error='Expected exact shape [1, 375, 1024]')
    if not np.isfinite(reference).all() or not np.isfinite(candidate).all():
        return dict(report, error='Non-finite embeddings')
    ref, actual = reference.astype(np.float64).ravel(), candidate.astype(np.float64).ravel()
    denominator = np.linalg.norm(ref) * np.linalg.norm(actual)
    if denominator == 0:
        return dict(report, error='Cosine is undefined for zero embeddings')
    cosine = float(np.dot(ref, actual) / denominator)
    mae = float(np.mean(np.abs(ref - actual)))
    return dict(report, cosine=cosine, mae=mae, passed=cosine >= .995 and mae <= .03)


@contextmanager
def select_runtime_library(library):
    if library is None:
        yield None
        return
    library = Path(library).resolve(strict=True)
    if not library.is_file():
        raise ValueError('Runtime library must be a file')
    if version('rknn-toolkit-lite2') != '2.3.2':
        raise RuntimeError('Private runtime selection requires RKNNLite 2.3.2')
    from rknnlite.api.rknn_runtime import RKNNRuntime

    # SDK 2.3.2 loads an absolute system path, ignoring LD_LIBRARY_PATH.
    # Override only inside this single-threaded offline probe; never edit the SDK.
    original = RKNNRuntime._get_rknn_api_lib_path
    try:
        RKNNRuntime._get_rknn_api_lib_path = lambda self: str(library)
        yield library
    finally:
        RKNNRuntime._get_rknn_api_lib_path = original


def run_rknn(model, features, runtime_library=None):
    from rknnlite.api import RKNNLite

    if (features.shape != INPUT_SHAPE or features.dtype.kind != 'f'
            or not np.isfinite(features).all()):
        raise ValueError('Input must be finite floating point [1, 80, 3000] features')
    with np.errstate(over='ignore'):
        features = np.ascontiguousarray(features, dtype=np.float32)
    if not np.isfinite(features).all():
        raise ValueError('Input features overflow float32')
    runtime = None
    try:
        with select_runtime_library(runtime_library) as selected:
            runtime = RKNNLite()
            result = runtime.load_rknn(str(model))
            if result != 0:
                raise RuntimeError(f'load_rknn failed: {result}')
            result = runtime.init_runtime(core_mask=RKNNLite.NPU_CORE_0_1_2)
            if result != 0:
                raise RuntimeError(f'init_runtime failed: {result}')
        if selected is not None:
            loaded = getattr(getattr(getattr(runtime, 'rknn_runtime', None), 'lib', None), '_name', None)
            if loaded is None or Path(loaded).resolve() != selected:
                raise RuntimeError(f'RKNN loaded unexpected runtime library: {loaded}')
            print(f'Verified RKNN runtime library: {loaded}')
        outputs = runtime.inference(inputs=[features], data_format=['nchw'])
        if outputs is None or len(outputs) != 1:
            raise RuntimeError('Expected one RKNN output')
        return np.asarray(outputs[0])
    finally:
        if runtime is not None:
            runtime.release()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reference', type=Path, required=True)
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument('--candidate', type=Path)
    source.add_argument('--model', type=Path)
    parser.add_argument('--input-features', type=Path)
    parser.add_argument('--runtime-library', type=Path,
                        help='Private librknnrt.so; requires RKNNLite 2.3.2')
    parser.add_argument('--save-output', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.model and not args.input_features:
        parser.error('--model requires --input-features')
    if args.runtime_library and not args.model:
        parser.error('--runtime-library requires --model')
    reference = np.load(args.reference, allow_pickle=False)
    candidate = (run_rknn(args.model, np.load(args.input_features, allow_pickle=False), args.runtime_library)
                 if args.model else np.load(args.candidate, allow_pickle=False))
    if args.save_output:
        np.save(args.save_output, candidate, allow_pickle=False)
    report = compare(reference, candidate)
    args.output.write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps(report))
    raise SystemExit(0 if report['passed'] else 1)


if __name__ == '__main__':
    main()
