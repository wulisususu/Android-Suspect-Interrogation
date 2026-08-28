from __future__ import annotations

import logging
import math
import struct
import threading
from dataclasses import dataclass, field
from typing import Any, Callable
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import sessionmaker

from app.ai.speech.types import SpeechEvent, SpeechEventType
from app.database.models import (
    ASRCaptureSession,
    OfficerVoiceprint,
    SessionVoiceAssignment,
)
from app.domain.errors import DomainError
from app.repositories import asr_fragments as asr_repo
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.repositories import voiceprints as voiceprint_repo
from app.services.interrogation_projection_service import InterrogationProjectionService
from app.services.speaker_policy import SpeakerRole, decide_speaker


logger = logging.getLogger(__name__)
PublishEvent = Callable[[str, str, dict[str, Any]], None]
_FLOAT32_BYTES = 4


@dataclass
class _CaptureRuntime:
    case_id: str
    interrogation_session_id: str
    capture_session_id: str
    speech_session_id: str
    stop_event: threading.Event = field(default_factory=threading.Event)
    thread: threading.Thread | None = None
    ordinal: int = 0
    seen_utterances: set[tuple[int, int]] = field(default_factory=set)


@dataclass
class _PreparationRuntime:
    case_id: str
    speech_session_id: str
    stop_event: threading.Event = field(default_factory=threading.Event)
    thread: threading.Thread | None = None
    text_parts: list[str] = field(default_factory=list)
    seen_utterances: set[tuple[int, int]] = field(default_factory=set)
    last_error: str | None = None


class AsrCaptureService:
    """Own the single ALSA -> speech-worker audio path.

    Formal interrogation capture persists speaker-attributed ASR fragments and
    drives the template projection. Question-preparation dictation deliberately
    reuses the same offline speech runtime and microphone but remains memory-only:
    it has no interrogation session, requires no voiceprint, emits no dialogue
    events, and writes no ASR capture/fragment rows.
    """

    def __init__(
        self,
        *,
        session_factory: sessionmaker,
        device_manager: Any,
        ai_supervisor: Any,
        publish_event: PublishEvent,
        sample_rate: int = 16_000,
        read_timeout: float = 0.2,
    ) -> None:
        self.session_factory = session_factory
        self.device_manager = device_manager
        self.ai_supervisor = ai_supervisor
        self.publish_event = publish_event
        self.sample_rate = int(sample_rate)
        self.read_timeout = max(0.001, float(read_timeout))
        if self.sample_rate <= 0:
            raise ValueError("sample_rate must be positive")

        self._lock = threading.RLock()
        self._active: dict[str, _CaptureRuntime] = {}
        self._last_error: dict[str, str | None] = {}
        self._preparation: dict[str, _PreparationRuntime] = {}
        self._preparation_results: dict[str, dict[str, Any]] = {}

    def start(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        if not case_id:
            raise DomainError("CASE_ID_REQUIRED", "案件编号不能为空", 400)
        self._require_calibration()

        with self._lock:
            existing = self._active.get(case_id)
            if existing is not None and existing.thread is not None and existing.thread.is_alive():
                raise DomainError("ASR_CAPTURE_ALREADY_ACTIVE", "该案件正在进行语音采集", 409)
            if self._any_preparation_active_locked():
                raise DomainError("ASR_AUDIO_RESOURCE_BUSY", "准备阶段语音输入正在占用麦克风", 409)

        with self.session_factory() as db:
            case_repo.get(db, case_id)
            interrogation_session = session_repo.active_for_case(db, case_id)
            if interrogation_session is None:
                raise DomainError("SESSION_NOT_ACTIVE", "请先开始审讯再启动语音采集", 409)
            if voiceprint_repo.get_suspect(db, case_id) is None:
                raise DomainError("SUSPECT_VOICEPRINT_REQUIRED", "请先完成嫌疑人声纹注册", 409)
            capture = asr_repo.create_capture_session(
                db,
                case_id=case_id,
                interrogation_session_id=interrogation_session.id,
                sample_rate=self.sample_rate,
            )
            db.commit()
            capture_session_id = capture.id
            interrogation_session_id = interrogation_session.id

        runtime = _CaptureRuntime(
            case_id=case_id,
            interrogation_session_id=interrogation_session_id,
            capture_session_id=capture_session_id,
            speech_session_id=capture_session_id,
        )

        speech_open = False
        audio_started = False
        try:
            self.ai_supervisor.open_speech_session(runtime.speech_session_id, sample_rate=self.sample_rate)
            speech_open = True
            self.device_manager.start_record()
            audio_started = True
        except Exception:
            if audio_started:
                self._safe_stop_audio()
            if speech_open:
                self._safe_finalize_close(runtime.speech_session_id)
            self._finish_capture_row(runtime.capture_session_id)
            raise

        thread = threading.Thread(
            target=self._capture_loop,
            args=(runtime,),
            daemon=True,
            name=f"asr-capture-{capture_session_id[:8]}",
        )
        runtime.thread = thread
        with self._lock:
            self._last_error[case_id] = None
            self._active[case_id] = runtime
        thread.start()
        return self._runtime_status(runtime, active=True, last_error=None)

    def stop(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        with self._lock:
            runtime = self._active.get(case_id)
        if runtime is None:
            return self.status(case_id)

        runtime.stop_event.set()
        thread = runtime.thread
        if thread is not None and thread is not threading.current_thread():
            thread.join(timeout=max(1.0, self.read_timeout * 5.0))
            if thread.is_alive():
                raise DomainError("ASR_CAPTURE_STOP_TIMEOUT", "语音采集线程未能及时停止", 504)
        return self.status(case_id)

    def status(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        with self._lock:
            runtime = self._active.get(case_id)
            last_error = self._last_error.get(case_id)
        if runtime is not None and runtime.thread is not None and runtime.thread.is_alive():
            return self._runtime_status(runtime, active=True, last_error=last_error)

        with self.session_factory() as db:
            capture = db.scalar(
                select(ASRCaptureSession)
                .where(ASRCaptureSession.case_id == case_id)
                .order_by(ASRCaptureSession.started_at.desc())
                .limit(1)
            )
            if capture is None:
                return {
                    "caseId": case_id,
                    "active": False,
                    "captureSessionId": None,
                    "interrogationSessionId": None,
                    "status": "IDLE",
                    "lastError": last_error,
                }
            return {
                "caseId": case_id,
                "active": False,
                "captureSessionId": capture.id,
                "interrogationSessionId": capture.interrogation_session_id,
                "status": capture.status,
                "sampleRate": capture.sample_rate,
                "startedAt": capture.started_at.isoformat() if capture.started_at is not None else None,
                "endedAt": capture.ended_at.isoformat() if capture.ended_at is not None else None,
                "lastError": last_error,
            }

    def start_preparation(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        if not case_id:
            raise DomainError("CASE_ID_REQUIRED", "案件编号不能为空", 400)

        with self.session_factory() as db:
            case_repo.get(db, case_id)

        with self._lock:
            if self._any_capture_active_locked():
                raise DomainError("ASR_AUDIO_RESOURCE_BUSY", "正式审讯录音正在占用麦克风", 409)
            if self._any_preparation_active_locked():
                raise DomainError("ASR_PREPARATION_ALREADY_ACTIVE", "已有准备阶段语音输入正在进行", 409)

        runtime = _PreparationRuntime(
            case_id=case_id,
            speech_session_id=f"question-prep-{case_id}-{uuid4().hex}",
        )
        speech_open = False
        audio_started = False
        try:
            self.ai_supervisor.open_speech_session(runtime.speech_session_id, sample_rate=self.sample_rate)
            speech_open = True
            self.device_manager.start_record()
            audio_started = True
        except Exception:
            if audio_started:
                self._safe_stop_audio()
            if speech_open:
                self._safe_finalize_close(runtime.speech_session_id)
            raise

        thread = threading.Thread(
            target=self._preparation_loop,
            args=(runtime,),
            daemon=True,
            name=f"question-prep-{case_id[:12]}",
        )
        runtime.thread = thread
        with self._lock:
            self._preparation[case_id] = runtime
            self._preparation_results.pop(case_id, None)
        thread.start()
        return self._preparation_status(runtime, active=True)

    def stop_preparation(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        with self._lock:
            runtime = self._preparation.get(case_id)
            prior_result = self._preparation_results.get(case_id)
        if runtime is None:
            if prior_result is not None:
                return dict(prior_result)
            return self._empty_preparation_status(case_id)

        runtime.stop_event.set()
        thread = runtime.thread
        if thread is not None and thread is not threading.current_thread():
            thread.join(timeout=max(1.0, self.read_timeout * 5.0))
            if thread.is_alive():
                raise DomainError("ASR_PREPARATION_STOP_TIMEOUT", "准备阶段语音输入未能及时停止", 504)

        with self._lock:
            result = self._preparation_results.get(case_id)
        return dict(result) if result is not None else self._preparation_status(runtime, active=False)

    def shutdown(self) -> None:
        with self._lock:
            case_ids = list(self._active)
            preparation_case_ids = list(self._preparation)
        for case_id in case_ids:
            try:
                self.stop(case_id)
            except Exception:
                pass
        for case_id in preparation_case_ids:
            try:
                self.stop_preparation(case_id)
            except Exception:
                pass

    def _capture_loop(self, runtime: _CaptureRuntime) -> None:
        failure: Exception | None = None
        try:
            while not runtime.stop_event.is_set():
                pcm = self.device_manager.read_audio_frames(timeout=self.read_timeout)
                if not pcm:
                    continue
                events = self.ai_supervisor.push_speech_pcm(runtime.speech_session_id, bytes(pcm))
                self._consume_events(runtime, events)
        except Exception as exc:
            failure = exc
        finally:
            try:
                final_events = self.ai_supervisor.finalize_speech_session(runtime.speech_session_id)
                self._consume_events(runtime, final_events)
            except Exception as exc:
                if failure is None:
                    failure = exc
            try:
                self.ai_supervisor.close_speech_session(runtime.speech_session_id)
            except Exception as exc:
                if failure is None:
                    failure = exc
            try:
                self.device_manager.stop_record()
            except Exception as exc:
                if failure is None:
                    failure = exc
            try:
                self._finish_capture_row(runtime.capture_session_id)
            except Exception as exc:
                if failure is None:
                    failure = exc

            with self._lock:
                if self._active.get(runtime.case_id) is runtime:
                    self._active.pop(runtime.case_id, None)
                self._last_error[runtime.case_id] = None if failure is None else str(failure)

    def _preparation_loop(self, runtime: _PreparationRuntime) -> None:
        failure: Exception | None = None
        try:
            while not runtime.stop_event.is_set():
                pcm = self.device_manager.read_audio_frames(timeout=self.read_timeout)
                if not pcm:
                    continue
                events = self.ai_supervisor.push_speech_pcm(runtime.speech_session_id, bytes(pcm))
                self._consume_preparation_events(runtime, events)
        except Exception as exc:
            failure = exc
        finally:
            try:
                final_events = self.ai_supervisor.finalize_speech_session(runtime.speech_session_id)
                self._consume_preparation_events(runtime, final_events)
            except Exception as exc:
                if failure is None:
                    failure = exc
            try:
                self.ai_supervisor.close_speech_session(runtime.speech_session_id)
            except Exception as exc:
                if failure is None:
                    failure = exc
            try:
                self.device_manager.stop_record()
            except Exception as exc:
                if failure is None:
                    failure = exc

            runtime.last_error = None if failure is None else str(failure)
            result = self._preparation_status(runtime, active=False)
            with self._lock:
                if self._preparation.get(runtime.case_id) is runtime:
                    self._preparation.pop(runtime.case_id, None)
                self._preparation_results[runtime.case_id] = result

    def _consume_preparation_events(
        self,
        runtime: _PreparationRuntime,
        events: list[SpeechEvent] | None,
    ) -> None:
        if not events:
            return
        for event in events:
            if event.type is not SpeechEventType.ASR_FINAL:
                continue
            text = str(event.text or "").strip()
            if not text:
                continue
            if event.start_ms is not None and event.end_ms is not None:
                key = (int(event.start_ms), int(event.end_ms))
                if key in runtime.seen_utterances:
                    continue
                runtime.seen_utterances.add(key)
            runtime.text_parts.append(text)

    def _consume_events(self, runtime: _CaptureRuntime, events: list[SpeechEvent] | None) -> None:
        if not events:
            return
        asr_by_range: dict[tuple[int, int], SpeechEvent] = {}
        speaker_by_range: dict[tuple[int, int], SpeechEvent] = {}
        for event in events:
            if event.start_ms is None or event.end_ms is None:
                continue
            key = (int(event.start_ms), int(event.end_ms))
            if event.type is SpeechEventType.ASR_FINAL:
                asr_by_range[key] = event
            elif event.type is SpeechEventType.SPEAKER_RESULT:
                speaker_by_range[key] = event

        for key, asr_event in asr_by_range.items():
            if key in runtime.seen_utterances:
                continue
            self._persist_fragment(runtime, key, asr_event, speaker_by_range.get(key))
            runtime.seen_utterances.add(key)

    def _persist_fragment(
        self,
        runtime: _CaptureRuntime,
        bounds: tuple[int, int],
        asr_event: SpeechEvent,
        speaker_event: SpeechEvent | None,
    ) -> None:
        start_ms, end_ms = bounds
        with self.session_factory() as db:
            case = case_repo.get(db, runtime.case_id)
            candidates, enabled_roles = self._speaker_candidates(
                db,
                case=case,
                interrogation_session_id=runtime.interrogation_session_id,
                speaker_event=speaker_event,
            )
            decision = decide_speaker(
                candidates=candidates,
                enabled_roles=enabled_roles,
                threshold=float(self.ai_supervisor.speaker_accept_threshold),
                margin=float(self.ai_supervisor.speaker_margin),
                usable_duration_ms=max(0, end_ms - start_ms),
                overlap=bool(
                    (asr_event.details or {}).get("overlap")
                    or (speaker_event is not None and (speaker_event.details or {}).get("overlap"))
                ),
            )
            fragment = asr_repo.create_fragment(
                db,
                capture_session_id=runtime.capture_session_id,
                case_id=runtime.case_id,
                ordinal=runtime.ordinal,
                started_at_ms=start_ms,
                ended_at_ms=end_ms,
                raw_text=str(asr_event.text or ""),
                asr_confidence=asr_event.confidence,
                speaker=decision.role.value,
                speaker_id=decision.speaker_id,
                speaker_name=decision.speaker_name,
                speaker_score=decision.score,
                second_best_score=decision.second_best_score,
                speaker_threshold=decision.threshold,
                speaker_margin=decision.margin,
                speaker_source=decision.source.value,
                voiceprint_verified=decision.voiceprint_verified,
                low_confidence=decision.low_confidence,
                model_id=str(asr_event.model_id or "paraformer"),
                model_version=self._optional_text((asr_event.details or {}).get("model_version")),
            )
            self._audit_speaker_decision(
                db,
                case_id=runtime.case_id,
                fragment_id=fragment.id,
                decision=decision,
                usable_duration_ms=max(0, end_ms - start_ms),
                asr_event=asr_event,
            )
            db.commit()
            fragment_id = fragment.id
            payload = self._fragment_payload(fragment)

        runtime.ordinal += 1
        self.publish_event(runtime.interrogation_session_id, "ASR_FRAGMENT", payload)
        try:
            with self.session_factory() as projection_db:
                InterrogationProjectionService(projection_db).process_fragment(runtime.case_id, fragment_id)
                projection_db.commit()
        except Exception:
            logger.exception("formal interrogation projection failed for fragment %s", fragment_id)

    @staticmethod
    def _audit_speaker_decision(
        db,
        *,
        case_id: str,
        fragment_id: str,
        decision,
        usable_duration_ms: int,
        asr_event: SpeechEvent,
    ) -> None:
        if decision.role is SpeakerRole.OFFICER_FALLBACK:
            action = "ASR_SPEAKER_FALLBACK"
        elif decision.low_confidence:
            action = "ASR_SPEAKER_LOW_CONFIDENCE"
        else:
            return

        event_details = asr_event.details or {}
        detail: dict[str, Any] = {
            "score": decision.score,
            "second_best_score": decision.second_best_score,
            "threshold": decision.threshold,
            "margin": decision.margin,
            "usable_duration_ms": int(usable_duration_ms),
        }
        if event_details.get("speaker_unavailable"):
            detail["speaker_unavailable"] = True
            error_code = event_details.get("speaker_error_code")
            if error_code:
                detail["speaker_error_code"] = str(error_code)

        audit_repo.add(
            db,
            case_id=case_id,
            action=action,
            target_type="ASR_FRAGMENT",
            target_id=fragment_id,
            after={
                "speaker": decision.role.value,
                "speaker_source": decision.source.value,
                "voiceprint_verified": decision.voiceprint_verified,
                "low_confidence": decision.low_confidence,
            },
            detail=detail,
        )

    def _speaker_candidates(
        self,
        db,
        *,
        case,
        interrogation_session_id: str,
        speaker_event: SpeechEvent | None,
    ) -> tuple[list[dict[str, Any]], set[SpeakerRole]]:
        embedding = self._normalize_vector(speaker_event.embedding if speaker_event is not None else None)
        suspect = voiceprint_repo.get_suspect(db, case.id)
        if suspect is None:
            raise DomainError("SUSPECT_VOICEPRINT_REQUIRED", "嫌疑人声纹不可用", 409)

        enabled: set[SpeakerRole] = {SpeakerRole.SUSPECT}
        references: list[tuple[SpeakerRole, Any, str | None, str | None]] = [
            (SpeakerRole.SUSPECT, suspect, suspect.id, case.suspect_name),
        ]
        assignment = db.scalar(
            select(SessionVoiceAssignment).where(
                SessionVoiceAssignment.session_id == interrogation_session_id
            )
        )
        if assignment is not None:
            self._append_officer_reference(
                db,
                references,
                enabled,
                SpeakerRole.INTERROGATOR,
                assignment.interrogator_voiceprint_id,
            )
            self._append_officer_reference(
                db,
                references,
                enabled,
                SpeakerRole.RECORDER,
                assignment.recorder_voiceprint_id,
            )

        candidates: list[dict[str, Any]] = []
        if embedding is None:
            return candidates, enabled
        for role, row, speaker_id, speaker_name in references:
            reference = self._decode_embedding(row.embedding, row.embedding_dim)
            score = self._cosine(embedding, reference)
            if score is None:
                continue
            candidates.append(
                {
                    "role": role,
                    "score": score,
                    "speaker_id": speaker_id,
                    "speaker_name": speaker_name,
                }
            )
        return candidates, enabled

    @staticmethod
    def _append_officer_reference(
        db,
        references: list[tuple[SpeakerRole, Any, str | None, str | None]],
        enabled: set[SpeakerRole],
        role: SpeakerRole,
        voiceprint_id: str | None,
    ) -> None:
        if not voiceprint_id:
            return
        officer = db.get(OfficerVoiceprint, voiceprint_id)
        if officer is None or not officer.active or officer.revoked_at is not None:
            return
        enabled.add(role)
        references.append((role, officer, officer.officer_id, officer.officer_name))

    def _require_calibration(self) -> None:
        if (
            getattr(self.ai_supervisor, "speaker_accept_threshold", None) is None
            or getattr(self.ai_supervisor, "speaker_margin", None) is None
        ):
            raise DomainError(
                "SPEAKER_CALIBRATION_REQUIRED",
                "声纹阈值和区分 margin 尚未完成设备实测校准",
                503,
            )

    def _finish_capture_row(self, capture_session_id: str) -> None:
        with self.session_factory() as db:
            capture = db.get(ASRCaptureSession, capture_session_id)
            if capture is not None and capture.status != "STOPPED":
                asr_repo.finish_capture_session(db, capture_session_id=capture_session_id)
                db.commit()

    def _safe_stop_audio(self) -> None:
        try:
            self.device_manager.stop_record()
        except Exception:
            pass

    def _safe_finalize_close(self, speech_session_id: str) -> None:
        try:
            self.ai_supervisor.finalize_speech_session(speech_session_id)
        except Exception:
            pass
        try:
            self.ai_supervisor.close_speech_session(speech_session_id)
        except Exception:
            pass

    def _any_capture_active_locked(self) -> bool:
        return any(
            runtime.thread is not None and runtime.thread.is_alive()
            for runtime in self._active.values()
        )

    def _any_preparation_active_locked(self) -> bool:
        return any(
            runtime.thread is not None and runtime.thread.is_alive()
            for runtime in self._preparation.values()
        )

    @staticmethod
    def _decode_embedding(blob: bytes, dimension: int) -> list[float] | None:
        try:
            dimension = int(dimension)
            raw = bytes(blob)
        except (TypeError, ValueError):
            return None
        if dimension <= 0 or len(raw) != dimension * _FLOAT32_BYTES:
            return None
        try:
            return [float(value) for value in struct.unpack(f"<{dimension}f", raw)]
        except struct.error:
            return None

    @staticmethod
    def _normalize_vector(value: Any) -> list[float] | None:
        if not isinstance(value, (list, tuple)) or not value:
            return None
        try:
            vector = [float(item) for item in value]
        except (TypeError, ValueError):
            return None
        if not all(math.isfinite(item) for item in vector):
            return None
        norm = math.sqrt(sum(item * item for item in vector))
        if norm <= 0.0:
            return None
        return [item / norm for item in vector]

    @classmethod
    def _cosine(cls, left: list[float], right: list[float] | None) -> float | None:
        if right is None or len(left) != len(right):
            return None
        normalized_right = cls._normalize_vector(right)
        if normalized_right is None:
            return None
        score = sum(a * b for a, b in zip(left, normalized_right))
        return max(-1.0, min(1.0, float(score)))

    @staticmethod
    def _optional_text(value: Any) -> str | None:
        if value is None:
            return None
        text = str(value).strip()
        return text or None

    @staticmethod
    def _fragment_payload(fragment) -> dict[str, Any]:
        return {
            "fragmentId": fragment.id,
            "captureSessionId": fragment.capture_session_id,
            "caseId": fragment.case_id,
            "ordinal": fragment.ordinal,
            "startedAtMs": fragment.started_at_ms,
            "endedAtMs": fragment.ended_at_ms,
            "rawText": fragment.raw_text,
            "editedText": fragment.edited_text,
            "asrConfidence": fragment.asr_confidence,
            "speaker": fragment.speaker,
            "speakerId": fragment.speaker_id,
            "speakerName": fragment.speaker_name,
            "speakerScore": fragment.speaker_score,
            "secondBestScore": fragment.second_best_score,
            "speakerThreshold": fragment.speaker_threshold,
            "speakerMargin": fragment.speaker_margin,
            "speakerSource": fragment.speaker_source,
            "voiceprintVerified": fragment.voiceprint_verified,
            "lowConfidence": fragment.low_confidence,
            "state": fragment.state,
            "modelId": fragment.model_id,
            "modelVersion": fragment.model_version,
        }

    def _runtime_status(
        self,
        runtime: _CaptureRuntime,
        *,
        active: bool,
        last_error: str | None,
    ) -> dict[str, Any]:
        return {
            "caseId": runtime.case_id,
            "active": active,
            "captureSessionId": runtime.capture_session_id,
            "interrogationSessionId": runtime.interrogation_session_id,
            "status": "CAPTURING" if active else "STOPPED",
            "sampleRate": self.sample_rate,
            "lastError": last_error,
        }

    def _preparation_status(self, runtime: _PreparationRuntime, *, active: bool) -> dict[str, Any]:
        return {
            "caseId": runtime.case_id,
            "active": active,
            "mode": "QUESTION_PREP",
            "captureSessionId": None,
            "interrogationSessionId": None,
            "status": "CAPTURING" if active else "STOPPED",
            "sampleRate": self.sample_rate,
            "text": "".join(runtime.text_parts),
            "lastError": runtime.last_error,
        }

    def _empty_preparation_status(self, case_id: str) -> dict[str, Any]:
        return {
            "caseId": case_id,
            "active": False,
            "mode": "QUESTION_PREP",
            "captureSessionId": None,
            "interrogationSessionId": None,
            "status": "IDLE",
            "sampleRate": self.sample_rate,
            "text": "",
            "lastError": None,
        }
