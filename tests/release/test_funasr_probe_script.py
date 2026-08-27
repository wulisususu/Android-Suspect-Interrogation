from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts" / "ci" / "probe-funasr-runtime.py"


def test_probe_exists_and_is_offline_and_non_destructive():
    text = SCRIPT.read_text(encoding="utf-8")
    assert "disable_update=True" in text
    assert "MODEL_ROOT" in text
    assert "paraformer" in text
    assert "fsmn-vad" in text
    assert "xvector" in text
    assert "AutoModel" in text
    assert "unlink(" not in text
    assert "rmtree(" not in text
