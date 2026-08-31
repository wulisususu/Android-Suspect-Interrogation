from app.api.client_context import resolve_client_audio_context


def test_windows_lan_client_uses_browser_audio():
    result = resolve_client_audio_context(
        headers={
            "sec-ch-ua-platform": '"Windows"',
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
        },
        client_host="192.168.0.10",
    )
    assert result["clientPlatform"] == "WINDOWS"
    assert result["localClient"] is False
    assert result["recommendedAudioInputMode"] == "BROWSER"
    assert result["platformSource"] == "SEC_CH_UA_PLATFORM"


def test_linux_loopback_client_uses_alsa():
    result = resolve_client_audio_context(
        headers={"user-agent": "Mozilla/5.0 (X11; Linux aarch64)"},
        client_host="127.0.0.1",
    )
    assert result["clientPlatform"] == "LINUX"
    assert result["localClient"] is True
    assert result["recommendedAudioInputMode"] == "ALSA"


def test_remote_linux_client_still_uses_browser_audio():
    result = resolve_client_audio_context(
        headers={"user-agent": "Mozilla/5.0 (X11; Linux x86_64)"},
        client_host="192.168.0.20",
    )
    assert result["clientPlatform"] == "LINUX"
    assert result["localClient"] is False
    assert result["recommendedAudioInputMode"] == "BROWSER"


def test_client_hint_platform_takes_priority_over_user_agent_fallback():
    result = resolve_client_audio_context(
        headers={
            "sec-ch-ua-platform": '"Windows"',
            "user-agent": "Mozilla/5.0 (X11; Linux x86_64)",
        },
        client_host="192.168.0.20",
    )
    assert result["clientPlatform"] == "WINDOWS"
    assert result["platformSource"] == "SEC_CH_UA_PLATFORM"
