from __future__ import annotations

import hashlib
import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Mapping

from hardware.base import DeviceInfo


@dataclass(frozen=True)
class MicrophoneFingerprint:
    fingerprint: str
    certainty: str
    device_id: str
    device_name: str


def _sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        while True:
            chunk = handle.read(1024 * 1024)
            if not chunk:
                break
            digest.update(chunk)
    return digest.hexdigest()


def fingerprint_model_directory(path: str | Path) -> str:
    root = Path(path).expanduser().resolve()
    if not root.is_dir():
        raise ValueError(f"speaker model directory does not exist: {root}")
    files = sorted(item for item in root.rglob("*") if item.is_file())
    if not files:
        raise ValueError("speaker model directory contains no files")

    manifest = hashlib.sha256()
    for file_path in files:
        relative = file_path.relative_to(root).as_posix()
        file_hash = _sha256_file(file_path)
        manifest.update(relative.encode("utf-8"))
        manifest.update(b"\0")
        manifest.update(file_hash.encode("ascii"))
        manifest.update(b"\n")
    return manifest.hexdigest()


def _normalize_metadata(metadata: Mapping[str, Any]) -> dict[str, str]:
    aliases = {
        "vendor": ("vendor_id", "vendorId", "idVendor", "usb_vendor_id"),
        "product": ("product_id", "productId", "idProduct", "usb_product_id"),
        "serial": ("serial", "serial_number", "serialNumber", "ID_SERIAL_SHORT"),
        "card": ("card", "alsa_card", "alsaCard"),
        "device": ("device", "alsa_device", "alsaDevice"),
    }
    normalized: dict[str, str] = {}
    for canonical, keys in aliases.items():
        for key in keys:
            value = metadata.get(key)
            if value is not None and str(value).strip():
                normalized[canonical] = str(value).strip().lower()
                break
    return normalized


def fingerprint_microphone(info: DeviceInfo) -> MicrophoneFingerprint:
    metadata = _normalize_metadata(info.metadata or {})
    canonical = {
        "device_type": str(info.device_type or "audio").strip().lower(),
        "device_id": str(info.device_id or "").strip().lower(),
        "path": str(info.path or "").strip().lower(),
        **metadata,
    }
    encoded = json.dumps(canonical, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode("utf-8")
    fingerprint = hashlib.sha256(encoded).hexdigest()

    if metadata.get("serial"):
        certainty = "STRONG"
    elif metadata.get("vendor") and metadata.get("product"):
        certainty = "MEDIUM"
    else:
        certainty = "REDUCED"

    return MicrophoneFingerprint(
        fingerprint=fingerprint,
        certainty=certainty,
        device_id=str(info.device_id or info.path or "unknown"),
        device_name=str(info.name or "Linux ALSA Microphone"),
    )
