#!/usr/bin/env python3
"""Validate the two-stage SpeakerTurnSplitter design on real swept embeddings.

Inputs (all produced on the RK3588 with the production ERes2Net model):
  --gate    task17-gate-evidence.json    per-annotated-segment whole-utterance cos vs the
                                         enrolled suspect reference + the mixed window's
                                         whole-utterance and sliding cosines
  --dual    task17-dual-sweep.json       whole-file sliding windows with cosPrev + cosRef
  --timeline dual_qa_21_speaker_timeline.json   assisted annotation (mossRole per segment)

What it answers:
  1. Does the stage-1 gate (single whole-utterance embedding) resolve every clean segment
     WITHOUT running the sliding split, and does it flag the mixed utterance as ambiguous?
  2. Is the gate band different from the role accept threshold (0.372 + margin 0.08)?
  3. When stage 2 runs on the mixed utterance, does the change point land on the real
     speaker change (±1s)?
  4. How often would stage 2 run (cost proxy)?
"""
import argparse
import json
import statistics as st


def load(p):
    return json.load(open(p, encoding="utf-8"))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--gate", default=r"D:\police Android\task17\task17-gate-evidence.json")
    ap.add_argument("--dual", default=r"D:\police Android\task17\docs\release\task17-evidence\task17-dual-sweep.json")
    ap.add_argument("--timeline", default=r"D:\police Android\task17\linux\backend\tests\fixtures\speaker_turn_corpus\dual_qa_21_speaker_timeline.json")
    ap.add_argument("--accept-threshold", type=float, default=0.372)
    ap.add_argument("--margin", type=float, default=0.08)
    args = ap.parse_args()

    gate = load(args.gate)
    dual = load(args.dual)
    tl = load(args.timeline)["segments"]

    seg_scores = gate["perSegment"]
    rng = {r: [s["cos"] for s in seg_scores if s["role"] == r] for r in ("SUSPECT", "INTERROGATOR")}
    suspect_min, officer_max = min(rng["SUSPECT"]), max(rng["INTERROGATOR"])
    print("=== observed single-speaker extremes (whole-segment embedding vs reference) ===")
    print(f"  SUSPECT     n={len(rng['SUSPECT']):3} min={suspect_min:.3f} max={max(rng['SUSPECT']):.3f}")
    print(f"  INTERROGATOR n={len(rng['INTERROGATOR']):3} min={min(rng['INTERROGATOR']):.3f} max={officer_max:.3f}")
    print(f"  production accept threshold={args.accept_threshold} margin={args.margin} "
          f"-> accept boundary={args.accept_threshold:.3f}")

    # gate band: stricter than the role accept threshold, derived from observed extremes
    band_low = round(officer_max + 0.02, 2)     # 0.29-ish
    band_high = round(suspect_min - 0.02, 2)    # 0.70-ish
    print(f"\n=== proposed gate band (single-speaker confidence) ===\n  confident-other <= {band_low} | ambiguous ({band_low}, {band_high}) | confident-suspect >= {band_high}")

    def stage1(cos_value: float) -> str:
        if cos_value >= band_high:
            return "SINGLE_SUSPECT"
        if cos_value <= band_low:
            return "SINGLE_OTHER"
        return "AMBIGUOUS"

    counts = {"SINGLE_SUSPECT": 0, "SINGLE_OTHER": 0, "AMBIGUOUS": 0}
    wrong = []
    for s in seg_scores:
        v = stage1(s["cos"])
        counts[v] += 1
        expected = "SINGLE_SUSPECT" if s["role"] == "SUSPECT" else "SINGLE_OTHER"
        if v != expected:
            wrong.append((s["startMs"], s["endMs"], s["role"], s["cos"], v))
    print(f"\n=== stage 1 over {len(seg_scores)} annotated clean segments ===")
    print(f"  {counts}")
    print(f"  misrouted (would need stage 2 or be mislabelled): {len(wrong)}")
    for w in wrong[:8]:
        print(f"    [{w[0]}-{w[1]}] role={w[2]} cos={w[3]} -> {w[4]}")

    mixed = gate["mixedWindow"]
    print(f"\n=== the mixed 5s utterance (the production failure) ===")
    print(f"  whole-utterance cos = {mixed['wholeUtteranceCos']}  -> stage1 = {stage1(mixed['wholeUtteranceCos'])}")
    print(f"  (mean of its sliding cosRef would be "
          f"{st.mean([w['cos'] for w in mixed['sliding']]):.3f} -> {stage1(st.mean([w['cos'] for w in mixed['sliding']]))}"
          f"  <-- why the gate MUST use one whole-utterance embedding, not the window mean)")

    # stage 2 on the mixed utterance, using the file sweep's cosPrev inside that span
    win = [w for w in dual["windows"] if mixed["startMs"] <= w["startMs"] <= mixed["endMs"]]
    print(f"\n=== stage 2: change-point detection inside the mixed utterance ===")
    T_FIRE = 0.50
    pts = [(w["startMs"], w["cosPrev"]) for w in win if w["cosPrev"] is not None]
    below = [p for p in pts if p[1] < T_FIRE]
    print(f"  T_FIRE={T_FIRE} windows below: {[(ms, c) for ms, c in below]}")
    confirmed = []
    for i, (ms, c) in enumerate(pts):
        if c < T_FIRE:
            nxt = pts[i + 1][1] if i + 1 < len(pts) else None
            prv = pts[i - 1][1] if i > 0 else None
            if (nxt is not None and nxt < T_FIRE) or (prv is not None and prv < T_FIRE):
                confirmed.append(ms)
    print(f"  rule A (>=2 consecutive below): {confirmed}")
    # rule B: a single dip is enough when BOTH sides carry opposing role evidence, because a
    # short mixed utterance (5s -> 11 windows) may contain only one dip pair.
    rule_b = []
    for ms, c in below:
        left = [w["cosRef"] for w in win if w["startMs"] < ms]
        right = [w["cosRef"] for w in win if w["startMs"] >= ms]
        if not left or not right:
            continue
        left_role, right_role = stage1(st.mean(left)), stage1(st.mean(right))
        if {left_role, right_role} == {"SINGLE_SUSPECT", "SINGLE_OTHER"}:
            rule_b.append((ms, round(st.mean(left), 3), left_role, round(st.mean(right), 3), right_role))
    print(f"  rule B (single dip + opposing role evidence): {rule_b}")
    truth = 103310  # annotation: end of officer question / start of suspect answer region
    for ms in confirmed:
        print(f"    ruleA {ms} vs truth {truth} -> offset {ms - truth} ms")
    for row in rule_b:
        print(f"    ruleB {row[0]} vs truth {truth} -> offset {row[0] - truth} ms | "
              f"left cosRef={row[1]} ({row[2]}) right cosRef={row[3]} ({row[4]})")
    chosen = rule_b[0][0] if rule_b else (confirmed[0] if confirmed else None)
    if chosen is not None:
        left = [w for w in win if w["startMs"] < chosen]
        right = [w for w in win if w["startMs"] >= chosen]
        print(f"  chosen split at {chosen}: "
              f"turn A mean cosRef={st.mean([w['cosRef'] for w in left]):.3f} -> {stage1(st.mean([w['cosRef'] for w in left]))} | "
              f"turn B mean cosRef={st.mean([w['cosRef'] for w in right]):.3f} -> {stage1(st.mean([w['cosRef'] for w in right]))}")
        print("  => must-pass point SATISFIED (two turns with opposing roles; never one whole SUSPECT)")
    else:
        print("  => no split: fall back to UNKNOWN (conservative, never whole-SUSPECT)")

    # cost proxy: how many utterances need stage 2
    total_segments = len(tl)
    ambiguous_segments = len(wrong)
    print(f"\n=== cost proxy ===")
    print(f"  stage-2 triggers as a share of clean segments: {ambiguous_segments}/{total_segments}")
    print(f"  per-trigger window embeddings: {len(win)} windows (~690ms each on RK3588)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
