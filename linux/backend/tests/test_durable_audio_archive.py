from __future__ import annotations

import hashlib
import os
from pathlib import Path

import pytest
from sqlalchemy import select

from app.database.models import ASRAudioFrame, ASRAudioSegment, ASRCaptureSession, Case
from app.database.session import init_database, make_engine, make_session_factory
from app.services.durable_audio_archive import DurableAudioArchive


@pytest.fixture
def archive_env(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'archive.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        db.add(Case(id="case-1"))
        db.commit()
    archive = DurableAudioArchive(tmp_path / "data", factory)
    return archive, factory, tmp_path / "data", engine


def test_capture_finalizes_wav_with_durable_metadata(archive_env):
    archive, factory, data_dir, engine = archive_env
    pcm = b"\x01\x00" * 16_000

    archive.open_capture("capture-1", case_id="case-1")
    assert archive.append("capture-1", pcm) == 16_000
    segments = archive.finalize_capture("capture-1")

    assert len(segments) == 1
    assert segments[0].finalized_samples == 16_000
    assert len(segments[0].sha256) == 64
    assert archive.read_samples("capture-1", 0, 16_000) == pcm
    wav_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    assert wav_path.read_bytes()[44:] == pcm
    assert segments[0].sha256 == hashlib.sha256(wav_path.read_bytes()).hexdigest()

    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        assert capture is not None
        assert capture.recording_status == "COMPLETE"
    engine.dispose()


def test_finalize_rejects_changed_active_audio_without_exposing_it(archive_env):
    archive, factory, data_dir, _engine = archive_env
    pcm = b"\x02\x00" * 800
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", pcm)
    wav_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    corrupted = bytearray(wav_path.read_bytes())
    corrupted[44 + 50] ^= 0x80
    wav_path.write_bytes(corrupted)
    corrupted_bytes = wav_path.read_bytes()

    with pytest.raises(RuntimeError, match="durable metadata"):
        archive.finalize_capture("capture-1")

    assert wav_path.read_bytes() == corrupted_bytes
    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        segment = db.scalar(select(ASRAudioSegment).where(ASRAudioSegment.capture_session_id == "capture-1"))
        assert capture.recording_status == "INCOMPLETE"
        assert capture.audio_sample_count == 0
        assert segment.status == "GAP"
        assert segment.committed_samples == 0
    with pytest.raises(ValueError):
        archive.read_samples("capture-1", 0, 1)


def test_finalize_rejects_changed_finalized_audio_without_rewriting_it(archive_env):
    archive, factory, data_dir, _engine = archive_env
    archive.open_capture("capture-1", case_id="case-1")
    for _ in range(60):
        archive.append("capture-1", b"\x03\x00" * 16_000)
    archive.append("capture-1", b"\x04\x00")
    wav_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    corrupted = bytearray(wav_path.read_bytes())
    corrupted[44 + 100] ^= 0x80
    wav_path.write_bytes(corrupted)
    corrupted_bytes = wav_path.read_bytes()

    with pytest.raises(RuntimeError, match="durable metadata"):
        archive.finalize_capture("capture-1")

    assert wav_path.read_bytes() == corrupted_bytes
    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        segments = list(
            db.scalars(
                select(ASRAudioSegment)
                .where(ASRAudioSegment.capture_session_id == "capture-1")
                .order_by(ASRAudioSegment.sequence)
            )
        )
        assert capture.recording_status == "INCOMPLETE"
        assert capture.audio_sample_count == 0
        assert [(item.status, item.committed_samples) for item in segments] == [("GAP", 0), ("GAP", 0)]
    with pytest.raises(ValueError):
        archive.read_samples("capture-1", 0, 1)


def test_archive_splits_audio_at_one_minute_boundaries_and_keeps_final_segment_immutable(archive_env):
    archive, factory, data_dir, _engine = archive_env
    pcm = b"\x01\x00" * (60 * 16_000 + 1)
    archive.open_capture("capture-1", case_id="case-1")

    for offset in range(0, len(pcm), 2 * 16_000):
        durable_end = archive.append("capture-1", pcm[offset : offset + 2 * 16_000])
    assert durable_end == 60 * 16_000 + 1
    segments = archive.list_segments("capture-1")

    assert [(item.start_sample, item.committed_samples, item.status) for item in segments] == [
        (0, 60 * 16_000, "FINALIZED"),
        (60 * 16_000, 1, "ACTIVE"),
    ]
    first_wav = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    first_wav_bytes = first_wav.read_bytes()
    assert segments[0].sha256 == hashlib.sha256(first_wav_bytes).hexdigest()
    active_wav = data_dir / "audio" / "case-1" / "capture-1" / "segment-000001.wav"
    with active_wav.open("ab") as stream:
        stream.write(b"\x02\x00")

    restarted = DurableAudioArchive(data_dir, factory)
    assert restarted.recover_incomplete() == ["capture-1"]

    assert first_wav.read_bytes() == first_wav_bytes
    assert active_wav.stat().st_size == 44 + 2


def test_append_rejects_more_than_one_second_and_marks_capture_incomplete(archive_env):
    archive, factory, _data_dir, _engine = archive_env
    archive.open_capture("capture-1", case_id="case-1")

    with pytest.raises(ValueError, match="one second"):
        archive.append("capture-1", b"\x01\x00" * 16_001)

    with factory() as db:
        assert db.get(ASRCaptureSession, "capture-1").recording_status == "INCOMPLETE"
    with pytest.raises(RuntimeError):
        archive.finalize_capture("capture-1")


def test_recovery_truncates_uncommitted_tail_and_repairs_wav_header(archive_env):
    archive, factory, data_dir, _engine = archive_env
    committed = b"\x03\x00" * 800
    uncommitted_tail = b"\x04\x00" * 17
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", committed)
    active_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    with active_path.open("ab") as stream:
        stream.write(uncommitted_tail)

    restarted = DurableAudioArchive(data_dir, factory)
    assert restarted.recover_incomplete() == ["capture-1"]

    repaired = active_path.read_bytes()
    assert len(repaired) == 44 + len(committed)
    assert int.from_bytes(repaired[40:44], "little") == len(committed)
    assert restarted.read_samples("capture-1", 0, 800) == committed
    segments = restarted.list_segments("capture-1")
    assert segments[0].committed_samples == 800
    assert segments[0].status == "ACTIVE"


def test_recovery_reports_missing_durable_audio_as_incomplete_gap(archive_env):
    archive, factory, data_dir, _engine = archive_env
    pcm = b"\x05\x00" * 800
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", pcm)
    active_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    active_path.write_bytes(active_path.read_bytes()[:-2])

    restarted = DurableAudioArchive(data_dir, factory)
    assert restarted.recover_incomplete() == ["capture-1"]

    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        assert capture.recording_status == "INCOMPLETE"
        assert capture.audio_sample_count == 0
        segment = db.scalar(select(ASRAudioSegment).where(ASRAudioSegment.capture_session_id == "capture-1"))
        assert segment.status == "GAP"
        assert segment.committed_samples == 0
    with pytest.raises(ValueError):
        restarted.read_samples("capture-1", 0, 1)


def test_recovery_rejects_same_size_corruption_in_committed_audio(archive_env):
    archive, factory, data_dir, _engine = archive_env
    pcm = b"\x06\x00" * 800
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", pcm)
    active_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    corrupted = bytearray(active_path.read_bytes())
    corrupted[44 + 100] ^= 0xFF
    active_path.write_bytes(corrupted)

    restarted = DurableAudioArchive(data_dir, factory)
    assert restarted.recover_incomplete() == ["capture-1"]

    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        segment = db.scalar(select(ASRAudioSegment).where(ASRAudioSegment.capture_session_id == "capture-1"))
        assert capture.recording_status == "INCOMPLETE"
        assert capture.audio_sample_count == 0
        assert segment.status == "GAP"
        assert segment.committed_samples == 0
    with pytest.raises(ValueError):
        restarted.read_samples("capture-1", 0, 1)
    with pytest.raises(RuntimeError):
        restarted.finalize_capture("capture-1")


def test_recovery_rejects_symlinked_capture_directory_escape(archive_env, tmp_path, monkeypatch):
    archive, factory, data_dir, _engine = archive_env
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", b"\x07\x00" * 100)
    capture_dir = data_dir / "audio" / "case-1" / "capture-1"
    external_dir = tmp_path / "outside-capture"
    capture_dir.rename(external_dir)
    try:
        os.symlink(external_dir, capture_dir, target_is_directory=True)
    except OSError as error:
        if os.name != "nt":
            external_dir.rename(capture_dir)
            pytest.skip(f"directory symlinks are unavailable: {error}")
        # Windows may block symlink creation without Developer Mode. Simulate
        # the resolved paths produced by that symlink so the containment check
        # remains exercised on this host.
        original_resolve = Path.resolve
        external_wav = external_dir / "segment-000000.wav"
        expected_wav = capture_dir / "segment-000000.wav"

        def resolve_symlink_path(path: Path, *args, **kwargs):
            if path == capture_dir:
                return external_dir
            if path == expected_wav:
                return external_wav
            return original_resolve(path, *args, **kwargs)

        monkeypatch.setattr(Path, "resolve", resolve_symlink_path)
    wav_path = external_dir / "segment-000000.wav"
    wav_before = wav_path.read_bytes()

    restarted = DurableAudioArchive(data_dir, factory)
    with pytest.raises(ValueError, match="archive root"):
        restarted.recover_incomplete()

    assert wav_path.read_bytes() == wav_before
    with factory() as db:
        assert db.get(ASRCaptureSession, "capture-1").recording_status == "INCOMPLETE"


def test_rejects_incomplete_pcm_frames_and_traversal_ids(archive_env):
    archive, factory, data_dir, _engine = archive_env
    archive.open_capture("capture-1", case_id="case-1")

    with pytest.raises(ValueError):
        archive.append("capture-1", b"\x01")
    with pytest.raises(ValueError):
        archive.open_capture("../escape", case_id="case-1")
    with pytest.raises(ValueError):
        archive.open_capture("capture-2", case_id="../../outside")

    with factory() as db:
        assert db.get(ASRCaptureSession, "capture-1").recording_status == "INCOMPLETE"
    with pytest.raises(RuntimeError):
        archive.finalize_capture("capture-1")

    assert not (data_dir / "escape").exists()
    assert not (data_dir.parent / "outside").exists()
    assert archive.list_segments("capture-1") == []


def test_append_io_failure_marks_capture_incomplete_and_not_complete(archive_env, monkeypatch):
    archive, factory, _data_dir, _engine = archive_env
    archive.open_capture("capture-1", case_id="case-1")
    original_open = Path.open

    def fail_wav_write(path: Path, mode="r", *args, **kwargs):
        if path.suffix == ".wav" and mode in {"r+b", "wb+"}:
            raise OSError("simulated disk full")
        return original_open(path, mode, *args, **kwargs)

    monkeypatch.setattr(Path, "open", fail_wav_write)
    with pytest.raises(OSError, match="disk full"):
        archive.append("capture-1", b"\x01\x00" * 64)

    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        assert capture.recording_status == "INCOMPLETE"
    with pytest.raises(RuntimeError):
        archive.finalize_capture("capture-1")


def test_browser_frame_duplicate_returns_original_durable_receipt(archive_env):
    archive, factory, _data_dir, _engine = archive_env
    first = b"\x10\x00" * 100
    second = b"\x11\x00" * 25
    archive.open_capture("capture-1", case_id="case-1")

    assert archive.append("capture-1", first, source_sequence=7) == 100
    assert archive.append("capture-1", first, source_sequence=7) == 100
    assert archive.append("capture-1", second, source_sequence=8) == 125
    assert archive.read_samples("capture-1", 0, 125) == first + second

    with factory() as db:
        frames = list(db.scalars(select(ASRAudioFrame).order_by(ASRAudioFrame.source_sequence)))
        assert len(frames) == 2
        assert (frames[0].start_sample, frames[0].end_sample, frames[0].durable_sample_end) == (0, 100, 100)
        assert frames[0].payload_sha256 == hashlib.sha256(first).hexdigest()


def test_browser_frame_replay_conflict_fails_closed(archive_env):
    archive, factory, _data_dir, _engine = archive_env
    pcm = b"\x10\x00" * 100
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", pcm, source_sequence=7)

    with pytest.raises(RuntimeError):
        archive.append("capture-1", b"\x12\x00" * 100, source_sequence=7)

    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        assert capture.recording_status == "INCOMPLETE"
        assert db.scalar(select(ASRAudioFrame).where(ASRAudioFrame.source_sequence == 7)).payload_sha256 == hashlib.sha256(pcm).hexdigest()
    assert archive.read_samples("capture-1", 0, 100) == pcm


def test_browser_frame_replay_detects_conflicting_persisted_range(archive_env):
    archive, factory, _data_dir, _engine = archive_env
    pcm = b"\x10\x00" * 100
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", pcm, source_sequence=7)
    with factory() as db:
        frame = db.scalar(select(ASRAudioFrame).where(ASRAudioFrame.source_sequence == 7))
        frame.start_sample = 1
        db.commit()

    with pytest.raises(RuntimeError):
        archive.append("capture-1", pcm, source_sequence=7)
    with factory() as db:
        assert db.get(ASRCaptureSession, "capture-1").recording_status == "INCOMPLETE"


def test_browser_frame_replay_fails_if_durable_wav_data_is_missing(archive_env):
    archive, factory, data_dir, _engine = archive_env
    pcm = b"\x10\x00" * 100
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", pcm, source_sequence=7)
    wav_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000000.wav"
    wav_path.write_bytes(wav_path.read_bytes()[:-2])

    with pytest.raises(RuntimeError):
        archive.append("capture-1", pcm, source_sequence=7)

    with factory() as db:
        assert db.get(ASRCaptureSession, "capture-1").recording_status == "INCOMPLETE"


def test_browser_frame_replay_quarantines_corrupted_wav_and_preserves_verified_prefix(archive_env):
    archive, factory, data_dir, _engine = archive_env
    prefix = b"\x20\x00" * 16_000
    frame = b"\x21\x00" * 100
    archive.open_capture("capture-1", case_id="case-1")
    for _ in range(60):
        archive.append("capture-1", prefix)
    archive.append("capture-1", frame, source_sequence=7)
    wav_path = data_dir / "audio" / "case-1" / "capture-1" / "segment-000001.wav"
    corrupted = bytearray(wav_path.read_bytes())
    corrupted[44 + 20] ^= 0x80
    wav_path.write_bytes(corrupted)

    with pytest.raises(RuntimeError):
        archive.append("capture-1", frame, source_sequence=7)

    with factory() as db:
        capture = db.get(ASRCaptureSession, "capture-1")
        segments = list(
            db.scalars(
                select(ASRAudioSegment)
                .where(ASRAudioSegment.capture_session_id == "capture-1")
                .order_by(ASRAudioSegment.sequence)
            )
        )
        assert capture.recording_status == "INCOMPLETE"
        assert capture.audio_sample_count == 60 * 16_000
        assert [(item.status, item.committed_samples) for item in segments] == [
            ("FINALIZED", 60 * 16_000),
            ("GAP", 0),
        ]
    assert archive.read_samples("capture-1", 0, 60 * 16_000) == prefix * 60
    with pytest.raises(ValueError):
        archive.read_samples("capture-1", 60 * 16_000, 60 * 16_000 + 100)


def test_conflicting_replay_after_finalize_downgrades_capture_state(archive_env):
    archive, factory, _data_dir, _engine = archive_env
    pcm = b"\x10\x00" * 100
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", pcm, source_sequence=7)
    archive.finalize_capture("capture-1")

    with pytest.raises(RuntimeError):
        archive.append("capture-1", b"\x12\x00" * 100, source_sequence=7)

    with factory() as db:
        assert db.get(ASRCaptureSession, "capture-1").recording_status == "INCOMPLETE"
