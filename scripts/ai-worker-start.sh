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
require_env SUSPECT_ERES2NET_MODEL_DIR
require_env SUSPECT_SPEECH_SOCKET

if [[ ! -x "$SUSPECT_FUNASR_PYTHON" ]]; then
  echo "SUSPECT_FUNASR_PYTHON is not executable: $SUSPECT_FUNASR_PYTHON" >&2
  exit 78
fi

if [[ ! -d "$SUSPECT_FUNASR_MODEL_ROOT" ]]; then
  echo "SUSPECT_FUNASR_MODEL_ROOT is not a directory: $SUSPECT_FUNASR_MODEL_ROOT" >&2
  exit 78
fi

for model_dir in paraformer fsmn-vad; do
  if [[ ! -d "$SUSPECT_FUNASR_MODEL_ROOT/$model_dir" ]]; then
    echo "required FunASR model directory is missing: $SUSPECT_FUNASR_MODEL_ROOT/$model_dir" >&2
    exit 78
  fi
done

if [[ ! -d "$SUSPECT_ERES2NET_MODEL_DIR" ]]; then
  echo "SUSPECT_ERES2NET_MODEL_DIR is not a directory: $SUSPECT_ERES2NET_MODEL_DIR" >&2
  exit 78
fi

if [[ ! -f "$SUSPECT_ERES2NET_MODEL_DIR/pretrained_eres2net.pt" ]]; then
  echo "ERes2Net-large checkpoint is missing: $SUSPECT_ERES2NET_MODEL_DIR/pretrained_eres2net.pt" >&2
  exit 78
fi

export PYTHONPATH=/opt/suspect-interrogation/current/linux/backend
exec "$SUSPECT_FUNASR_PYTHON" -m speech_worker.main
