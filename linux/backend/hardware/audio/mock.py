from pathlib import Path
from typing import List, Optional

from hardware.audio.interface import AudioRecorder
from hardware.base import DeviceInfo, DeviceState, HardwareError, HealthReport


class MockAudioRecorder(AudioRecorder):
    def __init__(self):
        self._state = DeviceState.CLOSED
        self.running = False
        self._frames = [b"mock-pcm-frame"]

    def enumerate_devices(self) -> List[str]:
        return ["mock"]

    def open(self) -> None:
        self._state = DeviceState.READY

    def close(self) -> None:
        self.running = False
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        return HealthReport(self._state in {DeviceState.READY, DeviceState.ACTIVE}, self._state, "mock audio recorder")

    def device_info(self) -> DeviceInfo:
        return DeviceInfo("audio", "mock-audio-001", "Mock Audio Recorder", source="mock")

    def start(self, output_path: Optional[Path] = None) -> None:
        if self._state == DeviceState.CLOSED:
            self.open()
        self.running = True
        self._state = DeviceState.ACTIVE

    def read_frames(self, timeout: float = 0.5) -> bytes:
        if not self.running:
            raise HardwareError("AUDIO_NOT_RUNNING", "mock audio recorder is not running")
        return self._frames[0]

    def stop(self) -> None:
        self.running = False
        self._state = DeviceState.READY
