import io
import tempfile
import time
import unittest
from pathlib import Path

from hardware.base import DeviceState, HardwareError
from hardware.device_manager import DeviceManager
from hardware.events import DeviceEventType
from hardware.factory import create_device_manager
from hardware.idcard.mock import MockIDCardReader
from hardware.idcard.vendor import CtypesVendorAdapter, SDKLibraryDiscovery, VendorIdentityReader
from hardware.audio.alsa import ALSARecorder
from hardware.camera.v4l2 import V4L2Camera, enumerate_cameras
from hardware.signature.mock import MockSignatureDevice
from hardware.monitor import DeviceMonitor, DeviceSnapshot


class FakeStdout:
    def __init__(self, chunks):
        self._chunks = list(chunks)

    def read(self, size):
        if not self._chunks:
            return b""
        return self._chunks.pop(0)


class FakeProcess:
    def __init__(self, chunks=(b"abc", b"")):
        self.stdout = FakeStdout(chunks)
        self.stderr = io.BytesIO()
        self.returncode = None
        self.terminated = False

    def poll(self):
        return self.returncode

    def terminate(self):
        self.terminated = True
        self.returncode = 0

    def wait(self, timeout=None):
        self.returncode = 0
        return 0

    def kill(self):
        self.returncode = -9


class HardwareHALTests(unittest.TestCase):
    def test_mock_identity_is_normalized_and_explicitly_mock(self):
        reader = MockIDCardReader()
        reader.open()
        result = reader.read()
        self.assertEqual(result.source, "mock")
        self.assertEqual(result.name, "测试用户")
        self.assertTrue(result.id_number)
        for field in (
            "gender", "nation", "birth", "address", "issuer",
            "valid_from", "valid_to", "portrait", "device_id", "read_at",
        ):
            self.assertTrue(hasattr(result, field), field)

    def test_identity_adapter_does_not_treat_unknown_sdk_return_code_as_success(self):
        class FakeLib:
            def SDT_OpenPort(self, port):
                return 0

        with tempfile.TemporaryDirectory() as td:
            sdk = Path(td) / "libsdtapi.so"
            sdk.touch()
            discovery = SDKLibraryDiscovery(candidates=[str(sdk)])
            adapter = CtypesVendorAdapter(discovery=discovery, loader=lambda _: FakeLib())
            with self.assertRaises(HardwareError) as ctx:
                adapter.open()
            self.assertEqual(ctx.exception.code, "DEVICE_NOT_CONNECTED")

    def test_real_identity_missing_sdk_reports_sdk_not_found(self):
        discovery = SDKLibraryDiscovery(candidates=[])
        adapter = CtypesVendorAdapter(discovery=discovery)
        reader = VendorIdentityReader(adapter=adapter)
        with self.assertRaises(HardwareError) as ctx:
            reader.open()
        self.assertEqual(ctx.exception.code, "SDK_NOT_FOUND")
        self.assertEqual(reader.status(), DeviceState.UNAVAILABLE)

    def test_signature_manager_uses_submit_protocol(self):
        signature = MockSignatureDevice()
        manager = DeviceManager(signature_device=signature)
        manager.open_all()
        manager.start_signature_capture()
        result = manager.submit_signature({"strokes": [[1, 2], [3, 4]]})
        self.assertEqual(result["source"], "mock")
        self.assertEqual(result["payload"]["strokes"][0], [1, 2])
        self.assertIn("device_info", result)

    def test_manager_capability_report_contains_all_devices(self):
        manager = create_device_manager("mock")
        manager.open_all()
        report = manager.capability_report()
        self.assertEqual(report["mode"], "mock")
        self.assertEqual(
            set(report["devices"]),
            {"identity", "camera", "audio", "signature", "monitor"},
        )
        self.assertTrue(all("status" in item for item in report["devices"].values()))

    def test_alsa_recorder_reads_frames_without_blocking_caller(self):
        process = FakeProcess((b"abcd", b""))
        recorder = ALSARecorder(
            device="default",
            sample_rate=16000,
            channels=1,
            pcm_format="S16_LE",
            which=lambda _: "/usr/bin/arecord",
            popen_factory=lambda *args, **kwargs: process,
            enumerate_runner=lambda *args, **kwargs: "default\n",
        )
        recorder.open()
        recorder.start()
        data = recorder.read_frames(timeout=0.5)
        recorder.stop()
        self.assertEqual(data, b"abcd")
        self.assertTrue(process.terminated)
        self.assertFalse(recorder.running)

    def test_alsa_wav_output_is_finalized(self):
        process = FakeProcess((b"\x01\x00\x02\x00", b""))
        with tempfile.TemporaryDirectory() as td:
            output = Path(td) / "test.wav"
            recorder = ALSARecorder(
                device="default",
                sample_rate=16000,
                channels=1,
                pcm_format="S16_LE",
                which=lambda _: "/usr/bin/arecord",
                popen_factory=lambda *args, **kwargs: process,
                enumerate_runner=lambda *args, **kwargs: "default\n",
            )
            recorder.open()
            recorder.start(output_path=output)
            _ = recorder.read_frames(timeout=0.5)
            time.sleep(0.02)
            recorder.stop()
            self.assertTrue(output.exists())
            self.assertGreater(output.stat().st_size, 44)

    def test_camera_missing_device_is_explicit(self):
        camera = V4L2Camera(device="/definitely/missing/video99", which=lambda _: "/usr/bin/v4l2-ctl")
        with self.assertRaises(HardwareError) as ctx:
            camera.open()
        self.assertEqual(ctx.exception.code, "DEVICE_NOT_CONNECTED")

    def test_camera_enumeration_uses_video_nodes(self):
        with tempfile.TemporaryDirectory() as td:
            root = Path(td)
            (root / "video0").touch()
            (root / "video2").touch()
            devices = enumerate_cameras(dev_root=root)
            self.assertEqual([d.path for d in devices], [str(root / "video0"), str(root / "video2")])

    def test_hotplug_monitor_emits_connected_disconnected_ready(self):
        snapshots = [
            DeviceSnapshot(video=frozenset(), audio=frozenset(), usb=frozenset()),
            DeviceSnapshot(video=frozenset({"/dev/video0"}), audio=frozenset(), usb=frozenset()),
            DeviceSnapshot(video=frozenset(), audio=frozenset(), usb=frozenset()),
        ]
        events = []

        def provider():
            return snapshots.pop(0) if snapshots else DeviceSnapshot.empty()

        monitor = DeviceMonitor(snapshot_provider=provider, event_sink=events.append, poll_interval=0.01, use_udev=False)
        monitor.scan_once()
        monitor.scan_once()
        monitor.scan_once()
        types = [event.event_type for event in events]
        self.assertIn(DeviceEventType.DEVICE_CONNECTED, types)
        self.assertIn(DeviceEventType.DEVICE_READY, types)
        self.assertIn(DeviceEventType.DEVICE_DISCONNECTED, types)

    def test_mock_factory_never_hides_source(self):
        manager = create_device_manager("mock")
        manager.open_all()
        identity = manager.read_identity()
        capture = manager.capture_image()
        self.assertEqual(identity.source, "mock")
        self.assertEqual(capture.source, "mock")
        self.assertEqual(manager.mode, "mock")

    def test_real_factory_reports_unavailable_instead_of_mocking(self):
        manager = create_device_manager("real")
        self.assertEqual(manager.mode, "real")
        self.assertNotEqual(type(manager.identity_reader).__name__, "MockIDCardReader")
        self.assertNotEqual(type(manager.camera).__name__, "MockCameraDevice")


class WebSocketBridgeTests(unittest.IsolatedAsyncioTestCase):
    async def test_hardware_event_broadcast_reaches_all_sessions_and_prunes_dead_socket(self):
        from app.websocket import manager as ws_manager

        class Socket:
            def __init__(self, fail=False):
                self.fail = fail
                self.messages = []

            async def send_json(self, data):
                if self.fail:
                    raise RuntimeError("disconnected")
                self.messages.append(data)

        good = Socket()
        bad = Socket(fail=True)
        ws_manager.connections.clear()
        ws_manager.connections.update({"good": good, "bad": bad})
        await ws_manager.broadcast_hardware_event({"event_type": "DEVICE_READY", "device_id": "/dev/video0"})
        self.assertEqual(good.messages[0]["type"], "hardware_event")
        self.assertEqual(good.messages[0]["event"]["device_id"], "/dev/video0")
        self.assertNotIn("bad", ws_manager.connections)


if __name__ == "__main__":
    unittest.main()
