"""Task 16: MossTranscriptionCoordinator submit/poll/resubmit/mapping.

The coordinator is the only writer of the ``moss_*`` business tables and the
only caller of ``MossTranscriptionService`` on the business path. Tests drive
the synchronous core with a fake service (no socket), mirroring the layered
fakes of ``tests/test_moss_service.py``.
"""
from __future__ import annotations

import hashlib
import json
from dataclasses import replace
from pathlib import Path

import pytest
from sqlalchemy import select

from app.ai.errors import BackendUnavailableError
from app.ai.moss.types import MossJobResult, MossJobSnapshot, MossTranscriptSegment, MossWindowStatus
from app.database.models import Message
from app.database.session import init_database, make_engine, make_session_factory
from app.domain.errors import DomainError
from app.repositories import cases as case_repo
from app.repositories import messages as message_repo
from app.repositories import moss_transcriptions as moss_repo
from app.services.moss_transcription_coordinator import MossTranscriptionCoordinator


def _snapshot(job_id: str, state: str, *, error: str | None = None, windows=(), audio_sha256: str = "a" * 64) -> MossJobSnapshot:
    return MossJobSnapshot(
        job_id=job_id, state=state, audio_sha256=audio_sha256,
        model_manifest_sha256="manifest", progress=0.0, error=error, windows=windows,
    )


def _window(window_id: str, state: str, segment_count: int, *, start_ms: int = 0, end_ms: int = 60_000) -> MossWindowStatus:
    return MossWindowStatus(
        window_id=window_id, start_ms=start_ms, end_ms=end_ms, window_minutes=10,
        state=state, parse_status=None, error=None, token_count=None,
        normal_termination=None, segment_count=segment_count,
    )


def _window_with_segments(window_id: str, *segments: MossTranscriptSegment, start_ms: int = 0, end_ms: int = 60_000) -> MossWindowStatus:
    """DONE window carrying the worker-published segments (Task 16 additive)."""
    return MossWindowStatus(
        window_id=window_id, start_ms=start_ms, end_ms=end_ms, window_minutes=10,
        state="DONE", parse_status="VALID", error=None, token_count=None,
        normal_termination=True, segment_count=len(segments), segments=tuple(segments),
    )


def _segment(**overrides) -> MossTranscriptSegment:
    payload = dict(
        segment_id="s1", window_id="w0001", start_ms=0, end_ms=12_000,
        local_speaker="S01", global_speaker="GS01", text="你好",
        speaker_mapping_confidence=0.91, parse_status="VALID",
        merge_status="PRIMARY", alternate=None, model_manifest_sha256="manifest",
    )
    payload.update(overrides)
    return MossTranscriptSegment.from_dict(payload)


def _result(job_id: str, segments) -> MossJobResult:
    return MossJobResult(
        job_id=job_id, audio_sha256="a" * 64, model_manifest_sha256="manifest",
        segments=tuple(segments),
    )


class FakeTranscriptionService:
    """Stands in for MossTranscriptionService; records every op.

    Faithful to the worker contract: snapshots/results echo the actually
    submitted file SHA-256 (the real spool hashes the source at creation).
    """

    def __init__(self):
        self.submit_calls: list[tuple[str, str]] = []
        self.job_calls: list[str] = []
        self.result_calls: list[str] = []
        self.snapshots: dict[str, MossJobSnapshot] = {}
        self.results: dict[str, MossJobResult] = {}
        self.errors: dict[str, Exception] = {}
        self.last_sha: str | None = None

    def _maybe_fail(self, op: str) -> None:
        exc = self.errors.get(op)
        if exc is not None:
            raise exc

    def submit_job(self, audio_path, audio_sha256=None):
        self._maybe_fail("submit_job")
        self.submit_calls.append((str(audio_path), str(audio_sha256)))
        self.last_sha = str(audio_sha256)
        job_id = f"job-{len(self.submit_calls)}"
        self.snapshots[job_id] = _snapshot(job_id, "QUEUED", audio_sha256=self.last_sha)
        return self.snapshots[job_id]

    def get_job(self, job_id):
        self._maybe_fail("get_job")
        self.job_calls.append(str(job_id))
        return self.snapshots[str(job_id)]

    def get_result(self, job_id):
        self._maybe_fail("get_result")
        self.result_calls.append(str(job_id))
        result = self.results[str(job_id)]
        return replace(result, audio_sha256=self.last_sha or result.audio_sha256)


def _factory(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'coordinator.db'}")
    init_database(engine)
    return engine, make_session_factory(engine)


def _seed_case(factory) -> None:
    with factory() as db:
        case_repo.create(db, {"id": "CASE-MOSS", "suspectName": "张某", "officerName": "李警官"})
        db.commit()


def _coordinator(factory, fake: FakeTranscriptionService, *, enabled: bool = True) -> MossTranscriptionCoordinator:
    return MossTranscriptionCoordinator(
        session_factory=factory,
        transcription_service=fake,
        enabled=enabled,
        poll_interval=0.01,
    )


def _audio(tmp_path: Path, content: bytes = b"RIFF-fake-wav-audio") -> Path:
    path = tmp_path / "recording.wav"
    path.write_bytes(content)
    return path


# --------------------------------------------------------------------------
# submit
# --------------------------------------------------------------------------


def test_submit_validates_case_and_audio_persists_row_and_calls_worker(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    wav = _audio(tmp_path)
    sha = hashlib.sha256(wav.read_bytes()).hexdigest()

    status = coordinator.submit("CASE-MOSS", str(wav))

    assert fake.submit_calls == [(str(wav.resolve()), sha)]
    assert status["caseId"] == "CASE-MOSS"
    assert status["jobId"] == "job-1"
    assert status["state"] == "QUEUED"
    assert status["audioSha256"] == sha
    assert status["windows"] == []
    with factory() as db:
        rows = list(db.scalars(select(moss_repo.MossTranscription)))
        assert len(rows) == 1 and rows[0].job_id == "job-1" and rows[0].state == "QUEUED"
    engine.dispose()


def test_submit_unknown_case_is_case_not_found(tmp_path):
    engine, factory = _factory(tmp_path)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    with pytest.raises(DomainError) as exc_info:
        coordinator.submit("CASE-MISSING", str(_audio(tmp_path)))
    assert exc_info.value.code == "CASE_NOT_FOUND"
    assert exc_info.value.status_code == 404
    assert fake.submit_calls == []
    engine.dispose()


def test_submit_missing_audio_is_unavailable_without_worker_call(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    with pytest.raises(DomainError) as exc_info:
        coordinator.submit("CASE-MOSS", str(tmp_path / "missing.wav"))
    assert exc_info.value.code == "MOSS_AUDIO_UNAVAILABLE"
    assert exc_info.value.status_code == 404
    assert fake.submit_calls == []
    engine.dispose()


def test_submit_disabled_is_moss_disabled(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    coordinator = _coordinator(factory, FakeTranscriptionService(), enabled=False)
    with pytest.raises(DomainError) as exc_info:
        coordinator.submit("CASE-MOSS", str(_audio(tmp_path)))
    assert exc_info.value.code == "MOSS_DISABLED"
    assert exc_info.value.status_code == 503
    engine.dispose()


# --------------------------------------------------------------------------
# poll
# --------------------------------------------------------------------------


def _submitted(tmp_path, fake, coordinator):
    wav = _audio(tmp_path)
    status = coordinator.submit("CASE-MOSS", str(wav))
    return wav, status["jobId"]


def test_poll_updates_running_state_and_windows_snapshot(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots[job_id] = _snapshot(
        job_id, "DECODING", windows=(_window("w0001", "RUNNING", 0),)
    )

    polled = coordinator.poll_once()

    assert polled == 1
    status = coordinator.status("CASE-MOSS")
    assert status["state"] == "DECODING"
    # Task 16 (additive): no revision exists yet, so the status payload pins
    # revisionNo as None for frontends polling for fresh transcript text.
    assert status["revisionNo"] is None
    assert status["windows"] == [
        {"windowId": "w0001", "state": "RUNNING", "segmentCount": 0, "startMs": 0, "endMs": 60_000}
    ]
    engine.dispose()


def test_poll_in_flight_done_window_appends_partial_revision(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    coordinator.put_mapping("CASE-MOSS", [{"globalSpeaker": "GS01", "role": "民警"}])
    fake.snapshots[job_id] = _snapshot(
        job_id, "PARSING", audio_sha256=fake.last_sha,
        windows=(
            _window("w0001", "RUNNING", 0),
            _window_with_segments(
                "w0002", _segment(segment_id="w0002-s1", window_id="w0002", start_ms=60_000, end_ms=72_000),
                start_ms=60_000, end_ms=120_000,
            ),
        ),
    )

    assert coordinator.poll_once() == 1

    status = coordinator.status("CASE-MOSS")
    assert status["state"] == "PARSING"
    assert status["revisionNo"] == 1
    with factory() as db:
        row = moss_repo.get_latest(db, "CASE-MOSS")
        revisions = list(row.revisions)
        assert [r.revision_no for r in revisions] == [1]
        assert revisions[0].job_id == job_id
        assert revisions[0].audio_sha256 == row.audio_sha256
        assert revisions[0].model_manifest_sha256 == "manifest"
        segments = json.loads(revisions[0].segments_json)
        assert len(segments) == 1
        assert segments[0]["segmentId"] == "w0002-s1"
        assert segments[0]["windowId"] == "w0002"
        assert segments[0]["startMs"] == 60_000
        assert segments[0]["gs"] == "GS01"
        assert segments[0]["text"] == "你好"
        provenance = json.loads(revisions[0].provenance_json)
        assert provenance == [
            {"windowId": "w0001", "startMs": 0, "endMs": 60_000, "state": "RUNNING", "segmentCount": 0, "partial": True},
            {"windowId": "w0002", "startMs": 60_000, "endMs": 120_000, "state": "DONE", "segmentCount": 1, "partial": True},
        ]
        assert json.loads(revisions[0].mapping_snapshot_json) == {"GS01": "民警"}
    engine.dispose()


def test_poll_growing_done_windows_append_revisions_until_completed_final(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots[job_id] = _snapshot(
        job_id, "PARSING",
        windows=(
            _window("w0001", "RUNNING", 0),
            _window_with_segments(
                "w0002", _segment(segment_id="w0002-s1", window_id="w0002", start_ms=60_000, end_ms=72_000),
                start_ms=60_000, end_ms=120_000,
            ),
        ),
    )
    assert coordinator.poll_once() == 1

    # More windows complete: the published set grows 1 -> 3, so a second
    # incremental revision (revision_no=2) is appended.
    fake.snapshots[job_id] = _snapshot(
        job_id, "DECODING",
        windows=(
            _window_with_segments(
                "w0001", _segment(), _segment(segment_id="s2", text="继续说", start_ms=12_000, end_ms=30_000),
            ),
            _window_with_segments(
                "w0002", _segment(segment_id="w0002-s1", window_id="w0002", start_ms=60_000, end_ms=72_000),
                start_ms=60_000, end_ms=120_000,
            ),
        ),
    )
    assert coordinator.poll_once() == 1
    status = coordinator.status("CASE-MOSS")
    assert status["revisionNo"] == 2

    # COMPLETED: the authoritative merged result replaces the display set with
    # a final revision even though its segment count equals the last partial
    # one (append-only allows same-count rewrite semantics via a new revision;
    # the final provenance is not marked partial).
    fake.snapshots[job_id] = _snapshot(
        job_id, "COMPLETED",
        windows=(
            _window("w0001", "DONE", 2),
            _window("w0002", "DONE", 1, start_ms=60_000, end_ms=120_000),
        ),
    )
    fake.results[job_id] = _result(job_id, [
        _segment(segment_id="m1"),
        _segment(segment_id="m2", text="继续说", start_ms=12_000, end_ms=30_000),
        _segment(segment_id="m3", window_id="w0002", start_ms=60_000, end_ms=72_000),
    ])
    assert coordinator.poll_once() == 1

    status = coordinator.status("CASE-MOSS")
    assert status["state"] == "COMPLETED"
    assert status["revisionNo"] == 3
    with factory() as db:
        row = moss_repo.get_latest(db, "CASE-MOSS")
        revisions = list(row.revisions)
        assert [r.revision_no for r in revisions] == [1, 2, 3]
        assert [len(json.loads(r.segments_json)) for r in revisions] == [1, 3, 3]
        final_segments = json.loads(revisions[2].segments_json)
        assert [s["segmentId"] for s in final_segments] == ["m1", "m2", "m3"]
        final_provenance = json.loads(revisions[2].provenance_json)
        assert final_provenance == [
            {"windowId": "w0001", "startMs": 0, "endMs": 60_000, "state": "DONE", "segmentCount": 2},
            {"windowId": "w0002", "startMs": 60_000, "endMs": 120_000, "state": "DONE", "segmentCount": 1},
        ]
        partial_provenance = json.loads(revisions[1].provenance_json)
        assert all(entry["partial"] is True for entry in partial_provenance)
    transcript = coordinator.transcript("CASE-MOSS")
    assert transcript["revisionNo"] == 3
    assert [s["segmentId"] for s in transcript["segments"]] == ["m1", "m2", "m3"]
    engine.dispose()


def test_poll_skips_partial_revision_when_published_segment_count_unchanged(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    windows = (
        _window_with_segments("w0001", _segment()),
    )
    fake.snapshots[job_id] = _snapshot(job_id, "PARSING", windows=windows)
    assert coordinator.poll_once() == 1

    fake.snapshots[job_id] = _snapshot(job_id, "REMAPPING", windows=windows)
    assert coordinator.poll_once() == 1

    with factory() as db:
        row = moss_repo.get_latest(db, "CASE-MOSS")
        assert [r.revision_no for r in row.revisions] == [1]
    assert coordinator.status("CASE-MOSS")["revisionNo"] == 1
    engine.dispose()


def test_poll_terminal_failure_ignores_partial_segments_and_writes_no_revision(tmp_path):
    # DONE-window segments must only become revisions while the job can still
    # progress (or at COMPLETED); a terminal failure settles with no transcript.
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots[job_id] = _snapshot(
        job_id, "FAILED", error="MOSS_WINDOW_FAILED",
        windows=(_window_with_segments("w0001", _segment()),),
    )

    assert coordinator.poll_once() == 1

    assert coordinator.status("CASE-MOSS")["revisionNo"] is None
    with factory() as db:
        row = moss_repo.get_latest(db, "CASE-MOSS")
        assert row.state == "FAILED"
        assert row.revisions == []
    engine.dispose()


def test_poll_completed_appends_revision_with_provenance_and_mapping_snapshot(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    coordinator.put_mapping("CASE-MOSS", [{"globalSpeaker": "GS01", "role": "民警"}])
    fake.snapshots[job_id] = _snapshot(
        job_id, "COMPLETED", windows=(_window("w0001", "DONE", 1),)
    )
    fake.results[job_id] = _result(job_id, [_segment()])

    coordinator.poll_once()

    with factory() as db:
        row = moss_repo.get_latest(db, "CASE-MOSS")
        assert row.state == "COMPLETED"
        revision = row.revisions[0]
        assert revision.revision_no == 1
        assert revision.job_id == job_id
        assert revision.audio_sha256 == row.audio_sha256
        assert revision.model_manifest_sha256 == "manifest"
        segments = json.loads(revision.segments_json)
        assert segments[0]["gs"] == "GS01" and segments[0]["text"] == "你好"
        assert segments[0]["windowId"] == "w0001"
        assert segments[0]["startMs"] == 0
        provenance = json.loads(revision.provenance_json)
        assert provenance == [
            {"windowId": "w0001", "startMs": 0, "endMs": 60_000, "state": "DONE", "segmentCount": 1}
        ]
        mapping_snapshot = json.loads(revision.mapping_snapshot_json)
        assert mapping_snapshot == {"GS01": "民警"}
    engine.dispose()


def test_poll_terminal_failure_persists_error_and_writes_no_revision(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots[job_id] = _snapshot(job_id, "FAILED", error="GENERATION_LIMIT_REACHED")

    coordinator.poll_once()

    status = coordinator.status("CASE-MOSS")
    assert status["state"] == "FAILED"
    assert status["error"] == "GENERATION_LIMIT_REACHED"
    with factory() as db:
        row = moss_repo.get_latest(db, "CASE-MOSS")
        assert row.revisions == []
    engine.dispose()


def test_poll_recovery_required_is_settled_and_not_polled_again(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots[job_id] = _snapshot(
        job_id, "RECOVERY_REQUIRED", error="MOSS_RECOVERY_REQUIRED: nonterminal job found after restart"
    )

    coordinator.poll_once()
    coordinator.poll_once()

    assert fake.job_calls == [job_id]
    assert coordinator.status("CASE-MOSS")["state"] == "RECOVERY_REQUIRED"
    engine.dispose()


def test_poll_survives_unreachable_worker_and_keeps_row(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots[job_id] = _snapshot(job_id, "DECODING")
    fake.errors["get_job"] = BackendUnavailableError("moss worker socket is unavailable")

    assert coordinator.poll_once() == 0

    assert coordinator.status("CASE-MOSS")["state"] == "QUEUED"
    engine.dispose()


# --------------------------------------------------------------------------
# resubmit (same immutable audio only)
# --------------------------------------------------------------------------


def test_resubmit_after_failure_requires_identical_hash(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    wav, _job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots["job-1"] = _snapshot("job-1", "FAILED", error="MOSS_OOM")
    coordinator.poll_once()

    status = coordinator.resubmit("CASE-MOSS", str(wav))

    assert len(fake.submit_calls) == 2
    assert status["jobId"] == "job-2"
    assert status["state"] == "QUEUED"
    with factory() as db:
        rows = moss_repo.list_all(db, "CASE-MOSS")
        assert len(rows) == 2
        assert rows[0].audio_sha256 == rows[1].audio_sha256
        assert rows[0].job_id != rows[1].job_id
    engine.dispose()


def test_resubmit_rejects_hash_mismatch_with_409(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    wav, _job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots["job-1"] = _snapshot("job-1", "RECOVERY_REQUIRED")
    coordinator.poll_once()

    tampered = tmp_path / "tampered.wav"
    tampered.write_bytes(b"RIFF-different-audio")
    with pytest.raises(DomainError) as exc_info:
        coordinator.resubmit("CASE-MOSS", str(tampered))

    assert exc_info.value.code == "MOSS_AUDIO_HASH_MISMATCH"
    assert exc_info.value.status_code == 409
    assert len(fake.submit_calls) == 1
    engine.dispose()


def test_resubmit_rejects_active_job_with_409(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    wav, _job_id = _submitted(tmp_path, fake, coordinator)

    with pytest.raises(DomainError) as exc_info:
        coordinator.resubmit("CASE-MOSS", str(wav))
    assert exc_info.value.code == "MOSS_JOB_ALREADY_ACTIVE"
    assert exc_info.value.status_code == 409
    assert len(fake.submit_calls) == 1
    engine.dispose()


# --------------------------------------------------------------------------
# mapping + transcript
# --------------------------------------------------------------------------


def test_mapping_put_get_roundtrip_and_overwrite(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    coordinator = _coordinator(factory, FakeTranscriptionService())

    coordinator.put_mapping("CASE-MOSS", [
        {"globalSpeaker": "GS01", "role": "民警"},
        {"globalSpeaker": "GS02", "role": "嫌疑人"},
    ])
    coordinator.put_mapping("CASE-MOSS", [{"globalSpeaker": "GS02", "role": "证人"}])

    mappings = coordinator.get_mapping("CASE-MOSS")
    assert mappings == [
        {"globalSpeaker": "GS01", "role": "民警"},
        {"globalSpeaker": "GS02", "role": "证人"},
    ]
    engine.dispose()


def test_mapping_rejects_bad_speaker_shape_and_empty_role(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    coordinator = _coordinator(factory, FakeTranscriptionService())
    with pytest.raises(DomainError) as exc_info:
        coordinator.put_mapping("CASE-MOSS", [{"globalSpeaker": "POLICE", "role": "民警"}])
    assert exc_info.value.code == "MOSS_INVALID_GLOBAL_SPEAKER"
    assert exc_info.value.status_code == 400
    with pytest.raises(DomainError) as exc_info:
        coordinator.put_mapping("CASE-MOSS", [{"globalSpeaker": "GS01", "role": "  "}])
    assert exc_info.value.code == "MOSS_INVALID_ROLE"
    engine.dispose()


def test_transcript_returns_role_plus_anonymous_gs(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    coordinator.put_mapping("CASE-MOSS", [{"globalSpeaker": "GS01", "role": "民警"}])
    fake.snapshots[job_id] = _snapshot(job_id, "COMPLETED", windows=(_window("w0001", "DONE", 1),))
    fake.results[job_id] = _result(job_id, [
        _segment(),
        _segment(segment_id="s2", global_speaker="GS02", text="我不同意"),
    ])
    coordinator.poll_once()

    transcript = coordinator.transcript("CASE-MOSS")

    assert transcript["revisionNo"] == 1
    assert transcript["state"] == "COMPLETED"
    first = transcript["segments"][0]
    assert first["gs"] == "GS01"
    assert first["role"] == "民警"
    assert first["text"] == "你好"
    second = transcript["segments"][1]
    assert second["gs"] == "GS02"
    assert second["role"] is None
    engine.dispose()


def test_transcript_without_revision_reports_state_with_empty_segments(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _submitted(tmp_path, fake, coordinator)

    transcript = coordinator.transcript("CASE-MOSS")
    assert transcript["revisionNo"] is None
    assert transcript["segments"] == []
    assert transcript["state"] == "QUEUED"
    engine.dispose()


def test_transcript_without_submission_is_not_found(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    coordinator = _coordinator(factory, FakeTranscriptionService())
    with pytest.raises(DomainError) as exc_info:
        coordinator.transcript("CASE-MOSS")
    assert exc_info.value.code == "MOSS_TRANSCRIPTION_NOT_FOUND"
    assert exc_info.value.status_code == 404
    engine.dispose()


# --------------------------------------------------------------------------
# failure isolation: MOSS writes never touch interrogation text
# --------------------------------------------------------------------------


def test_moss_failure_leaves_existing_interrogation_text_byte_identical(tmp_path):
    engine, factory = _factory(tmp_path)
    _seed_case(factory)
    with factory() as db:
        message_repo.create(db, case_id="CASE-MOSS", session_id=None, speaker="嫌疑人", text="原始笔录文本")
        db.commit()
    fake = FakeTranscriptionService()
    coordinator = _coordinator(factory, fake)
    _wav, job_id = _submitted(tmp_path, fake, coordinator)
    fake.snapshots[job_id] = _snapshot(job_id, "FAILED", error="MOSS_AUDIO_CORRUPT")

    with factory() as db:
        original = db.scalar(select(Message).where(Message.case_id == "CASE-MOSS"))
        original_bytes = (original.id, original.seq, original.text, original.speaker, original.current_version)

    coordinator.poll_once()

    with factory() as db:
        after = db.scalar(select(Message).where(Message.case_id == "CASE-MOSS"))
        assert (after.id, after.seq, after.text, after.speaker, after.current_version) == original_bytes
        assert after.text == "原始笔录文本"
    engine.dispose()
