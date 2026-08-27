from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
WORKFLOW = ROOT / ".github" / "workflows" / "rk3588-service-bootstrap.yml"


def test_rk3588_service_bootstrap_workflow_installs_deploys_and_verifies_runtime():
    assert WORKFLOW.is_file(), "RK3588 service bootstrap workflow is missing"
    workflow = WORKFLOW.read_text(encoding="utf-8")

    assert "name: RK3588 Service Bootstrap" in workflow
    assert "workflow_dispatch:" in workflow
    assert "runs-on: [self-hosted, rk3588]" in workflow
    assert "sudo -n true" in workflow
    assert "sudo -n bash deploy/control.sh install" in workflow
    assert 'sudo -n bash deploy/control.sh deploy "$GITHUB_WORKSPACE"' in workflow
    assert "systemctl is-enabled --quiet interrogation-api.service" in workflow
    assert "systemctl is-active --quiet interrogation-api.service" in workflow
    assert "systemctl is-enabled --quiet kiosk.service" in workflow
    assert "curl -fsS http://127.0.0.1:8000/health/ready" in workflow
    assert "curl -fsS http://127.0.0.1:8000/" in workflow
