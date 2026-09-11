#!/usr/bin/env python3
"""Speaker-change sweep on the board: adjacent-window cosine similarity on 21.wav.

Purpose: give the SpeakerTurnSplitter (Task 17B-2) data-driven window/hop/threshold
starting points instead of guesses. Runs only ERes2Net (no ASR/VAD load).

Usage (board):
  /opt/suspect-interrogation/runtime/funasr-env/bin/python sweep_speaker_change.py \
      --wav /var/lib/suspect-interrogation/t15/case-zhangming.wav \
      --out /home/youyeetoo/task17/sweep-1.5-0.5.json \
      --window 1.5 --hop 0.5 [--start 0 --end 0]
"""
import argparse
import json
import math
import sys
import time
import wave
from pathlib import Path

BACKEND = "/opt/suspect-interrogation/current/linux/backend"
sys.path.insert(0, BACKEND)
MODEL_DIR = "/opt/suspect-interrogation/models/funasr/eres2net-large"


def load_pcm(path: str) -> tuple[bytes, int]:
    with wave.open(path, "rb") as w:
        assert w.getnchannels() == 1 and w.getsampwidth() == 2, w.getparams()
        return w.readframes(w.getnframes()), w.getframerate()


def cosine(a, b) -> float:
    dot = sum(x * y for x, y in zip(a, b))
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(y * y for y in b))
    return dot / (na * nb) if na and nb else 0.0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--wav", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--window", type=float, default=1.5)
    ap.add_argument("--hop", type=float, default=0.5)
    ap.add_argument("--start", type=float, default=0.0)
    ap.add_argument("--end", type=float, default=0.0)
    args = ap.parse_args()

    from speech_worker.speaker.eres2net_large import ERes2NetLargeBackend

    pcm, rate = load_pcm(args.wav)
    assert rate == 16000, f"expected 16k, got {rate}"
    total_s = len(pcm) / (rate * 2)

    backend = ERes2NetLargeBackend(model_path=MODEL_DIR)
    t0 = time.time()
    backend.load()
    print(f"ERes2Net loaded in {time.time() - t0:.1f}s", flush=True)

    win_b = int(args.window * rate) * 2
    hop_b = int(args.hop * rate) * 2
    start_b = int((args.start or 0) * rate) * 2
    end_b = int(args.end * rate) * 2 if args.end else len(pcm)

    windows = []
    pos = start_b
    while pos + win_b <= end_b:
        chunk = pcm[pos : pos + win_b]
        t1 = time.time()
        try:
            res = backend.extract_embedding(chunk, rate)
            vec = list(res.embedding) if hasattr(res, "embedding") else list(res)
        except Exception as exc:  # keep the sweep going, record the failure
            windows.append({"startMs": int(pos / 2 / rate * 1000), "error": str(exc)[:120]})
            pos += hop_b
            continue
        windows.append({
            "startMs": int(pos / 2 / rate * 1000),
            "endMs": int((pos + win_b) / 2 / rate * 1000),
            "embedMs": round((time.time() - t1) * 1000),
            "dim": len(vec),
            "vec": [round(float(v), 5) for v in vec],
        })
        pos += hop_b

    ok = [w for w in windows if "vec" in w]
    for i in range(1, len(ok)):
        ok[i]["cosPrev"] = round(cosine(ok[i - 1]["vec"], ok[i]["vec"]), 4)
    cos_series = [w["cosPrev"] for w in ok[1:]]

    # data-driven threshold band: use the corpus annotation (MOSS clusters) if provided
    out = {
        "wav": args.wav,
        "totalSeconds": round(total_s, 2),
        "window": args.window,
        "hop": args.hop,
        "windows": len(ok),
        "embedMsMedian": sorted(w["embedMs"] for w in ok)[len(ok) // 2] if ok else None,
        "cosine": {
            "min": min(cos_series) if cos_series else None,
            "p05": sorted(cos_series)[max(0, int(len(cos_series) * 0.05))] if cos_series else None,
            "median": sorted(cos_series)[len(cos_series) // 2] if cos_series else None,
            "p95": sorted(cos_series)[min(len(cos_series) - 1, int(len(cos_series) * 0.95))] if cos_series else None,
            "max": max(cos_series) if cos_series else None,
        },
        "series": [{"startMs": w["startMs"], "endMs": w["endMs"], "cosPrev": w.get("cosPrev")} for w in ok],
    }

    # region of interest: the mixed utterance the realtime chain got wrong
    roi = [w for w in ok if 93000 <= w["startMs"] <= 112000]
    out["regionOfInterest_93-112s"] = [
        {"startMs": w["startMs"], "endMs": w["endMs"], "cosPrev": w.get("cosPrev")} for w in roi
    ]

    Path(args.out).parent.mkdir(parents=True, exist_ok=True)
    json.dump(out, open(args.out, "w"), ensure_ascii=False, indent=1)

    print(f"windows={out['windows']} median_embed_ms={out['embedMsMedian']}")
    print("cosine stats:", out["cosine"])
    print("region 93-112s (startMs, cosPrev):")
    for w in roi:
        print(f"  {w['startMs']:>7}  {w.get('cosPrev')}")
    print("saved:", args.out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
