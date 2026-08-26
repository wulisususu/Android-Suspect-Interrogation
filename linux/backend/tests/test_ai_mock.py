from app.health import _ai_capability
from app.runtime_settings import RuntimeSettings


def test_empty_model_directory_is_not_installed_but_optional(tmp_path):
    model_dir = tmp_path / "models"
    model_dir.mkdir()
    result = _ai_capability(RuntimeSettings(model_path=model_dir))
    assert result["state"] == "NOT_INSTALLED"
    assert result["required"] is False


def test_model_file_presence_marks_capability_ready(tmp_path):
    model = tmp_path / "model.bin"
    model.write_bytes(b"test-placeholder-not-a-real-model")
    result = _ai_capability(RuntimeSettings(model_path=model))
    assert result["state"] == "READY"
    assert result["required"] is False
