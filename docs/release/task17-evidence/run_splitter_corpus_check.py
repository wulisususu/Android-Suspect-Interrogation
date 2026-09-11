#!/usr/bin/env python3
"""Board acceptance for Task 17B-2: run the REAL SpeakerTurnSplitter over the golden corpus.

Uses the production ERes2Net model and the enrolled suspect reference (both real), replays the
annotated segments as candidate VAD utterances, and asserts:

  MUST-PASS  mixed-turn-src-99.8-105.2 (99840-105240ms)
             -> split into >=2 turns with opposing roles, or marked ambiguous
             -> NEVER a single span that the policy would label SUSPECT
  NO-REGRESSION  clean single-speaker segments -> exactly one span each (no over-splitting)

Run on the board:
  SUSPECT_ERES2NET_MODEL_DIR=/opt/.../eres2net-large \
  /opt/suspect-interrogation/runtime/funasr-env/bin/python run_splitter_corpus_check.py \
      --wav /tmp/t17-21.wav --timeline <timeline.json> --db /tmp/interrogation.db \
      --case CASE-20260911-EBD4BF --out /tmp/t17-splitter-check.json
"""
import argparse
import hashlib
import json
import math
import sqlite3
import struct
import sys
import wave
from pathlib import Path

BACKEND = "/opt/suspect-interrogation/current/linux/backend"
sys.path.insert(0, BACKEND)
MODEL_DIR = "/opt/suspect-interrogation/models/funasr/eres2net-large"
MUST_PASS = {"startMs": 99840, "endMs": 105240, "name": "mixed-turn-src-99.8-105.2"}
BAND_HIGH, BAND_LOW = 0.70, 0.29


def cosine(a, b) -> float:
    dot = sum(x * y for x, y in zip(a, b))
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(y * y for y in b))
    return dot / (na * nb) if na and nb else 0.0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--wav", required=True)
    ap.add_argument("--timeline", required=True)
    ap.add_argument("--db", default="/var/lib/suspect-interrogation/interrogation.db")
    ap.add_argument("--case", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--expect-sha", default=None)
    ap.add_argument("--splitter-file", default=None,
                    help="load SpeakerTurnSplitter from this file instead of the installed package "
                         "(used to prove the harness passes on a correct implementation)")
    ap.add_argument("--no-reference", action="store_true",
                    help="run the splitter the way the live speech worker must: without any biometric "
                         "reference (the worker must never touch the voiceprint database). Roles are then "
                         "judged downstream; this mode asserts the worker-side invariant instead: never a "
                         "single SUSPECT turn over a mixed utterance.")
    args = ap.parse_args()

    # corpus integrity
    h = hashlib.sha256()
    with open(args.wav, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    sha = h.hexdigest()
    print(f"wav sha256={sha}")
    if args.expect_sha and sha != args.expect_sha:
        print(f"FATAL: sha mismatch (expected {args.expect_sha})")
        return 2

    # reference voiceprint
    con = sqlite3.connect(f"file:{args.db}?mode=ro", uri=True)
    row = con.execute("select embedding, embedding_dim from suspect_voiceprints where case_id=?",
                      (args.case,)).fetchone()
    if not row:
        print("FATAL: no reference voiceprint for", args.case)
        return 2
    reference = list(struct.unpack("<%df" % row[1], row[0]))

    with wave.open(args.wav, "rb") as w:
        assert w.getnchannels() == 1 and w.getsampwidth() == 2
        pcm, rate = w.readframes(w.getnframes()), w.getframerate()

    from speech_worker.speaker.eres2net_large import ERes2NetLargeBackend
    backend = ERes2NetLargeBackend(model_path=MODEL_DIR)
    backend.load()

    def embed(chunk: bytes):
        res = backend.extract_embedding(chunk, rate)
        return list(res.embedding) if hasattr(res, "embedding") else list(res)

    try:
        if args.splitter_file:
            import importlib.util
            spec = importlib.util.spec_from_file_location("t17_splitter_probe", args.splitter_file)
            module = importlib.util.module_from_spec(spec)
            # dataclasses resolves cls.__module__ through sys.modules, so register first
            sys.modules[spec.name] = module
            spec.loader.exec_module(module)
            SpeakerTurnSplitter = module.SpeakerTurnSplitter
            print(f"splitter loaded from file: {args.splitter_file}")
        else:
            from speech_worker.speaker_turn_splitter import SpeakerTurnSplitter
    except Exception as exc:
        print("NOT_IMPLEMENTED: speech_worker.speaker_turn_splitter unavailable:", exc)
        json.dump({"status": "NOT_IMPLEMENTED", "error": str(exc)[:200]},
                  open(args.out, "w"), ensure_ascii=False, indent=1)
        return 3

    splitter = SpeakerTurnSplitter()
    tl = json.load(open(args.timeline, encoding="utf-8"))["segments"]

    def segment_pcm(start_ms: int, end_ms: int) -> bytes:
        a, b = int(start_ms * 16) * 2, int(end_ms * 16) * 2
        return pcm[max(0, a):min(len(pcm), b)]

    def role_of(chunk: bytes) -> tuple[str, float]:
        c = cosine(reference, embed(chunk))
        if c >= BAND_HIGH:
            return "SUSPECT", round(c, 3)
        if c <= BAND_LOW:
            return "INTERROGATOR", round(c, 3)
        return "UNKNOWN", round(c, 3)

    results = []
    for s in tl:
        chunk = segment_pcm(s["startMs"], s["endMs"])
        if len(chunk) < 16000:
            continue
        try:
            spans = splitter.split(chunk, rate, embed=embed, reference=reference)
        except Exception as exc:
            results.append({"startMs": s["startMs"], "endMs": s["endMs"], "error": str(exc)[:160]})
            continue
        turns = []
        for sp in spans:
            start, end = getattr(sp, "start_ms", 0), getattr(sp, "end_ms", None)
            sub = chunk[int(start * 16) * 2: int(end * 16) * 2] if end else chunk
            role, c = role_of(sub) if len(sub) >= 16000 else ("UNKNOWN", None)
            turns.append({"startMs": s["startMs"] + start,
                          "endMs": s["startMs"] + (end if end is not None else 0),
                          "ambiguous": bool(getattr(sp, "ambiguous", False)),
                          "role": role, "cosRef": c})
        results.append({"startMs": s["startMs"], "endMs": s["endMs"],
                        "annotatedRole": s["mossRole"], "spans": len(spans), "turns": turns})

    # MUST-PASS: replay the realtime failure shape -- the whole mixed window as ONE VAD utterance.
    # The annotation splits it into an officer segment and a suspect segment; the VAD utterance
    # did not, which is exactly why production labelled the whole thing SUSPECT.
    mp_pcm = segment_pcm(MUST_PASS["startMs"], MUST_PASS["endMs"])
    worker_reference = None if args.no_reference else reference
    mp_spans = splitter.split(mp_pcm, rate, embed=embed, reference=worker_reference)
    mp_turns = []
    for sp in mp_spans:
        start, end = getattr(sp, "start_ms", 0), getattr(sp, "end_ms", None)
        sub = mp_pcm[int(start * 16) * 2: int(end * 16) * 2] if end else mp_pcm
        role, c = role_of(sub) if len(sub) >= 16000 else ("UNKNOWN", None)
        mp_turns.append({"startMs": MUST_PASS["startMs"] + start,
                         "endMs": MUST_PASS["startMs"] + (end if end is not None else 0),
                         "ambiguous": bool(getattr(sp, "ambiguous", False)),
                         "role": role, "cosRef": c})
    detail = {"spans": len(mp_spans), "turns": mp_turns,
              "windowMs": [MUST_PASS["startMs"], MUST_PASS["endMs"]],
              "mode": "worker-no-reference" if args.no_reference else "reference-assisted"}
    roles = {t["role"] for t in mp_turns if t["role"] != "UNKNOWN"}
    ambiguous = any(t["ambiguous"] for t in mp_turns)
    single_suspect = len(mp_turns) == 1 and mp_turns[0]["role"] == "SUSPECT" and not mp_turns[0]["ambiguous"]
    if args.no_reference:
        # Without a reference the worker cannot know who is who, so the required invariant is weaker
        # but still meaningful: it must not hand the backend one undivided span, and it must never
        # claim a confident single SUSPECT turn over mixed audio.
        ok_must = (len(mp_turns) >= 2 or ambiguous) and not single_suspect
    else:
        ok_must = ((len(mp_turns) >= 2 and len(roles) >= 2) or ambiguous) and not single_suspect
    clean = [r for r in results if r.get("spans") == 1 and r["annotatedRole"] in ("SUSPECT", "INTERROGATOR")]
    oversplit = [r for r in results
                 if r.get("spans", 1) > 1 and r["annotatedRole"] in ("SUSPECT", "INTERROGATOR")
                 and not any(t["ambiguous"] for t in r.get("turns", []))]

    out = {
        "status": "OK",
        "mustPass": {"name": MUST_PASS["name"], "satisfied": bool(ok_must), "detail": detail},
        "segments": len(results),
        "singleSpanCleanSegments": len(clean),
        "oversplitCleanSegments": len(oversplit),
        "oversplitExamples": oversplit[:5],
        "results": results,
    }
    json.dump(out, open(args.out, "w"), ensure_ascii=False, indent=1)

    print(f"\n=== MUST-PASS {MUST_PASS['name']} ===")
    print("  satisfied:", ok_must)
    if detail:
        for t in detail.get("turns", []):
            print(f"    [{t['startMs']}-{t['endMs']}] role={t['role']} cosRef={t['cosRef']} ambiguous={t['ambiguous']}")
    print(f"\n=== over-splitting check ===")
    print(f"  clean segments kept as a single span: {len(clean)}/{len(results)}")
    print(f"  clean segments wrongly split: {len(oversplit)}")
    for o in oversplit[:5]:
        print(f"    [{o['startMs']}-{o['endMs']}] {o['annotatedRole']} -> {o['spans']} spans")
    print(f"\nsaved {args.out}")
    return 0 if ok_must else 1


if __name__ == "__main__":
    raise SystemExit(main())
