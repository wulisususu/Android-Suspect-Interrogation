#!/usr/bin/env python3
"""Read-only process/cgroup memory sampler for RK3588 acceptance evidence."""

from __future__ import annotations

import argparse
import json
import time
from pathlib import Path


def parse_proc_status_kb(text: str) -> int | None:
    for line in str(text or "").splitlines():
        if not line.startswith("VmRSS:"):
            continue
        parts = line.split()
        if len(parts) < 2:
            return None
        try:
            value = int(parts[1])
        except ValueError:
            return None
        return value if value >= 0 else None
    return None


def parse_cgroup_bytes_to_kb(text: str) -> int | None:
    clean = str(text or "").strip()
    if not clean or clean == "max":
        return None
    try:
        value = int(clean)
    except ValueError:
        return None
    if value < 0:
        return None
    return value // 1024


def _read_proc_rss_kb(pid: int) -> int | None:
    path = Path(f"/proc/{pid}/status")
    try:
        return parse_proc_status_kb(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError):
        return None


def _read_cgroup_kb(path: Path | None) -> int | None:
    if path is None:
        return None
    try:
        return parse_cgroup_bytes_to_kb(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError):
        return None


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Sample process VmRSS and cgroup memory.current as JSONL")
    parser.add_argument("--pid", type=int, required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--cgroup-current", default=None)
    parser.add_argument("--interval", type=float, default=1.0)
    args = parser.parse_args(argv)
    if args.pid <= 0:
        raise ValueError("--pid must be positive")
    if args.interval <= 0:
        raise ValueError("--interval must be positive")

    proc_dir = Path(f"/proc/{args.pid}")
    output = Path(args.output).expanduser().resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    cgroup_current = Path(args.cgroup_current).expanduser().resolve() if args.cgroup_current else None

    with output.open("a", encoding="utf-8", buffering=1) as handle:
        while proc_dir.exists():
            row = {
                "timestamp": time.time(),
                "process_rss_kb": _read_proc_rss_kb(args.pid),
                "cgroup_memory_kb": _read_cgroup_kb(cgroup_current),
            }
            handle.write(json.dumps(row, ensure_ascii=False, separators=(",", ":")) + "\n")
            handle.flush()
            time.sleep(args.interval)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
