from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
FEATURE = ROOT / ".github" / "workflows" / "rk3588-feature-deploy.yml"
BOOTSTRAP = ROOT / ".github" / "workflows" / "rk3588-service-bootstrap.yml"


def _before_runtime_probe(source: str, marker: str) -> str:
    assert marker in source
    return source[: source.index(marker)]


def _assert_read_only_model_mount_is_rerunnable(source: str) -> None:
    marker = 'if ! mountpoint -q "$FUNASR_MODEL_ROOT"; then'
    remount = 'sudo -n mount -o remount,bind,ro "$FUNASR_MODEL_ROOT"'
    target_install = 'sudo -n install -d -o root -g root -m 0755 "$FUNASR_MODEL_ROOT"'
    assert marker in source
    assert remount in source
    marker_index = source.index(marker)
    remount_index = source.index(remount, marker_index)
    mount_block = source[marker_index:remount_index]
    assert target_install in mount_block
    assert target_install not in source[:marker_index]


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


def test_feature_deploy_does_not_chown_existing_read_only_model_mount():
    _assert_read_only_model_mount_is_rerunnable(FEATURE.read_text(encoding="utf-8"))


def test_production_bootstrap_does_not_chown_existing_read_only_model_mount():
    _assert_read_only_model_mount_is_rerunnable(BOOTSTRAP.read_text(encoding="utf-8"))


def test_feature_and_bootstrap_pin_modelscope_for_legacy_xvector():
    for workflow in (FEATURE, BOOTSTRAP):
        source = workflow.read_text(encoding="utf-8")
        assert "MODELSCOPE_PACKAGE_VERSION: '1.39.1'" in source
        assert '"modelscope==${MODELSCOPE_PACKAGE_VERSION}"' in source
        assert "import funasr" in source and "modelscope" in source
