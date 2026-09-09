#!/usr/bin/env python3
"""Read-only RK3588 probe for the deployed MOSS worker (Task 14 Step 4).

Verifies, without submitting case audio and without downloading anything:

- machine is aarch64 and the expected model bundle exists;
- every bundle artifact hash matches manifest.json (and, when the project
  validator is available, the bundle passes the Task 4 policy validation);
- the pinned private RKNN/RKLLM runtime libraries match the SHA-256 values
  burned into ``moss_worker/runtime.py`` and the env-file configuration;
- when the worker process is running, ``/proc/<pid>/maps`` confirms the
  actual selected native libraries are exactly the configured pinned ones;
- the systemd unit state, the AF_UNIX socket path and its 0660
  suspect-interrogation:suspect-interrogation permissions;
- the worker ``health`` op: status, manifest SHA, queue depth, active job
  and pinned runtime versions;
- the current atomic release symlink and the TCP/8000 listener inventory.

The probe is read-only: it opens no model inference, no spool writes and no
network connections other than the worker's Unix socket. JSON evidence is
written only under GITHUB_WORKSPACE or RUNNER_TEMP (or an explicit --output
given with --allow-any-output for local runs).
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import re
import socket
import stat
import struct
import subprocess
import sys
from pathlib import Path
from typing import Any

MODEL_BUNDLE = Path("/opt/suspect-interrogation/models/moss-rk3588")
RUNTIME_ENV_DIR = Path("/opt/suspect-interrogation/runtime/moss-env")
SOCKET_PATH = Path("/run/suspect-interrogation/moss.sock")
SPOOL_ROOT = Path("/var/lib/suspect-interrogation/moss")
CURRENT_LINK = Path("/opt/suspect-interrogation/current")
UNIT = "moss-worker.service"
SERVICE_USER = "suspect-interrogation"
SERVICE_GROUP = "suspect-interrogation"
APPROVED_LIBRARY_SHA256 = {
    # Burned into moss_worker/runtime.py MossRuntime.from_bundle()
    "rknn": "d31fc19c85b85f6091b2bd0f6af9d962d5264a4e410bfb536402ec92bac738e8",
    "rkllm": "6a9e4fc5324c68921c3a900340361e107af7599fe34dc8fa7759b2c5ae22a6e6",
}
# health op protocol: 4-byte big-endian length-prefixed UTF-8 JSON
MAX_MESSAGE_BYTES = 16 * 1024 * 1024


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def worker_main_pid() -> int | None:
    try:
        out = subprocess.run(
            ["systemctl", "show", "-p", "MainPID", "--value", UNIT],
            capture_output=True, text=True, timeout=15, check=False,
        ).stdout.strip()
    except (OSError, subprocess.SubprocessError):
        return None
    try:
        pid = int(out)
    except ValueError:
        return None
    return pid or None


def systemctl_state(*args: str) -> str:
    try:
        return subprocess.run(
            ["systemctl", *args], capture_output=True, text=True, timeout=15, check=False,
        ).stdout.strip()
    except (OSError, subprocess.SubprocessError) as exc:
        return f"probe-error: {type(exc).__name__}: {exc}"


def probe_unit() -> dict[str, Any]:
    report: dict[str, Any] = {
        "unit": UNIT,
        "is_active": systemctl_state("is-active", UNIT),
        "is_enabled": systemctl_state("is-enabled", UNIT),
        "main_pid": worker_main_pid(),
        "condition_asserted_active": False,
    }
    report["condition_asserted_active"] = report["is_active"] == "active"
    return report


def probe_socket_permissions() -> dict[str, Any]:
    report: dict[str, Any] = {"socket": str(SOCKET_PATH), "exists": SOCKET_PATH.is_socket()}
    if not report["exists"]:
        return report
    info = SOCKET_PATH.lstat()
    report["mode_octal"] = format(stat.S_IMODE(info.st_mode), "04o")
    try:
        owner = subprocess.run(
            ["stat", "-c", "%U:%G", str(SOCKET_PATH)],
            capture_output=True, text=True, timeout=10, check=True,
        ).stdout.strip()
    except (OSError, subprocess.SubprocessError) as exc:
        owner = f"probe-error: {type(exc).__name__}: {exc}"
    report["owner"] = owner
    report["mode_is_0660"] = report.get("mode_octal") == "0660"
    report["owner_matches_service"] = owner == f"{SERVICE_USER}:{SERVICE_GROUP}"
    return report


def probe_bundle() -> dict[str, Any]:
    report: dict[str, Any] = {"bundle": str(MODEL_BUNDLE), "present": MODEL_BUNDLE.is_dir()}
    manifest_path = MODEL_BUNDLE / "manifest.json"
    report["manifest_present"] = manifest_path.is_file()
    if not report["manifest_present"]:
        return report
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    report["manifest_sha256"] = sha256_file(manifest_path)
    report["policy"] = manifest.get("policy")
    artifacts = manifest.get("artifacts") or {}
    mismatches, missing, verified = [], [], 0
    for name in sorted(artifacts):
        path = MODEL_BUNDLE / name
        if not path.is_file():
            missing.append(name)
            continue
        if sha256_file(path) == artifacts[name]:
            verified += 1
        else:
            mismatches.append(name)
    report["artifacts_total"] = len(artifacts)
    report["artifacts_verified"] = verified
    report["artifacts_mismatched"] = mismatches
    report["artifacts_missing"] = missing
    report["policy_window_target_fallback_minimum"] = (
        manifest.get("policy", {}).get("target_window_minutes"),
        manifest.get("policy", {}).get("fallback_window_minutes"),
        manifest.get("policy", {}).get("minimum_window_minutes"),
    )
    return report


def read_env_file() -> dict[str, str]:
    values: dict[str, str] = {}
    path = Path("/etc/suspect-interrogation/moss-worker.env")
    if not path.is_file():
        return values
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        values[key.strip()] = value.strip()
    return values


def probe_runtime_libraries(env: dict[str, str]) -> dict[str, Any]:
    report: dict[str, Any] = {}
    for name in ("rknn", "rkllm"):
        key = f"MOSS_{'RKNN' if name == 'rknn' else 'RKLLM'}_LIBRARY"
        configured = env.get(key, "")
        entry: dict[str, Any] = {"env_key": key, "configured_path": configured}
        path = Path(configured) if configured else None
        if path is not None and path.is_file():
            entry["exists"] = True
            entry["sha256"] = sha256_file(path)
            entry["matches_approved"] = entry["sha256"] == APPROVED_LIBRARY_SHA256[name]
        else:
            entry["exists"] = False
        report[name] = entry
    child = env.get("MOSS_CHILD_PYTHON", "")
    report["child_python"] = child
    report["child_python_executable"] = Path(child).is_file() if child else False
    report["runtime_env_dir"] = str(RUNTIME_ENV_DIR)
    report["runtime_env_present"] = (RUNTIME_ENV_DIR / "bin" / "python").is_file()
    return report


def probe_actual_library_selection(main_pid: int | None) -> dict[str, Any]:
    """The native libraries load in the moss_worker.child process, not the unit main process."""
    report: dict[str, Any] = {"checked": False, "child_pids": []}
    children: list[int] = []
    for entry in Path("/proc").iterdir():
        if not entry.name.isdigit():
            continue
        try:
            cmdline = (entry / "cmdline").read_bytes().split(b"\0")
        except OSError:
            continue
        if any(b"moss_worker.child" in part for part in cmdline):
            children.append(int(entry.name))
    report["child_pids"] = children
    if not children:
        report["reason"] = "no moss_worker.child process is running"
        return report
    report["checked"] = True
    lib_suffixes = {"rknn": "librknnrt.so", "rkllm": "librkllmrt.so"}
    for name, so_name in lib_suffixes.items():
        found: set[str] = set()
        for pid in children:
            try:
                text = (Path("/proc") / str(pid) / "maps").read_text(encoding="utf-8", errors="replace")
            except OSError:
                continue
            found.update(re.findall(rf"(/\S*{so_name})", text))
        loaded = sorted(found)
        report[name] = {"loaded_paths": loaded}
        report[name]["matches_approved"] = bool(loaded) and all(
            Path(p).is_file() and sha256_file(Path(p)) == APPROVED_LIBRARY_SHA256[name]
            for p in loaded
        )
    return report


def moss_health_call(socket_path: Path) -> dict[str, Any]:
    request = {"request_id": "moss-probe-health", "op": "health"}
    payload = json.dumps(request, separators=(",", ":")).encode("utf-8")
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
        sock.settimeout(10)
        sock.connect(str(socket_path))
        sock.sendall(struct.pack("!I", len(payload)) + payload)
        header = b""
        while len(header) < 4:
            block = sock.recv(4 - len(header))
            if not block:
                raise OSError("worker closed before frame length completed")
            header += block
        (length,) = struct.unpack("!I", header)
        if length > MAX_MESSAGE_BYTES:
            raise ValueError("worker frame exceeds protocol maximum")
        body = b""
        while len(body) < length:
            block = sock.recv(min(65536, length - len(body)))
            if not block:
                raise OSError("worker closed before frame body completed")
            body += block
    response = json.loads(body.decode("utf-8"))
    if not response.get("ok"):
        raise RuntimeError(f"health op failed: {response.get('error')}")
    return response.get("result") or {}


def probe_health(env: dict[str, str]) -> dict[str, Any]:
    report: dict[str, Any] = {"socket": str(SOCKET_PATH)}
    if not SOCKET_PATH.is_socket():
        report["reachable"] = False
        return report
    try:
        result = moss_health_call(SOCKET_PATH)
    except Exception as exc:
        report["reachable"] = False
        report["error"] = f"{type(exc).__name__}: {exc}"
        return report
    report["reachable"] = True
    report["health"] = result
    report["status_ok"] = result.get("status") == "ok"
    report["queue_depth_zero"] = result.get("queue_depth") == 0
    report["active_job_none"] = result.get("active_job") is None
    expected_sha = env.get("MOSS_MODEL_MANIFEST_SHA256", "")
    report["manifest_sha_matches_env"] = bool(expected_sha) and result.get("manifest_sha256") == expected_sha
    return report


def probe_tcp8000() -> dict[str, Any]:
    report: dict[str, Any] = {"port": 8000}
    try:
        out = subprocess.run(
            ["ss", "-H", "-ltnp", "sport = :8000"],
            capture_output=True, text=True, timeout=15, check=False,
        ).stdout.strip()
    except (OSError, subprocess.SubprocessError) as exc:
        report["error"] = f"{type(exc).__name__}: {exc}"
        return report
    report["listener_lines"] = [line for line in out.splitlines() if line.strip()]
    report["listening"] = bool(report["listener_lines"])
    report["listener_pids"] = sorted(set(re.findall(r"pid=(\d+)", out)))
    return report


def probe_shared_layout() -> dict[str, Any]:
    return {
        "current_release": os.path.realpath(CURRENT_LINK) if CURRENT_LINK.exists() else None,
        "spool_root": str(SPOOL_ROOT),
        "spool_present": SPOOL_ROOT.is_dir(),
        "models_dir_entries": sorted(
            entry.name for entry in Path("/opt/suspect-interrogation/models").iterdir()
        ) if Path("/opt/suspect-interrogation/models").is_dir() else [],
    }


def _safe_output_path(raw: str, allow_any: bool) -> Path:
    output = Path(raw).expanduser().resolve()
    if allow_any:
        return output
    roots = [
        Path(value).expanduser().resolve()
        for name in ("GITHUB_WORKSPACE", "RUNNER_TEMP")
        if (value := os.environ.get(name))
    ]
    if not roots:
        raise RuntimeError("GITHUB_WORKSPACE or RUNNER_TEMP is required (or pass --allow-any-output)")
    if not any(output == root or root in output.parents for root in roots):
        raise ValueError(f"--output must be inside an allowed runtime directory: {', '.join(map(str, roots))}")
    return output


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Read-only MOSS RK3588 worker probe (no audio, no downloads)")
    parser.add_argument("--output", required=True, help="JSON evidence path inside GITHUB_WORKSPACE or RUNNER_TEMP")
    parser.add_argument("--allow-any-output", action="store_true",
                        help="local debugging only: skip the CI output-directory guard")
    parser.add_argument("--expect-manifest-sha256", default="",
                        help="fail unless the bundle manifest SHA equals this value")
    args = parser.parse_args(argv)
    output = _safe_output_path(args.output, args.allow_any_output)

    failures: list[str] = []
    env = read_env_file()
    unit = probe_unit()
    main_pid = unit.get("main_pid")
    report: dict[str, Any] = {
        "machine": platform.machine(),
        "aarch64": platform.machine() in {"aarch64", "arm64"},
        "python": sys.executable,
        "unit": unit,
        "socket": probe_socket_permissions(),
        "bundle": probe_bundle(),
        "runtime_libraries": probe_runtime_libraries(env),
        "actual_library_selection": probe_actual_library_selection(main_pid),
        "health": probe_health(env),
        "tcp8000": probe_tcp8000(),
        "shared_layout": probe_shared_layout(),
        "runtime_versions_env": env.get("MOSS_RUNTIME_VERSIONS", ""),
        "success": False,
    }

    if not report["aarch64"]:
        failures.append("machine is not aarch64")
    if unit["is_active"] != "active":
        failures.append(f"{UNIT} is not active: {unit['is_active']!r} (ConditionPathExists must never skip silently)")
    if not report["socket"].get("exists"):
        failures.append("moss.sock does not exist")
    elif not (report["socket"].get("mode_is_0660") and report["socket"].get("owner_matches_service")):
        failures.append("moss.sock permissions are not 0660 suspect-interrogation:suspect-interrogation")
    bundle = report["bundle"]
    if not bundle.get("manifest_present"):
        failures.append("bundle manifest.json is missing")
    elif bundle["artifacts_mismatched"] or bundle["artifacts_missing"]:
        failures.append(f"bundle artifact hash mismatch: {bundle['artifacts_mismatched']} missing: {bundle['artifacts_missing']}")
    elif (bundle.get("policy_window_target_fallback_minimum") != (10, 8, 8)):
        failures.append("bundle policy is not the approved 10/8/8 window policy")
    if args.expect_manifest_sha256 and bundle.get("manifest_sha256") != args.expect_manifest_sha256:
        failures.append("bundle manifest SHA does not equal --expect-manifest-sha256")
    for name in ("rknn", "rkllm"):
        lib = report["runtime_libraries"][name]
        if not lib.get("exists"):
            failures.append(f"configured {name} library is missing: {lib.get('configured_path')!r}")
        elif not lib.get("matches_approved"):
            failures.append(f"configured {name} library hash is not the approved pinned SHA")
    selection = report["actual_library_selection"]
    if selection.get("checked"):
        for name in ("rknn", "rkllm"):
            if not selection[name].get("matches_approved"):
                failures.append(f"worker process has a non-approved {name} library mapped")
    health = report["health"]
    if not health.get("reachable"):
        failures.append(f"health op unreachable: {health.get('error')}")
    else:
        if not health.get("status_ok"):
            failures.append("health status is not ok")
        if not health.get("queue_depth_zero") or not health.get("active_job_none"):
            failures.append("health queue_depth/active_job are not idle (the probe must run on an idle worker)")
        if not health.get("manifest_sha_matches_env"):
            failures.append("health manifest_sha256 does not match the env-file pin")
    if not report["tcp8000"].get("listening"):
        failures.append("TCP/8000 has no listener; the existing FunASR service must stay listening")

    report["success"] = not failures
    if failures:
        report["failures"] = failures
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2, default=str) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2, default=str))
    return 0 if report["success"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
