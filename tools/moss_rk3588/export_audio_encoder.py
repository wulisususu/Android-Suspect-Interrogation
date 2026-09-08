"""Export one static 30-second MOSS Whisper + time-merge + adaptor window."""
import argparse
import json
from pathlib import Path

import numpy as np
import torch

if __package__:
    from .capture_input_embeds import fingerprint_model, guard_output, load_local_moss, sha256_file
else:
    from capture_input_embeds import fingerprint_model, guard_output, load_local_moss, sha256_file


def load_features(path):
    features = np.load(path, allow_pickle=False)
    if (features.shape != (1, 80, 3000) or features.dtype.kind != 'f'
            or not np.isfinite(features).all()):
        raise ValueError('Features must be finite floating point [1, 80, 3000]')
    features = np.ascontiguousarray(features, dtype=np.float32)
    if not np.isfinite(features).all():
        raise ValueError('Features overflow float32')
    return features


class MossAudioEncoderExport(torch.nn.Module):
    def __init__(self, whisper, adaptor, merge_size):
        super().__init__()
        self.whisper = whisper
        self.adaptor = adaptor
        self.merge_size = merge_size

    def forward(self, input_features):
        features = self.whisper(input_features, return_dict=True).last_hidden_state
        batch, time, width = features.shape
        trimmed = time // self.merge_size * self.merge_size
        merged = features[:, :trimmed, :].reshape(
            batch, trimmed // self.merge_size, width * self.merge_size)
        return self.adaptor(merged)


def export_encoder(model_dir, input_features, output_dir):
    import onnxruntime as ort
    if __package__:
        from .compare_pytorch_rknn import compare
    else:
        from compare_pytorch_rknn import compare

    model_dir, output_dir = Path(model_dir), Path(output_dir)
    guard_output(model_dir, output_dir)
    features = load_features(input_features)
    fingerprint = fingerprint_model(model_dir)
    moss, _ = load_local_moss(model_dir)
    if int(moss.config.audio_merge_size) != 4:
        raise ValueError('Static MOSS export requires audio_merge_size=4')
    wrapper = MossAudioEncoderExport(moss.model.whisper_encoder, moss.model.vq_adaptor, 4)
    wrapper = wrapper.cpu().float().eval()
    del moss
    tensor = torch.from_numpy(features)
    with torch.inference_mode():
        golden = wrapper(tensor).numpy()
    if golden.shape != (1, 375, 1024) or not np.isfinite(golden).all():
        raise ValueError('MOSS output must be finite [1, 375, 1024]')
    output_dir.mkdir(parents=True, exist_ok=True)
    onnx_path = output_dir / 'moss_audio_encoder.onnx'
    with torch.inference_mode():
        torch.onnx.export(wrapper, (tensor,), onnx_path, input_names=['input_features'],
                          output_names=['audio_embeddings'], opset_version=17,
                          dynamic_axes=None, dynamo=False)
    session = ort.InferenceSession(str(onnx_path), providers=['CPUExecutionProvider'])
    if (session.get_inputs()[0].shape != [1, 80, 3000]
            or session.get_outputs()[0].shape != [1, 375, 1024]):
        raise ValueError('ONNX graph does not have the required static dimensions')
    actual = session.run(['audio_embeddings'], {'input_features': features})[0]
    validation = compare(golden, actual)
    if not validation['passed']:
        raise RuntimeError(f'ONNX Runtime parity failed: {validation}')
    for name, array in (('input_features.npy', features), ('pytorch_output.npy', golden),
                        ('onnx_output.npy', actual)):
        np.save(output_dir / name, array, allow_pickle=False)
    manifest = {'model_fingerprint': fingerprint, 'input_shape': list(features.shape),
                'output_shape': list(golden.shape), 'compute_dtype': 'float32',
                'audio_merge_size': 4, 'opset': 17, 'onnx_validation': validation,
                'artifacts': {path.name: sha256_file(path)
                              for path in sorted(output_dir.iterdir()) if path.is_file()}}
    (output_dir / 'manifest.json').write_text(json.dumps(manifest, indent=2), encoding='utf-8')
    return manifest


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--model', type=Path, required=True)
    parser.add_argument('--input-features', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(export_encoder(args.model, args.input_features, args.output), indent=2))
