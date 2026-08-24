from abc import ABC, abstractmethod


class IDCardReader(ABC):
    """Common interface for ID card readers."""

    @abstractmethod
    def read(self):
        pass
