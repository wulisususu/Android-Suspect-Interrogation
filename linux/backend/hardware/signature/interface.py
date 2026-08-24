from abc import ABC, abstractmethod


class SignatureDevice(ABC):
    """Electronic signature abstraction."""

    @abstractmethod
    def submit(self, data):
        pass
