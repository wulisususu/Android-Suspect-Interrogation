#!/usr/bin/env bash
set -euo pipefail

require_env() {
  local name="$1"
  if [[ -z "${!name:-}" ]]; then
    echo "${name} is required for the FunASR speech worker" >&2
    exit 78
  fi
}

require_env SUSPECT_FUNASR_PYTHON
require_env SUSPECT_FUNASR_MODEL_ROOT
require_env SUSPECT_SPEECH_SOCKET

if [[ ! -x "$SUSPECT_FUNASR_PYTHON" ]]; then
  echo "SUSPECT_FUNASR_PYTHON is not executable: $SUSPECT_FUNASR_PYTHON" >&2
  exit 78
fi

if [[ ! -d "$SUSPECT_FUNASR_MODEL_ROOT" ]]; then
  echo "SUSPECT_FUNASR_MODEL_ROOT is not a directory: $SUSPECT_FUNASR_MODEL_ROOT" >&2
  exit 78
fi

for model_dir in paraformer fsmn-vad xvector; do
  if [[ ! -d "$SUSPECT_FUNASR_MODEL_ROOT/$model_dir" ]]; then
    echo "required FunASR model directory is missing: $SUSPECT_FUNASR_MODEL_ROOT/$model_dir" >&2
    exit 78
  fi
done

export PYTHONPATH=/opt/suspect-interrogation/current/linux/backend
exec "$SUSPECT_FUNASR_PYTHON" -m speech_worker.main
