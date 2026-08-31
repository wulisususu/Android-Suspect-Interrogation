from __future__ import annotations

import threading
import time

import pytest

from app.services.browser_audio_input import BrowserAudioInput


def test_browser_audio_input_delivers_lan_pcm_without_touching_alsa():
    source = BrowserAudioInput(max_frame_bytes=64 * 1024)
    source.start_record()

    pcm = b"\x01\x00" * 1600
    source.push_pcm(pcm)

    assert source.read_audio_frames(timeout=0.05) == pcm
    assert source.active is True

    source.stop_record()
    assert source.active is False
    assert source.read_audio_frames(timeout=0.01) == b""


def test_browser_audio_input_rejects_invalid_or_inactive_frames():
    source = BrowserAudioInput(max_frame_bytes=16)

    with pytest.raises(RuntimeError, match="not active"):
        source.push_pcm(b"\x00\x00")

    source.start_record()
    with pytest.raises(ValueError, match="PCM16"):
        source.push_pcm(b"\x00")
    with pytest.raises(ValueError, match="too large"):
        source.push_pcm(b"\x00\x00" * 9)


def test_browser_audio_input_waits_for_pcm_until_timeout():
    source = BrowserAudioInput()
    source.start_record()

    result: list[bytes] = []
    thread = threading.Thread(target=lambda: result.append(source.read_audio_frames(timeout=0.2)))
    thread.start()
    time.sleep(0.02)
    source.push_pcm(b"\x02\x00" * 10)
    thread.join(timeout=1)

    assert result == [b"\x02\x00" * 10]
    source.stop_record()
