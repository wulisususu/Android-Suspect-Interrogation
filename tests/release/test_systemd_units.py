from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def _read(name: str) -> str:
    return (ROOT / "systemd" / name).read_text(encoding="utf-8")


def test_api_unit_runs_non_root_and_is_hardened():
    unit = _read("interrogation-api.service")
    assert "User=suspect-interrogation" in unit
    assert "Group=suspect-interrogation" in unit
    assert "WorkingDirectory=/opt/suspect-interrogation/current/linux/backend" in unit
    assert "EnvironmentFile=/etc/suspect-interrogation/runtime.env" in unit
    assert "Restart=on-failure" in unit
    assert "NoNewPrivileges=true" in unit
    assert "ProtectSystem=strict" in unit
    assert "PrivateTmp=true" in unit
    assert "ReadWritePaths=/var/lib/suspect-interrogation /var/log/suspect-interrogation" in unit
    assert "0.0.0.0" not in unit


def test_ai_worker_is_optional_and_non_root():
    unit = _read("ai-worker.service")
    assert "User=suspect-interrogation" in unit
    assert "EnvironmentFile=-/etc/suspect-interrogation/ai-worker.env" in unit
    assert "Restart=on-failure" in unit
    assert "ConditionPathExists=/opt/suspect-interrogation/current/linux/backend" in unit


def test_kiosk_orders_after_api_and_uses_launcher():
    unit = _read("kiosk.service")
    assert "After=graphical.target interrogation-api.service" in unit
    assert "ExecStart=/opt/suspect-interrogation/current/scripts/kiosk-launch.sh" in unit
    assert "Restart=always" in unit
