from abc import ABC, abstractmethod


class AudioRecorder(ABC):
    """Linux audio abstraction interface."""

    @abstractmethod
    def start(self):
        pass

    @abstractmethod
    def stop(self):
        pass
