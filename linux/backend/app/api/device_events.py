from enum import Enum


class DeviceEvent(str, Enum):
    ID_CARD_CONNECTED = "id_card_connected"
    ID_CARD_READING = "id_card_reading"
    ID_CARD_SUCCESS = "id_card_success"
    CAMERA_READY = "camera_ready"
    AUDIO_READY = "audio_ready"
    SIGN_PAD_READY = "sign_pad_ready"


class DeviceStatus:
    def __init__(self):
        self.devices = {}

    def update(self, device: str, status: str):
        self.devices[device] = status

    def snapshot(self):
        return self.devices
