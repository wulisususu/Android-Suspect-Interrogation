from __future__ import annotations

import queue
import shutil
import subprocess
import threading
import wave
from pathlib import Path
from typing import Callable, List, Optional

from hardware.audio.interface import AudioRecorder
from hardware.base import DeviceInfo, DeviceState, HardwareError, HealthReport


_SAMPLE_WIDTH = {"S16_LE": 2, "S24_LE": 3, "S32_LE": 4, "U8": 1}


class ALSARecorder(AudioRecorder):
    """Non-blocking ALSA capture implemented through the standard ``arecord`` tool."""

    def __init__(
        self,
        device: str = "default",
        sample_rate: int = 16000,
        channels: int = 1,
        pcm_format: str = "S16_LE",
        *,
        chunk_frames: int = 1024,
        queue_chunks: int = 64,
        which: Callable[[str], Optional[str]] = shutil.which,
        popen_factory: Callable[..., subprocess.Popen] = subprocess.Popen,
        enumerate_runner: Callable[..., object] = subprocess.check_output,
    ):
        if pcm_format not in _SAMPLE_WIDTH:
            raise ValueError(f"unsupported PCM format: {pcm_format}")
        self.device = device
        self.sample_rate = int(sample_rate)
        self.channels = int(channels)
        self.pcm_format = pcm_format
        self.chunk_frames = int(chunk_frames)
        self._which = which
        self._popen_factory = popen_factory
        self._enumerate_runner = enumerate_runner
        self._state = DeviceState.CLOSED
        self._process = None
        self._thread: Optional[threading.Thread] = None
        self._stop_event = threading.Event()
        self._frames: "queue.Queue[bytes]" = queue.Queue(maxsize=queue_chunks)
        self._wav = None
        self._wav_lock = threading.Lock()
        self._last_error: Optional[str] = None
        self.dropped_chunks = 0
        self.running = False

    def enumerate_devices(self) -> List[str]:
        executable = self._which("arecord")
        if not executable:
            return []
        try:
            output = self._enumerate_runner([executable, "-L"], text=True, stderr=subprocess.STDOUT)
            if hasattr(output, "stdout"):
                output = output.stdout
            if isinstance(output, bytes):
                output = output.decode(errors="replace")
            devices = []
            for line in str(output).splitlines():
                if not line or line[0].isspace() or line.startswith("#"):
                    continue
                devices.append(line.strip())
            return devices
        except Exception as exc:
            self._last_error = str(exc)
            return []

    def open(self) -> None:
        executable = self._which("arecord")
        if not executable:
            self._state = DeviceState.UNAVAILABLE
            raise HardwareError("ALSA_TOOL_NOT_FOUND", "arecord is required for ALSA capture")
        self._state = DeviceState.READY
        self._last_error = None

    def close(self) -> None:
        if self.running:
            self.stop()
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        healthy = self._state in {DeviceState.READY, DeviceState.ACTIVE}
        details = {
            "device": self.device,
            "sample_rate": self.sample_rate,
            "channels": self.channels,
            "pcm_format": self.pcm_format,
            "dropped_chunks": self.dropped_chunks,
        }
        if self._last_error:
            details["last_error"] = self._last_error
        return HealthReport(healthy, self._state, "ALSA recorder ready" if healthy else "ALSA recorder unavailable", details)

    def device_info(self) -> DeviceInfo:
        return DeviceInfo(
            "audio",
            f"alsa:{self.device}",
            f"ALSA {self.device}",
            source="real",
            path=self.device,
            metadata={"sample_rate": self.sample_rate, "channels": self.channels, "pcm_format": self.pcm_format},
        )

    def start(self, output_path: Optional[Path] = None) -> None:
        if self._state == DeviceState.CLOSED:
            self.open()
        if self.running:
            raise HardwareError("DEVICE_BUSY", "audio recorder is already running")
        executable = self._which("arecord")
        if not executable:
            self._state = DeviceState.UNAVAILABLE
            raise HardwareError("ALSA_TOOL_NOT_FOUND", "arecord is required for ALSA capture")
        command = [
            executable,
            "-q",
            "-D", self.device,
            "-f", self.pcm_format,
            "-r", str(self.sample_rate),
            "-c", str(self.channels),
            "-t", "raw",
        ]
        self._stop_event.clear()
        self.dropped_chunks = 0
        while not self._frames.empty():
            try:
                self._frames.get_nowait()
            except queue.Empty:
                break
        if output_path is not None:
            path = Path(output_path)
            path.parent.mkdir(parents=True, exist_ok=True)
            self._wav = wave.open(str(path), "wb")
            self._wav.setnchannels(self.channels)
            self._wav.setsampwidth(_SAMPLE_WIDTH[self.pcm_format])
            self._wav.setframerate(self.sample_rate)
        try:
            self._process = self._popen_factory(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, bufsize=0)
        except OSError as exc:
            self._close_wav()
            self._state = DeviceState.ERROR
            self._last_error = str(exc)
            raise HardwareError("AUDIO_OPEN_FAILED", f"failed to start arecord: {exc}") from exc
        self.running = True
        self._state = DeviceState.ACTIVE
        self._thread = threading.Thread(target=self._reader_loop, name="alsa-reader", daemon=True)
        self._thread.start()

    def _reader_loop(self) -> None:
        bytes_per_chunk = self.chunk_frames * self.channels * _SAMPLE_WIDTH[self.pcm_format]
        try:
            while not self._stop_event.is_set():
                stdout = getattr(self._process, "stdout", None)
                if stdout is None:
                    raise RuntimeError("arecord stdout pipe is unavailable")
                chunk = stdout.read(bytes_per_chunk)
                if not chunk:
                    break
                if self._wav is not None:
                    with self._wav_lock:
                        if self._wav is not None:
                            self._wav.writeframesraw(chunk)
                try:
                    self._frames.put_nowait(chunk)
                except queue.Full:
                    self.dropped_chunks += 1
        except Exception as exc:
            self._last_error = str(exc)
            self._state = DeviceState.ERROR

    def read_frames(self, timeout: float = 0.5) -> bytes:
        if not self.running and self._frames.empty():
            raise HardwareError("AUDIO_NOT_RUNNING", "audio recorder is not running")
        try:
            return self._frames.get(timeout=timeout)
        except queue.Empty:
            if self._last_error:
                raise HardwareError("AUDIO_READ_FAILED", self._last_error)
            return b""

    def stop(self) -> None:
        self._stop_event.set()
        process = self._process
        if process is not None and process.poll() is None:
            try:
                process.terminate()
                process.wait(timeout=2)
            except Exception:
                try:
                    process.kill()
                except Exception:
                    pass
        if self._thread is not None and self._thread.is_alive():
            self._thread.join(timeout=2)
        self._thread = None
        self._process = None
        self.running = False
        self._close_wav()
        if self._state != DeviceState.ERROR:
            self._state = DeviceState.READY

    def _close_wav(self) -> None:
        with self._wav_lock:
            if self._wav is not None:
                self._wav.close()
                self._wav = None
