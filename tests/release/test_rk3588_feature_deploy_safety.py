from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
FEATURE = ROOT / ".github" / "workflows" / "rk3588-feature-deploy.yml"
BOOTSTRAP = ROOT / ".github" / "workflows" / "rk3588-service-bootstrap.yml"


def _before_runtime_probe(source: str, marker: str) -> str:
    assert marker in source
    return source[: source.index(marker)]


def test_feature_deploy_does_not_stop_working_api_before_model_probe():
    source = FEATURE.read_text(encoding="utf-8")
    preflight = _before_runtime_probe(source, "Prepare read-only FunASR models and isolated runtime")
    assert "systemctl stop interrogation-api.service" not in preflight
    assert "systemctl is-active --quiet interrogation-api.service" in preflight
    assert "existing project API on TCP/18080 is preserved during speech preflight" in source
    assert "sudo -n ss -ltnp 'sport = :8000'" in source


def test_production_bootstrap_does_not_stop_working_api_before_model_probe():
    source = BOOTSTRAP.read_text(encoding="utf-8")
    preflight = _before_runtime_probe(source, "Prepare stable offline FunASR model and runtime layout")
    assert "systemctl stop interrogation-api.service" not in preflight
    assert "systemctl is-active --quiet interrogation-api.service" in preflight
    assert "existing project API on TCP/18080 is preserved during speech preflight" in source
    assert "Existing TCP/8000 owner is preserved" in source
