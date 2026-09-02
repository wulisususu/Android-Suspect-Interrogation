from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def replace_once(path: str, old: str, new: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected one compatibility anchor, found {count}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def main() -> None:
    # Preserve the legacy readiness response shape for the default XVector path.
    # Non-default backend selection is explicit and exposes the backend discriminator.
    replace_once(
        "linux/backend/app/services/voiceprint_service.py",
        '        return {\n'
        '            "selectedSpeakerBackend": self.speaker_model_key,\n'
        '            "suspectReady": suspect is not None,\n'
        '            "interrogatorReady": interrogator_ready,\n'
        '            "recorderReady": recorder_ready,\n'
        '            "recognitionMode": "SUSPECT_ONLY",\n'
        '            "canStart": suspect is not None,\n'
        '        }\n',
        '        result = {\n'
        '            "suspectReady": suspect is not None,\n'
        '            "interrogatorReady": interrogator_ready,\n'
        '            "recorderReady": recorder_ready,\n'
        '            "recognitionMode": "SUSPECT_ONLY",\n'
        '            "canStart": suspect is not None,\n'
        '        }\n'
        '        if self.speaker_model_key != _XVECTOR:\n'
        '            result["selectedSpeakerBackend"] = self.speaker_model_key\n'
        '        return result\n',
    )

    # An omitted backend is the legacy call form. Still send XVector to the worker,
    # but strip the additive discriminator from the returned legacy response.
    replace_once(
        "linux/backend/app/ai/speech/client.py",
        '    def open_session(\n'
        '        self,\n'
        '        session_id: str,\n'
        '        sample_rate: int = 16000,\n'
        '        *,\n'
        '        speaker_backend: str = "xvector",\n'
        '    ) -> dict[str, Any]:\n'
        '        backend_key = str(speaker_backend or "xvector").strip().lower()\n'
        '        if not backend_key:\n'
        '            raise ValueError("speaker_backend must not be empty")\n'
        '        return self._require_dict(\n'
        '            self._request(\n'
        '                "open_session",\n'
        '                session_id=session_id,\n'
        '                sample_rate=int(sample_rate),\n'
        '                speaker_backend=backend_key,\n'
        '            )\n'
        '        )\n',
        '    def open_session(\n'
        '        self,\n'
        '        session_id: str,\n'
        '        sample_rate: int = 16000,\n'
        '        *,\n'
        '        speaker_backend: str | None = None,\n'
        '    ) -> dict[str, Any]:\n'
        '        explicit_backend = speaker_backend is not None\n'
        '        backend_key = str(speaker_backend or "xvector").strip().lower()\n'
        '        if not backend_key:\n'
        '            raise ValueError("speaker_backend must not be empty")\n'
        '        result = self._require_dict(\n'
        '            self._request(\n'
        '                "open_session",\n'
        '                session_id=session_id,\n'
        '                sample_rate=int(sample_rate),\n'
        '                speaker_backend=backend_key,\n'
        '            )\n'
        '        )\n'
        '        if not explicit_backend:\n'
        '            result.pop("speaker_backend", None)\n'
        '        return result\n',
    )


if __name__ == "__main__":
    main()
