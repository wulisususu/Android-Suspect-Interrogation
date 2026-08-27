#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import math
import os
import stat
import sys
import tempfile
import wave
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[2]
BACKEND = ROOT / "linux" / "backend"
if str(BACKEND) not in sys.path:
    sys.path.insert(0, str(BACKEND))

from app.ai.speech.client import SpeechWorkerClient  # noqa: E402

SAMPLE_RATE = 16_000
SAMPLE_WIDTH = 2
MIN_UTTERANCES_PER_IDENTITY = 3
MIN_VAD_SPEECH_MS = 1_000
THRESHOLD_KEY = "SUSPECT_SPEAKER_ACCEPT_THRESHOLD"
MARGIN_KEY = "SUSPECT_SPEAKER_MARGIN"


@dataclass(frozen=True)
class SampleScore:
    identity: str
    own_score: float
    top_wrong_score: float
    second_wrong_score: float | None

    @property
    def genuine_margin(self) -> float:
        return self.own_score - self.top_wrong_score

    @property
    def impostor_margin(self) -> float | None:
        if self.second_wrong_score is None:
            return None
        return self.top_wrong_score - self.second_wrong_score


def _normalize(values: Iterable[float]) -> list[float]:
    vector = [float(v) for v in values]
    if not vector or not all(math.isfinite(v) for v in vector):
        raise ValueError("embedding must contain finite values")
    norm = math.sqrt(sum(v * v for v in vector))
    if norm <= 0.0:
        raise ValueError("embedding norm must be positive")
    return [v / norm for v in vector]


def _cosine(left: list[float], right: list[float]) -> float:
    if len(left) != len(right):
        raise ValueError("embedding dimensions do not match")
    return max(-1.0, min(1.0, float(sum(a * b for a, b in zip(left, right)))))


def _centroid(vectors: list[list[float]]) -> list[float]:
    if not vectors:
        raise ValueError("centroid requires at least one vector")
    dim = len(vectors[0])
    if dim <= 0 or any(len(v) != dim for v in vectors):
        raise ValueError("embedding dimensions do not match")
    return _normalize(sum(v[i] for v in vectors) / len(vectors) for i in range(dim))


def _read_pcm16_wav(path: Path) -> bytes:
    try:
        with wave.open(str(path), "rb") as wav:
            channels = wav.getnchannels()
            width = wav.getsampwidth()
            rate = wav.getframerate()
            compression = wav.getcomptype()
            frames = wav.readframes(wav.getnframes())
    except (OSError, wave.Error) as exc:
        raise ValueError("calibration input must be a readable PCM WAV") from exc
    if channels != 1 or width != SAMPLE_WIDTH or rate != SAMPLE_RATE or compression != "NONE":
        raise ValueError("calibration WAV must be uncompressed 16 kHz mono PCM16")
    if not frames or len(frames) % SAMPLE_WIDTH:
        raise ValueError("calibration WAV contains no complete PCM16 samples")
    return frames


def _vad_positive_pcm(client: SpeechWorkerClient, pcm: bytes) -> tuple[bytes, int]:
    segments = client.speech_segments(pcm, sample_rate=SAMPLE_RATE)
    pieces: list[bytes] = []
    total_ms = 0
    bytes_per_ms = SAMPLE_RATE * SAMPLE_WIDTH / 1000.0
    duration_ms = int(round((len(pcm) / SAMPLE_WIDTH) * 1000.0 / SAMPLE_RATE))
    for start_ms, end_ms in segments:
        start = max(0, int(start_ms))
        end = min(duration_ms, int(end_ms))
        if end <= start:
            continue
        start_byte = int(round(start * bytes_per_ms))
        end_byte = int(round(end * bytes_per_ms))
        pieces.append(pcm[start_byte:end_byte])
        total_ms += end - start
    if total_ms < MIN_VAD_SPEECH_MS or not pieces:
        raise ValueError(f"calibration utterance has less than {MIN_VAD_SPEECH_MS} ms of VAD-positive speech")
    return b"".join(pieces), total_ms


def _embedding_for_wav(client: SpeechWorkerClient, path: Path) -> tuple[list[float], int]:
    pcm = _read_pcm16_wav(path)
    speech_pcm, speech_ms = _vad_positive_pcm(client, pcm)
    result = client.extract_embedding(speech_pcm, sample_rate=SAMPLE_RATE)
    embedding = result.get("embedding")
    if not isinstance(embedding, list):
        raise ValueError("speech worker did not return an embedding array")
    return _normalize(embedding), speech_ms


def _build_scores(samples: dict[str, list[list[float]]]) -> list[SampleScore]:
    full_centroids = {identity: _centroid(vectors) for identity, vectors in samples.items()}
    scores: list[SampleScore] = []
    for identity, vectors in samples.items():
        for index, vector in enumerate(vectors):
            own_reference = _centroid([v for i, v in enumerate(vectors) if i != index])
            own_score = _cosine(vector, own_reference)
            wrong_scores = sorted(
                (_cosine(vector, centroid) for other, centroid in full_centroids.items() if other != identity),
                reverse=True,
            )
            if not wrong_scores:
                raise ValueError("calibration requires at least two distinct identities")
            scores.append(
                SampleScore(
                    identity=identity,
                    own_score=own_score,
                    top_wrong_score=wrong_scores[0],
                    second_wrong_score=wrong_scores[1] if len(wrong_scores) > 1 else None,
                )
            )
    return scores


def _candidate_values(values: Iterable[float]) -> list[float]:
    clipped = sorted({max(0.0, min(1.0, float(v))) for v in values if math.isfinite(float(v))} | {0.0, 1.0})
    mids = {(a + b) / 2.0 for a, b in zip(clipped, clipped[1:]) if b > a}
    return sorted(clipped | mids)


def _evaluate(scores: list[SampleScore], threshold: float, margin: float) -> tuple[int, int, float]:
    false_rejects = 0
    false_accepts = 0
    robustness_terms: list[float] = []
    for sample in scores:
        genuine_gap = sample.genuine_margin
        if sample.own_score < threshold or genuine_gap < margin:
            false_rejects += 1
        else:
            robustness_terms.extend((sample.own_score - threshold, genuine_gap - margin))

        impostor_gap = sample.impostor_margin
        impostor_passes_margin = impostor_gap is None or impostor_gap >= margin
        if sample.top_wrong_score >= threshold and impostor_passes_margin:
            false_accepts += 1
        else:
            reject_buffers = [threshold - sample.top_wrong_score]
            if impostor_gap is not None:
                reject_buffers.append(margin - impostor_gap)
            robustness_terms.append(max(reject_buffers))

    robustness = min(robustness_terms) if robustness_terms else float("-inf")
    return false_accepts, false_rejects, robustness


def choose_calibration(scores: list[SampleScore]) -> tuple[float, float, dict[str, float | int]]:
    if not scores:
        raise ValueError("calibration requires scored utterances")
    genuine_scores = [s.own_score for s in scores]
    wrong_scores = [s.top_wrong_score for s in scores]
    genuine_margins = [s.genuine_margin for s in scores]
    impostor_margins = [s.impostor_margin for s in scores if s.impostor_margin is not None]

    thresholds = _candidate_values(genuine_scores + wrong_scores)
    margins = _candidate_values(genuine_margins + impostor_margins)
    safe: list[tuple[float, float, float]] = []
    for threshold in thresholds:
        for margin in margins:
            false_accepts, false_rejects, robustness = _evaluate(scores, threshold, margin)
            if false_accepts == 0 and false_rejects == 0:
                safe.append((robustness, threshold, margin))
    if not safe:
        raise ValueError("no threshold/margin pair yields zero observed false accepts and zero observed false rejects")

    robustness, threshold, margin = max(safe, key=lambda item: (item[0], item[1], item[2]))
    false_accepts, false_rejects, _ = _evaluate(scores, threshold, margin)
    if false_accepts or false_rejects:
        raise AssertionError("calibration search selected an unsafe operating point")
    return threshold, margin, {
        "false_accepts": false_accepts,
        "false_rejects": false_rejects,
        "min_genuine_score": min(genuine_scores),
        "max_impostor_score": max(wrong_scores),
        "min_genuine_margin": min(genuine_margins),
        "max_impostor_margin": max(impostor_margins) if impostor_margins else 0.0,
        "robustness": robustness,
    }


def _atomic_apply_env(path: Path, threshold: float, margin: float) -> None:
    path = path.resolve()
    path.parent.mkdir(parents=True, exist_ok=True)
    existing = path.read_text(encoding="utf-8").splitlines() if path.exists() else []
    updates = {
        THRESHOLD_KEY: f"{threshold:.9f}",
        MARGIN_KEY: f"{margin:.9f}",
    }
    output: list[str] = []
    seen: set[str] = set()
    for line in existing:
        key = line.split("=", 1)[0].strip() if "=" in line else ""
        if key in updates:
            if key not in seen:
                output.append(f"{key}={updates[key]}")
                seen.add(key)
            continue
        output.append(line)
    for key, value in updates.items():
        if key not in seen:
            output.append(f"{key}={value}")

    previous = path.stat() if path.exists() else None
    fd, tmp_name = tempfile.mkstemp(prefix=f".{path.name}.", dir=str(path.parent), text=True)
    tmp = Path(tmp_name)
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as handle:
            handle.write("\n".join(output).rstrip() + "\n")
            handle.flush()
            os.fsync(handle.fileno())
        if previous is not None:
            os.chmod(tmp, stat.S_IMODE(previous.st_mode))
            try:
                os.chown(tmp, previous.st_uid, previous.st_gid)
            except PermissionError:
                if os.geteuid() == 0:
                    raise
        else:
            os.chmod(tmp, 0o640)
        os.replace(tmp, path)
        dir_fd = os.open(path.parent, os.O_DIRECTORY)
        try:
            os.fsync(dir_fd)
        finally:
            os.close(dir_fd)
    finally:
        if tmp.exists():
            tmp.unlink()


def _paths(values: list[str]) -> list[Path]:
    return [Path(value).expanduser() for value in values if str(value).strip()]


def main() -> int:
    parser = argparse.ArgumentParser(description="Calibrate RK3588 XVector threshold/margin from local WAV samples.")
    parser.add_argument("--socket", default="/run/suspect-interrogation/speech.sock")
    parser.add_argument("--suspect-wavs", nargs="+", required=True)
    parser.add_argument("--interrogator-wavs", nargs="*", default=[])
    parser.add_argument("--recorder-wavs", nargs="*", default=[])
    parser.add_argument("--env-file", default="/etc/suspect-interrogation/ai-worker.env")
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("--output")
    args = parser.parse_args()

    groups = {
        "SUSPECT": _paths(args.suspect_wavs),
        "INTERROGATOR": _paths(args.interrogator_wavs),
        "RECORDER": _paths(args.recorder_wavs),
    }
    groups = {identity: paths for identity, paths in groups.items() if paths}
    if len(groups) < 2:
        parser.error("calibration requires SUSPECT plus at least one distinct officer identity")
    for identity, paths in groups.items():
        if len(paths) < MIN_UTTERANCES_PER_IDENTITY:
            parser.error(f"{identity} requires at least {MIN_UTTERANCES_PER_IDENTITY} separate utterance WAVs")
        for path in paths:
            if not path.is_file():
                parser.error(f"a calibration WAV does not exist for {identity}")

    client = SpeechWorkerClient(args.socket, timeout=30.0)
    health = client.health()
    models = health.get("models") if isinstance(health, dict) else None
    if not isinstance(models, dict) or not models.get("vad") or not models.get("speaker"):
        raise SystemExit("speech worker VAD/XVector models are not ready")

    samples: dict[str, list[list[float]]] = {}
    speech_ms_by_identity: dict[str, int] = {}
    for identity, paths in groups.items():
        vectors: list[list[float]] = []
        total_speech_ms = 0
        for path in paths:
            vector, speech_ms = _embedding_for_wav(client, path)
            vectors.append(vector)
            total_speech_ms += speech_ms
        samples[identity] = vectors
        speech_ms_by_identity[identity] = total_speech_ms

    scores = _build_scores(samples)
    threshold, margin, metrics = choose_calibration(scores)
    if not (0.0 <= threshold <= 1.0 and 0.0 <= margin <= 1.0):
        raise SystemExit("calibration result is outside the production [0, 1] configuration range")

    if args.apply:
        _atomic_apply_env(Path(args.env_file), threshold, margin)

    report = {
        "status": "safe" if metrics["false_accepts"] == 0 and metrics["false_rejects"] == 0 else "unsafe",
        "sample_rate": SAMPLE_RATE,
        "minimum_utterances_per_identity": MIN_UTTERANCES_PER_IDENTITY,
        "identities": {identity: {"utterances": len(samples[identity]), "vad_positive_ms": speech_ms_by_identity[identity]} for identity in sorted(samples)},
        "threshold": threshold,
        "margin": margin,
        **metrics,
        "applied": bool(args.apply),
        "privacy": "report contains aggregate scores only; no audio, file paths, or embeddings are persisted",
    }
    encoded = json.dumps(report, ensure_ascii=False, sort_keys=True, indent=2)
    print(encoded)
    if args.output:
        output_path = Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(encoded + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
