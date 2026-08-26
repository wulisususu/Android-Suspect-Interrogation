class AIError(RuntimeError):
    code = "AI_ERROR"

    def __init__(self, message: str, *, details: dict | None = None):
        super().__init__(message)
        self.message = message
        self.details = details or {}


class ModelNotInstalledError(AIError):
    code = "MODEL_NOT_INSTALLED"


class BackendUnavailableError(AIError):
    code = "BACKEND_UNAVAILABLE"


class WorkerTimeoutError(AIError):
    code = "WORKER_TIMEOUT"


class WorkerCancelledError(AIError):
    code = "WORKER_CANCELLED"


class WorkerCrashedError(AIError):
    code = "WORKER_CRASHED"


class ResourceBusyError(AIError):
    code = "RESOURCE_BUSY"
