import pytest

from hardware.base import HardwareError
from hardware.device_manager import DeviceManager


def assert_not_configured(operation):
    with pytest.raises(HardwareError) as captured:
        operation()
    assert captured.value.code == "DEVICE_NOT_CONFIGURED"


def test_unconfigured_hardware_reports_explicit_not_configured_errors():
    manager = DeviceManager()
    assert_not_configured(manager.read_identity)
    assert_not_configured(manager.start_record)
    assert_not_configured(lambda: manager.capture_signature(b"mock"))
