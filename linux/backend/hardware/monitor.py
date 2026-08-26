from __future__ import annotations

import glob
import shutil
import subprocess
import threading
from dataclasses import dataclass
from typing import Callable, FrozenSet, Optional

from hardware.base import DeviceInfo, DeviceState, HealthReport, HardwareDevice
from hardware.events import DeviceEvent, DeviceEventType, EventBus


@dataclass(frozen=True)
class DeviceSnapshot:
    video: FrozenSet[str]
    audio: FrozenSet[str]
    usb: FrozenSet[str]

    @classmethod
    def empty(cls) -> "DeviceSnapshot":
        return cls(frozenset(), frozenset(), frozenset())


def default_snapshot() -> DeviceSnapshot:
    return DeviceSnapshot(
        video=frozenset(glob.glob("/dev/video*")),
        audio=frozenset(glob.glob("/dev/snd/*")),
        usb=frozenset(glob.glob("/dev/bus/usb/*/*")),
    )


class DeviceMonitor(HardwareDevice):
    def __init__(
        self,
        *,
        snapshot_provider: Callable[[], DeviceSnapshot] = default_snapshot,
        event_sink=None,
        poll_interval: float = 1.0,
        use_udev: bool = True,
        source: str = "real",
    ):
        self.snapshot_provider = snapshot_provider
        self.poll_interval = float(poll_interval)
        self.use_udev = use_udev
        self.source = source
        self.events = EventBus(event_sink)
        self._state = DeviceState.CLOSED
        self._snapshot: Optional[DeviceSnapshot] = None
        self._stop = threading.Event()
        self._poll_thread: Optional[threading.Thread] = None
        self._udev_thread: Optional[threading.Thread] = None
        self._udev_process = None

    def open(self) -> None:
        self._snapshot = None
        self._state = DeviceState.READY

    def close(self) -> None:
        self.stop()
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        return HealthReport(self._state in {DeviceState.READY, DeviceState.ACTIVE}, self._state, "device monitor ready", {"udevadm": bool(shutil.which("udevadm")), "poll_interval": self.poll_interval})

    def device_info(self) -> DeviceInfo:
        return DeviceInfo("monitor", "linux-device-monitor", "Linux Device Monitor", source=self.source, metadata={"udev": self.use_udev})

    def subscribe(self, subscriber) -> None:
        self.events.subscribe(subscriber)

    def scan_once(self) -> DeviceSnapshot:
        current = self.snapshot_provider()
        previous = self._snapshot
        self._snapshot = current
        if previous is None:
            return current
        for subsystem in ("video", "audio", "usb"):
            old = getattr(previous, subsystem)
            new = getattr(current, subsystem)
            for device in sorted(new - old):
                self._emit(DeviceEventType.DEVICE_CONNECTED, subsystem, device)
                self._emit(DeviceEventType.DEVICE_READY, subsystem, device)
            for device in sorted(old - new):
                self._emit(DeviceEventType.DEVICE_DISCONNECTED, subsystem, device)
        return current

    def _emit(self, event_type: DeviceEventType, subsystem: str, device_id: str, **details) -> None:
        self.events.publish(DeviceEvent(event_type, subsystem, device_id, source=self.source, details=details))

    def start(self) -> None:
        if self._poll_thread and self._poll_thread.is_alive():
            return
        if self._state == DeviceState.CLOSED:
            self.open()
        self._stop.clear()
        self.scan_once()
        self._state = DeviceState.ACTIVE

        def poll_loop() -> None:
            while not self._stop.wait(self.poll_interval):
                try:
                    self.scan_once()
                except Exception as exc:
                    self._emit(DeviceEventType.DEVICE_ERROR, "monitor", "snapshot", error=str(exc))

        self._poll_thread = threading.Thread(target=poll_loop, name="device-poller", daemon=True)
        self._poll_thread.start()
        if self.use_udev and shutil.which("udevadm"):
            self._start_udev()

    def _start_udev(self) -> None:
        def udev_loop() -> None:
            try:
                self._udev_process = subprocess.Popen(
                    ["udevadm", "monitor", "--udev", "--property"],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.DEVNULL,
                    text=True,
                    bufsize=1,
                )
                block = {}
                for raw_line in self._udev_process.stdout or ():
                    if self._stop.is_set():
                        break
                    line = raw_line.strip()
                    if not line:
                        self._publish_udev_block(block)
                        block = {}
                        continue
                    if "=" in line:
                        key, value = line.split("=", 1)
                        block[key] = value
                if block:
                    self._publish_udev_block(block)
            except Exception as exc:
                if not self._stop.is_set():
                    self._emit(DeviceEventType.DEVICE_ERROR, "udev", "udevadm", error=str(exc))

        self._udev_thread = threading.Thread(target=udev_loop, name="udev-monitor", daemon=True)
        self._udev_thread.start()

    def _publish_udev_block(self, block) -> None:
        action = block.get("ACTION")
        subsystem = block.get("SUBSYSTEM", "udev")
        if subsystem not in {"usb", "video4linux", "sound"}:
            return
        device = block.get("DEVNAME") or block.get("DEVPATH") or block.get("DEVNUM") or "unknown"
        if action == "add":
            self._emit(DeviceEventType.DEVICE_CONNECTED, subsystem, device, udev=block)
            self._emit(DeviceEventType.DEVICE_READY, subsystem, device, udev=block)
        elif action == "remove":
            self._emit(DeviceEventType.DEVICE_DISCONNECTED, subsystem, device, udev=block)
        elif action == "change":
            self._emit(DeviceEventType.DEVICE_READY, subsystem, device, udev=block)

    def stop(self) -> None:
        self._stop.set()
        if self._udev_process is not None and self._udev_process.poll() is None:
            try:
                self._udev_process.terminate()
            except Exception:
                pass
        for thread in (self._poll_thread, self._udev_thread):
            if thread and thread.is_alive():
                thread.join(timeout=2)
        self._poll_thread = None
        self._udev_thread = None
        self._udev_process = None
        if self._state != DeviceState.CLOSED:
            self._state = DeviceState.READY
