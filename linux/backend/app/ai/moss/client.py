from __future__ import annotations

import socket
import uuid
from pathlib import Path
from typing import Any

from ..errors import (
    AIError,
    BackendUnavailableError,
    ModelNotInstalledError,
    ResourceBusyError,
    WorkerCancelledError,
    WorkerCrashedError,
    WorkerTimeoutError,
)
from moss_worker.protocol import MAX_MESSAGE_BYTES, ProtocolError, recv_frame, send_frame
from .types import (
    MossAudioChangedError,
    MossAudioCorruptError,
    MossAudioUnsupportedError,
    MossCancelledError,
    MossContextError,
    MossGenerationLimitError,
    MossInvalidGenerationError,
    MossJobNotFoundError,
    MossJobResult,
    MossJobSnapshot,
    MossModelError,
    MossOomError,
    MossRevisionChangedError,
    MossRkllmError,
    MossRknnError,
)


_ERROR_TYPES: dict[str, type[AIError]] = {
    AIError.code: AIError,
    ModelNotInstalledError.code: ModelNotInstalledError,
    BackendUnavailableError.code: BackendUnavailableError,
    WorkerTimeoutError.code: WorkerTimeoutError,
    WorkerCancelledError.code: WorkerCancelledError,
    WorkerCrashedError.code: WorkerCrashedError,
    ResourceBusyError.code: ResourceBusyError,
    MossModelError.code: MossModelError,
    MossRknnError.code: MossRknnError,
    MossRkllmError.code: MossRkllmError,
    MossContextError.code: MossContextError,
    "MOSS_CONTEXT_BUDGET_EXCEEDED": MossContextError,
    "MOSS_CONTEXT_OVERFLOW": MossContextError,
    MossOomError.code: MossOomError,
    "MOSS_OUT_OF_MEMORY": MossOomError,
    MossInvalidGenerationError.code: MossInvalidGenerationError,
    MossAudioCorruptError.code: MossAudioCorruptError,
    MossAudioUnsupportedError.code: MossAudioUnsupportedError,
    MossAudioChangedError.code: MossAudioChangedError,
    MossCancelledError.code: MossCancelledError,
    MossRevisionChangedError.code: MossRevisionChangedError,
    MossJobNotFoundError.code: MossJobNotFoundError,
    MossGenerationLimitError.code: MossGenerationLimitError,
}


class MossWorkerClient:
    def __init__(
        self,
        socket_path: str | Path,
        *,
        timeout: float = 5.0,
        max_message_bytes: int = MAX_MESSAGE_BYTES,
    ) -> None:
        self.socket_path = Path(socket_path)
        self.timeout = max(0.001, float(timeout))
        self.max_message_bytes = int(max_message_bytes)

    def health(self) -> dict[str, object]:
        return self._require_dict(self._request("health"))

    def submit_job(self, audio_path: str, audio_sha256: str | None = None) -> MossJobSnapshot:
        payload: dict[str, Any] = {"audio_path": str(audio_path)}
        if audio_sha256:
            payload["audio_sha256"] = str(audio_sha256)
        return self._snapshot(self._request("submit_job", **payload))

    def get_job(self, job_id: str) -> MossJobSnapshot:
        return self._snapshot(self._request("get_job", job_id=str(job_id)))

    def get_result(self, job_id: str) -> MossJobResult | None:
        result = self._require_dict(self._request("get_result", job_id=str(job_id)))
        payload = result.get("result")
        if payload is None:
            return None
        return self._job_result(payload)

    def cancel_job(self, job_id: str) -> MossJobSnapshot:
        return self._snapshot(self._request("cancel_job", job_id=str(job_id)))

    def _request(self, op: str, **payload: Any) -> Any:
        request_id = uuid.uuid4().hex
        request = {"request_id": request_id, "op": op, **payload}
        try:
            with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
                sock.settimeout(self.timeout)
                sock.connect(str(self.socket_path))
                send_frame(sock, request, max_message_bytes=self.max_message_bytes)
                response = recv_frame(sock, max_message_bytes=self.max_message_bytes)
        except socket.timeout as exc:
            raise WorkerTimeoutError(
                f"moss worker timed out during {op}",
                details={"op": op, "socket": str(self.socket_path)},
            ) from exc
        except ProtocolError as exc:
            raise WorkerCrashedError(
                f"moss worker returned an invalid protocol response during {op}",
                details={"op": op, "socket": str(self.socket_path)},
            ) from exc
        except OSError as exc:
            raise BackendUnavailableError(
                f"moss worker socket is unavailable during {op}",
                details={"op": op, "socket": str(self.socket_path)},
            ) from exc

        return self._validated_result(request_id, response, op=op)

    def _validated_result(self, request_id: str, response: dict[str, Any], *, op: str) -> Any:
        if response.get("request_id") != request_id:
            raise WorkerCrashedError(
                "moss worker response request_id mismatch",
                details={"op": op, "socket": str(self.socket_path)},
            )
        if not isinstance(response.get("ok"), bool):
            raise WorkerCrashedError(
                "moss worker response is missing boolean ok",
                details={"op": op, "socket": str(self.socket_path)},
            )
        if response["ok"]:
            return response.get("result")
        self._raise_worker_error(response, op=op)
        raise AssertionError("unreachable")

    def _raise_worker_error(self, response: dict[str, Any], *, op: str) -> None:
        error = response.get("error")
        if not isinstance(error, dict):
            raise WorkerCrashedError(
                "moss worker error response is malformed",
                details={"op": op, "socket": str(self.socket_path)},
            )
        code = str(error.get("code") or AIError.code)
        message = str(error.get("message") or "moss worker request failed")
        details = error.get("details")
        if not isinstance(details, dict):
            details = {}
        error_type = _ERROR_TYPES.get(code, AIError)
        raise error_type(message, details=details)

    def _snapshot(self, result: Any) -> MossJobSnapshot:
        if not isinstance(result, dict):
            raise WorkerCrashedError("moss worker job result must be a JSON object")
        try:
            return MossJobSnapshot.from_dict(result)
        except (KeyError, TypeError, ValueError) as exc:
            raise WorkerCrashedError("moss worker returned a malformed job snapshot") from exc

    def _job_result(self, result: Any) -> MossJobResult:
        if not isinstance(result, dict):
            raise WorkerCrashedError("moss worker job result must be a JSON object")
        try:
            return MossJobResult.from_dict(result)
        except (KeyError, TypeError, ValueError) as exc:
            raise WorkerCrashedError("moss worker returned a malformed job result") from exc

    @staticmethod
    def _require_dict(result: Any) -> dict[str, Any]:
        if not isinstance(result, dict):
            raise WorkerCrashedError("moss worker result must be a JSON object")
        return result
