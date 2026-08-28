#!/usr/bin/env python3
from __future__ import annotations

import argparse
import audioop
import json
import struct
import time
import uuid
from dataclasses import dataclass
from typing import Iterable

from app.ai.speech.client import SpeechWorkerClient
from app.ai.speech.types import SpeechEvent, SpeechEventType
from hardware.audio.alsa import ALSARecorder


@dataclass(frozen=True)
class CaptureMetrics:
    byte_count: int
    sample_count: int
    rms: int
    peak: int
    nonzero_ratio: float


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Capture live RK3588 microphone audio and prove the offline FunASR stream accepts it."
    )
    parser.add_argument("--socket", required=True, help="Speech-worker Unix socket path")
    parser.add_argument("--device", default="default", help="ALSA capture device")
    parser.add_argument("--capture-seconds", type=float, default=12.0)
    parser.add_argument("--sample-rate", type=int, default=16_000)
    parser.add_argument("--min-rms", type=int, default=80)
    parser.add_argument("--min-peak", type=int, default=500)
    parser.add_argument("--min-nonzero-ratio", type=float, default=0.01)
    parser.add_argument("--require-asr-text", action="store_true")
    return parser.parse_args()


def capture_metrics(pcm: bytes) -> CaptureMetrics:
    usable = pcm[: len(pcm) - (len(pcm) % 2)]
    if not usable:
        return CaptureMetrics(0, 0, 0, 0, 0.0)

    sample_count = len(usable) // 2
    nonzero_samples = sum(1 for (sample,) in struct.iter_unpack("<h", usable) if sample != 0)
    nonzero_ratio = nonzero_samples / sample_count if sample_count else 0.0
    return CaptureMetrics(
        byte_count=len(usable),
        sample_count=sample_count,
        rms=audioop.rms(usable, 2),
        peak=audioop.max(usable, 2),
        nonzero_ratio=nonzero_ratio,
    )


def final_texts(events: Iterable[SpeechEvent]) -> list[str]:
    return [
        str(event.text).strip()
        for event in events
        if event.type is SpeechEventType.ASR_FINAL and str(event.text or "").strip()
    ]


def validate_capture(
    metrics: CaptureMetrics,
    *,
    min_rms: int,
    min_peak: int,
    min_nonzero_ratio: float,
) -> None:
    if metrics.sample_count <= 0:
        raise RuntimeError("live microphone returned no 16-bit samples")
    if metrics.rms < min_rms:
        raise RuntimeError(f"live microphone RMS too low: {metrics.rms} < {min_rms}")
    if metrics.peak < min_peak:
        raise RuntimeError(f"live microphone peak too low: {metrics.peak} < {min_peak}")
    if metrics.nonzero_ratio < min_nonzero_ratio:
        raise RuntimeError(
            "live microphone nonzero ratio too low: "
            f"{metrics.nonzero_ratio:.6f} < {min_nonzero_ratio:.6f}"
        )


def run() -> dict[str, object]:
    args = parse_args()
    capture_seconds = float(args.capture_seconds)
    min_rms = int(args.min_rms)
    min_peak = int(args.min_peak)
    require_asr_text = bool(args.require_asr_text)

    if capture_seconds <= 0:
        raise ValueError("capture_seconds must be positive")
    if args.sample_rate <= 0:
        raise ValueError("sample_rate must be positive")
    if min_rms < 0 or min_peak < 0:
        raise ValueError("audio thresholds must be non-negative")
    if not 0.0 <= args.min_nonzero_ratio <= 1.0:
        raise ValueError("min_nonzero_ratio must be between 0 and 1")

    recorder = ALSARecorder(
        device=args.device,
        sample_rate=args.sample_rate,
        channels=1,
        pcm_format="S16_LE",
        chunk_frames=1024,
        queue_chunks=256,
    )
    client = SpeechWorkerClient(args.socket, timeout=max(20.0, capture_seconds + 10.0))
    session_id = f"live-acceptance-{uuid.uuid4().hex}"
    pcm_chunks: list[bytes] = []
    events: list[SpeechEvent] = []
    recorder_started = False
    session_open = False

    try:
        client.health()
        client.open_session(session_id, sample_rate=args.sample_rate)
        session_open = True
        recorder.start()
        recorder_started = True

        deadline = time.monotonic() + capture_seconds
        while time.monotonic() < deadline:
            chunk = recorder.read_frames(timeout=0.5)
            if not chunk:
                continue
            pcm_chunks.append(chunk)
            events.extend(client.push_pcm(session_id, chunk))
    finally:
        if recorder_started:
            recorder.stop()
        if session_open:
            try:
                events.extend(client.finalize_session(session_id))
            finally:
                client.close_session(session_id)

    pcm = b"".join(pcm_chunks)
    metrics = capture_metrics(pcm)
    validate_capture(
        metrics,
        min_rms=min_rms,
        min_peak=min_peak,
        min_nonzero_ratio=float(args.min_nonzero_ratio),
    )

    texts = final_texts(events)
    if require_asr_text and not texts:
        raise RuntimeError("live FunASR stream produced no non-empty ASR_FINAL text")

    expected_bytes = int(args.sample_rate * 2 * capture_seconds)
    return {
        "ok": True,
        "mode": "LIVE_ALSA_FUNASR",
        "device": args.device,
        "sampleRate": args.sample_rate,
        "captureSeconds": capture_seconds,
        "capturedBytes": metrics.byte_count,
        "expectedBytes": expected_bytes,
        "rms": metrics.rms,
        "peak": metrics.peak,
        "nonzeroRatio": round(metrics.nonzero_ratio, 6),
        "asrFinalCount": len(texts),
        "asrCharacterCount": sum(len(text) for text in texts),
        "recognizedTextLogged": False,
    }


if __name__ == "__main__":
    print(json.dumps(run(), ensure_ascii=False, sort_keys=True))
