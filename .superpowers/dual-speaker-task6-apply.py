# commit: feat: bind sessions to selected speaker backend
from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def replace_once(path: str, old: str, new: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected exactly one anchor, found {count}: {old[:80]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def main() -> None:
    # AISupervisor: preserve the selected embedding space for the full speech session.
    replace_once(
        "linux/backend/app/ai/supervisor.py",
        '    def open_session(self, session_id: str, sample_rate: int = 16000) -> dict[str, Any]:\n'
        '        session_id = str(session_id).strip()\n'
        '        sample_rate = int(sample_rate)\n'
        '        if not session_id:\n'
        '            raise AIError("session_id is required")\n'
        '        if sample_rate <= 0:\n'
        '            raise AIError("sample_rate must be positive")\n'
        '        with self._lock:\n'
        '            self._sessions[session_id] = {"sample_rate": sample_rate, "bytes_received": 0}\n'
        '        return {"session_id": session_id, "sample_rate": sample_rate}\n',
        '    def open_session(\n'
        '        self,\n'
        '        session_id: str,\n'
        '        sample_rate: int = 16000,\n'
        '        speaker_backend: str = "xvector",\n'
        '    ) -> dict[str, Any]:\n'
        '        session_id = str(session_id).strip()\n'
        '        sample_rate = int(sample_rate)\n'
        '        speaker_backend = str(speaker_backend or "xvector").strip().lower()\n'
        '        if not session_id:\n'
        '            raise AIError("session_id is required")\n'
        '        if sample_rate <= 0:\n'
        '            raise AIError("sample_rate must be positive")\n'
        '        if speaker_backend not in {"xvector", "eres2net_large"}:\n'
        '            raise AIError("unsupported speaker backend", details={"speaker_backend": speaker_backend})\n'
        '        with self._lock:\n'
        '            self._sessions[session_id] = {\n'
        '                "sample_rate": sample_rate,\n'
        '                "bytes_received": 0,\n'
        '                "speaker_backend": speaker_backend,\n'
        '            }\n'
        '        return {\n'
        '            "session_id": session_id,\n'
        '            "sample_rate": sample_rate,\n'
        '            "speaker_backend": speaker_backend,\n'
        '        }\n',
    )
    replace_once(
        "linux/backend/app/ai/supervisor.py",
        '    def open_speech_session(self, session_id: str, *, sample_rate: int = 16000) -> dict[str, Any]:\n'
        '        result = self._speech_client.open_session(session_id, sample_rate=sample_rate)\n'
        '        self._speech_sessions.add(session_id)\n'
        '        return result\n',
        '    def open_speech_session(\n'
        '        self,\n'
        '        session_id: str,\n'
        '        *,\n'
        '        sample_rate: int = 16000,\n'
        '        speaker_backend: str = "xvector",\n'
        '    ) -> dict[str, Any]:\n'
        '        result = self._speech_client.open_session(\n'
        '            session_id,\n'
        '            sample_rate=sample_rate,\n'
        '            speaker_backend=speaker_backend,\n'
        '        )\n'
        '        self._speech_sessions.add(session_id)\n'
        '        return result\n',
    )

    # VoiceprintService: readiness and role freezing must operate in one model space only.
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        'class VoiceprintService:\n'
        '    def __init__(self, db: Session, *, speech_client: Any):\n'
        '        self.db = db\n'
        '        self.speech_client = speech_client\n',
        'class VoiceprintService:\n'
        '    def __init__(\n'
        '        self,\n'
        '        db: Session,\n'
        '        *,\n'
        '        speech_client: Any,\n'
        '        speaker_model_key: str = _XVECTOR,\n'
        '    ):\n'
        '        self.db = db\n'
        '        self.speech_client = speech_client\n'
        '        self.speaker_model_key = str(speaker_model_key or _XVECTOR).strip().lower()\n'
        '        if self.speaker_model_key not in _ENROLLMENT_BACKENDS:\n'
        '            raise ValueError("speaker_model_key must be xvector or eres2net_large")\n',
    )
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '        suspect = voiceprint_repo.get_suspect(self.db, case_id)\n'
        '        interrogator_ready = False\n'
        '        recorder_ready = False\n',
        '        suspect = voiceprint_repo.get_suspect(\n'
        '            self.db, case_id, model_key=self.speaker_model_key\n'
        '        )\n'
        '        interrogator_ready = False\n'
        '        recorder_ready = False\n',
    )
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '                interrogator_ready = self._officer_active(assignment.interrogator_officer_id)\n'
        '                recorder_ready = self._officer_active(assignment.recorder_officer_id)\n',
        '                interrogator_ready = self._officer_active(\n'
        '                    assignment.interrogator_officer_id, self.speaker_model_key\n'
        '                )\n'
        '                recorder_ready = self._officer_active(\n'
        '                    assignment.recorder_officer_id, self.speaker_model_key\n'
        '                )\n',
    )
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '        return {\n'
        '            "suspectReady": suspect is not None,\n'
        '            "interrogatorReady": interrogator_ready,\n',
        '        return {\n'
        '            "selectedSpeakerBackend": self.speaker_model_key,\n'
        '            "suspectReady": suspect is not None,\n'
        '            "interrogatorReady": interrogator_ready,\n',
    )
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '        suspect = voiceprint_repo.get_suspect(self.db, case_id)\n'
        '        if suspect is None:\n'
        '            raise DomainError("SUSPECT_VOICEPRINT_REQUIRED", "请先完成嫌疑人声纹注册", 409)\n',
        '        suspect = voiceprint_repo.get_suspect(\n'
        '            self.db, case_id, model_key=self.speaker_model_key\n'
        '        )\n'
        '        if suspect is None:\n'
        '            raise DomainError(\n'
        '                "SUSPECT_VOICEPRINT_BACKEND_REQUIRED",\n'
        '                f"请先完成 {self.speaker_model_key} 嫌疑人声纹注册",\n'
        '                409,\n'
        '                data={"speaker_backend": self.speaker_model_key},\n'
        '            )\n',
    )
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '            interrogator_officer_id=self._optional_id(interrogator_officer_id),\n'
        '            recorder_officer_id=self._optional_id(recorder_officer_id),\n'
        '        )\n',
        '            interrogator_officer_id=self._optional_id(interrogator_officer_id),\n'
        '            recorder_officer_id=self._optional_id(recorder_officer_id),\n'
        '            model_key=self.speaker_model_key,\n'
        '        )\n',
    )
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '        return {\n'
        '            "sessionId": session.id,\n'
        '            "assignmentId": assignment.id,\n',
        '        return {\n'
        '            "sessionId": session.id,\n'
        '            "assignmentId": assignment.id,\n'
        '            "selectedSpeakerBackend": self.speaker_model_key,\n',
    )
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '    def _officer_active(self, officer_id: str | None) -> bool:\n'
        '        return bool(officer_id and voiceprint_repo.get_officer(self.db, officer_id) is not None)\n',
        '    def _officer_active(self, officer_id: str | None, model_key: str | None = None) -> bool:\n'
        '        return bool(\n'
        '            officer_id\n'
        '            and voiceprint_repo.get_officer(\n'
        '                self.db,\n'
        '                officer_id,\n'
        '                model_key=model_key or self.speaker_model_key,\n'
        '            ) is not None\n'
        '        )\n',
    )

    # Formal capture: require and compare references from the selected backend only.
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '        capture_finished_sink: CaptureFinishedSink | None = None,\n'
        '    ) -> None:\n',
        '        capture_finished_sink: CaptureFinishedSink | None = None,\n'
        '        speaker_model_key: str = "xvector",\n'
        '    ) -> None:\n',
    )
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '        self.capture_finished_sink = capture_finished_sink\n'
        '        if self.sample_rate <= 0:\n',
        '        self.capture_finished_sink = capture_finished_sink\n'
        '        self.speaker_model_key = str(speaker_model_key or "xvector").strip().lower()\n'
        '        if self.speaker_model_key not in {"xvector", "eres2net_large"}:\n'
        '            raise ValueError("speaker_model_key must be xvector or eres2net_large")\n'
        '        if self.sample_rate <= 0:\n',
    )
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '            if voiceprint_repo.get_suspect(db, case_id) is None:\n'
        '                raise DomainError("SUSPECT_VOICEPRINT_REQUIRED", "请先完成嫌疑人声纹注册", 409)\n',
        '            if voiceprint_repo.get_suspect(\n'
        '                db, case_id, model_key=self.speaker_model_key\n'
        '            ) is None:\n'
        '                raise DomainError(\n'
        '                    "SUSPECT_VOICEPRINT_BACKEND_REQUIRED",\n'
        '                    f"请先完成 {self.speaker_model_key} 嫌疑人声纹注册",\n'
        '                    409,\n'
        '                    data={"speaker_backend": self.speaker_model_key},\n'
        '                )\n',
    )
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '            self.ai_supervisor.open_speech_session(runtime.speech_session_id, sample_rate=self.sample_rate)\n',
        '            self.ai_supervisor.open_speech_session(\n'
        '                runtime.speech_session_id,\n'
        '                sample_rate=self.sample_rate,\n'
        '                speaker_backend=self.speaker_model_key,\n'
        '            )\n',
    )
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '        suspect = voiceprint_repo.get_suspect(db, case.id)\n'
        '        if suspect is None:\n'
        '            raise DomainError("SUSPECT_VOICEPRINT_REQUIRED", "嫌疑人声纹不可用", 409)\n',
        '        suspect = voiceprint_repo.get_suspect(\n'
        '            db, case.id, model_key=self.speaker_model_key\n'
        '        )\n'
        '        if suspect is None:\n'
        '            raise DomainError(\n'
        '                "SUSPECT_VOICEPRINT_BACKEND_REQUIRED",\n'
        '                f"{self.speaker_model_key} 嫌疑人声纹不可用",\n'
        '                409,\n'
        '                data={"speaker_backend": self.speaker_model_key},\n'
        '            )\n',
    )
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '            "sampleRate": self.sample_rate,\n'
        '            "speakerThreshold": runtime.speaker_threshold,\n',
        '            "sampleRate": self.sample_rate,\n'
        '            "speakerModelKey": self.speaker_model_key,\n'
        '            "speakerThreshold": runtime.speaker_threshold,\n',
    )

    # Source-aware coordinator and app wiring carry RuntimeSettings.speaker_backend through.
    replace_once(
        "linux/backend/app/services/source_aware_asr_capture_service.py",
        '        capture_finished_sink: Callable[[str, str], None] | None = None,\n'
        '    ) -> None:\n',
        '        capture_finished_sink: Callable[[str, str], None] | None = None,\n'
        '        speaker_model_key: str = "xvector",\n'
        '    ) -> None:\n',
    )
    replace_once(
        "linux/backend/app/services/source_aware_asr_capture_service.py",
        '        self.capture_finished_sink = capture_finished_sink\n'
        '        self._lock = threading.RLock()\n',
        '        self.capture_finished_sink = capture_finished_sink\n'
        '        self.speaker_model_key = str(speaker_model_key or "xvector").strip().lower()\n'
        '        self._lock = threading.RLock()\n',
    )
    replace_once(
        "linux/backend/app/services/source_aware_asr_capture_service.py",
        '                capture_finished_sink=capture_finished_sink,\n'
        '            )\n',
        '                capture_finished_sink=capture_finished_sink,\n'
        '                speaker_model_key=self.speaker_model_key,\n'
        '            )\n',
    )
    replace_once(
        "linux/backend/app/main.py",
        '            capture_finished_sink=None if routing_coordinator is None else routing_coordinator.flush_capture,\n'
        '        )\n',
        '            capture_finished_sink=None if routing_coordinator is None else routing_coordinator.flush_capture,\n'
        '            speaker_model_key=settings.speaker_backend,\n'
        '        )\n',
    )

    # HTTP readiness/binding uses the same runtime-selected backend as capture.
    replace_once(
        "linux/backend/app/api/voiceprints.py",
        'def _service(request: Request, db: Session) -> VoiceprintService:\n'
        '    return VoiceprintService(db, speech_client=_speech_client(request))\n',
        'def _service(request: Request, db: Session) -> VoiceprintService:\n'
        '    settings = getattr(request.app.state, "runtime_settings", None)\n'
        '    speaker_model_key = getattr(settings, "speaker_backend", "xvector")\n'
        '    return VoiceprintService(\n'
        '        db,\n'
        '        speech_client=_speech_client(request),\n'
        '        speaker_model_key=speaker_model_key,\n'
        '    )\n',
    )


if __name__ == "__main__":
    main()
