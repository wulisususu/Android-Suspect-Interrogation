from __future__ import annotations

import os
from typing import Optional

from hardware.audio.alsa import ALSARecorder
from hardware.audio.mock import MockAudioRecorder
from hardware.camera.mock import MockCameraDevice
from hardware.camera.v4l2 import V4L2Camera, enumerate_cameras
from hardware.device_manager import DeviceManager
from hardware.idcard.mock import MockIDCardReader
from hardware.idcard.vendor import VendorIdentityReader
from hardware.monitor import DeviceMonitor, DeviceSnapshot
from hardware.signature.linux import LinuxSignatureDevice
from hardware.signature.mock import MockSignatureDevice


def create_device_manager(mode: Optional[str] = None, *, event_sink=None) -> DeviceManager:
    selected = (mode or os.getenv("HARDWARE_MODE", "real")).strip().lower()
    if selected not in {"mock", "real"}:
        raise ValueError("HARDWARE_MODE must be 'mock' or 'real'")
    if selected == "mock":
        monitor = DeviceMonitor(
            snapshot_provider=lambda: DeviceSnapshot.empty(),
            event_sink=event_sink,
            use_udev=False,
            source="mock",
        )
        return DeviceManager(
            identity_reader=MockIDCardReader(),
            camera=MockCameraDevice(),
            audio_recorder=MockAudioRecorder(),
            signature_device=MockSignatureDevice(),
            device_monitor=monitor,
            mode="mock",
        )

    cameras = enumerate_cameras()
    camera_path = cameras[0].path if cameras else os.getenv("CAMERA_DEVICE", "/dev/video0")
    monitor = DeviceMonitor(event_sink=event_sink, use_udev=True, source="real")
    return DeviceManager(
        identity_reader=VendorIdentityReader(),
        camera=V4L2Camera(camera_path),
        audio_recorder=ALSARecorder(device=os.getenv("ALSA_DEVICE", "default")),
        signature_device=LinuxSignatureDevice(os.getenv("SIGNATURE_DEVICE")),
        device_monitor=monitor,
        mode="real",
    )
