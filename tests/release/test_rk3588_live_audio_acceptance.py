from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts" / "ci" / "rk3588-live-audio-acceptance.py"
WORKFLOW = ROOT / ".github" / "workflows" / "rk3588-live-audio-acceptance.yml"


def test_live_audio_script_uses_real_alsa_and_rejects_silent_capture():
    assert SCRIPT.is_file(), "live audio acceptance script is missing"
    source = SCRIPT.read_text(encoding="utf-8")

    for required in (
        "ALSARecorder",
        "read_frames",
        "audioop.rms",
        "peak",
        "nonzero_ratio",
        "min_rms",
        "min_peak",
        "capture_seconds",
    ):
        assert required in source

    assert "MockAudio" not in source
    assert "synthetic" not in source.lower()


def test_live_audio_script_pushes_live_pcm_to_funasr_and_requires_real_text():
    source = SCRIPT.read_text(encoding="utf-8")

    for required in (
        "SpeechWorkerClient",
        "open_session",
        "push_pcm",
        "finalize_session",
        "ASR_FINAL",
        "require_asr_text",
    ):
        assert required in source

    assert "wavfile" not in source.lower()
    assert "--speech-wav" not in source


def test_live_audio_workflow_is_manual_real_hardware_only_and_never_uploads_audio():
    assert WORKFLOW.is_file(), "live audio workflow is missing"
    workflow = WORKFLOW.read_text(encoding="utf-8")

    assert "workflow_dispatch:" in workflow
    assert "push:" not in workflow
    assert "pull_request:" not in workflow
    assert "runs-on: [self-hosted, rk3588]" in workflow
    assert "capture_seconds:" in workflow
    assert "alsa_device:" in workflow
    assert "require_asr_text:" in workflow
    assert "START SPEAKING NOW" in workflow
    assert "rk3588-live-audio-acceptance.py" in workflow
    assert "SUSPECT_FUNASR_MODEL_ROOT" in workflow
    assert "speech_worker.main" in workflow

    lowered = workflow.lower()
    assert "upload-artifact" not in lowered
    assert "*.wav" not in lowered
    assert "*.pcm" not in lowered
    assert ".wav" not in lowered
    assert ".pcm" not in lowered
