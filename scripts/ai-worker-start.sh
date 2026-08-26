#!/usr/bin/env bash
set -euo pipefail
if [[ -n "${SUSPECT_AI_WORKER_COMMAND:-}" ]]; then exec /bin/sh -c "$SUSPECT_AI_WORKER_COMMAND"; fi
if [[ -z "${SUSPECT_MODEL_PATH:-}" || ! -e "${SUSPECT_MODEL_PATH}" ]]; then echo "AI capability NOT_INSTALLED; worker remains optional" >&2; exit 0; fi
echo "AI model path exists but SUSPECT_AI_WORKER_COMMAND is not configured" >&2
exit 0
