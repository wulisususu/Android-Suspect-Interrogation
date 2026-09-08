"""MOSS long-audio transcription service over the durable worker socket.

The service is a thin, typed bridge in front of :class:`MossWorkerClient`:

- ``submit_job`` resolves the audio path and declares the immutable source
  SHA-256 (the stored evidence hash, or a locally computed one) so the worker
  can verify the file before queueing. It rides a dedicated long-timeout
  client because the moss server accepts one connection at a time and hashes
  the whole file server-side; every other op keeps the short RPC budget.
- ``get_result`` distinguishes the three ``None`` states of the worker
  contract: a still-running job is a 409-class ``MossResultNotReadyError``; a
  ``COMPLETED`` job without a stored result is a ``MossResultMissingError``
  (worker/storage inconsistency, never an empty transcript); ``FAILED`` /
  ``CANCELLED`` terminal states pass through as ``MossJobTerminalError``
  carrying the evidence snapshot.
- The service never performs person identification: global speakers stay the
  worker's anonymous ``GSxx`` labels and are returned verbatim.
"""
from __future__ import annotations

import hashlib
import re
from pathlib import Path
from typing import Any, Callable

from app.ai.errors import AIError, ModelNotInstalledError
from app.ai.moss.client import MossWorkerClient
from app.ai.moss.types import (
    MossAudioCorruptError,
    MossJobResult,
    MossJobSnapshot,
    MossWorkerError,
)
from app.ai.registry import ModelRegistry, RegistryError
from app.ai.settings import AISettings

__all__ = [
    "MossJobTerminalError",
    "MossResultMissingError",
    "MossResultNotReadyError",
    "MossTranscriptionService",
]

_HASH_BLOCK = 1024 * 1024

# Supervisor error strings can reach the app as generic AIError when the wire
# code is missing from the client mapping (e.g. MOSS_AUDIO_EMPTY). Recover the
# exact code from the message prefix like moss_worker.main._MOSS_CODE does.
_MESSAGE_CODE = re.compile(r"^(MOSS_[A-Z0-9_]+|GENERATION_LIMIT_REACHED)(?::|$)")
# Task 12 review alignment: MOSS_AUDIO_EMPTY (emitted by the supervisor) is not
# in the client map, so the service classifies it as audio-corrupt semantics.
_AUDIO_CORRUPT_CODES = {"MOSS_AUDIO_CORRUPT", "MOSS_AUDIO_EMPTY"}


class MossResultNotReadyError(AIError):
    """409-class outcome: the job is still running; retry later, not a failure."""

    code = "MOSS_RESULT_NOT_READY"

    def __init__(self, snapshot: MossJobSnapshot):
        self.snapshot = snapshot
        super().__init__(
            f"moss job {snapshot.job_id} is not finished yet (state={snapshot.state})",
            details={
                "job_id": snapshot.job_id,
                "state": snapshot.state,
                "progress": snapshot.progress,
            },
        )


class MossResultMissingError(AIError):
    """Worker/storage inconsistency: a COMPLETED job without a stored result."""

    code = "MOSS_RESULT_MISSING"

    def __init__(self, snapshot: MossJobSnapshot):
        self.snapshot = snapshot
        super().__init__(
            f"moss job {snapshot.job_id} is COMPLETED but the worker returned no result",
            details={"job_id": snapshot.job_id, "state": snapshot.state},
        )


class MossJobTerminalError(AIError):
    """FAILED/CANCELLED terminal passthrough; ``snapshot`` carries the evidence."""

    code = "MOSS_JOB_NOT_SUCCESSFUL"

    def __init__(self, snapshot: MossJobSnapshot):
        self.snapshot = snapshot
        super().__init__(
            f"moss job {snapshot.job_id} ended without a transcript: {snapshot.state}",
            details={
                "job_id": snapshot.job_id,
                "state": snapshot.state,
                "error": snapshot.error,
                "windows": [window.__dict__ for window in snapshot.windows],
            },
        )


def _sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(_HASH_BLOCK), b""):
            digest.update(block)
    return digest.hexdigest()


def _classify_submit_error(exc: AIError) -> AIError:
    """Map unmapped worker codes onto service semantics; pass the rest through."""
    if isinstance(exc, MossWorkerError):
        return exc
    match = _MESSAGE_CODE.match(str(exc.message or ""))
    if match is None:
        return exc
    code = match.group(1)
    if code in _AUDIO_CORRUPT_CODES:
        details = dict(exc.details)
        details["moss_code"] = code
        return MossAudioCorruptError(exc.message, details=details)
    return exc


def _last_worker_error(payload: dict[str, Any]) -> str | None:
    scheduler_error = payload.get("scheduler_error")
    if scheduler_error:
        return str(scheduler_error)
    failures = payload.get("run_failures")
    if isinstance(failures, dict) and failures:
        return "; ".join(f"{job}: {message}" for job, message in sorted(failures.items()))
    return None


class MossTranscriptionService:
    """Submit durable long-audio jobs and fetch typed transcripts.

    The service never spawns a worker or constructs a supervisor; it only
    speaks the committed socket client contract.
    """

    def __init__(
        self,
        *,
        socket_path: str | Path,
        request_timeout: float = 5.0,
        submit_timeout: float = 1800.0,
        model_id: str = "moss.default",
        registry: ModelRegistry | None = None,
        client_factory: Callable[..., Any] = MossWorkerClient,
    ) -> None:
        request_timeout = max(0.05, float(request_timeout))
        submit_timeout = max(0.05, float(submit_timeout))
        if submit_timeout <= request_timeout:
            raise ValueError(
                "moss submit timeout must be an independent budget above the short RPC timeout"
            )
        self.socket_path = Path(socket_path)
        self.request_timeout = request_timeout
        self.submit_timeout = submit_timeout
        self.model_id = str(model_id or "moss.default")
        self._registry = registry
        # submit_job is server-side expensive (serial accept, whole-file
        # SHA-256, token/context budgeting): it gets its own long-timeout
        # client, while every other op shares the short RPC client.
        self._client = client_factory(self.socket_path, timeout=request_timeout)
        self._submit_client = client_factory(self.socket_path, timeout=submit_timeout)

    @classmethod
    def from_settings(cls, settings: AISettings) -> "MossTranscriptionService":
        registry: ModelRegistry | None = None
        try:
            registry = ModelRegistry.load(settings.registry_path, settings.model_root)
        except (RegistryError, OSError):
            registry = None
        return cls(
            socket_path=settings.moss_socket,
            request_timeout=settings.moss_request_timeout,
            submit_timeout=settings.moss_submit_timeout,
            model_id=settings.moss_model_id,
            registry=registry,
        )

    def submit_job(
        self, audio_path: str | Path, audio_sha256: str | None = None
    ) -> MossJobSnapshot:
        """Resolve the audio path/hash and submit via the long-timeout client."""
        path = Path(audio_path).expanduser().resolve()
        if not path.is_file():
            raise AIError("moss audio file is unavailable", details={"audio_path": str(path)})
        self._ensure_model_installed()
        if audio_sha256:
            sha = str(audio_sha256).strip().lower()
        else:
            try:
                sha = _sha256_file(path)
            except OSError as exc:
                raise AIError(
                    "moss audio hash is unavailable", details={"audio_path": str(path)}
                ) from exc
        try:
            return self._submit_client.submit_job(str(path), sha)
        except AIError as exc:
            raise _classify_submit_error(exc) from exc

    def get_job(self, job_id: str) -> MossJobSnapshot:
        return self._client.get_job(str(job_id))

    def cancel_job(self, job_id: str) -> MossJobSnapshot:
        return self._client.cancel_job(str(job_id))

    def get_result(self, job_id: str) -> MossJobResult:
        """Return the transcript only for a genuinely COMPLETED job."""
        snapshot = self._client.get_job(str(job_id))
        state = str(snapshot.state).upper()
        if state == "COMPLETED":
            result = self._client.get_result(str(job_id))
            if result is None:
                raise MossResultMissingError(snapshot)
            return result
        if state in {"FAILED", "CANCELLED"}:
            raise MossJobTerminalError(snapshot)
        raise MossResultNotReadyError(snapshot)

    def health(self) -> dict[str, Any]:
        """Aggregate worker/model state for the optional health capability.

        Never raises: a capability probe must not take readiness handling down.
        """
        snapshot: dict[str, Any] = {
            "worker": "UNAVAILABLE",
            "model": self.model_state(),
            "manifest_sha256": None,
            "runtime_versions": None,
            # The worker health op does not publish queue depth or the active
            # job id yet; report them explicitly until the contract grows them.
            "queue_depth": None,
            "active_job": None,
            "last_error": None,
        }
        try:
            payload = self._client.health()
        except Exception as exc:  # health probing is best-effort by contract
            snapshot["last_error"] = str(exc) or exc.__class__.__name__
            return snapshot
        snapshot["worker"] = "AVAILABLE"
        snapshot["manifest_sha256"] = payload.get("manifest_sha256")
        snapshot["runtime_versions"] = payload.get("runtime_versions")
        snapshot["last_error"] = _last_worker_error(payload)
        return snapshot

    def model_state(self) -> str:
        if self._registry is None:
            return "UNKNOWN"
        try:
            status = self._registry.installation_status(self.model_id)
        except RegistryError:
            return "UNKNOWN"
        return "INSTALLED" if status.installed else "NOT_INSTALLED"

    def _ensure_model_installed(self) -> None:
        if self.model_state() != "NOT_INSTALLED":
            return
        assert self._registry is not None  # model_state NOT_INSTALLED implies a registry
        status = self._registry.installation_status(self.model_id)
        raise ModelNotInstalledError(
            f"moss model bundle is not installed: {self.model_id}",
            details={
                "model_id": self.model_id,
                "model_dir": str(status.model_dir),
                "missing_files": [str(item) for item in status.missing_files],
            },
        )
