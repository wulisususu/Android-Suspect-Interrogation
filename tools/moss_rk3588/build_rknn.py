"""Build an unquantized FP16 MOSS audio encoder for RK3588, offline."""
import argparse
from pathlib import Path


def build(onnx, output):
    from rknn.api import RKNN

    onnx, output = Path(onnx), Path(output)
    if not onnx.is_file():
        raise FileNotFoundError(onnx)
    if output.exists():
        raise FileExistsError(output)
    converter = RKNN(verbose=True)
    try:
        result = converter.config(target_platform='rk3588', float_dtype='float16')
        if result != 0:
            raise RuntimeError(f'config failed: {result}')
        result = converter.load_onnx(model=str(onnx))
        if result != 0:
            raise RuntimeError(f'load_onnx failed: {result}')
        result = converter.build(do_quantization=False)
        if result != 0:
            raise RuntimeError(f'build failed: {result}')
        result = converter.export_rknn(str(output))
        if result != 0:
            raise RuntimeError(f'export_rknn failed: {result}')
        if not output.is_file() or output.stat().st_size == 0:
            raise RuntimeError('RKNN export produced no model')
    finally:
        converter.release()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--onnx', type=Path, required=True)
    parser.add_argument('--output', type=Path,
                        default=Path('moss_audio_encoder_fp16_rk3588.rknn'))
    args = parser.parse_args()
    build(args.onnx, args.output)
