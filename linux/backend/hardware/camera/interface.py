from abc import ABC, abstractmethod


class CameraDevice(ABC):
    @abstractmethod
    def capture(self):
        pass
