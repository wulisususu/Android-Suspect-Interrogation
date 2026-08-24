from typing import Optional


class DeviceManager:
    """Unified hardware access layer.

    Business modules should call this manager instead of talking directly
    with USB drivers, SDK libraries or Linux device nodes.
    """

    def __init__(self):
        self.idcard_reader = None
        self.audio_recorder = None
        self.signature_device = None

    def read_identity(self):
        if self.idcard_reader is None:
            return {"status": "unavailable", "message": "idcard reader not configured"}
        return self.idcard_reader.read()

    def start_record(self):
        if self.audio_recorder is None:
            return {"status": "unavailable", "message": "audio recorder not configured"}
        return self.audio_recorder.start()

    def capture_signature(self, data):
        if self.signature_device is None:
            return {"status": "unavailable", "message": "signature device not configured"}
        return self.signature_device.save(data)
