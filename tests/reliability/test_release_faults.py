from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def test_api_service_restarts_after_backend_crash():
    unit = (ROOT / "systemd" / "interrogation-api.service").read_text(encoding="utf-8")
    assert "Restart=on-failure" in unit
    assert "RestartSec=" in unit


def test_ai_worker_failure_is_isolated_from_api():
    api = (ROOT / "systemd" / "interrogation-api.service").read_text(encoding="utf-8")
    ai = (ROOT / "systemd" / "ai-worker.service").read_text(encoding="utf-8")
    assert "Requires=ai-worker.service" not in api
    assert "PartOf=interrogation-api.service" not in ai


def test_kiosk_has_bounded_backend_retry_and_maintenance_fallback():
    launcher = (ROOT / "scripts" / "kiosk-launch.sh").read_text(encoding="utf-8")
    assert "SUSPECT_KIOSK_READY_ATTEMPTS" in launcher
    assert "/health/ready" in launcher
    assert "maintenance" in launcher.lower()


def test_rk3588_checkout_is_bounded_and_sparse():
    checkout = (ROOT / "scripts" / "ci" / "resilient-checkout.sh").read_text(encoding="utf-8")
    assert "timeout \"${FETCH_TIMEOUT_SECONDS}s\"" in checkout
    assert "--filter=blob:none" in checkout
    assert "sparse-checkout" in checkout
    assert "http.version HTTP/1.1" in checkout
    assert "http.lowSpeedLimit" in checkout
    assert "http.lowSpeedTime" in checkout


def test_release_check_covers_low_disk_and_required_paths():
    checker = (ROOT / "scripts" / "check-release.sh").read_text(encoding="utf-8")
    assert "SUSPECT_MIN_FREE_MB" in checker
    assert "/var/lib/suspect-interrogation" in checker
    assert "/etc/suspect-interrogation" in checker
