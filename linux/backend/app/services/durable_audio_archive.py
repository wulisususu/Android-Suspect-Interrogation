from __future__ import annotations

import hashlib
import os
import re
import shutil
import struct
from pathlib import Path, PurePosixPath
from typing import Any

from sqlalchemy import func, select
from sqlalchemy.orm import Session, sessionmaker

from app.database.models import ASRAudioFrame, ASRAudioSegment, ASRCaptureSession
from app.repositories import audio_archive as archive_repo


_CAPTURE_ID = re.compile(r"^[A-Za-z0-9][A-Za-z0-9_-]{0,63}$")
_SAMPLE_RATE = 16_000
_SAMPLE_BYTES = 2
_SEGMENT_SAMPLES = 60 * _SAMPLE_RATE
_WAV_HEADER_BYTES = 44


class BrowserAudioDiscontinuityError(RuntimeError):
    """A browser frame conflicts with the durable sequence/sample history."""


class AudioStorageReserveError(RuntimeError):
    """The evidence volume reached its configured minimum free-space reserve."""


class DurableAudioArchive:
    """Persist raw mono PCM16 as recoverable, one-minute WAV segments."""

    def __init__(
        self,
        data_dir: str | Path,
        session_factory: sessionmaker[Session],
        sample_rate: int = _SAMPLE_RATE,
        min_free_bytes: int = 0,
    ) -> None:
        if sample_rate != _SAMPLE_RATE:
            raise ValueError("durable audio archive requires 16 kHz audio")
        self.data_dir = Path(data_dir).resolve()
        self.audio_dir = self.data_dir / "audio"
        self.session_factory = session_factory
        self.sample_rate = sample_rate
        self.min_free_bytes = max(0, int(min_free_bytes))
        self._segment_hashers: dict[str, Any] = {}

    def check_storage_reserve(self) -> None:
        if not self.min_free_bytes:
            return
        probe_root = self.data_dir if self.data_dir.exists() else self.data_dir.parent
        free_bytes = shutil.disk_usage(probe_root).free
        if free_bytes < self.min_free_bytes:
            free_mb = free_bytes // (1024 * 1024)
            reserve_mb = self.min_free_bytes // (1024 * 1024)
            raise AudioStorageReserveError(
                f"audio evidence storage reserve reached: free_mb={free_mb} below minimum={reserve_mb}"
            )

    def open_capture(self, capture_id: str, *, case_id: str) -> None:
        self._validate_id(capture_id, "capture_id")
        self._validate_id(case_id, "case_id")
        self.check_storage_reserve()
        with archive_repo.archive_transaction(self.session_factory) as db:
            capture = archive_repo.get_capture(db, capture_id)
            if capture is None:
                self._ensure_capture_dirs(case_id, capture_id)
                archive_repo.create_capture(db, capture_id=capture_id, case_id=case_id)
                return
            if capture.case_id != case_id:
                raise ValueError("capture_id is already assigned to another case")
            if capture.sample_rate != self.sample_rate:
                raise ValueError("capture sample rate does not match the archive")
            if capture.recording_status == "COMPLETE":
                raise RuntimeError("capture is already finalized")
            if capture.recording_status == "INCOMPLETE":
                raise RuntimeError("capture is incomplete and cannot be reopened")
            self._ensure_capture_dirs(case_id, capture_id)
            if capture.recording_status == "PENDING":
                capture.recording_status = "CAPTURING"
                capture.status = "CAPTURING"

    def append(
        self,
        capture_id: str,
        pcm: bytes,
        *,
        source_sequence: int | None = None,
        expected_start_sample: int | None = None,
        allow_incomplete_recovery: bool = False,
    ) -> int:
        """Durably append up to one second of PCM; callers must split larger input."""
        self._validate_id(capture_id, "capture_id")
        if not isinstance(pcm, bytes):
            raise ValueError("PCM16 audio must contain complete 16-bit samples")
        if len(pcm) % _SAMPLE_BYTES:
            self._mark_incomplete(capture_id)
            raise ValueError("PCM16 audio must contain complete 16-bit samples")
        if not pcm:
            raise ValueError("PCM16 audio frame cannot be empty")
        sample_count = len(pcm) // _SAMPLE_BYTES
        if sample_count > _SAMPLE_RATE:
            self._mark_incomplete(capture_id)
            raise ValueError("audio append cannot exceed one second")
        if source_sequence is not None and (
            not isinstance(source_sequence, int) or isinstance(source_sequence, bool) or source_sequence < 0
        ):
            raise ValueError("source_sequence must be a non-negative integer")
        if expected_start_sample is not None and (
            not isinstance(expected_start_sample, int)
            or isinstance(expected_start_sample, bool)
            or expected_start_sample < 0
            or source_sequence is None
            or source_sequence < 1
        ):
            raise ValueError("formal browser frame sequence and start sample are invalid")

        payload_hash = hashlib.sha256(pcm).hexdigest()
        conflict = False
        discontinuity = False
        integrity_failure = False
        reserve_error: AudioStorageReserveError | None = None
        durable_end: int | None = None
        io_started = False
        try:
            with archive_repo.archive_transaction(self.session_factory) as db:
                capture = archive_repo.get_capture(db, capture_id)
                if capture is None:
                    raise ValueError(f"capture does not exist: {capture_id}")

                if source_sequence is not None:
                    prior = archive_repo.get_frame(db, capture_id, source_sequence)
                    if prior is not None:
                        receipt_valid = (
                            prior.start_sample >= 0
                            and prior.end_sample > prior.start_sample
                            and prior.durable_sample_end == prior.end_sample
                            and prior.durable_sample_end <= capture.audio_sample_count
                        )
                        if not receipt_valid:
                            archive_repo.mark_capture_incomplete(db, capture_id)
                            conflict = True
                        else:
                            segments = archive_repo.list_capture_segments(db, capture_id)
                            bad_index = self._first_invalid_segment_in_range(
                                capture.case_id,
                                capture.id,
                                segments,
                                prior.start_sample,
                                prior.end_sample,
                            )
                            stored_pcm: bytes | None = None
                            if bad_index is None:
                                try:
                                    stored_pcm = self._read_sample_range(
                                        capture.case_id,
                                        capture.id,
                                        segments,
                                        prior.start_sample,
                                        prior.end_sample,
                                    )
                                except (OSError, ValueError):
                                    bad_index = self._first_segment_for_range(
                                        segments,
                                        prior.start_sample,
                                        prior.end_sample,
                                    )

                            if bad_index is None and stored_pcm is not None:
                                if hashlib.sha256(stored_pcm).hexdigest() != prior.payload_sha256:
                                    bad_index = self._first_segment_for_range(
                                        segments,
                                        prior.start_sample,
                                        prior.end_sample,
                                    )

                            if bad_index is not None:
                                self._quarantine_unverified_segment_range(db, capture, segments, bad_index)
                                integrity_failure = True
                            elif (
                                stored_pcm == pcm
                                and payload_hash == prior.payload_sha256
                                and (
                                    expected_start_sample is None
                                    or (
                                        prior.start_sample == expected_start_sample
                                        and prior.end_sample == expected_start_sample + sample_count
                                    )
                                )
                            ):
                                durable_end = prior.durable_sample_end
                            else:
                                archive_repo.mark_capture_incomplete(db, capture_id)
                                conflict = True
                    else:
                        durable_end = None
                        if expected_start_sample is not None:
                            last_sequence = db.scalar(
                                select(func.max(ASRAudioFrame.source_sequence)).where(
                                    ASRAudioFrame.capture_session_id == capture_id
                                )
                            )
                            next_sequence = 1 if last_sequence is None else int(last_sequence) + 1
                            if (
                                source_sequence != next_sequence
                                or expected_start_sample != capture.audio_sample_count
                            ):
                                archive_repo.mark_capture_incomplete(db, capture_id)
                                conflict = True
                                discontinuity = True

                if durable_end is None and not conflict and not integrity_failure:
                    if capture.recording_status != "CAPTURING" and not (
                        allow_incomplete_recovery and capture.recording_status == "INCOMPLETE"
                    ):
                        raise RuntimeError("capture is not accepting audio")
                    try:
                        self.check_storage_reserve()
                    except AudioStorageReserveError as exc:
                        reserve_error = exc
                    else:
                        io_started = True
                        start_sample = capture.audio_sample_count
                        self._append_to_segments(db, capture, pcm)
                        durable_end = start_sample + sample_count
                        if source_sequence is not None:
                            archive_repo.record_frame(
                                db,
                                capture_id=capture_id,
                                source_sequence=source_sequence,
                                start_sample=start_sample,
                                end_sample=durable_end,
                                payload_sha256=payload_hash,
                                durable_sample_end=durable_end,
                            )
        except Exception:
            if io_started:
                self._mark_incomplete(capture_id)
                self._forget_hashers(capture_id)
            raise

        if reserve_error is not None:
            self._mark_incomplete(capture_id)
            self._forget_hashers(capture_id)
            raise reserve_error

        if integrity_failure:
            self._forget_hashers(capture_id)
            raise RuntimeError("source_sequence receipt does not match durable audio bytes")
        if conflict:
            self._forget_hashers(capture_id)
            if discontinuity:
                raise BrowserAudioDiscontinuityError(
                    "formal browser frame sequence or sample range has a discontinuity"
                )
            raise BrowserAudioDiscontinuityError(
                "source_sequence was replayed with conflicting audio or range"
            )
        if durable_end is None:
            raise RuntimeError("audio append did not reach a durable checkpoint")
        return durable_end

    def read_samples(self, capture_id: str, start: int, end: int) -> bytes:
        self._validate_id(capture_id, "capture_id")
        if (
            not isinstance(start, int)
            or not isinstance(end, int)
            or isinstance(start, bool)
            or isinstance(end, bool)
            or start < 0
            or end < start
        ):
            raise ValueError("sample range is invalid")
        integrity_failure = False
        samples = b""
        with archive_repo.archive_transaction(self.session_factory) as db:
            capture = archive_repo.get_capture(db, capture_id)
            if capture is None:
                raise ValueError(f"capture does not exist: {capture_id}")
            if end > capture.audio_sample_count:
                raise ValueError("sample range extends beyond the durable archive")
            segments = archive_repo.list_capture_segments(db, capture_id)
            if start == end:
                return b""
            bad_index = self._first_invalid_segment_in_range(
                capture.case_id,
                capture.id,
                segments,
                start,
                end,
            )
            if bad_index is None:
                try:
                    samples = self._read_sample_range(capture.case_id, capture_id, segments, start, end)
                except (OSError, ValueError):
                    bad_index = self._first_invalid_segment_in_range(
                        capture.case_id,
                        capture.id,
                        segments,
                        start,
                        end,
                    )
                    if bad_index is None:
                        bad_index = self._first_segment_for_range(segments, start, end)
                    if bad_index is None:
                        archive_repo.mark_capture_incomplete(db, capture_id)
                    else:
                        self._quarantine_unverified_segment_range(db, capture, segments, bad_index)
                    integrity_failure = True
            else:
                self._quarantine_unverified_segment_range(db, capture, segments, bad_index)
                integrity_failure = True

        if integrity_failure:
            raise ValueError("audio archive integrity validation failed")
        return samples

    def _read_sample_range(
        self,
        case_id: str,
        capture_id: str,
        segments: list[ASRAudioSegment],
        start: int,
        end: int,
    ) -> bytes:
        output = bytearray()
        cursor = start
        for segment in segments:
            segment_start = segment.start_sample
            segment_end = segment_start + segment.committed_samples
            overlap_start = max(start, segment_start)
            overlap_end = min(end, segment_end)
            if overlap_start >= overlap_end:
                continue
            if segment.status == "GAP" or segment_start > cursor or overlap_start != cursor:
                raise ValueError("sample range crosses a missing audio gap")
            path = self._segment_path(case_id, capture_id, segment)
            contents = path.read_bytes()
            if not self._segment_bytes_match_metadata(segment, contents):
                raise ValueError("audio segment integrity does not match its durable metadata")
            chunk_start = _WAV_HEADER_BYTES + (overlap_start - segment_start) * _SAMPLE_BYTES
            expected = (overlap_end - overlap_start) * _SAMPLE_BYTES
            chunk = contents[chunk_start : chunk_start + expected]
            if len(chunk) != expected:
                raise ValueError("audio segment is shorter than its durable metadata")
            output.extend(chunk)
            cursor = overlap_end
        if cursor != end:
            raise ValueError("sample range crosses a missing audio gap")
        if len(output) != (end - start) * _SAMPLE_BYTES:
            raise ValueError("audio byte count does not match the requested sample range")
        return bytes(output)

    def list_segments(self, capture_id: str) -> list[ASRAudioSegment]:
        self._validate_id(capture_id, "capture_id")
        with archive_repo.archive_transaction(self.session_factory, immediate=False) as db:
            if archive_repo.get_capture(db, capture_id) is None:
                raise ValueError(f"capture does not exist: {capture_id}")
            return archive_repo.list_capture_segments(db, capture_id)

    def finalize_capture(
        self,
        capture_id: str,
        *,
        allow_incomplete_recovery: bool = False,
    ) -> list[ASRAudioSegment]:
        self._validate_id(capture_id, "capture_id")
        integrity_error: str | None = None
        try:
            with archive_repo.archive_transaction(self.session_factory) as db:
                capture = archive_repo.get_capture(db, capture_id)
                if capture is None:
                    raise ValueError(f"capture does not exist: {capture_id}")
                segments = archive_repo.list_capture_segments(db, capture_id)
                if capture.recording_status == "COMPLETE":
                    cursor = 0
                    for index, segment in enumerate(segments):
                        path = self._segment_path(capture.case_id, capture.id, segment)
                        if (
                            segment.start_sample != cursor
                            or segment.status != "FINALIZED"
                            or not self._finalized_segment_matches_metadata(segment, path)
                        ):
                            self._mark_finalize_gap(db, capture, segments, index, cursor)
                            integrity_error = "finalized audio segment does not match its durable metadata"
                            break
                        cursor += segment.committed_samples
                    if integrity_error is None and cursor != capture.audio_sample_count:
                        archive_repo.mark_capture_incomplete(db, capture_id)
                        integrity_error = "capture sample count does not match its segments"
                    if integrity_error is None:
                        result = list(segments)
                elif capture.recording_status != "CAPTURING" and not (
                    allow_incomplete_recovery and capture.recording_status == "INCOMPLETE"
                ):
                    raise RuntimeError("incomplete capture cannot be finalized")
                else:
                    cursor = 0
                    for index, segment in enumerate(segments):
                        if segment.status == "GAP" or segment.start_sample != cursor:
                            raise RuntimeError("capture contains an audio gap")
                        if segment.committed_samples > _SEGMENT_SAMPLES:
                            raise RuntimeError("audio segment exceeds its one-minute limit")
                        path = self._segment_path(capture.case_id, capture.id, segment)
                        if segment.status == "ACTIVE":
                            if not self._active_segment_matches_metadata(segment, path):
                                self._mark_finalize_gap(db, capture, segments, index, cursor)
                                integrity_error = "active audio segment does not match its durable metadata"
                                break
                            self._repair_wav(path, segment.committed_samples, allow_create=segment.committed_samples == 0)
                            self._finalize_segment_file(segment, path)
                        elif segment.status == "FINALIZED":
                            if not self._finalized_segment_matches_metadata(segment, path):
                                self._mark_finalize_gap(db, capture, segments, index, cursor)
                                integrity_error = "finalized audio segment does not match its durable metadata"
                                break
                        else:
                            raise RuntimeError("audio segment state is invalid")
                        cursor += segment.committed_samples
                    if integrity_error is None and cursor != capture.audio_sample_count:
                        raise RuntimeError("capture sample count does not match its segments")
                    if integrity_error is None:
                        archive_repo.complete_capture(capture)
                        result = list(segments)
        except Exception:
            self._mark_incomplete(capture_id)
            self._forget_hashers(capture_id)
            raise
        if integrity_error is not None:
            self._forget_hashers(capture_id)
            raise RuntimeError(integrity_error)
        return result

    def recover_incomplete(self) -> list[str]:
        with archive_repo.archive_transaction(self.session_factory, immediate=False) as db:
            capture_ids = sorted(item.id for item in archive_repo.active_captures(db))
        recovered: list[str] = []
        for capture_id in capture_ids:
            self._recover_capture(capture_id)
            recovered.append(capture_id)
        return recovered

    def _append_to_segments(self, db: Session, capture: ASRCaptureSession, pcm: bytes) -> None:
        segments = archive_repo.list_capture_segments(db, capture.id)
        cursor = 0
        for index, segment in enumerate(segments):
            if segment.start_sample != cursor:
                raise RuntimeError("capture segment metadata is not appendable")
            if segment.committed_samples > _SEGMENT_SAMPLES:
                raise RuntimeError("audio segment exceeds its one-minute limit")
            if segment.status == "FINALIZED":
                if segment.committed_samples != _SEGMENT_SAMPLES or segment.finalized_samples != segment.committed_samples:
                    raise RuntimeError("finalized audio segment metadata is inconsistent")
            elif segment.status == "ACTIVE":
                if index != len(segments) - 1:
                    raise RuntimeError("only the last audio segment can remain active")
            else:
                raise RuntimeError("capture segment metadata is not appendable")
            cursor += segment.committed_samples
        if cursor != capture.audio_sample_count:
            raise RuntimeError("capture sample count does not match its segments")

        next_start_sample = capture.audio_sample_count
        remaining = memoryview(pcm)
        if segments and segments[-1].status == "ACTIVE" and segments[-1].committed_samples == _SEGMENT_SAMPLES:
            path = self._segment_path(capture.case_id, capture.id, segments[-1])
            self._finalize_segment_file(segments[-1], path)
        while remaining:
            segment = segments[-1] if segments and segments[-1].committed_samples < _SEGMENT_SAMPLES else None
            if segment is None:
                sequence = segments[-1].sequence + 1 if segments else 0
                relative_path = PurePosixPath("audio", capture.case_id, capture.id, f"segment-{sequence:06d}.wav")
                segment = archive_repo.create_segment(
                    db,
                    capture_id=capture.id,
                    sequence=sequence,
                    relative_path=relative_path.as_posix(),
                    start_sample=next_start_sample,
                    sha256=hashlib.sha256(b"").hexdigest(),
                )
                segments.append(segment)

            if segment.status != "ACTIVE":
                raise RuntimeError("capture segment is not active")
            available = _SEGMENT_SAMPLES - segment.committed_samples
            take_samples = min(available, len(remaining) // _SAMPLE_BYTES)
            take_bytes = take_samples * _SAMPLE_BYTES
            chunk = bytes(remaining[:take_bytes])
            path = self._segment_path(capture.case_id, capture.id, segment)
            hasher = self._hasher_for(path, segment)
            self._write_wav_chunk(path, segment.committed_samples, segment.committed_samples + take_samples, chunk)
            hasher.update(chunk)
            archive_repo.update_segment(
                segment,
                committed_samples=segment.committed_samples + take_samples,
                sha256=hasher.hexdigest(),
            )
            archive_repo.update_capture_count(capture, capture.audio_sample_count + take_samples)
            next_start_sample += take_samples
            if segment.committed_samples == _SEGMENT_SAMPLES:
                self._finalize_segment_file(segment, path)
            remaining = remaining[take_bytes:]

    def _recover_capture(self, capture_id: str) -> None:
        try:
            with archive_repo.archive_transaction(self.session_factory) as db:
                capture = archive_repo.get_capture(db, capture_id)
                if capture is None or capture.recording_status == "COMPLETE":
                    return
                segments = archive_repo.list_capture_segments(db, capture_id)
                expected_start = 0
                gap_found = False
                for segment in segments:
                    if gap_found or segment.start_sample != expected_start:
                        archive_repo.update_segment(
                            segment,
                            committed_samples=0,
                            finalized_samples=0,
                            sha256=hashlib.sha256(b"").hexdigest(),
                            status="GAP",
                        )
                        gap_found = True
                        self._segment_hashers.pop(str(self._segment_path(capture.case_id, capture.id, segment)), None)
                        continue

                    path = self._segment_path(capture.case_id, capture.id, segment)
                    if segment.status == "FINALIZED":
                        expected_file_size = _WAV_HEADER_BYTES + segment.committed_samples * _SAMPLE_BYTES
                        valid_finalized = False
                        if path.exists() and path.stat().st_size == expected_file_size:
                            with path.open("rb") as stream:
                                valid_finalized = stream.read(_WAV_HEADER_BYTES) == self._wav_header(segment.committed_samples)
                            valid_finalized = valid_finalized and self._hash_file(path) == segment.sha256
                        if valid_finalized and segment.finalized_samples == segment.committed_samples:
                            expected_start += segment.committed_samples
                        else:
                            self._mark_segment_gap(segment)
                            gap_found = True
                        continue

                    if segment.status != "ACTIVE":
                        self._mark_segment_gap(segment)
                        gap_found = True
                        continue
                    if not path.exists():
                        if segment.committed_samples == 0:
                            self._ensure_capture_dirs(capture.case_id, capture.id)
                            self._repair_wav(path, 0, allow_create=True)
                        else:
                            self._mark_segment_gap(segment)
                            gap_found = True
                            continue

                    file_size = path.stat().st_size
                    if file_size < _WAV_HEADER_BYTES and segment.committed_samples > 0:
                        self._mark_segment_gap(segment)
                        gap_found = True
                        continue
                    available_samples = max(0, (file_size - _WAV_HEADER_BYTES) // _SAMPLE_BYTES)
                    durable_samples = segment.committed_samples
                    if available_samples < durable_samples:
                        self._mark_segment_gap(segment)
                        gap_found = True
                        continue
                    if self._hash_pcm(path, durable_samples) != segment.sha256:
                        self._mark_segment_gap(segment)
                        self._segment_hashers.pop(str(path), None)
                        gap_found = True
                        continue
                    self._repair_wav(path, durable_samples, allow_create=durable_samples == 0)
                    digest = self._hash_pcm(path, durable_samples)
                    self._segment_hashers[str(path)] = self._new_hasher(path, durable_samples)
                    if durable_samples == _SEGMENT_SAMPLES:
                        digest = self._hash_file(path)
                        os.chmod(path, 0o640)
                        self._segment_hashers.pop(str(path), None)
                    archive_repo.update_segment(
                        segment,
                        committed_samples=durable_samples,
                        finalized_samples=durable_samples if durable_samples == _SEGMENT_SAMPLES else 0,
                        sha256=digest,
                        status="FINALIZED" if durable_samples == _SEGMENT_SAMPLES else "ACTIVE",
                    )
                    expected_start += durable_samples

                if not segments and capture.audio_sample_count:
                    gap_found = True
                    expected_start = 0
                archive_repo.update_capture_count(capture, expected_start)
                if gap_found:
                    archive_repo.mark_capture_incomplete(db, capture_id)
                    archive_repo.update_capture_count(capture, expected_start)
        except Exception:
            self._mark_incomplete(capture_id)
            raise

    @staticmethod
    def _mark_segment_gap(segment: ASRAudioSegment) -> None:
        archive_repo.update_segment(
            segment,
            committed_samples=0,
            finalized_samples=0,
            sha256=hashlib.sha256(b"").hexdigest(),
            status="GAP",
        )

    def _mark_finalize_gap(
        self,
        db: Session,
        capture: ASRCaptureSession,
        segments: list[ASRAudioSegment],
        index: int,
        verified_samples: int,
    ) -> None:
        for segment in segments[index:]:
            self._mark_segment_gap(segment)
        self._forget_hashers(capture.id)
        archive_repo.update_capture_count(capture, verified_samples)
        archive_repo.mark_capture_incomplete(db, capture.id)

    def _quarantine_unverified_segment_range(
        self,
        db: Session,
        capture: ASRCaptureSession,
        segments: list[ASRAudioSegment],
        index: int,
    ) -> None:
        verified_samples = 0
        first_bad_index = index
        for prefix_index, segment in enumerate(segments[:index]):
            if (
                segment.start_sample != verified_samples
                or not self._segment_matches_metadata(
                    capture.case_id,
                    capture.id,
                    segment,
                )
            ):
                first_bad_index = prefix_index
                break
            verified_samples += segment.committed_samples
        self._mark_finalize_gap(db, capture, segments, first_bad_index, verified_samples)

    @staticmethod
    def _first_segment_for_range(
        segments: list[ASRAudioSegment],
        start: int,
        end: int,
    ) -> int | None:
        for index, segment in enumerate(segments):
            segment_end = segment.start_sample + segment.committed_samples
            if max(start, segment.start_sample) < min(end, segment_end):
                return index
        return None

    def _first_invalid_segment_in_range(
        self,
        case_id: str,
        capture_id: str,
        segments: list[ASRAudioSegment],
        start: int,
        end: int,
    ) -> int | None:
        cursor = start
        first_overlap = self._first_segment_for_range(segments, start, end)
        for index, segment in enumerate(segments):
            segment_start = segment.start_sample
            segment_end = segment_start + segment.committed_samples
            overlap_start = max(start, segment_start)
            overlap_end = min(end, segment_end)
            if overlap_start >= overlap_end:
                continue
            if segment_start > cursor or overlap_start != cursor or not self._segment_matches_metadata(
                case_id,
                capture_id,
                segment,
            ):
                return index
            cursor = overlap_end
        if cursor != end:
            return first_overlap
        return None

    def _segment_matches_metadata(
        self,
        case_id: str,
        capture_id: str,
        segment: ASRAudioSegment,
    ) -> bool:
        try:
            path = self._segment_path(case_id, capture_id, segment)
        except ValueError:
            return False
        if segment.status == "ACTIVE":
            return self._active_segment_matches_metadata(segment, path)
        if segment.status == "FINALIZED":
            return self._finalized_segment_matches_metadata(segment, path)
        return False

    def _active_segment_matches_metadata(self, segment: ASRAudioSegment, path: Path) -> bool:
        try:
            return self._segment_bytes_match_metadata(segment, path.read_bytes())
        except OSError:
            return False

    def _finalized_segment_matches_metadata(self, segment: ASRAudioSegment, path: Path) -> bool:
        try:
            return self._segment_bytes_match_metadata(segment, path.read_bytes())
        except OSError:
            return False

    def _segment_bytes_match_metadata(self, segment: ASRAudioSegment, contents: bytes) -> bool:
        if (
            segment.committed_samples < 0
            or segment.committed_samples > _SEGMENT_SAMPLES
        ):
            return False
        expected_size = _WAV_HEADER_BYTES + segment.committed_samples * _SAMPLE_BYTES
        if segment.status == "ACTIVE":
            if len(contents) < expected_size:
                return False
            return hashlib.sha256(contents[_WAV_HEADER_BYTES:expected_size]).hexdigest() == segment.sha256
        if segment.status == "FINALIZED":
            return (
                segment.finalized_samples == segment.committed_samples
                and len(contents) == expected_size
                and contents[:_WAV_HEADER_BYTES] == self._wav_header(segment.committed_samples)
                and hashlib.sha256(contents).hexdigest() == segment.sha256
            )
        return False

    def _hasher_for(self, path: Path, segment: ASRAudioSegment) -> Any:
        key = str(path)
        hasher = self._segment_hashers.get(key)
        if hasher is not None:
            return hasher
        hasher = self._new_hasher(path, segment.committed_samples)
        if hasher.hexdigest() != segment.sha256:
            raise OSError("active audio segment hash does not match its durable metadata")
        self._segment_hashers[key] = hasher
        return hasher

    @staticmethod
    def _new_hasher(path: Path, sample_count: int) -> Any:
        hasher = hashlib.sha256()
        if sample_count:
            with path.open("rb") as stream:
                stream.seek(_WAV_HEADER_BYTES)
                remaining = sample_count * _SAMPLE_BYTES
                while remaining:
                    chunk = stream.read(min(1024 * 1024, remaining))
                    if not chunk:
                        raise OSError("audio segment is shorter than its durable metadata")
                    hasher.update(chunk)
                    remaining -= len(chunk)
        return hasher

    def _write_wav_chunk(self, path: Path, old_samples: int, new_samples: int, pcm: bytes) -> None:
        path.parent.mkdir(parents=True, exist_ok=True, mode=0o750)
        exists = path.exists()
        if not exists and old_samples:
            raise OSError("durable audio segment is missing")
        if exists:
            stream_context = path.open("r+b")
        else:
            stream_context = self._open_new_audio_file(path)
        with stream_context as stream:
            committed_length = _WAV_HEADER_BYTES + old_samples * _SAMPLE_BYTES
            if exists and stream.seek(0, os.SEEK_END) < committed_length:
                raise OSError("audio segment is shorter than its durable metadata")
            stream.truncate(committed_length)
            stream.seek(committed_length)
            written = stream.write(pcm)
            if written != len(pcm):
                raise OSError("short write while appending audio")
            stream.seek(0)
            if stream.write(self._wav_header(new_samples)) != _WAV_HEADER_BYTES:
                raise OSError("short write while updating WAV header")
            stream.flush()
            os.fsync(stream.fileno())
        if not exists:
            self._fsync_directory(path.parent)

    def _finalize_segment_file(self, segment: ASRAudioSegment, path: Path) -> None:
        digest = self._hash_file(path)
        os.chmod(path, 0o640)
        self._fsync_file(path)
        self._fsync_directory(path.parent)
        archive_repo.update_segment(
            segment,
            finalized_samples=segment.committed_samples,
            sha256=digest,
            status="FINALIZED",
        )
        self._segment_hashers.pop(str(path), None)

    def _repair_wav(self, path: Path, sample_count: int, *, allow_create: bool) -> None:
        path.parent.mkdir(parents=True, exist_ok=True, mode=0o750)
        self._chmod_directory(path.parent)
        exists = path.exists()
        if not exists and not allow_create:
            raise OSError("durable audio segment is missing")
        stream_context = path.open("r+b") if exists else self._open_new_audio_file(path)
        with stream_context as stream:
            target_length = _WAV_HEADER_BYTES + sample_count * _SAMPLE_BYTES
            if exists and stream.seek(0, os.SEEK_END) < target_length:
                raise OSError("audio segment is shorter than its recovery checkpoint")
            stream.truncate(target_length)
            stream.seek(0)
            if stream.write(self._wav_header(sample_count)) != _WAV_HEADER_BYTES:
                raise OSError("short write while repairing WAV header")
            stream.flush()
            os.fsync(stream.fileno())

    @staticmethod
    def _open_new_audio_file(path: Path) -> Any:
        flags = os.O_RDWR | os.O_CREAT | os.O_EXCL | getattr(os, "O_BINARY", 0)
        fd = os.open(path, flags, 0o640)
        try:
            if hasattr(os, "fchmod"):
                os.fchmod(fd, 0o640)
            else:
                os.chmod(path, 0o640)
            return os.fdopen(fd, "r+b")
        except BaseException:
            os.close(fd)
            raise

    @staticmethod
    def _wav_header(sample_count: int) -> bytes:
        data_bytes = sample_count * _SAMPLE_BYTES
        return (
            b"RIFF"
            + struct.pack("<I", 36 + data_bytes)
            + b"WAVEfmt "
            + struct.pack("<IHHIIHH", 16, 1, 1, _SAMPLE_RATE, _SAMPLE_RATE * _SAMPLE_BYTES, _SAMPLE_BYTES, 16)
            + b"data"
            + struct.pack("<I", data_bytes)
        )

    @staticmethod
    def _hash_pcm(path: Path, sample_count: int) -> str:
        return DurableAudioArchive._new_hasher(path, sample_count).hexdigest()

    @staticmethod
    def _hash_file(path: Path) -> str:
        hasher = hashlib.sha256()
        with path.open("rb") as stream:
            for chunk in iter(lambda: stream.read(1024 * 1024), b""):
                hasher.update(chunk)
        return hasher.hexdigest()

    def _segment_path(self, case_id: str, capture_id: str, segment: ASRAudioSegment) -> Path:
        self._validate_id(case_id, "case_id")
        self._validate_id(capture_id, "capture_id")
        relative = PurePosixPath(segment.relative_path)
        if relative.is_absolute() or ".." in relative.parts:
            raise ValueError("audio segment metadata contains an unsafe path")
        expected_relative = PurePosixPath(
            "audio", case_id, capture_id, f"segment-{segment.sequence:06d}.wav"
        )
        if relative != expected_relative:
            raise ValueError("audio segment path does not match its validated identifiers")
        data_root = self.data_dir.resolve()
        archive_root = self.audio_dir.resolve()
        if archive_root != self.audio_dir:
            raise ValueError("audio archive root does not match its canonical path")
        if not archive_root.is_relative_to(data_root):
            raise ValueError("audio archive root escapes data_dir")
        case_dir = self.audio_dir / case_id
        if case_dir.resolve() != case_dir:
            raise ValueError("case directory does not match its canonical archive path")
        capture_dir = self._capture_dir(case_id, capture_id)
        if capture_dir.resolve() != capture_dir:
            raise ValueError("capture directory does not match its canonical archive path")
        expected_path = data_root / Path(*relative.parts)
        path = expected_path.resolve()
        if path != expected_path:
            raise ValueError("audio segment file does not match its canonical archive path")
        if not capture_dir.is_relative_to(archive_root):
            raise ValueError("capture directory escapes the audio archive root")
        if not path.is_relative_to(archive_root) or not path.is_relative_to(capture_dir):
            raise ValueError("audio segment path escapes its capture directory")
        return path

    def _capture_dir(self, case_id: str, capture_id: str) -> Path:
        return self.audio_dir / case_id / capture_id

    def _ensure_capture_dirs(self, case_id: str, capture_id: str) -> None:
        self._validate_id(case_id, "case_id")
        self._validate_id(capture_id, "capture_id")
        root = self.data_dir.resolve()
        self.data_dir.mkdir(parents=True, exist_ok=True, mode=0o750)
        self._chmod_directory(self.data_dir)
        if self.audio_dir.resolve() != self.audio_dir:
            raise ValueError("audio archive root does not match its canonical path")
        audio_exists = self.audio_dir.exists()
        self.audio_dir.mkdir(mode=0o750, exist_ok=True)
        resolved_audio_dir = self.audio_dir.resolve()
        if resolved_audio_dir != self.audio_dir:
            raise ValueError("audio archive root does not match its canonical path")
        if not resolved_audio_dir.is_relative_to(root):
            raise ValueError("audio archive directory escapes data_dir")
        self._chmod_directory(self.audio_dir)
        if not audio_exists:
            self._fsync_directory(self.data_dir)
        self._fsync_directory(self.audio_dir)
        case_dir = self.audio_dir / case_id
        if case_dir.resolve() != case_dir:
            raise ValueError("case directory does not match its canonical archive path")
        case_exists = case_dir.exists()
        case_dir.mkdir(mode=0o750, exist_ok=True)
        resolved_case_dir = case_dir.resolve()
        if resolved_case_dir != case_dir:
            raise ValueError("case directory does not match its canonical archive path")
        if not resolved_case_dir.is_relative_to(resolved_audio_dir):
            raise ValueError("case archive directory escapes audio directory")
        self._chmod_directory(case_dir)
        if not case_exists:
            self._fsync_directory(self.audio_dir)
        self._fsync_directory(case_dir)
        capture_dir = case_dir / capture_id
        if capture_dir.resolve() != capture_dir:
            raise ValueError("capture directory does not match its canonical archive path")
        capture_exists = capture_dir.exists()
        capture_dir.mkdir(mode=0o750, exist_ok=True)
        resolved_capture_dir = capture_dir.resolve()
        if resolved_capture_dir != capture_dir:
            raise ValueError("capture directory does not match its canonical archive path")
        if not resolved_capture_dir.is_relative_to(resolved_case_dir):
            raise ValueError("capture archive directory escapes case directory")
        self._chmod_directory(capture_dir)
        if not capture_exists:
            self._fsync_directory(case_dir)
        self._fsync_directory(capture_dir)

    @staticmethod
    def _validate_id(value: str, name: str) -> None:
        if not isinstance(value, str) or not _CAPTURE_ID.fullmatch(value):
            raise ValueError(f"{name} must be a safe opaque identifier")

    @staticmethod
    def _chmod_directory(path: Path) -> None:
        os.chmod(path, 0o750)

    @staticmethod
    def _fsync_directory(path: Path) -> None:
        if os.name == "nt":
            return
        fd = os.open(path, os.O_RDONLY)
        try:
            os.fsync(fd)
        finally:
            os.close(fd)

    @staticmethod
    def _fsync_file(path: Path) -> None:
        if os.name == "nt":
            return
        with path.open("rb") as stream:
            os.fsync(stream.fileno())

    def _mark_incomplete(self, capture_id: str) -> None:
        try:
            with archive_repo.archive_transaction(self.session_factory) as db:
                archive_repo.mark_capture_incomplete(db, capture_id)
        except Exception:
            # The original append or disk error is more useful to the caller;
            # a failed metadata write cannot be repaired while the DB is full.
            pass

    def _forget_hashers(self, capture_id: str) -> None:
        for key in list(self._segment_hashers):
            if Path(key).parent.name == capture_id:
                self._segment_hashers.pop(key, None)
