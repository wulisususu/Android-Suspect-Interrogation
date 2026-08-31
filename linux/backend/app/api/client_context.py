from __future__ import annotations

from ipaddress import ip_address
from typing import Mapping

from fastapi import APIRouter, Request

from app.api.responses import envelope


router = APIRouter(tags=["client-context"])


def _header(headers: Mapping[str, str], name: str) -> str:
    lowered = name.lower()
    for key, value in headers.items():
        if str(key).lower() == lowered:
            return str(value or "").strip()
    return ""


def _normalize_platform(value: str) -> str:
    text = str(value or "").strip().strip('"').lower()
    if "windows" in text or text in {"win32", "win64"}:
        return "WINDOWS"
    if "android" in text:
        return "ANDROID"
    if any(token in text for token in ("iphone", "ipad", "ios")):
        return "IOS"
    if "mac" in text:
        return "MACOS"
    if "linux" in text:
        return "LINUX"
    return "UNKNOWN"


def _detect_platform(headers: Mapping[str, str]) -> tuple[str, str]:
    # Prefer the canonical Sec-CH-UA-Platform client hint. HTTP header lookup
    # itself is case-insensitive, so the normalized key below is lowercase.
    client_hint = _header(headers, "sec-ch-ua-platform")
    if client_hint:
        platform = _normalize_platform(client_hint)
        if platform != "UNKNOWN":
            return platform, "SEC_CH_UA_PLATFORM"

    user_agent = _header(headers, "user-agent")
    platform = _normalize_platform(user_agent)
    return platform, "USER_AGENT" if user_agent else "UNAVAILABLE"


def _is_loopback_client(client_host: str) -> bool:
    host = str(client_host or "").strip().strip("[]")
    if host.lower() == "localhost":
        return True
    try:
        return ip_address(host).is_loopback
    except ValueError:
        return False


def resolve_client_audio_context(*, headers: Mapping[str, str], client_host: str) -> dict[str, object]:
    """Resolve the physical microphone owner from HTTP client identity.

    Audio capture runs on the RK3588 ALSA device only for a browser connected
    from loopback. Any non-loopback browser is a remote client and therefore
    owns its microphone, regardless of whether that client OS is Windows,
    macOS, Android, iOS, or another Linux machine.
    """

    platform, platform_source = _detect_platform(headers)
    local_client = _is_loopback_client(client_host)
    return {
        "clientPlatform": platform,
        "clientAddress": str(client_host or ""),
        "localClient": local_client,
        "accessTopology": "LOCAL_KIOSK" if local_client else "REMOTE_BROWSER",
        "recommendedAudioInputMode": "ALSA" if local_client else "BROWSER",
        "platformSource": platform_source,
    }


@router.get("/client-context")
def client_context(request: Request):
    client_host = request.client.host if request.client is not None else ""
    payload = resolve_client_audio_context(headers=request.headers, client_host=client_host)
    return envelope(payload)
