from fastapi.testclient import TestClient

from app.hardware_gateway.linux import LinuxHardwareGateway
from app.main import create_app
from hardware.factory import create_device_manager


def test_linux_hardware_gateway_normalizes_mock_identity_for_core_service():
    manager = create_device_manager("mock")
    manager.open_all()
    gateway = LinuxHardwareGateway(manager)

    status = gateway.status()
    assert status["backend"] == "ready"
    assert status["simulator"] is True
    assert status["devices"]["identity"]["available"] is True

    identity = gateway.read_identity()
    assert identity["source"] == "mock"
    assert identity["name"] == "测试用户"
    assert identity["id_number"]
    assert "birth_date" in identity


def test_create_app_uses_linux_device_manager_when_no_gateway_is_injected(monkeypatch, tmp_path):
    monkeypatch.setenv("HARDWARE_MODE", "mock")
    app = create_app(database_url=f"sqlite:///{tmp_path / 'integration.db'}")

    assert app.state.hardware_manager.mode == "mock"
    assert isinstance(app.state.hardware_gateway, LinuxHardwareGateway)
    assert app.state.hardware_gateway.status()["devices"]["camera"]["status"] == "closed"

    with TestClient(app):
        status = app.state.hardware_gateway.status()
        assert status["devices"]["camera"]["available"] is True
        assert status["devices"]["identity"]["available"] is True

    assert app.state.hardware_gateway.status()["devices"]["camera"]["status"] == "closed"
