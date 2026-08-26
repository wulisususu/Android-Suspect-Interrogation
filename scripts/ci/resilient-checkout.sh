#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_WORKSPACE:?GITHUB_WORKSPACE is required}"
: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"
TARGET_SHA="${TARGET_SHA:-${GITHUB_SHA:?GITHUB_SHA is required}}"
SPARSE_PATHS="${SPARSE_PATHS:-.github linux webapp deploy scripts systemd tests docs}"
FETCH_ATTEMPTS="${FETCH_ATTEMPTS:-5}"
FETCH_TIMEOUT_SECONDS="${FETCH_TIMEOUT_SECONDS:-120}"

cd "$GITHUB_WORKSPACE"
find . -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +
git init .
git remote add origin "https://github.com/${GITHUB_REPOSITORY}.git"
git config --local gc.auto 0
git config --local http.version HTTP/1.1
git config --local http.lowSpeedLimit 1024
git config --local http.lowSpeedTime 15
git sparse-checkout init --cone
# shellcheck disable=SC2086
git sparse-checkout set ${SPARSE_PATHS}

fetched=0
for ((attempt=1; attempt<=FETCH_ATTEMPTS; attempt++)); do
  echo "fetch attempt ${attempt}/${FETCH_ATTEMPTS}"
  if timeout "${FETCH_TIMEOUT_SECONDS}s" git -c protocol.version=2 fetch \
      --filter=blob:none \
      --no-tags \
      --prune \
      --no-recurse-submodules \
      --depth=1 \
      origin "+${TARGET_SHA}:refs/remotes/origin/__runner_target"; then
    fetched=1
    break
  fi
  sleep $((attempt * 3))
done

[[ "$fetched" -eq 1 ]] || {
  echo "Git fetch failed after ${FETCH_ATTEMPTS} bounded attempts" >&2
  exit 1
}
git checkout --force --detach "$TARGET_SHA"
[[ "$(git rev-parse HEAD)" == "$TARGET_SHA" ]]
git status --short
