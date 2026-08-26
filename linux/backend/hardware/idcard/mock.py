from hardware.base import DeviceInfo, DeviceState, HealthReport
from hardware.idcard.interface import IdentityReader
from hardware.idcard.models import IdentityResult


class MockIDCardReader(IdentityReader):
    def __init__(self, device_id: str = "mock-idcard-001"):
        self._device_id = device_id
        self._state = DeviceState.CLOSED

    def open(self) -> None:
        self._state = DeviceState.READY

    def close(self) -> None:
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        return HealthReport(self._state in {DeviceState.READY, DeviceState.ACTIVE}, self._state, "mock identity reader")

    def device_info(self) -> DeviceInfo:
        return DeviceInfo("identity", self._device_id, "Mock Identity Reader", source="mock")

    def read(self) -> IdentityResult:
        if self._state == DeviceState.CLOSED:
            self.open()
        return IdentityResult.create(
            name="测试用户",
            gender="未知",
            nation="测试",
            birth="2000-01-01",
            id_number="000000000000000000",
            address="Mock Address",
            issuer="Mock Issuer",
            valid_from="2020-01-01",
            valid_to="2030-01-01",
            portrait=None,
            source="mock",
            device_id=self._device_id,
        )
