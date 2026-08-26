# Linux Hardware Setup

The Linux backend uses a strict hardware abstraction layer. Business/API code must not call `ctypes`, ALSA, V4L2, or raw USB nodes directly.

## Runtime mode

`HARDWARE_MODE=real` is the default. Missing hardware remains unavailable and is never silently replaced with a mock device. CI or development without physical peripherals must set `HARDWARE_MODE=mock`; all mock payloads expose `source=mock`.

## Required Linux capabilities

Use the service account's supplementary groups instead of world-writable device nodes:

```bash
sudo usermod -aG video,audio,plugdev <service-user>
```

A new login/session is required after group changes. Recommended distro packages are `alsa-utils` (`arecord`), `v4l-utils` (`v4l2-ctl`), `udev` (`udevadm`), and `usbutils` (`lsusb`). On an offline system, install them from the approved local package repository/media.

The example rules file is `linux/backend/hardware/udev/99-interrogation-hardware.rules.example`. Video and sound nodes use mode `0660`; identity/signature USB rules must be restricted to the actual vendor/product IDs discovered with `lsusb`. Do not use `chmod 777` or a blanket world-writable USB rule.

## Identity reader SDK

The real identity adapter searches for a vendor `.so` through `IDCARD_SDK_LIB`, `LD_LIBRARY_PATH`, and common system/vendor library directories. The common SDT ABI is supported when `SDT_OpenPort`, `SDT_StartFindIDCard`, `SDT_SelectIDCard`, and `SDT_ReadBaseMsg` are exported. The USB port parameter defaults to `1001` and can be changed with `IDCARD_SDK_PORT`.

If the SDK is absent, diagnostics reports `SDK_NOT_FOUND`. If the library loads but no device is reachable, it reports `DEVICE_NOT_CONNECTED`. Neither state is treated as a successful read.

## ALSA

`ALSA_DEVICE` defaults to `default`. Recording uses an `arecord` subprocess with a background reader thread, bounded frame queue, overflow counter, and optional WAV writer so API/UI workers are not blocked by PCM reads. `sample_rate`, `channels`, and PCM format are configurable in `ALSARecorder`.

## V4L2/UVC camera

`CAMERA_DEVICE` defaults to the first `/dev/video*` node or `/dev/video0`. Capture uses `v4l2-ctl` with the V4L2 streaming API. Camera metadata and disconnects are surfaced through the HAL. OCR is intentionally outside this layer.

## Signature device

Set `SIGNATURE_DEVICE` to the Linux device node exposed by the deployed signature pad/adapter. The HAL protocol is `start_capture -> submit/cancel`; the old `save` name is not used. Submitted raw strokes/image payloads are returned with device metadata. Evidentiary/legal freezing is intentionally outside this layer.

## Hotplug events

`DeviceMonitor` combines periodic snapshots of USB/ALSA/V4L2 nodes with `udevadm monitor` when available and emits:

- `DEVICE_CONNECTED`
- `DEVICE_DISCONNECTED`
- `DEVICE_ERROR`
- `DEVICE_READY`

The FastAPI process bridges these events to active interrogation WebSocket sessions as `{"type":"hardware_event","event":...}`.

## Diagnostics

From `linux/backend`:

```bash
PYTHONPATH=. HARDWARE_MODE=mock python3 -m hardware.diagnostics --json
PYTHONPATH=. HARDWARE_MODE=real python3 -m hardware.diagnostics --json
```

The report includes identity/camera/audio/signature/monitor status, SDK discovery, Linux groups, device-node permissions, and external tool availability.

## Physical validation still required

A Runner without attached peripherals can validate adapter loading, explicit unavailable states, mock E2E, permissions, and hotplug logic. Final onsite acceptance still requires the actual identity reader SDK/device, microphone, UVC camera, and signature pad to verify vendor return codes, PCM parameters, camera pixel format, stable hotplug behavior, and signature-device transport.
