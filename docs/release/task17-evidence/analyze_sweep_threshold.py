#!/usr/bin/env python3
"""Evaluate change-point detectability from the board sweep against the corpus annotation.

Instead of labelling window pairs by midpoints (unreliable: speaker changes here come with
pauses, so midpoints fall into gaps), this measures the detector directly:

  boundary dip   : for each annotated role change at time B, min cosine within B +/- 1.0s
  interior noise : min cosine inside homogeneous stretches (>=1.5s away from any change)

A usable threshold must sit above interior noise and below boundary dips. Also reports the
cost model (embedding ms per window) so the splitter design stays realtime-feasible.
"""
import json
import sys

SWEEP = sys.argv[1] if len(sys.argv) > 1 else "task17-sweep-1.5-0.5.json"
TIMELINE = sys.argv[2] if len(sys.argv) > 2 else r"D:\police Android\task15\browser\dual_qa_21_speaker_timeline.json"

sweep = json.load(open(SWEEP, encoding="utf-8"))
series = [s for s in sweep["series"] if s.get("cosPrev") is not None]
tl = sorted(json.load(open(TIMELINE, encoding="utf-8"))["segments"], key=lambda s: s["startMs"])

# pair i is scored at series[i]["startMs"] with cosine series[i]["cosPrev"]
pts = [(s["startMs"], s["cosPrev"]) for s in series]

# annotated transitions: role change between adjacent segments (short gaps included)
transitions = []
for a, b in zip(tl, tl[1:]):
    if a["mossRole"] != b["mossRole"] and (b["startMs"] - a["endMs"]) <= 3000:
        transitions.append({"atMs": (a["endMs"] + b["startMs"]) // 2,
                            "from": a["mossRole"], "to": b["mossRole"],
                            "gapMs": b["startMs"] - a["endMs"]})

WIN = 1000.0
def window_min(center_ms: float, half_ms: float = WIN):
    vals = [c for ms, c in pts if abs(ms - center_ms) <= half_ms]
    return (min(vals), len(vals)) if vals else (None, 0)

boundary = []
for t in transitions:
    lo, n = window_min(t["atMs"])
    boundary.append({**t, "dipCos": lo, "samples": n})

interior = []
for s in tl:
    mid = (s["startMs"] + s["endMs"]) / 2
    if any(abs(mid - t["atMs"]) <= 1500 for t in transitions):
        continue
    if s["endMs"] - s["startMs"] < 2000:
        continue
    lo, n = window_min(mid, half_ms=(s["endMs"] - s["startMs"]) / 2 - 200)
    interior.append({"role": s["mossRole"], "startMs": s["startMs"], "minCos": lo, "samples": n})

bd = sorted([b["dipCos"] for b in boundary if b["dipCos"] is not None])
inr = sorted([i["minCos"] for i in interior if i["minCos"] is not None])

print(f"sweep windows: {len(pts)} | annotated transitions: {len(transitions)} | homogeneous stretches sampled: {len(interior)}")
print(f"\nBOUNDARY dips (detector should fire)  n={len(bd)}")
if bd:
    print(f"  min={bd[0]:.3f} p25={bd[len(bd)//4]:.3f} median={bd[len(bd)//2]:.3f} p75={bd[3*len(bd)//4]:.3f} max={bd[-1]:.3f}")
print(f"\nINTERIOR noise (detector must stay quiet)  n={len(inr)}")
if inr:
    print(f"  min={inr[0]:.3f} p10={inr[int(len(inr)*0.1)]:.3f} median={inr[len(inr)//2]:.3f} max={inr[-1]:.3f}")

if bd and inr:
    overlap_lo, overlap_hi = max(bd), min(inr)
    print(f"\nseparation: max boundary dip={overlap_lo:.3f} vs min interior dip={overlap_hi:.3f} "
          f"-> {'SEPARABLE' if overlap_lo < overlap_hi else 'OVERLAPPING'}"
          f" (margin={overlap_hi - overlap_lo:+.3f})")
    print("\nthreshold candidates (fire if window min cos < t):")
    print(f"{'t':>5} {'boundaries detected':>20} {'interior false fires':>21}")
    for t100 in range(30, 91, 5):
        t = t100 / 100
        det = sum(1 for b in boundary if b["dipCos"] is not None and b["dipCos"] < t)
        fp = sum(1 for i in interior if i["minCos"] is not None and i["minCos"] < t)
        print(f"{t:>5.2f} {det:>13}/{len(boundary):<6} {fp:>14}/{len(interior):<6}")

print("\nper-boundary detail:")
for b in sorted(boundary, key=lambda x: (x["dipCos"] if x["dipCos"] is not None else 9)):
    print(f"  {b['atMs']:>7}ms  dip={b['dipCos']}  {b['from']} -> {b['to']}  gap={b['gapMs']}ms  samples={b['samples']}")

print("\ncost model:")
w = sweep["window"]; h = sweep["hop"]
print(f"  window={w}s hop={h}s | median embed={sweep['embedMsMedian']}ms")
n_per_5s = int(5 / h)
print(f"  windows per 5s utterance = {n_per_5s} -> {n_per_5s * sweep['embedMsMedian'] / 1000:.1f}s of embedding compute "
      f"(splitter-only RTF {n_per_5s * sweep['embedMsMedian'] / 5000:.2f})")
