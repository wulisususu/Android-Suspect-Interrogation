#!/usr/bin/env bash
set -euo pipefail

# The current Linux skeleton does not yet own a production migration framework.
# When the backend agent adds Alembic, this gate automatically exercises it.
if [[ -f linux/backend/alembic.ini ]]; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  export SUSPECT_DB_PATH="$tmp/migration.db"
  (
    cd linux/backend
    python3 -m alembic -c alembic.ini upgrade head
    python3 -m alembic -c alembic.ini current
  )
else
  echo "::notice::No linux/backend Alembic configuration yet; validating SQLite snapshot/restore compatibility instead."
  python3 -m pytest tests/release/test_backup_restore.py -q
fi
