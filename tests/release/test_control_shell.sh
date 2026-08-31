#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONTROL="$ROOT_DIR/deploy/control.sh"

if [[ ! -x "$CONTROL" ]]; then
  echo "control script missing or not executable: $CONTROL" >&2
  exit 1
fi

help="$($CONTROL --help)"
for command in install deploy upgrade health rollback status backup restore; do
  grep -q "$command" <<<"$help"
done

TMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TMP_ROOT"' EXIT
mkdir -p "$TMP_ROOT/releases/old" "$TMP_ROOT/releases/new"
ln -s "$TMP_ROOT/releases/old" "$TMP_ROOT/current"

SUSPECT_OPT_DIR="$TMP_ROOT" \
SUSPECT_ETC_DIR="$TMP_ROOT/etc" \
SUSPECT_DATA_DIR="$TMP_ROOT/data" \
SUSPECT_LOG_DIR="$TMP_ROOT/log" \
SUSPECT_SYSTEMD_DIR="$TMP_ROOT/systemd" \
SUSPECT_DRY_RUN=1 \
  "$CONTROL" rollback "$TMP_ROOT/releases/new" >/dev/null

[[ "$(readlink "$TMP_ROOT/current")" == "$TMP_ROOT/releases/new" ]]

# Regression: under `set -u`, install_python_dependencies must not reference
# the local `release` variable before that assignment has taken effect.
source "$ROOT_DIR/deploy/lib/release.sh"
mkdir -p "$TMP_ROOT/release-under-test"
SUSPECT_SKIP_DEP_INSTALL=1 install_python_dependencies "$TMP_ROOT/release-under-test"
[[ -x "$TMP_ROOT/release-under-test/.venv/bin/python" ]]

# Production migrations are part of the release transaction. The helper must
# run Alembic against the staged release while loading the production runtime
# environment, before the release is switched live.
MIGRATION_RELEASE="$TMP_ROOT/migration-release"
mkdir -p "$MIGRATION_RELEASE/.venv/bin" "$MIGRATION_RELEASE/linux/backend" "$TMP_ROOT/etc" "$TMP_ROOT/data"
touch "$MIGRATION_RELEASE/linux/backend/alembic.ini"
cat >"$TMP_ROOT/etc/runtime.env" <<EOF
SUSPECT_DB_PATH=$TMP_ROOT/data/interrogation.db
EOF
cat >"$MIGRATION_RELEASE/.venv/bin/python" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
printf 'args=%s\n' "$*" >"$MIGRATION_TRACE"
printf 'db=%s\n' "${SUSPECT_DB_PATH:-}" >>"$MIGRATION_TRACE"
printf 'pythonpath=%s\n' "${PYTHONPATH:-}" >>"$MIGRATION_TRACE"
EOF
chmod +x "$MIGRATION_RELEASE/.venv/bin/python"
export MIGRATION_TRACE="$TMP_ROOT/migration.trace"
SUSPECT_ETC_DIR="$TMP_ROOT/etc" apply_database_migrations "$MIGRATION_RELEASE"
grep -q 'args=-m alembic -c .*alembic.ini upgrade head' "$MIGRATION_TRACE"
grep -q "db=$TMP_ROOT/data/interrogation.db" "$MIGRATION_TRACE"
grep -q "pythonpath=$MIGRATION_RELEASE/linux/backend" "$MIGRATION_TRACE"

echo "deploy control contract: ok"
