import os

from app.domain.errors import DomainError


class MockHardwareGateway:
    def __init__(self, simulated: bool | None = None):
        self.simulated = (os.getenv("DEVICE_SIMULATOR", "0") == "1") if simulated is None else bool(simulated)

    def status(self) -> dict:
        status = "simulated" if self.simulated else "not_connected"
        return {
            "backend": "ready",
            "simulator": self.simulated,
            "devices": {
                "identity": {"available": self.simulated, "status": status},
                "fingerprint": {"available": self.simulated, "status": status},
                "signature": {"available": self.simulated, "status": status},
                "face": {"available": False, "status": "not_connected"},
                "scanner": {"available": False, "status": "not_connected"},
            },
        }

    def _require(self, device_type: str) -> None:
        if device_type not in self.status()["devices"]:
            raise DomainError("UNKNOWN_DEVICE", "未知设备类型", 400)
        if not self.status()["devices"][device_type]["available"]:
            raise DomainError("DEVICE_NOT_CONNECTED", f"{device_type} 设备未连接", 409)

    def read_identity(self) -> dict:
        self._require("identity")
        return {
            "name": "联调测试对象", "id_number": "MOCK-ID-0001", "gender": "",
            "nation": "", "birth_date": "", "address": "", "source": "mock_idcard",
        }

    def action(self, device_type: str) -> dict:
        if device_type == "identity":
            data = self.read_identity()
            return {"success": True, "simulated": True, "message": "身份证阅读器模拟联调完成（非真实硬件数据）", **data,
                    "idNumber": data["id_number"]}
        self._require(device_type)
        return {"success": True, "simulated": True, "message": f"{device_type} 模拟联调完成（非真实硬件数据）"}
