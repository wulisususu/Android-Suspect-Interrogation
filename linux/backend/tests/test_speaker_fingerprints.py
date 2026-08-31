from __future__ import annotations

import os

from app.ai.speech.fingerprint import fingerprint_model_directory, fingerprint_microphone
from hardware.base import DeviceInfo


def test_model_fingerprint_is_content_based_and_stable_across_mtime(tmp_path):
    model = tmp_path / "xvector"
    model.mkdir()
    (model / "config.yaml").write_text("dim: 192\n", encoding="utf-8")
    (model / "model.bin").write_bytes(b"model-v1")

    first = fingerprint_model_directory(model)
    os.utime(model / "model.bin", (1_000_000, 1_000_000))
    second = fingerprint_model_directory(model)
    assert second == first

    (model / "model.bin").write_bytes(b"model-v2")
    third = fingerprint_model_directory(model)
    assert third != first
    assert len(third) == 64


def test_microphone_fingerprint_uses_stable_hardware_identity_and_certainty():
    strong = fingerprint_microphone(
        DeviceInfo(
            "audio",
            "alsa:hw:1,0",
            "USB Microphone",
            path="hw:1,0",
            metadata={"vendor_id": "1234", "product_id": "5678", "serial": "ABC-001"},
        )
    )
    same = fingerprint_microphone(
        DeviceInfo(
            "audio",
            "alsa:hw:1,0",
            "Renamed UI Label",
            path="hw:1,0",
            metadata={"vendor_id": "1234", "product_id": "5678", "serial": "ABC-001"},
        )
    )
    replaced = fingerprint_microphone(
        DeviceInfo(
            "audio",
            "alsa:hw:1,0",
            "USB Microphone",
            path="hw:1,0",
            metadata={"vendor_id": "1234", "product_id": "5678", "serial": "ABC-002"},
        )
    )

    assert strong.fingerprint == same.fingerprint
    assert strong.certainty == "STRONG"
    assert replaced.fingerprint != strong.fingerprint

    reduced = fingerprint_microphone(
        DeviceInfo("audio", "alsa:default", "Default ALSA", path="default", metadata={})
    )
    assert reduced.certainty == "REDUCED"
    assert reduced.fingerprint
