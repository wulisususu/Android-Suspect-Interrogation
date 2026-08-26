#!/usr/bin/env bash
set -euo pipefail

arch="$(uname -m)"
echo "runner_name=${RUNNER_NAME:-unknown}"
echo "runner_os=${RUNNER_OS:-unknown}"
echo "runner_arch=${RUNNER_ARCH:-unknown}"
echo "uname_arch=$arch"
echo "hostname=$(hostname)"
uname -a
git --version
python3 --version

[[ "$arch" == "aarch64" || "$arch" == "arm64" ]] || {
  echo "expected ARM64 RK3588 runner, got $arch" >&2
  exit 1
}

python3 -m compileall -q linux/backend
bash -n deploy/control.sh deploy/lib/common.sh deploy/lib/release.sh \
  scripts/backup.sh scripts/restore.sh scripts/kiosk-launch.sh \
  scripts/check-release.sh scripts/ci/resilient-checkout.sh

TMP_STATE="$(mktemp -d)"
trap 'rm -rf "$TMP_STATE"' EXIT
mkdir -p "$TMP_STATE/data" "$TMP_STATE/log" "$TMP_STATE/etc"

SUSPECT_DATA_DIR="$TMP_STATE/data" \
SUSPECT_DB_PATH="$TMP_STATE/data/interrogation.db" \
SUSPECT_LOG_DIR="$TMP_STATE/log" \
SUSPECT_MIN_FREE_MB=1 \
PYTHONPATH=linux/backend \
python3 - <<'PY'
from app.health import readiness_snapshot
from app.main import app
snapshot = readiness_snapshot()
assert snapshot["status"] == "ready", snapshot
assert snapshot["checks"]["storage"]["state"] == "READY"
assert snapshot["checks"]["database"]["state"] == "READY"
assert snapshot["capabilities"]["ai"]["state"] in {"NOT_INSTALLED", "READY"}
assert app.title == "Linux Suspect Interrogation API"
print(snapshot)
PY

python3 scripts/mock_e2e.py --state-dir "$TMP_STATE/e2e" --backup-dir "$TMP_STATE/backups"

if command -v npm >/dev/null 2>&1; then
  (
    cd webapp
    if [[ -f package-lock.json && ! -d node_modules ]]; then npm ci --prefer-offline; fi
    npm run typecheck
    npm run build
  )
else
  echo "npm unavailable on runner; hosted CI owns Vue typecheck/build gate"
fi

echo "rk3588 smoke: ok"
