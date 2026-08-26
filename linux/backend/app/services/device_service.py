class DeviceService:
    def __init__(self, hardware_gateway):
        self.hardware = hardware_gateway

    def status(self) -> dict:
        return self.hardware.status()

    def action(self, device_type: str) -> dict:
        return self.hardware.action(device_type)
