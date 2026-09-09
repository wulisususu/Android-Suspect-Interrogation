"""Task 14: systemd/offline deployment contracts for the MOSS RK3588 worker.

Covers the systemd unit contract from the implementation plan (Task 14
Step 1), the tmpfiles.d fragment that keeps /run/suspect-interrogation
present, and the Windows-safe dry-run of the manifest rebuild runbook
(the board rebuild itself is a phase-2, on-device step).
"""
from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
UNIT = ROOT / "systemd" / "moss-worker.service"
TMPFILES = ROOT / "deploy" / "tmpfiles-suspect-interrogation.conf"
RUNBOOK = ROOT / "deploy" / "rebuild_moss_manifest.py"

# The deployed bundle-v2 manifest still carries the pre-revision policy; the
# hard prerequisite for phase 2 is rebuilding/re-signing with the approved
# policy (target=10 / fallback=8 / minimum=8) before the worker can load it.
OLD_POLICY = {
    "compiled_context_limit": 16384,
    "generation_reserve": 5120,
    "safety_margin": 512,
    "target_window_minutes": 12,
    "fallback_window_minutes": 10,
    "minimum_window_minutes": 8,
    "overlap_minutes": 2,
    "logical_chunk_minutes": 60,
}


# --------------------------------------------------------------------------
# systemd unit contract
# --------------------------------------------------------------------------


def test_unit_is_local_restricted_and_not_tcp8000():
    t = UNIT.read_text(encoding="utf-8")
    assert "User=suspect-interrogation" in t and "Group=suspect-interrogation" in t
    # The MOSS unit must NOT declare RuntimeDirectory=suspect-interrogation:
    # ai-worker.service declares the same shared directory, and systemd GCs
    # it whenever a declaring unit stops, orphaning ai-worker's bound
    # speech.sock. The directory is created by the tmpfiles fragment instead.
    assert "RuntimeDirectory" not in t
    assert "Restart=on-failure" in t
    assert "8000" not in t
    assert "/opt/suspect-interrogation/models/moss-rk3588" in t


def test_unit_hardens_and_starts_the_worker_entrypoint():
    t = UNIT.read_text(encoding="utf-8")
    assert "WorkingDirectory=/opt/suspect-interrogation/current/linux/backend" in t
    assert "ExecStart=/opt/suspect-interrogation/current/.venv/bin/python -m moss_worker.main" in t
    assert "EnvironmentFile=/etc/suspect-interrogation/runtime.env" in t
    assert "EnvironmentFile=-/etc/suspect-interrogation/moss-worker.env" in t
    assert "Environment=SUSPECT_MOSS_SOCKET=/run/suspect-interrogation/moss.sock" in t
    assert "Environment=MOSS_SPOOL_ROOT=/var/lib/suspect-interrogation/moss" in t
    assert "Environment=MOSS_MODEL_BUNDLE=/opt/suspect-interrogation/models/moss-rk3588" in t
    assert "MOSS_CHILD_PYTHON=" in t
    assert "RestartSec=" in t
    assert "NoNewPrivileges=true" in t
    assert "ProtectSystem=strict" in t
    assert "ProtectHome=true" in t
    assert "ReadWritePaths=/run/suspect-interrogation /var/lib/suspect-interrogation /var/log/suspect-interrogation" in t
    assert "ReadOnlyPaths=/opt/suspect-interrogation/models/moss-rk3588" in t
    assert "/opt/suspect-interrogation/runtime/moss-env" in t


def test_unit_never_touches_funasr_speech_or_other_units():
    t = UNIT.read_text(encoding="utf-8")
    assert "speech.sock" not in t
    assert "funasr" not in t.lower()
    assert ":8000" not in t
    assert "systemctl" not in t
    assert "ExecReload" not in t


def test_tmpfiles_fragment_keeps_the_runtime_directory_present():
    t = TMPFILES.read_text(encoding="utf-8")
    assert "d /run/suspect-interrogation 0750 suspect-interrogation suspect-interrogation" in t


# --------------------------------------------------------------------------
# Manifest rebuild runbook (phase-2 board tool; dry-run is Windows-safe)
# --------------------------------------------------------------------------


def _write_old_bundle(tmp_path: Path) -> Path:
    bundle = tmp_path / "old-bundle"
    bundle.mkdir()
    manifest = {
        "schema_version": 1,
        "policy": dict(OLD_POLICY),
        "artifacts": {"moss_token_embedding_fp16.bin": "0" * 64},
    }
    (bundle / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    return bundle


def _run_runbook(*args: str) -> subprocess.CompletedProcess:
    return subprocess.run(
        [sys.executable, str(RUNBOOK), *args],
        cwd=str(ROOT),
        capture_output=True,
        text=True,
        timeout=120,
        check=False,
    )


def _staged_inputs(tmp_path: Path, output: Path) -> list[str]:
    assets = tmp_path / "assets"
    source = tmp_path / "source"
    checkpoint = tmp_path / "checkpoint"
    for directory in (assets, source, checkpoint):
        directory.mkdir()
    provenance = tmp_path / "provenance.json"
    provenance.write_text('{"checkpoint_revision": "' + "a" * 40 + '"}', encoding="utf-8")
    return [
        "--assets", str(assets),
        "--source", str(source),
        "--checkpoint", str(checkpoint),
        "--provenance", str(provenance),
        "--output", str(output),
    ]


def test_runbook_dry_run_reports_policy_drift_and_full_plan(tmp_path):
    old_bundle = _write_old_bundle(tmp_path)
    output = tmp_path / "bundle-v3"

    result = _run_runbook("--dry-run", "--old-bundle", str(old_bundle),
                          *_staged_inputs(tmp_path, output))

    assert result.returncode == 0, result.stderr
    out = result.stdout
    # Old policy is named as the MOSS_BUNDLE_INVALID cause, field by field.
    assert "target_window_minutes: bundle=12 approved=10" in out
    assert "fallback_window_minutes: bundle=10 approved=8" in out
    assert "minimum_window_minutes: bundle=8 approved=8" not in out
    # The plan rebuilds with the policy-carrying builder and revalidates.
    assert "tools.moss_rk3588.build_manifest" in out
    assert "tools.moss_rk3588.validate_bundle" in out
    assert str(output) in out
    assert "MOSS_MODEL_MANIFEST_SHA256" in out
    assert "moss-worker" in out
    # Dry-run never creates the output bundle.
    assert not output.exists()


def test_runbook_dry_run_fails_closed_when_old_bundle_is_missing(tmp_path):
    output = tmp_path / "bundle-v3"

    result = _run_runbook("--dry-run", "--old-bundle", str(tmp_path / "gone"),
                          *_staged_inputs(tmp_path, output))

    assert result.returncode == 2
    assert "manifest.json" in result.stdout + result.stderr


def test_runbook_real_run_requires_staged_build_inputs(tmp_path):
    output = tmp_path / "bundle-v3"
    old_bundle = _write_old_bundle(tmp_path)

    result = _run_runbook("--old-bundle", str(old_bundle), "--output", str(output))

    assert result.returncode == 2
    assert "--assets" in result.stdout + result.stderr
    assert not output.exists()


def test_runbook_refuses_to_rebuild_into_an_existing_output(tmp_path):
    old_bundle = _write_old_bundle(tmp_path)
    output = tmp_path / "bundle-v3"
    output.mkdir()

    result = _run_runbook("--old-bundle", str(old_bundle),
                          *_staged_inputs(tmp_path, output))

    assert result.returncode == 2
    assert "exists" in result.stdout + result.stderr
