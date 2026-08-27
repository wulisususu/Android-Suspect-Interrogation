#!/usr/bin/env bash
set -euo pipefail

# Exercise Alembic against a clean, isolated database. Do not reuse the
# application's default SQLite file because earlier test imports may initialize
# it from current ORM metadata, which would bypass historical migrations.
if [[ -f linux/backend/alembic.ini ]]; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  export DATABASE_URL="sqlite:///$tmp/migration.db"
  (
    cd linux/backend
    python3 -m alembic -c alembic.ini upgrade head
    python3 -m alembic -c alembic.ini current
  )
else
  echo "::notice::No linux/backend Alembic configuration yet; validating SQLite snapshot/restore compatibility instead."
  python3 -m pytest tests/release/test_backup_restore.py -q
fi
