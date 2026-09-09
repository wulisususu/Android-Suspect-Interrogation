#!/usr/bin/env python3
"""Task 14 runbook: rebuild the MOSS RK3588 bundle manifest with the approved policy.

The deployed bundle-v2 manifest predates the approved window-policy revision
(target=10 / fallback=8 / minimum=8). Under the current validator that old
manifest fails as MOSS_BUNDLE_INVALID ("Unapproved context/window policy"),
so the bundle must be rebuilt/re-signed on the RK3588 with the policy-carrying
tools/moss_rk3588/build_manifest.py and revalidated before the worker can load
it. This script orchestrates exactly that sequence.

Modes
-----
--dry-run  Windows/board-safe preflight: reads the deployed bundle's
           manifest.json, reports the policy drift field by field, and prints
           the full rebuild/validate/cutover plan without touching anything.
(default)  Board execution: runs tools.moss_rk3588.build_manifest (needs the
           build venv with torch/numpy), revalidates with
           tools.moss_rk3588.validate_bundle, prints the new manifest SHA-256
           and the remaining manual cutover steps.

Exit codes: 0 success, 2 preflight/usage refusal, 3 post-build validation
failure; build failures propagate the builder's exit code.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from tools.moss_rk3588.validate_bundle import POLICY  # noqa: E402  (needs numpy)


BUILD_ARGS = ("assets", "source", "checkpoint", "provenance")


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def read_old_policy(bundle: Path) -> tuple[dict | None, str | None]:
    manifest_path = Path(bundle) / "manifest.json"
    if not manifest_path.is_file():
        return None, f"old bundle has no manifest.json: {manifest_path}"
    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        return None, f"old bundle manifest.json is unreadable: {exc}"
    if not isinstance(manifest, dict):
        return None, f"old bundle manifest.json is not a JSON object: {manifest_path}"
    return manifest.get("policy"), None


def policy_drift(actual: dict | None) -> list[str]:
    if not isinstance(actual, dict):
        return ["old bundle manifest carries no policy object"]
    return [
        f"{key}: bundle={actual.get(key)!r} approved={value!r}"
        for key, value in POLICY.items()
        if actual.get(key) != value
    ]


def print_report(old_bundle: Path, policy: dict | None, error: str | None, args) -> list[str]:
    output = Path(args.output) if args.output else None
    print(f"old bundle: {old_bundle}")
    if error is not None:
        print(f"PREFLIGHT PROBLEM: {error}")
        print("The worker rejects such a bundle at load with MOSS_BUNDLE_INVALID.")
        return []
    drift = policy_drift(policy)
    print("approved policy (tools/moss_rk3588/validate_bundle.POLICY):")
    for key, value in POLICY.items():
        print(f"  {key}: {value!r}")
    if not drift:
        print("old manifest policy already matches the approved policy; no rebuild needed.")
        return []
    print("policy drift (the reason the deployed bundle fails validation):")
    for line in drift:
        print(f"  {line}")
    print()
    print("rebuild/validate/cutover plan:")
    if None in (args.assets, args.source, args.checkpoint, args.provenance, args.output):
        print("  (staged build inputs incomplete; pass --assets/--source/--checkpoint/"
              "--provenance/--output for the exact command)")
        return drift
    build_cmd = subprocess.list2cmdline(build_argv(args))
    print(f"  1. {build_cmd}")
    print(f"  2. python3 -m tools.moss_rk3588.validate_bundle {output}")
    print(f"  3. new manifest SHA-256: sha256sum {output / 'manifest.json'}")
    print("  4. update /etc/suspect-interrogation/moss-worker.env:"
          " MOSS_MODEL_MANIFEST_SHA256=<sha256 from step 3>")
    print(f"  5. install the rebuilt bundle read-only under"
          f" /opt/suspect-interrogation/models/moss-rk3588 (atomic dir swap)")
    print("  6. systemctl restart moss-worker.service; confirm the child self-test"
          " handshake in journalctl -u moss-worker")
    print("  7. verify the health op reports the new manifest_sha256, queue_depth 0"
          " and active_job null before re-enabling MOSS_ENABLED=1 traffic")
    return drift


def build_argv(args) -> list[str]:
    parts = [sys.executable, "-m", "tools.moss_rk3588.build_manifest",
             "--assets", str(args.assets), "--source", str(args.source),
             "--checkpoint", str(args.checkpoint), "--provenance", str(args.provenance),
             "--output", str(args.output)]
    if args.allow_dirty:
        parts.append("--allow-dirty")
    return parts


def real_run(args) -> int:
    missing = [name for name in ("output",) + BUILD_ARGS if getattr(args, name) is None]
    if missing:
        print(f"REFUSED: a real rebuild requires --assets, --source, --checkpoint,"
              f" --provenance and --output (missing: {missing});"
              f" the staged assets cannot be defaulted.", file=sys.stderr)
        return 2
    output = Path(args.output)
    if output.exists():
        print(f"REFUSED: output directory already exists: {output};"
              f" build_manifest never overwrites bundles.", file=sys.stderr)
        return 2
    argv = build_argv(args)
    print(f"building bundle: {subprocess.list2cmdline(argv)}")
    built = subprocess.run(argv, cwd=str(ROOT), check=False)
    if built.returncode != 0:
        print(f"build_manifest failed with exit code {built.returncode}", file=sys.stderr)
        return built.returncode
    validate = subprocess.run(
        [sys.executable, "-m", "tools.moss_rk3588.validate_bundle", str(output)],
        cwd=str(ROOT), check=False)
    if validate.returncode != 0:
        print(f"validate_bundle rejected {output}", file=sys.stderr)
        return 3
    digest = sha256_file(output / "manifest.json")
    print(f"rebuilt bundle is valid: {output}")
    print(f"manifest sha256: {digest}")
    print("next: update MOSS_MODEL_MANIFEST_SHA256 in"
          " /etc/suspect-interrogation/moss-worker.env, swap the bundle into"
          " /opt/suspect-interrogation/models/moss-rk3588, restart moss-worker"
          " and re-verify the health op (see deploy/README.md).")
    return 0


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--old-bundle", required=True, type=Path,
                        help="deployed bundle whose manifest predates the approved policy")
    parser.add_argument("--dry-run", action="store_true",
                        help="print the plan only; never build (safe everywhere)")
    for name in BUILD_ARGS:
        parser.add_argument("--" + name, type=Path, default=None)
    parser.add_argument("--output", type=Path, default=None)
    parser.add_argument("--allow-dirty", action="store_true")
    args = parser.parse_args(argv)

    policy, error = read_old_policy(args.old_bundle)
    drift = print_report(args.old_bundle, policy, error, args)
    if error is not None:
        return 2
    if args.dry_run:
        return 0
    if not drift:
        # The deployed manifest already carries the approved policy: there is
        # nothing to rebuild, so never stage a fresh bundle for this call.
        return 0
    return real_run(args)


if __name__ == "__main__":
    raise SystemExit(main())
