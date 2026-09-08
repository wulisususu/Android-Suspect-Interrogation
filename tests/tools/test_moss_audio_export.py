from types import SimpleNamespace

import torch
import numpy as np
import pytest


def test_encoder_merges_four_whisper_frames():
    from tools.moss_rk3588.export_audio_encoder import MossAudioEncoderExport

    class FakeWhisper(torch.nn.Module):
        def forward(self, input_features, return_dict):
            assert return_dict is True
            return SimpleNamespace(last_hidden_state=torch.zeros(1, 1500, 4))

    class FakeAdaptor(torch.nn.Module):
        def forward(self, x):
            return x[..., :4]

    result = MossAudioEncoderExport(FakeWhisper(), FakeAdaptor(), 4)(torch.zeros(1, 80, 3000))
    assert result.shape == (1, 375, 4)


def test_merge_trims_tail_and_preserves_frame_order():
    from tools.moss_rk3588.export_audio_encoder import MossAudioEncoderExport

    class Whisper(torch.nn.Module):
        def forward(self, x, return_dict):
            return SimpleNamespace(last_hidden_state=torch.arange(20).reshape(1, 10, 2))

    output = MossAudioEncoderExport(Whisper(), torch.nn.Identity(), 4)(None)
    assert torch.equal(output, torch.arange(16).reshape(1, 2, 8))


def test_input_requires_static_finite_float_features(tmp_path):
    from tools.moss_rk3588.export_audio_encoder import load_features
    path = tmp_path / 'features.npy'
    for bad in (np.zeros((80, 3000)), np.zeros((1, 80, 3000), dtype=np.int32),
                np.full((1, 80, 3000), np.nan)):
        np.save(path, bad)
        with pytest.raises(ValueError):
            load_features(path)
    np.save(path, np.ones((1, 80, 3000), dtype=np.float64))
    assert load_features(path).dtype == np.float32


def test_gate_b_uses_both_metrics_and_fails_invalid_arrays():
    from tools.moss_rk3588.compare_pytorch_rknn import compare
    reference = np.ones((1, 375, 1024), dtype=np.float32)
    assert compare(reference, reference)['passed']
    assert not compare(reference, reference * 1.04)['passed']
    assert not compare(reference, -reference)['passed']
    assert not compare(reference, reference.reshape(375, 1024))['passed']
    assert not compare(reference, np.full_like(reference, np.nan))['passed']
    assert not compare(np.zeros_like(reference), np.zeros_like(reference))['passed']


def test_build_is_unquantized_rk3588_and_releases_on_error(tmp_path, monkeypatch):
    import sys
    from tools.moss_rk3588.build_rknn import build
    calls = []

    class RKNN:
        def __init__(self, **kwargs): pass
        def config(self, **kwargs):
            calls.append(kwargs)
            return 0
        def load_onnx(self, **kwargs): return 0
        def build(self, **kwargs):
            calls.append(kwargs)
            return -1
        def release(self): calls.append('released')

    monkeypatch.setitem(sys.modules, 'rknn.api', SimpleNamespace(RKNN=RKNN))
    model = tmp_path / 'model.onnx'
    model.touch()
    with pytest.raises(RuntimeError, match='build'):
        build(model, tmp_path / 'model.rknn')
    assert calls == [{'target_platform': 'rk3588', 'float_dtype': 'float16'},
                     {'do_quantization': False}, 'released']


def test_board_uses_three_cores_and_fixed_input(tmp_path, monkeypatch):
    import sys
    from tools.moss_rk3588.compare_pytorch_rknn import run_rknn
    calls = []
    features = np.zeros((1, 80, 3000), dtype=np.float32)

    class RKNNLite:
        NPU_CORE_0_1_2 = 7
        def load_rknn(self, model): return 0
        def init_runtime(self, **kwargs):
            calls.append(kwargs)
            return 0
        def inference(self, inputs, data_format):
            assert data_format == ['nchw']
            assert np.array_equal(inputs[0], features)
            return [np.ones((1, 375, 1024), dtype=np.float32)]
        def release(self): calls.append('released')

    monkeypatch.setitem(sys.modules, 'rknnlite.api', SimpleNamespace(RKNNLite=RKNNLite))
    assert run_rknn(tmp_path / 'model.rknn', features).shape == (1, 375, 1024)
    assert calls == [{'core_mask': 7}, 'released']


@pytest.mark.parametrize('features', [
    np.zeros((1, 80, 3000), dtype=np.int32),
    np.full((1, 80, 3000), np.finfo(np.float64).max),
])
def test_board_rejects_invalid_float32_input_before_creating_runtime(features, monkeypatch):
    import sys
    from tools.moss_rk3588.compare_pytorch_rknn import run_rknn

    class RKNNLite:
        def __init__(self):
            pytest.fail('Invalid input must not create a native runtime')

    monkeypatch.setitem(sys.modules, 'rknnlite.api', SimpleNamespace(RKNNLite=RKNNLite))
    with pytest.raises(ValueError):
        run_rknn('model.rknn', features)


@pytest.mark.parametrize('failure', [None, 'init', 'wrong_library', 'missing_library'])
def test_private_runtime_selection_is_verified_and_restored(tmp_path, monkeypatch, failure):
    import sys
    from tools.moss_rk3588 import compare_pytorch_rknn as probe
    library = tmp_path / 'librknnrt.so'
    library.touch()
    calls = []

    class RKNNRuntime:
        def _get_rknn_api_lib_path(self):
            return '/usr/lib/librknnrt.so'

    original = RKNNRuntime._get_rknn_api_lib_path

    class RKNNLite:
        NPU_CORE_0_1_2 = 7
        def load_rknn(self, model): return 0
        def init_runtime(self, **kwargs):
            selected = RKNNRuntime()._get_rknn_api_lib_path()
            assert Path(selected).resolve() == library.resolve()
            self.rknn_runtime = SimpleNamespace(lib=SimpleNamespace(
                _name='/usr/lib/librknnrt.so' if failure == 'wrong_library' else selected))
            if failure == 'missing_library':
                self.rknn_runtime = None
            return -1 if failure == 'init' else 0
        def inference(self, **kwargs):
            calls.append('inference')
            return [np.ones((1, 375, 1024), dtype=np.float32)]
        def release(self): calls.append('release')

    from pathlib import Path
    monkeypatch.setitem(sys.modules, 'rknnlite.api', SimpleNamespace(RKNNLite=RKNNLite))
    monkeypatch.setitem(sys.modules, 'rknnlite.api.rknn_runtime', SimpleNamespace(RKNNRuntime=RKNNRuntime))
    monkeypatch.setattr(probe, 'version', lambda package: '2.3.2')
    if failure:
        with pytest.raises(RuntimeError):
            probe.run_rknn('model.rknn', np.zeros((1, 80, 3000), np.float32), library)
        assert calls == ['release']
    else:
        probe.run_rknn('model.rknn', np.zeros((1, 80, 3000), np.float32), library)
        assert calls == ['inference', 'release']
    assert RKNNRuntime._get_rknn_api_lib_path is original


def test_private_runtime_rejects_unpinned_sdk(tmp_path, monkeypatch):
    from tools.moss_rk3588 import compare_pytorch_rknn as probe
    library = tmp_path / 'librknnrt.so'
    library.touch()
    monkeypatch.setattr(probe, 'version', lambda package: '2.2.0')
    with pytest.raises(RuntimeError, match='2.3.2'):
        with probe.select_runtime_library(library):
            pytest.fail('Unpinned SDK must not enter the override scope')


def test_export_runs_onnx_inference_and_records_static_contract(tmp_path, monkeypatch):
    import json
    import sys
    from tools.moss_rk3588 import export_audio_encoder as exporter
    calls = []

    class Whisper(torch.nn.Module):
        def forward(self, x, return_dict):
            return SimpleNamespace(last_hidden_state=torch.ones(1, 1500, 256))

    moss = SimpleNamespace(config=SimpleNamespace(audio_merge_size=4), model=SimpleNamespace(
        whisper_encoder=Whisper(), vq_adaptor=torch.nn.Identity()))
    monkeypatch.setattr(exporter, 'load_local_moss', lambda path: (moss, None))
    monkeypatch.setattr(exporter, 'fingerprint_model', lambda path: 'sha256:test')

    def export(model, inputs, path, **kwargs):
        assert kwargs['dynamic_axes'] is None
        assert kwargs['dynamo'] is False
        path.write_bytes(b'onnx')

    class Session:
        def __init__(self, *args, **kwargs): pass
        def get_inputs(self):
            return [SimpleNamespace(shape=[1, 80, 3000])]
        def get_outputs(self):
            return [SimpleNamespace(shape=[1, 375, 1024])]
        def run(self, names, inputs):
            calls.append(inputs['input_features'].shape)
            return [np.ones((1, 375, 1024), dtype=np.float32)]

    monkeypatch.setattr(torch.onnx, 'export', export)
    monkeypatch.setitem(sys.modules, 'onnxruntime', SimpleNamespace(InferenceSession=Session))
    source = tmp_path / 'input.npy'
    np.save(source, np.zeros((1, 80, 3000), dtype=np.float32))
    output = tmp_path / 'export'
    exporter.export_encoder(tmp_path / 'model', source, output)
    manifest = json.loads((output / 'manifest.json').read_text())
    assert manifest['onnx_validation']['passed']
    assert calls == [(1, 80, 3000)]
    assert np.load(output / 'pytorch_output.npy').shape == (1, 375, 1024)
