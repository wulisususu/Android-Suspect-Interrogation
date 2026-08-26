from hardware.device_manager import DeviceManager


def test_unconfigured_hardware_returns_unavailable_instead_of_crashing():
    manager = DeviceManager()
    assert manager.read_identity()["status"] == "unavailable"
    assert manager.start_record()["status"] == "unavailable"
    assert manager.capture_signature(b"mock")["status"] == "unavailable"
