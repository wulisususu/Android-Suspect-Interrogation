#!/usr/bin/env python3
"""Two-stage gating feasibility for the SpeakerTurnSplitter.

Question: can the ALREADY-COMPUTED whole-utterance embedding tell us "this utterance may mix
speakers" cheaply, so the expensive sliding-window split only runs when needed?

Method (all on real data):
  1. Read the enrolled suspect reference embedding from the production SQLite DB.
  2. For every annotated MOSS segment: embedding of the whole segment -> cosine vs reference.
     Clean suspect turns should score high, clean officer turns low.
  3. For the mixed 5s window (the realtime failure): whole-window cosine vs reference, plus its
     sliding-window cosines, to see where it lands.
Run with the FunASR venv python on the board.
"""
import argparse
import json
import math
import sqlite3
import struct
import sys
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
    ap.add_argument("--timeline", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--mixed-start", type=int, default=99840)
    ap.add_argument("--mixed-end", type=int, default=105240)
    args = ap.parse_args()

    con = sqlite3.connect(f"file:{args.db}?mode=ro", uri=True)
    row = con.execute(
        "select embedding, embedding_dim, model_key, model_id, enrollment_quality, usable_duration_ms "
        "from suspect_voiceprints where case_id=?", (args.case,)).fetchone()
    if not row:
        print("NO_REFERENCE for", args.case)
        return 2
    blob, dim, model_key, model_id, quality, usable_ms = row
    reference = list(struct.unpack("<%df" % dim, blob))
    print(f"reference: dim={dim} model={model_key}/{model_id} quality={quality} usable={usable_ms}ms")

    with wave.open(args.wav, "rb") as w:
        assert w.getnchannels() == 1 and w.getsampwidth() == 2
        pcm, rate = w.readframes(w.getnframes()), w.getframerate()

    from speech_worker.speaker.eres2net_large import ERes2NetLargeBackend
    backend = ERes2NetLargeBackend(model_path=MODEL_DIR)
    backend.load()

    def embed(start_ms: int, end_ms: int):
        a, b = int(start_ms * 16) * 2, int(end_ms * 16) * 2
        chunk = pcm[max(0, a):min(len(pcm), b)]
        if len(chunk) < 16000:
            return None
        res = backend.extract_embedding(chunk, rate)
        vec = list(res.embedding) if hasattr(res, "embedding") else list(res)
        return vec

    tl = json.load(open(args.timeline, encoding="utf-8"))["segments"]
    seg_scores = []
    for s in tl:
        vec = embed(s["startMs"], s["endMs"])
        if vec is None:
            continue
        seg_scores.append({
            "startMs": s["startMs"], "endMs": s["endMs"], "role": s["mossRole"], "text": (s["text"] or "")[:22],
            "cos": round(cosine(reference, vec), 4),
        })

    by_role: dict[str, list[float]] = {}
    for s in seg_scores:
        by_role.setdefault(s["role"], []).append(s["cos"])
    stats = {}
    for role, vals in by_role.items():
        v = sorted(vals)
        stats[role] = {"n": len(v), "min": v[0], "median": v[len(v) // 2], "max": v[-1]}

    # the mixed window that broke realtime, as one whole utterance + its sliding windows
    mixed_whole = embed(args.mixed_start, args.mixed_end)
    mixed_windows = []
    if mixed_whole is not None:
        win, hop = 1500, 500
        pos = args.mixed_start
        while pos + win <= args.mixed_end:
            vec = embed(pos, pos + win)
            if vec is not None:
                mixed_windows.append({"startMs": pos, "endMs": pos + win, "cos": round(cosine(reference, vec), 4)})
            pos += hop

    out = {
        "reference": {"caseId": args.case, "dim": dim, "quality": quality, "usableDurationMs": usable_ms},
        "perSegment": seg_scores,
        "perRoleStats": stats,
        "mixedWindow": {
            "startMs": args.mixed_start, "endMs": args.mixed_end,
            "wholeUtteranceCos": round(cosine(reference, mixed_whole), 4) if mixed_whole else None,
            "sliding": mixed_windows,
        },
    }
    Path(args.out).parent.mkdir(parents=True, exist_ok=True)
    json.dump(out, open(args.out, "w"), ensure_ascii=False, indent=1)

    print("\nper-role whole-segment cosine vs suspect reference:")
    for role, s in stats.items():
        print(f"  {role:12} n={s['n']:3} min={s['min']:.3f} median={s['median']:.3f} max={s['max']:.3f}")
    print(f"\nmixed window whole-utterance cosine = {out['mixedWindow']['wholeUtteranceCos']}")
    print("mixed window sliding cosines:")
    for w in mixed_windows:
        print(f"  {w['startMs']:>7}  {w['cos']}")
    print("saved:", args.out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
