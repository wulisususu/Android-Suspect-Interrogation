"""Static cross-layer check: do the readiness keys the backend emits survive the webapp's
type contract and the API normalizer?

The same class of defect already bit once (normalizeVoiceprintReadiness silently dropped the
new speaker-mode fields), so this compares three sources of truth:

  1. backend: keys returned by VoiceprintService.readiness + SpeakerModeConfig.as_readiness_fields
  2. webapp type: VoiceprintReadiness fields
  3. webapp normalizer: keys copied by normalizeVoiceprintReadiness

Run: python docs/release/task17-evidence/check_readiness_field_parity.py
"""
import re
import sys
from pathlib import Path

ROOT = Path(r"D:\police Android\task17")
SERVICE = ROOT / "linux/backend/app/services/voiceprint_service.py"
MODE = ROOT / "linux/backend/app/services/speaker_mode.py"
TYPES = ROOT / "webapp/src/types/interrogation.ts"
NORMALIZER = ROOT / "webapp/src/api/interrogation.ts"


def backend_keys() -> set[str]:
    keys: set[str] = set()
    src = SERVICE.read_text(encoding="utf-8")
    # camelCase string keys in the readiness payload, plus identifier keys in dict literals
    for m in re.finditer(r'"([a-zA-Z][A-Za-z0-9]*)"\s*:', src):
        keys.add(m.group(1))
    for m in re.finditer(r"^\s{8,}([a-z][A-Za-z0-9_]*)\s*[:=]", src, re.M):
        keys.add(m.group(1))
    mode_src = MODE.read_text(encoding="utf-8")
    for m in re.finditer(r'"([a-zA-Z][A-Za-z0-9]*)"\s*:', mode_src):
        keys.add(m.group(1))
    # keys defined through the shared constants
    for const in ("MODE_DECLARED_KEY", "MODE_EFFECTIVE_KEY", "MODE_DEGRADED_KEY", "MODE_REASON_KEY"):
        cm = re.search(rf'{const}\s*=\s*"([^"]+)"', mode_src)
        if cm:
            keys.add(cm.group(1))
    return keys


def readiness_relevant(keys: set[str]) -> set[str]:
    """Keep only keys that plausibly belong to the readiness payload."""
    interesting = (
        "recognition", "speaker", "suspect", "interrogator", "recorder", "canStart",
        "enrollment", "usable", "modelKey", "modelId", "modelVersion", "threshold", "margin",
    )
    return {k for k in keys if any(t.lower() in k.lower() for t in interesting)}


def ts_interface_fields() -> set[str]:
    """Fields of VoiceprintReadiness plus the interface(s) it extends."""
    src = TYPES.read_text(encoding="utf-8")
    fields: set[str] = set()
    todo = ["VoiceprintReadiness"]
    seen: set[str] = set()
    while todo:
        name = todo.pop()
        if name in seen:
            continue
        seen.add(name)
        m = re.search(rf"export interface {name}(?: extends ([A-Za-z0-9_,\s]+))? \{{(.*?)\n\}}", src, re.S)
        if not m:
            continue
        parents, body = m.group(1), m.group(2)
        fields |= set(re.findall(r"^\s*([A-Za-z][A-Za-z0-9]*)\??:", body, re.M))
        if parents:
            todo.extend(p.strip() for p in parents.split(",") if p.strip())
    if not fields:
        raise SystemExit("VoiceprintReadiness interface not found")
    return fields


def normalizer_keys() -> set[str]:
    """Keys the readiness normalizer copies through to the UI (it is not exported)."""
    src = NORMALIZER.read_text(encoding="utf-8")
    start = src.find("function normalizeVoiceprintReadiness")
    if start < 0:
        raise SystemExit("normalizeVoiceprintReadiness not found")
    # take the function body up to the next top-level declaration
    rest = src[start:]
    end = re.search(r"\n(?:export )?(?:async )?function |\nconst [A-Za-z]", rest[1:])
    body = rest[: end.start() + 1] if end else rest
    return set(re.findall(r"([A-Za-z][A-Za-z0-9]*)\s*:", body))


def consumed_fields() -> dict[str, list[str]]:
    """Fields the UI actually reads off a readiness object, mapped to where they are read."""
    import collections
    hits: dict[str, list[str]] = collections.defaultdict(list)
    pattern = re.compile(r"(?:readiness|voiceprintReadiness)\.([A-Za-z][A-Za-z0-9_]*)")
    noise = {"value", "length", "map", "filter", "then", "catch"}
    for path in (ROOT / "webapp/src").rglob("*"):
        if path.suffix not in (".ts", ".vue"):
            continue
        if path.name.endswith((".test.ts",)):
            continue
        if path.name == "interrogation.ts" and path.parent.name == "api":
            continue  # the normalizer itself builds the object; not a consumer
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        for m in pattern.finditer(text):
            name = m.group(1)
            if name in noise:
                continue
            hits[name].append(path.name)
    return hits


def main() -> int:
    be_all = backend_keys()
    be = readiness_relevant(be_all)
    ts = ts_interface_fields()
    norm = normalizer_keys()
    consumed = consumed_fields()

    print(f"backend readiness-relevant keys ({len(be)}):")
    print("  " + ", ".join(sorted(be)))
    print(f"\nVoiceprintReadiness fields ({len(ts)}):")
    print("  " + ", ".join(sorted(ts)))
    print(f"\nnormalizer keys ({len(norm)}):")
    print("  " + ", ".join(sorted(norm)))
    print(f"\nfields the UI reads off readiness ({len(consumed)}):")
    for k in sorted(consumed):
        print(f"  {k}  <- {', '.join(sorted(set(consumed[k]))[:3])}")

    # The invariant that matters: anything the UI reads must survive the normalizer and the type.
    dropped_by_normalizer = sorted(k for k in consumed if k not in norm)
    missing_from_type = sorted(k for k in consumed if k not in ts)
    declared_but_unused = sorted(k for k in (ts - set(consumed)))

    print("\n=== parity verdict ===")
    print("  UI reads but normalizer drops :", dropped_by_normalizer or "none")
    print("  UI reads but type lacks       :", missing_from_type or "none")
    print("  declared in type, never read  :", declared_but_unused or "none")
    ok = not dropped_by_normalizer and not missing_from_type
    print("  RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
