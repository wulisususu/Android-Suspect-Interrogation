from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def read(path: str) -> str:
    return (ROOT / path).read_text(encoding="utf-8")


def test_tls_helper_and_windows_bootstrap_exist():
    assert (ROOT / "deploy/lib/tls.sh").is_file()
    assert (ROOT / "scripts/windows/install-lan-ca.ps1").is_file()


def test_systemd_uvicorn_uses_configured_tls_certificate_and_key():
    service = read("systemd/interrogation-api.service")
    assert '--ssl-certfile "$SUSPECT_TLS_CERT_FILE"' in service
    assert '--ssl-keyfile "$SUSPECT_TLS_KEY_FILE"' in service


def test_release_control_prepares_tls_and_verifies_https_with_ca():
    control = read("deploy/control.sh")
    assert 'source "$SCRIPT_DIR/lib/tls.sh"' in control
    assert "ensure_tls_material" in control
    assert "install_tls_trust" in control
    assert "curl_tls" in control
    assert "https://127.0.0.1" in control
    assert "curl -k" not in control
    assert "curl --insecure" not in control


def test_production_workflow_uses_https_and_verifies_certificate_identity():
    workflow = read(".github/workflows/rk3588-production-redeploy.yml")
    assert 'https://127.0.0.1:${SUSPECT_DEPLOY_PORT}' in workflow
    assert "SUSPECT_TLS_LAN_IP" in workflow
    assert "openssl x509" in workflow
    assert "subjectAltName" in workflow or "Subject Alternative Name" in workflow
    assert "TCP/8000 preserved" in workflow


def test_ca_download_endpoint_is_registered_without_private_key_endpoint():
    assert (ROOT / "linux/backend/app/api/tls.py").is_file()
    main = read("linux/backend/app/main.py")
    assert "tls_router" in main
    assert "/api/v1/tls/ca.crt" in read("linux/backend/app/api/tls.py")
    assert "ca.key" not in read("linux/backend/app/api/tls.py")
    assert "server.key" not in read("linux/backend/app/api/tls.py")


def test_kiosk_defaults_to_https_without_disabling_certificate_verification():
    kiosk = read("scripts/kiosk-launch.sh")
    assert "https://127.0.0.1" in kiosk
    assert "--ignore-certificate-errors" not in kiosk
    assert "--allow-insecure-localhost" not in kiosk


def test_repository_definition_of_done_uses_https():
    rules = read("AGENTS.md")
    assert "https://192.168.0.9:18080" in rules
    assert "http://192.168.0.9:18080" not in rules


def test_windows_bootstrap_limits_insecure_tls_to_ca_download_then_verifies_strictly():
    script = read("scripts/windows/install-lan-ca.ps1")
    lowered = script.lower()
    assert "curl.exe" in lowered
    assert "/api/v1/tls/ca.crt" in lowered
    assert "certutil" in lowered
    assert "-addstore" in lowered
    assert "root" in lowered
    assert "/health/live" in lowered
    assert lowered.count(" -k ") == 1 or lowered.count(" --insecure ") == 1
