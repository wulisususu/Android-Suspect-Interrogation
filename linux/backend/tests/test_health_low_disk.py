from app.health import _storage_check
from app.runtime_settings import RuntimeSettings


def test_low_disk_is_a_required_readiness_failure(tmp_path):
    # Use an intentionally impossible minimum so the test is deterministic on
    # hosted runners and RK3588 regardless of actual free-space size.
    settings = RuntimeSettings(data_dir=tmp_path, min_free_mb=10**15)
    result = _storage_check(settings)
    assert result['state'] == 'LOW_SPACE'
    assert result['required'] is True
