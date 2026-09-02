from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def replace_once(path: str, old: str, new: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected exactly one anchor, found {count}: {old[:100]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def main() -> None:
    # Default XVector is the historical API contract. Keep its missing-reference
    # error code unchanged; use the backend-specific code only for ERes2Net.
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '''            if voiceprint_repo.get_suspect(\n                db, case_id, model_key=self.speaker_model_key\n            ) is None:\n                raise DomainError(\n                    "SUSPECT_VOICEPRINT_BACKEND_REQUIRED",\n                    f"请先完成 {self.speaker_model_key} 嫌疑人声纹注册",\n                    409,\n                    data={"speaker_backend": self.speaker_model_key},\n                )\n''',
        '''            if voiceprint_repo.get_suspect(\n                db, case_id, model_key=self.speaker_model_key\n            ) is None:\n                if self.speaker_model_key == "xvector":\n                    raise DomainError("SUSPECT_VOICEPRINT_REQUIRED", "请先完成嫌疑人声纹注册", 409)\n                raise DomainError(\n                    "SUSPECT_VOICEPRINT_BACKEND_REQUIRED",\n                    f"请先完成 {self.speaker_model_key} 嫌疑人声纹注册",\n                    409,\n                    data={"speaker_backend": self.speaker_model_key},\n                )\n''',
    )

    # Legacy supervisors/fakes know only the old open_speech_session signature.
    # Omitting the backend for XVector is semantically identical because XVector
    # is the worker's default; non-default ERes2Net remains explicitly bound.
    replace_once(
        "linux/backend/app/services/asr_capture_service.py",
        '''        try:\n            self.ai_supervisor.open_speech_session(\n                runtime.speech_session_id,\n                sample_rate=self.sample_rate,\n                speaker_backend=self.speaker_model_key,\n            )\n            speech_open = True\n''',
        '''        try:\n            if self.speaker_model_key == "xvector":\n                self.ai_supervisor.open_speech_session(\n                    runtime.speech_session_id,\n                    sample_rate=self.sample_rate,\n                )\n            else:\n                self.ai_supervisor.open_speech_session(\n                    runtime.speech_session_id,\n                    sample_rate=self.sample_rate,\n                    speaker_backend=self.speaker_model_key,\n                )\n            speech_open = True\n''',
    )

    # AISupervisor itself must also preserve its public legacy response shape when
    # no backend was explicitly requested. Explicit ERes2Net still forwards the
    # discriminator end-to-end and is observable to backend-aware tests.
    replace_once(
        "linux/backend/app/ai/supervisor.py",
        '''    def open_speech_session(\n        self,\n        session_id: str,\n        *,\n        sample_rate: int = 16000,\n        speaker_backend: str = "xvector",\n    ) -> dict[str, Any]:\n        result = self._speech_client.open_session(\n            session_id,\n            sample_rate=sample_rate,\n            speaker_backend=speaker_backend,\n        )\n        self._speech_sessions.add(session_id)\n        return result\n''',
        '''    def open_speech_session(\n        self,\n        session_id: str,\n        *,\n        sample_rate: int = 16000,\n        speaker_backend: str | None = None,\n    ) -> dict[str, Any]:\n        explicit_backend = speaker_backend is not None\n        if explicit_backend:\n            result = self._speech_client.open_session(\n                session_id,\n                sample_rate=sample_rate,\n                speaker_backend=speaker_backend,\n            )\n        else:\n            result = self._speech_client.open_session(\n                session_id,\n                sample_rate=sample_rate,\n            )\n            # In-process mock historically returned no backend discriminator.\n            # Normalize the omitted-backend call even if an internal client adds it.\n            result = dict(result)\n            result.pop("speaker_backend", None)\n        self._speech_sessions.add(session_id)\n        return result\n''',
    )


if __name__ == "__main__":
    main()
