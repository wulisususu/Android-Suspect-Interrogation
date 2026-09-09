"""Business orchestration: wire MOSS transcription into interrogation records.

Task 16 (2026-09-09, user-approved). The coordinator is the only writer of the
``moss_*`` tables and the only business caller of
:class:`~app.services.moss_transcription.MossTranscriptionService`:

- ``submit`` validates case + audio, records the immutable SHA-256 and hands
  the file to the worker as an async job (never blocking recording or the
  realtime ASR path).
- A background poll task owned by the app lifespan polls active jobs, writes
  state/window snapshots back, appends append-only transcript revisions — an
  incremental partial revision whenever the worker has published more segments
  for its DONE windows (user requirement ⑤: 完成一个窗口就可以追加显示结果),
  plus the authoritative final revision on ``COMPLETED`` (with provenance and
  the current mapping snapshot) — and settles
  ``FAILED``/``CANCELLED``/``RECOVERY_REQUIRED`` rows.
- ``resubmit`` is the explicit V1 recovery path: it is rejected while the last
  submission is active and enforces the identical ``audio_sha256`` (409 on
  mismatch) so evidence chains cannot be mixed. The worker never auto-resumes;
  ``RECOVERY_REQUIRED`` rows are reported verbatim.
- ``GSxx`` labels stay anonymous; the case-level mapping is display-only.

With ``MOSS_ENABLED=0`` every entry point answers ``503 MOSS_DISABLED`` before
touching the socket or the database.
"""
from __future__ import annotations

import asyncio
import hashlib
import json
import logging
import re
import threading
from pathlib import Path
from typing import Any

from app.ai.errors import AIError
from app.ai.settings import AISettings
from app.domain.errors import DomainError
from app.repositories import cases as case_repo
from app.repositories import moss_transcriptions as moss_repo

logger = logging.getLogger(__name__)

# States that still track a live worker job; everything else is settled and no
# longer polled (RECOVERY_REQUIRED cannot progress without a human decision).
ACTIVE_POLL_STATES = (
    "QUEUED", "PREPARING", "ENCODING", "BUILDING_EMBEDS", "DECODING",
    "PARSING", "REMAPPING", "MERGING",
)
SETTLED_STATES = ("COMPLETED", "FAILED", "CANCELLED", "RECOVERY_REQUIRED")

_GLOBAL_SPEAKER = re.compile(r"^GS\d{2,}$")

_HASH_BLOCK = 1024 * 1024


def _segment_payload(segment: Any) -> dict:
    alternate = getattr(segment, "alternate", None)
    return {
        "segmentId": segment.segment_id,
        "windowId": segment.window_id,
        "startMs": segment.start_ms,
        "endMs": segment.end_ms,
        "localSpeaker": segment.local_speaker,
        # The worker's anonymous global label is kept verbatim (never a name).
        "gs": segment.global_speaker,
        "text": segment.text,
        "speakerMappingConfidence": segment.speaker_mapping_confidence,
        "parseStatus": segment.parse_status,
        "mergeStatus": segment.merge_status,
        "alternate": _segment_payload(alternate) if alternate is not None else None,
        "modelManifestSha256": segment.model_manifest_sha256,
    }


def _windows_payload(windows) -> list[dict]:
    payload = []
    for window in windows or ():
        payload.append({
            "windowId": window.window_id,
            "startMs": window.start_ms,
            "endMs": window.end_ms,
            "state": window.state,
            "segmentCount": int(window.segment_count or 0),
        })
    return payload


def _provenance_payload(windows, *, partial: bool) -> list[dict]:
    """Per-window provenance; partial revisions mark every entry partial=True."""
    payload = []
    for window in windows or ():
        entry = {
            "windowId": window.window_id,
            "startMs": window.start_ms,
            "endMs": window.end_ms,
            "state": window.state,
            "segmentCount": int(window.segment_count or 0),
        }
        if partial:
            entry["partial"] = True
        payload.append(entry)
    return payload


def _published_segments(windows) -> list[dict]:
    """Flatten the segments the worker already published for its DONE windows.

    Windows arrive ordered by the worker (start_ms, window_id) and each window's
    segments in generation order, so the concatenation is deterministic. The
    cross-window duplicates the final merge deduplicates may appear here; the
    COMPLETED revision remains the authoritative display set.
    """
    payload: list[dict] = []
    for window in windows or ():
        if str(window.state) != "DONE":
            continue
        for segment in window.segments or ():
            payload.append(_segment_payload(segment))
    return payload


class MossTranscriptionCoordinator:
    def __init__(self, *, session_factory, transcription_service, enabled: bool, poll_interval: float = 2.0):
        self.session_factory = session_factory
        self.transcription_service = transcription_service
        self.enabled = bool(enabled)
        self.poll_interval = max(0.05, float(poll_interval))
        self._loop: asyncio.AbstractEventLoop | None = None
        self._stop: asyncio.Event | None = None
        self._task: asyncio.Task | None = None
        self._lifecycle_lock = threading.Lock()

    @classmethod
    def from_settings(cls, settings: AISettings, session_factory) -> "MossTranscriptionCoordinator":
        """Build from AISettings; the default MOSS_ENABLED=0 keeps it disabled."""
        service = None
        if settings.moss_enabled:
            from app.services.moss_transcription import MossTranscriptionService

            service = MossTranscriptionService.from_settings(settings)
        return cls(
            session_factory=session_factory,
            transcription_service=service,
            enabled=settings.moss_enabled,
        )

    # ------------------------------------------------------------------
    # Lifecycle (app lifespan owns start/shutdown, like QARoutingCoordinator)
    # ------------------------------------------------------------------

    @property
    def running(self) -> bool:
        task = self._task
        return bool(task is not None and not task.done())

    def start(self) -> None:
        with self._lifecycle_lock:
            if not self.enabled or self.running:
                return
            loop = asyncio.get_running_loop()
            self._loop = loop
            self._stop = asyncio.Event()
            self._task = loop.create_task(self._poll_loop(), name="moss-transcription-poller")

    async def _poll_loop(self) -> None:
        stop = self._stop
        assert stop is not None
        while not stop.is_set():
            try:
                await asyncio.to_thread(self.poll_once)
            except asyncio.CancelledError:
                raise
            except Exception:
                logger.exception("moss transcription poll iteration failed")
            try:
                await asyncio.wait_for(stop.wait(), timeout=self.poll_interval)
            except asyncio.TimeoutError:
                pass

    def shutdown(self) -> None:
        with self._lifecycle_lock:
            task, loop, stop = self._task, self._loop, self._stop
            self._task = None
        if task is None:
            return
        try:
            if loop is not None and loop.is_running():
                if loop is asyncio.get_running_loop():
                    stop.set()
                else:
                    loop.call_soon_threadsafe(stop.set)
                task.cancel()
            else:
                task.cancel()
        except RuntimeError:
            pass

    # ------------------------------------------------------------------
    # Sync core (also exercised directly by tests via to_thread in the loop)
    # ------------------------------------------------------------------

    def _require_enabled(self) -> None:
        if not self.enabled:
            raise DomainError(
                "MOSS_DISABLED",
                "MOSS 长音频转写未启用 (MOSS_ENABLED=0)",
                503,
            )

    def _sha256_file(self, path: Path) -> str:
        digest = hashlib.sha256()
        with path.open("rb") as stream:
            for block in iter(lambda: stream.read(_HASH_BLOCK), b""):
                digest.update(block)
        return digest.hexdigest()

    def _resolve_audio(self, audio_path: str, expected_sha256: str | None = None) -> tuple[Path, str]:
        raw = str(audio_path or "").strip()
        path = Path(raw).expanduser() if raw else None
        if path is None or not path.is_file():
            raise DomainError(
                "MOSS_AUDIO_UNAVAILABLE",
                "审讯录音文件不存在或不可读",
                404,
                {"audioPath": raw},
            )
        resolved = path.resolve()
        sha = self._sha256_file(resolved)
        if expected_sha256 is not None and str(expected_sha256).strip().lower() != sha:
            raise DomainError(
                "MOSS_AUDIO_HASH_MISMATCH",
                "音频哈希与既有提交不一致，拒绝混用证据链（重提必须基于同一个不可变 WAV）",
                409,
                {"audioPath": str(resolved), "expectedSha256": expected_sha256, "actualSha256": sha},
            )
        return resolved, sha

    def submit(self, case_id: str, audio_path: str, audio_sha256: str | None = None) -> dict:
        self._require_enabled()
        with self.session_factory() as db:
            case_repo.get(db, case_id)
        path, sha = self._resolve_audio(audio_path, audio_sha256)
        snapshot = self.transcription_service.submit_job(str(path), sha)
        return self._create_row(case_id, path, sha, snapshot)

    def resubmit(self, case_id: str, audio_path: str) -> dict:
        """Explicit recovery: new job on the *same* immutable audio only."""
        self._require_enabled()
        with self.session_factory() as db:
            case_repo.get(db, case_id)
            latest = moss_repo.get_latest(db, case_id)
            if latest is None:
                raise DomainError(
                    "MOSS_TRANSCRIPTION_NOT_FOUND", "该案件还没有 MOSS 转写提交", 404
                )
            if str(latest.state) not in SETTLED_STATES:
                raise DomainError(
                    "MOSS_JOB_ALREADY_ACTIVE",
                    "上一次 MOSS 任务仍在处理中，不能重复提交",
                    409,
                    {"state": latest.state, "jobId": latest.job_id},
                )
            expected_sha = latest.audio_sha256
        path, sha = self._resolve_audio(audio_path, expected_sha)
        snapshot = self.transcription_service.submit_job(str(path), sha)
        return self._create_row(case_id, path, sha, snapshot)

    def _create_row(self, case_id: str, path: Path, sha: str, snapshot) -> dict:
        with self.session_factory() as db:
            row = moss_repo.create_transcription(
                db,
                case_id=case_id,
                audio_path=str(path),
                audio_sha256=sha,
                job_id=snapshot.job_id,
                model_manifest_sha256=snapshot.model_manifest_sha256 or None,
                state=str(snapshot.state),
                windows=_windows_payload(snapshot.windows),
            )
            db.commit()
            return self._status_payload(row, db)

    def status(self, case_id: str) -> dict:
        self._require_enabled()
        with self.session_factory() as db:
            case_repo.get(db, case_id)
            row = moss_repo.get_latest(db, case_id)
            if row is None:
                raise DomainError(
                    "MOSS_TRANSCRIPTION_NOT_FOUND", "该案件还没有 MOSS 转写提交", 404
                )
            return self._status_payload(row, db)

    def _status_payload(self, row, db) -> dict:
        revision = moss_repo.latest_revision(db, row.id)
        return {
            "caseId": row.case_id,
            "transcriptionId": row.id,
            "jobId": row.job_id,
            "state": row.state,
            "error": row.error,
            "audioPath": row.audio_path,
            "audioSha256": row.audio_sha256,
            "modelManifestSha256": row.model_manifest_sha256,
            "windows": json.loads(row.windows_json or "[]"),
            # Task 16 (additive): monotonically increasing transcript revision
            # number; None until the first revision exists. A larger value than
            # the previously observed one means fresh text is available from
            # GET .../moss-transcription/transcript.
            "revisionNo": None if revision is None else int(revision.revision_no),
            "createdAt": row.created_at.isoformat() if row.created_at is not None else None,
            "updatedAt": row.updated_at.isoformat() if row.updated_at is not None else None,
        }

    # ------------------------------------------------------------------
    # Polling
    # ------------------------------------------------------------------

    def poll_once(self) -> int:
        """Poll every active job once; returns the number of rows updated.

        Worker transport failures leave the persisted row untouched and are
        retried on the next tick; a poll failure never writes business data.
        """
        if self.transcription_service is None:
            return 0
        with self.session_factory() as db:
            targets = [(row.id, row.job_id) for row in moss_repo.list_by_states(db, ACTIVE_POLL_STATES)]
        updated = 0
        for transcription_id, job_id in targets:
            try:
                if self._poll_row(transcription_id, str(job_id)):
                    updated += 1
            except AIError as exc:
                logger.warning(
                    "moss poll skipped transcription %s (job %s): %s", transcription_id, job_id, exc
                )
            except Exception:
                logger.exception("moss poll failed for transcription %s", transcription_id)
        return updated

    def _poll_row(self, transcription_id: str, job_id: str) -> bool:
        snapshot = self.transcription_service.get_job(job_id)
        state = str(snapshot.state)
        result = None
        if state == "COMPLETED":
            # Raises (typed AIError) on worker/storage inconsistency; the row
            # stays untouched and is retried on the next tick.
            result = self.transcription_service.get_result(job_id)
        # Task 16 incremental display (⑤: 完成一个窗口就可以追加显示结果):
        # while the job can still progress, collect what the worker already
        # published for its DONE windows so the poller can append a partial
        # revision when the published set grows.
        partial_segments = _published_segments(snapshot.windows) if state in ACTIVE_POLL_STATES else []
        with self.session_factory() as db:
            row = db.get(moss_repo.MossTranscription, transcription_id)
            if row is None or row.state in SETTLED_STATES:
                return False
            moss_repo.set_state(
                db,
                row,
                state,
                error=snapshot.error,
                windows=_windows_payload(snapshot.windows),
            )
            if result is not None:
                mapping = {
                    item.global_speaker: item.role
                    for item in moss_repo.list_mappings(db, row.case_id)
                }
                moss_repo.append_revision(
                    db,
                    transcription=row,
                    job_id=job_id,
                    audio_sha256=result.audio_sha256,
                    model_manifest_sha256=result.model_manifest_sha256,
                    segments=[_segment_payload(segment) for segment in result.segments],
                    provenance=_provenance_payload(snapshot.windows, partial=False),
                    mapping_snapshot=mapping,
                )
            else:
                self._append_partial_revision_if_grown(db, row, job_id, snapshot, partial_segments)
            db.commit()
            return True

    def _append_partial_revision_if_grown(self, db, row, job_id, snapshot, partial_segments: list[dict]) -> None:
        """Append an incremental transcript revision when more text arrived.

        Trigger: the total number of published DONE-window segments exceeds the
        segment count of the latest persisted revision. Append-only: a new
        ``revision_no`` (max+1) row is written; existing revisions are never
        rewritten. The final COMPLETED revision is still appended afterwards —
        even with an unchanged segment count — so the authoritative merged
        segment set and non-partial provenance carry the terminal semantics.
        """
        if not partial_segments:
            return
        latest = moss_repo.latest_revision(db, row.id)
        known = 0
        if latest is not None:
            known = len(json.loads(latest.segments_json or "[]"))
        if len(partial_segments) <= known:
            return
        mapping = {
            item.global_speaker: item.role
            for item in moss_repo.list_mappings(db, row.case_id)
        }
        moss_repo.append_revision(
            db,
            transcription=row,
            job_id=job_id,
            audio_sha256=str(snapshot.audio_sha256 or row.audio_sha256),
            model_manifest_sha256=str(snapshot.model_manifest_sha256 or row.model_manifest_sha256 or ""),
            segments=partial_segments,
            provenance=_provenance_payload(snapshot.windows, partial=True),
            mapping_snapshot=mapping,
        )

    # ------------------------------------------------------------------
    # Speaker mapping (display-only; GSxx stays anonymous)
    # ------------------------------------------------------------------

    def get_mapping(self, case_id: str) -> list[dict]:
        self._require_enabled()
        with self.session_factory() as db:
            case_repo.get(db, case_id)
            return [
                {"globalSpeaker": item.global_speaker, "role": item.role}
                for item in moss_repo.list_mappings(db, case_id)
            ]

    def put_mapping(self, case_id: str, mappings: list[dict] | None) -> list[dict]:
        self._require_enabled()
        normalized: list[tuple[str, str]] = []
        for item in mappings or []:
            gs = str(item.get("globalSpeaker") or "").strip().upper()
            role = str(item.get("role") or "").strip()
            if not _GLOBAL_SPEAKER.match(gs):
                raise DomainError(
                    "MOSS_INVALID_GLOBAL_SPEAKER",
                    "无效的匿名说话人标签（需要 GSxx 形式）",
                    400,
                    {"globalSpeaker": item.get("globalSpeaker")},
                )
            if not role or len(role) > 64:
                raise DomainError(
                    "MOSS_INVALID_ROLE",
                    "映射角色不能为空且不超过 64 个字符",
                    400,
                    {"globalSpeaker": gs},
                )
            normalized.append((gs, role))
        with self.session_factory() as db:
            case_repo.get(db, case_id)
            for gs, role in normalized:
                moss_repo.upsert_mapping(db, case_id=case_id, global_speaker=gs, role=role)
            db.commit()
        return self.get_mapping(case_id)

    # ------------------------------------------------------------------
    # Transcript (latest revision + current mapping as display role)
    # ------------------------------------------------------------------

    def transcript(self, case_id: str) -> dict:
        self._require_enabled()
        with self.session_factory() as db:
            case_repo.get(db, case_id)
            row = moss_repo.get_latest(db, case_id)
            if row is None:
                raise DomainError(
                    "MOSS_TRANSCRIPTION_NOT_FOUND", "该案件还没有 MOSS 转写提交", 404
                )
            revision = moss_repo.latest_revision(db, row.id)
            mapping = {
                item.global_speaker: item.role
                for item in moss_repo.list_mappings(db, case_id)
            }
            base = {
                "caseId": case_id,
                "transcriptionId": row.id,
                "jobId": row.job_id,
                "state": row.state,
            }
            if revision is None:
                return {**base, "revisionNo": None, "segments": []}
            segments = []
            for item in json.loads(revision.segments_json or "[]"):
                gs = item.get("gs")
                segments.append({
                    "segmentId": item.get("segmentId"),
                    "windowId": item.get("windowId"),
                    "startMs": item.get("startMs"),
                    "endMs": item.get("endMs"),
                    "localSpeaker": item.get("localSpeaker"),
                    "gs": gs,
                    "role": mapping.get(gs),
                    "text": item.get("text"),
                    "parseStatus": item.get("parseStatus"),
                    "mergeStatus": item.get("mergeStatus"),
                    "modelManifestSha256": item.get("modelManifestSha256"),
                })
            return {
                **base,
                "revisionNo": revision.revision_no,
                "audioSha256": revision.audio_sha256,
                "modelManifestSha256": revision.model_manifest_sha256,
                "segments": segments,
            }
