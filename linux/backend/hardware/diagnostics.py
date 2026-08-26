from __future__ import annotations

import argparse
import grp
import json
import os
import shutil
from pathlib import Path
from typing import Any, Dict, Optional

from hardware.factory import create_device_manager
from hardware.idcard.vendor import SDKLibraryDiscovery


def _permission_report() -> Dict[str, Any]:
    group_ids = set(os.getgroups())
    try:
        group_ids.add(os.getgid())
    except AttributeError:
        pass
    groups = sorted({entry.gr_name for entry in grp.getgrall() if entry.gr_gid in group_ids})
    nodes = {}
    for label, path in {
        "video0": Path("/dev/video0"),
        "snd": Path("/dev/snd"),
        "usb": Path("/dev/bus/usb"),
    }.items():
        nodes[label] = {
            "path": str(path),
            "exists": path.exists(),
            "readable": os.access(path, os.R_OK),
            "writable": os.access(path, os.W_OK),
        }
    return {
        "euid": os.geteuid() if hasattr(os, "geteuid") else None,
        "groups": groups,
        "required_groups": ["video", "audio", "plugdev"],
        "nodes": nodes,
        "tools": {name: shutil.which(name) for name in ("arecord", "v4l2-ctl", "udevadm", "lsusb")},
    }


def collect_diagnostics(mode: Optional[str] = None) -> Dict[str, Any]:
    manager = create_device_manager(mode)
    open_errors = manager.open_all(strict=False)
    report = manager.capability_report()
    report["open_errors"] = open_errors
    report["sdk"] = SDKLibraryDiscovery().report()
    report["permissions"] = _permission_report()
    manager.close_all()
    return report


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description="Linux hardware diagnostics")
    parser.add_argument("--mode", choices=("mock", "real"), default=None)
    parser.add_argument("--json", action="store_true", help="print machine-readable JSON")
    args = parser.parse_args(argv)
    report = collect_diagnostics(args.mode)
    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        print(f"hardware mode: {report['mode']}")
        for name, item in report["devices"].items():
            print(f"{name:10s} status={item['status']} healthy={item['health'].get('healthy', False)}")
        print(f"SDK: {report['sdk'].get('found') or 'SDK_NOT_FOUND'}")
        print(f"groups: {', '.join(report['permissions']['groups']) or '(none)'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
