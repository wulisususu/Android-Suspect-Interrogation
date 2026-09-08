import importlib.util
import json
import pickle
import subprocess
import sys
from types import SimpleNamespace
from pathlib import Path

import numpy as np
import pytest

ROOT = Path(__file__).resolve().parents[2]


def tool(name):
    path = ROOT / 'tools' / 'moss_rk3588' / (name + '.py')
    assert path.is_file(), f'Missing tool: {path}'
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_manual_offline_embed_workflow():
    path = ROOT / '.github/workflows/rk3588-moss-embed-probe.yml'
    assert path.is_file(), 'Missing manual RK3588 embedding gate workflow'
    content = path.read_text(encoding='utf-8')
    for text in ('workflow_dispatch:', 'self-hosted', 'rk3588', 'RKLLM_INPUT_EMBED',
                 '/lib/librkllmrt.so', 'compare_pytorch_rkllm.py'):
        assert text in content
    assert 'curl' not in content and 'wget' not in content
    assert 'pip install' not in content
    assert '80596a578f7f8e70df6eda1c2cbead3bfced14623a190258f2bd009a3d1f72cf' in content
    assert '6a9e4fc5324c68921c3a900340361e107af7599fe34dc8fa7759b2c5ae22a6e6' in content
    assert 'runtime_directory:' in content and 'default: /lib' in content


def test_calibration_tensor_contract(tmp_path):
    module = tool('build_calibration_set')
    source = tmp_path / 'capture.npy'
    array = np.ones((1, 3, 1024), dtype=np.float32)
    np.save(source, array)
    dataset = module.build_calibration_set([source], tmp_path / 'calibration')
    entries = json.loads(dataset.read_text())
    assert entries == [{'sample': 'sample_0000.pkl', 'token_nums': 3}]
    with (dataset.parent / entries[0]['sample']).open('rb') as stream:
        sample = pickle.load(stream)
    assert list(sample) == ['inputs_embeds']
    np.testing.assert_array_equal(sample['inputs_embeds'].numpy(), array)


@pytest.mark.parametrize('shape,value', [((3, 1024), 1), ((2, 3, 1024), 1),
                                       ((1, 3, 512), 1), ((1, 0, 1024), 1),
                                       ((1, 3, 1024), float('nan'))])
def test_calibration_rejects_invalid_array(tmp_path, shape, value):
    module = tool('build_calibration_set')
    source = tmp_path / 'bad.npy'
    np.save(source, np.full(shape, value, dtype=np.float32))
    with pytest.raises(ValueError):
        module.build_calibration_set([source], tmp_path / 'calibration')


def test_comparator_checks_content_and_speakers():
    compare = tool('compare_pytorch_rkllm').compare
    text = '[00:00.00][S01]你好，今天怎么样？[00:03.00]\n[00:03.00][S02]今天很好，谢谢。[00:06.00]'
    assert compare(text, text)['passed']
    assert not compare(text, text.replace('[S02]', '[S01]'))['passed']
    assert not compare(text, '[S01]你好 [S02]谢谢')['passed']
    assert not compare(text, '[00:00.00][S01]完全不同[00:01.00]\n[00:01.00][S02]无关文本[00:02.00]')['passed']


def test_native_uses_130_callback_and_embed_contract():
    path = ROOT / 'tools/moss_rk3588/native/rkllm_embed_probe.cpp'
    assert path.is_file()
    content = path.read_text()
    for text in ('RKLLMCallback', 'RKLLM_INPUT_EMBED', 'embed_input.n_tokens',
                 'enable_thinking = false', 'keep_history = 0', 'RKLLM_RUN_ERROR'):
        assert text in content
    assert content.index('raw byte size mismatch') < content.index('rkllm_init(')


def test_build_rejects_wrong_identity_before_toolkit_import(tmp_path):
    module = tool('build_rkllm')
    (tmp_path / 'repack_manifest.json').write_text(json.dumps({'architecture': 'Qwen3ForCausalLM',
        'model_fingerprint': 'sha256:' + '0' * 64, 'artifacts': {}}))
    with pytest.raises(ValueError, match='MOSS'):
        module.verify_repack(tmp_path)


def test_build_uses_available_130_api():
    source = (ROOT / 'tools/moss_rk3588/build_rkllm.py').read_text()
    assert 'llm.release(' not in source  # The official 1.3.0 RKLLM class has no release method.
    for required in ("installed != '1.3.0'", "device='cpu'", 'optimization_level=0',
                     "quantized_dtype='w8a8'", "quantized_algorithm='normal'",
                     "target_platform='rk3588'", 'num_npu_core=3'):
        assert required in source
    assert source.index('widen_loaded_model(llm)', source.index('def build(')) < source.index('result = llm.build(')


def test_loaded_bf16_model_widens_losslessly_for_fp32_calibration(tmp_path):
    import hashlib
    import torch

    module = tool('build_rkllm')
    assert hasattr(module, 'widen_loaded_model'), 'Missing SDK 1.3.0 loaded-model dtype workaround'
    model = torch.nn.Linear(4, 2, bias=False).to(dtype=torch.bfloat16)
    original = model.weight.detach().clone()
    checkpoint = tmp_path / 'weights.pt'
    torch.save(model.state_dict(), checkpoint)
    digest = hashlib.sha256(checkpoint.read_bytes()).hexdigest()
    llm = SimpleNamespace(base=SimpleNamespace(model=model))
    inputs = torch.tensor([[0.1234567, 0.25, 0.5, 0.75]], dtype=torch.float32)
    module.widen_loaded_model(llm)
    assert all(p.dtype == torch.float32 for p in model.parameters() if p.is_floating_point())
    assert torch.equal(model.weight, original.float())
    assert torch.equal(model(inputs), inputs @ original.float().T)
    assert inputs.dtype == torch.float32 and inputs[0, 0].item() != inputs[0, 0].bfloat16().item()
    assert hashlib.sha256(checkpoint.read_bytes()).hexdigest() == digest
    assert torch.load(checkpoint, weights_only=True)['weight'].dtype == torch.bfloat16


def test_build_detects_changed_artifact(tmp_path):
    module = tool('build_rkllm')
    (tmp_path / 'config.json').write_text('{}')
    (tmp_path / 'repack_manifest.json').write_text(json.dumps({'architecture': 'Qwen3ForCausalLM',
        'model_fingerprint': module.MOSS_FINGERPRINT, 'mapped_tensor_count': 311,
        'artifacts': {'config.json': '0' * 64, 'model.safetensors': '0' * 64}}))
    with pytest.raises(ValueError, match='hash'):
        module.verify_repack(tmp_path)


def test_comparator_cli_rejects_invalid_utf8(tmp_path):
    candidate = tmp_path / 'candidate.txt'
    candidate.write_bytes(b'\xff')
    reference = tmp_path / 'reference.txt'
    reference.write_text('[0.0][S01]甲[1.0][1.0][S02]乙[2.0]', encoding='utf-8')
    report = tmp_path / 'report.json'
    result = subprocess.run([sys.executable, str(ROOT / 'tools/moss_rk3588/compare_pytorch_rkllm.py'),
        '--reference', str(reference), '--candidate', str(candidate), '--output', str(report)],
        capture_output=True)
    assert result.returncode == 1
    assert json.loads(report.read_text())['passed'] is False
