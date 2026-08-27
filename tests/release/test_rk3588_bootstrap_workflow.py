from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
WORKFLOW = ROOT / ".github" / "workflows" / "rk3588-service-bootstrap.yml"


def test_rk3588_service_bootstrap_workflow_installs_deploys_and_verifies_runtime():
    assert WORKFLOW.is_file(), "RK3588 service bootstrap workflow is missing"
    workflow = WORKFLOW.read_text(encoding="utf-8")

    assert "name: RK3588 Service Bootstrap" in workflow
    assert "workflow_dispatch:" in workflow
    assert "runs-on: [self-hosted, rk3588]" in workflow
    assert "cancel-in-progress: true" in workflow
    assert "SUSPECT_DEPLOY_PORT: '18080'" in workflow
    assert "sudo -n true" in workflow
    assert "git sparse-checkout init --cone" in workflow
    assert "git sparse-checkout set .github linux webapp deploy scripts systemd tests docs" in workflow
    assert 'TEST_RUNTIME_ROOT="$RUNNER_TEMP/suspect-bootstrap-test"' in workflow
    assert 'export SUSPECT_DB_PATH="$TEST_RUNTIME_ROOT/interrogation.db"' in workflow
    assert 'export SUSPECT_DATA_DIR="$TEST_RUNTIME_ROOT/data"' in workflow
    assert 'export SUSPECT_LOG_DIR="$TEST_RUNTIME_ROOT/log"' in workflow
    assert "sudo -n systemctl stop interrogation-api.service" in workflow
    assert "sudo -n ss -ltnp \"sport = :${SUSPECT_DEPLOY_PORT}\"" in workflow
    assert "SUSPECT_API_PORT=${SUSPECT_DEPLOY_PORT}" in workflow
    assert "SUSPECT_KIOSK_READY_URL=http://127.0.0.1:${SUSPECT_DEPLOY_PORT}/health/ready" in workflow
    assert "SUSPECT_KIOSK_URL=http://127.0.0.1:${SUSPECT_DEPLOY_PORT}/" in workflow
    assert "sudo -n bash deploy/control.sh install" in workflow
    assert "SUSPECT_HEALTH_BASE_URL=\"http://127.0.0.1:${SUSPECT_DEPLOY_PORT}\"" in workflow
    assert "systemctl is-enabled --quiet interrogation-api.service" in workflow
    assert "systemctl is-active --quiet interrogation-api.service" in workflow
    assert "systemctl is-enabled --quiet kiosk.service" in workflow
    assert "curl -fsS \"http://127.0.0.1:${SUSPECT_DEPLOY_PORT}/health/ready\"" in workflow
    assert "curl -fsS \"http://127.0.0.1:${SUSPECT_DEPLOY_PORT}/\"" in workflow
