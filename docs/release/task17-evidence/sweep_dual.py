#!/usr/bin/env python3
"""Full-file sweep capturing BOTH cosine families per window (for splitter prototyping):

  cosPrev : cosine to the previous window  (change-point signal)
  cosRef  : cosine to the enrolled suspect reference (role/gate signal)

Run on the board with the FunASR venv python. Output feeds prototype_splitter.py, so the
change-point thresholds are validated on real audio before any production code is written.
"""
import argparse
import json
import math
import sqlite3
import struct
import sys
import time
import wave
from pathlib import Path

sys.path.insert(0, "/opt/suspect-interrogation/current/linux/backend")
MODEL_DIR = "/opt/suspect-interrogation/models/funasr/eres2net-large"
DB = "/var/lib/suspect-interrogation/interrogation.db"


def cosine(a, b) -> float:
    dot = sum(x * y for x, y in zip(a, b))
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(y * y for y in b))
    return dot / (na * nb) if na and nb else 0.0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--db", default=DB)
    ap.add_argument("--wav", required=True)
    ap.add_argument("--case", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--window", type=float, default=1.5)
    ap.add_argument("--hop", type=float, default=0.5)
    args = ap.parse_args()

    con = sqlite3.connect(f"file:{args.db}?mode=ro", uri=True)
    row = con.execute(
        "select embedding, embedding_dim, model_key, enrollment_quality, usable_duration_ms "
        "from suspect_voiceprints where case_id=?", (args.case,)).fetchone()
    if not row:
        print("NO_REFERENCE for", args.case)
        return 2
    blob, dim, model_key, quality, usable_ms = row
    reference = list(struct.unpack("<%df" % dim, blob))
    print(f"reference dim={dim} model={model_key} quality={quality} usable={usable_ms}ms")

    with wave.open(args.wav, "rb") as w:
        assert w.getnchannels() == 1 and w.getsampwidth() == 2
        pcm, rate = w.readframes(w.getnframes()), w.getframerate()

    from speech_worker.speaker.eres2net_large import ERes2NetLargeBackend
    backend = ERes2NetLargeBackend(model_path=MODEL_DIR)
    t0 = time.time()
    backend.load()
    print(f"loaded in {time.time() - t0:.1f}s", flush=True)

    win_b, hop_b = int(args.window * rate) * 2, int(args.hop * rate) * 2
    out = {"wav": args.wav, "window": args.window, "hop": args.hop, "reference": {
        "caseId": args.case, "dim": dim, "quality": quality, "usableDurationMs": usable_ms}, "windows": []}
    prev = None
    pos = 0
    while pos + win_b <= len(pcm):
        chunk = pcm[pos:pos + win_b]
        res = backend.extract_embedding(chunk, rate)
        vec = list(res.embedding) if hasattr(res, "embedding") else list(res)
        item = {
            "startMs": int(pos / 2 / rate * 1000),
            "endMs": int((pos + win_b) / 2 / rate * 1000),
            "cosRef": round(cosine(reference, vec), 4),
            "cosPrev": round(cosine(prev, vec), 4) if prev is not None else None,
        }
        out["windows"].append(item)
        prev = vec
        pos += hop_b
    out["embedMsMedian"] = None

    Path(args.out).parent.mkdir(parents=True, exist_ok=True)
    json.dump(out, open(args.out, "w"), ensure_ascii=False, indent=1)
    print(f"windows={len(out['windows'])} saved {args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
