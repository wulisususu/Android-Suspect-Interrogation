#!/usr/bin/env bash
set -euo pipefail

release_name_for_source() {
  local source="$1" stamp sha
  stamp="$(date -u +%Y%m%dT%H%M%SZ)"
  sha="$(git -C "$source" rev-parse --short=12 HEAD 2>/dev/null || printf 'manual')"
  printf '%s-%s\n' "$stamp" "$sha"
}

stage_source_tree() {
  local source="$1" destination="$2"
  mkdir -p "$destination"
  tar -C "$source" --exclude='.git' --exclude='node_modules' --exclude='webapp/node_modules' --exclude='webapp/dist' -cf - . | tar -C "$destination" -xf -
}

install_python_dependencies() {
  local release="$1"
  local venv="$release/.venv"
  python3 -m venv "$venv"
  [[ "${SUSPECT_SKIP_DEP_INSTALL:-0}" == "1" ]] && return 0
  local pip_args=(install -r "$release/linux/backend/requirements.txt")
  if [[ -n "${SUSPECT_WHEELHOUSE:-}" ]]; then
    pip_args=(install --no-index --find-links "$SUSPECT_WHEELHOUSE" -r "$release/linux/backend/requirements.txt")
  fi
  "$venv/bin/python" -m pip "${pip_args[@]}"
}

build_webapp() {
  local release="$1"
  [[ -f "$release/webapp/package.json" ]] || return 0
  [[ "${SUSPECT_SKIP_WEB_BUILD:-0}" == "1" ]] && return 0
  command -v npm >/dev/null 2>&1 || return 1
  (
    cd "$release/webapp"
    if [[ -f package-lock.json ]]; then npm ci --prefer-offline; else npm install --prefer-offline; fi
    npm run typecheck
    npm run build
  )
}

apply_database_migrations() {
  local release="$1"
  local backend="$release/linux/backend"
  local python="$release/.venv/bin/python"
  local runtime_env="${SUSPECT_RUNTIME_ENV_FILE:-${SUSPECT_ETC_DIR:-/etc/suspect-interrogation}/runtime.env}"

  [[ -x "$python" ]] || { printf 'release python missing: %s\n' "$python" >&2; return 1; }
  [[ -f "$backend/alembic.ini" ]] || { printf 'alembic config missing: %s\n' "$backend/alembic.ini" >&2; return 1; }
  [[ -f "$runtime_env" ]] || { printf 'runtime env missing: %s\n' "$runtime_env" >&2; return 1; }

  (
    set -a
    # shellcheck disable=SC1090
    source "$runtime_env"
    set +a
    export PYTHONPATH="$backend"
    cd "$backend"
    "$python" -m alembic -c "$backend/alembic.ini" upgrade head
  )
}

prune_releases() {
  local keep="${SUSPECT_RELEASE_RETENTION:-3}"
  mapfile -t releases < <(find "$SUSPECT_RELEASES_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' 2>/dev/null | sort -nr | cut -d' ' -f2-)
  local i
  for ((i=keep; i<${#releases[@]}; i++)); do
    [[ "${releases[$i]}" == "$(current_release)" ]] && continue
    rm -rf -- "${releases[$i]}"
  done
}
