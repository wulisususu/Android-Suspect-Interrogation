from pathlib import Path

workflow = r'''name: RK3588 Dual Speaker Backend Probe

on:
  push:
    branches:
      - feat/dual-speaker-backends
    paths:
      - 'scripts/ci/probe-eres2net-large.py'
      - 'scripts/ci/rk3588-speech-calibrate.py'
      - 'scripts/ci/rk3588-speech-smoke.py'
      - 'tests/release/test_rk3588_dual_speaker_probes.py'
      - '.github/workflows/rk3588-dual-speaker-probe.yml'
      - 'docs/release/task12-post-apply-validation.md'
  workflow_dispatch:

permissions:
  contents: read

concurrency:
  group: rk3588-dual-speaker-probe
  cancel-in-progress: false

jobs:
  hosted-contract:
    name: Task 12 hosted contract
    runs-on: ubuntu-24.04
    timeout-minutes: 10
    env:
      PYTHONPATH: linux/backend
      HARDWARE_MODE: mock
      DEVICE_SIMULATOR: '1'
      AI_MODE: mock
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
          cache: pip
          cache-dependency-path: linux/backend/requirements.txt
      - name: Install hosted dependencies
        run: python -m pip install -r linux/backend/requirements.txt pytest
      - name: Compile Task 12 scripts
        run: |
          python -m py_compile \
            scripts/ci/probe-eres2net-large.py \
            scripts/ci/rk3588-speech-calibrate.py \
            scripts/ci/rk3588-speech-smoke.py
      - name: Task 12 release contracts
        run: |
          python -m pytest -q \
            tests/release/test_rk3588_dual_speaker_probes.py \
            tests/release/test_funasr_probe_script.py

  rk3588-dual-probe:
    name: RK3588 read-only dual speaker probe
    needs: hosted-contract
    runs-on: [self-hosted, rk3588]
    timeout-minutes: 45
    env:
      PYTHONDONTWRITEBYTECODE: '1'
      PYTHONPATH: ${{ github.workspace }}/linux/backend
      MODELSCOPE_OFFLINE: '1'
      HF_HUB_OFFLINE: '1'
      TRANSFORMERS_OFFLINE: '1'
    steps:
      - name: Checkout exact revision
        uses: actions/checkout@v4
        with:
          ref: ${{ github.sha }}
          fetch-depth: 1
          clean: true

      - name: Resolve installed runtime and ERes2Net package
        shell: bash
        run: |
          set -euo pipefail
          OUT="$RUNNER_TEMP/task12-dual-speaker"
          mkdir -p "$OUT"
          FUNASR_PYTHON=/opt/suspect-interrogation/runtime/funasr-env/bin/python
          test -x "$FUNASR_PYTHON"
          if [[ -d /opt/suspect-interrogation/models/funasr ]]; then
            FUNASR_MODEL_ROOT=/opt/suspect-interrogation/models/funasr
          elif [[ -d /home/youyeetoo/funasr-models ]]; then
            FUNASR_MODEL_ROOT=/home/youyeetoo/funasr-models
          else
            echo 'FUNASR_MODEL_ROOT_MISSING' >&2
            exit 1
          fi
          python3 scripts/ci/probe-eres2net-large.py \
            --search-root /opt/suspect-interrogation/models \
            --search-root /home/youyeetoo/.cache/modelscope \
            --search-root /home/youyeetoo/funasr-models \
            --output "$OUT/eres2net-package.json"
          ERES_MODEL_DIR="$(python3 - "$OUT/eres2net-package.json" <<'PY'
          import json, sys
          data=json.load(open(sys.argv[1], encoding='utf-8'))
          if data.get('status') != 'INSTALLED' or not data.get('model_dir'):
              raise SystemExit('ERES2NET_MODEL_NOT_INSTALLED')
          print(data['model_dir'])
          PY
          )"
          echo "TASK12_OUT=$OUT" >> "$GITHUB_ENV"
          echo "FUNASR_PYTHON=$FUNASR_PYTHON" >> "$GITHUB_ENV"
          echo "FUNASR_MODEL_ROOT=$FUNASR_MODEL_ROOT" >> "$GITHUB_ENV"
          echo "ERES_MODEL_DIR=$ERES_MODEL_DIR" >> "$GITHUB_ENV"

      - name: Resolve existing three-identity calibration corpus without copying audio
        shell: bash
        run: |
          set -euo pipefail
          CORPUS_ROOT=''
          for candidate in \
            /var/lib/suspect-interrogation/speaker-calibration \
            /var/lib/suspect-interrogation/calibration \
            /opt/suspect-interrogation/calibration \
            /home/youyeetoo/suspect-speaker-calibration; do
            [[ -d "$candidate" ]] || continue
            suspect="$(find "$candidate" -mindepth 1 -maxdepth 1 -type d -iname 'suspect' -print -quit)"
            interrogator="$(find "$candidate" -mindepth 1 -maxdepth 1 -type d -iname 'interrogator' -print -quit)"
            recorder="$(find "$candidate" -mindepth 1 -maxdepth 1 -type d -iname 'recorder' -print -quit)"
            if [[ -n "$suspect" && -n "$interrogator" && -n "$recorder" ]]; then
              CORPUS_ROOT="$candidate"
              SUSPECT_DIR="$suspect"
              INTERROGATOR_DIR="$interrogator"
              RECORDER_DIR="$recorder"
              break
            fi
          done
          if [[ -z "$CORPUS_ROOT" ]]; then
            echo 'CALIBRATION_CORPUS_MISSING: expected SUSPECT/INTERROGATOR/RECORDER WAV groups on the board' >&2
            exit 1
          fi
          mapfile -t SUSPECT_WAVS < <(find "$SUSPECT_DIR" -maxdepth 1 -type f -iname '*.wav' | sort)
          mapfile -t INTERROGATOR_WAVS < <(find "$INTERROGATOR_DIR" -maxdepth 1 -type f -iname '*.wav' | sort)
          mapfile -t RECORDER_WAVS < <(find "$RECORDER_DIR" -maxdepth 1 -type f -iname '*.wav' | sort)
          if (( ${#SUSPECT_WAVS[@]} < 3 || ${#INTERROGATOR_WAVS[@]} < 3 || ${#RECORDER_WAVS[@]} < 3 )); then
            echo 'CALIBRATION_CORPUS_INSUFFICIENT: each identity needs at least 3 WAV utterances' >&2
            exit 1
          fi
          printf '%s\0' "${SUSPECT_WAVS[@]}" > "$RUNNER_TEMP/task12-suspect-wavs.list0"
          printf '%s\0' "${INTERROGATOR_WAVS[@]}" > "$RUNNER_TEMP/task12-interrogator-wavs.list0"
          printf '%s\0' "${RECORDER_WAVS[@]}" > "$RUNNER_TEMP/task12-recorder-wavs.list0"
          echo "corpus_root=$CORPUS_ROOT"
          echo "corpus_counts=${#SUSPECT_WAVS[@]}/${#INTERROGATOR_WAVS[@]}/${#RECORDER_WAVS[@]}"

      - name: Start isolated exact-revision speech worker
        shell: bash
        run: |
          set -euo pipefail
          SOCKET="$RUNNER_TEMP/task12-dual-speaker.sock"
          LOG="$RUNNER_TEMP/task12-dual-speaker-worker.log"
          rm -f "$SOCKET"
          export SUSPECT_SPEECH_SOCKET="$SOCKET"
          export SUSPECT_FUNASR_MODEL_ROOT="$FUNASR_MODEL_ROOT"
          export SUSPECT_ERES2NET_MODEL_DIR="$ERES_MODEL_DIR"
          "$FUNASR_PYTHON" -m speech_worker.main >"$LOG" 2>&1 &
          PID=$!
          echo "$PID" > "$RUNNER_TEMP/task12-dual-speaker.pid"
          for _ in $(seq 1 180); do
            [[ -S "$SOCKET" ]] && break
            if ! kill -0 "$PID" 2>/dev/null; then
              cat "$LOG" >&2 || true
              exit 1
            fi
            sleep 0.5
          done
          test -S "$SOCKET" || { cat "$LOG" >&2 || true; exit 1; }
          echo "TASK12_SOCKET=$SOCKET" >> "$GITHUB_ENV"
          "$FUNASR_PYTHON" - "$SOCKET" <<'PY'
          import json, sys
          from app.ai.speech.client import SpeechWorkerClient
          health=SpeechWorkerClient(sys.argv[1], timeout=60).health()
          backends=health.get('speaker_backends') or {}
          safe={key: {'ready': value.get('ready'), 'model_id': value.get('model_id'), 'model_fingerprint': value.get('model_fingerprint'), 'error': value.get('error')} for key, value in backends.items() if isinstance(value, dict)}
          print(json.dumps({'models': health.get('models'), 'speaker_backends': safe}, ensure_ascii=False, sort_keys=True, indent=2))
          for key in ('xvector', 'eres2net_large'):
              if not isinstance(backends.get(key), dict) or backends[key].get('ready') is not True:
                  raise SystemExit(f'{key}_BACKEND_NOT_READY')
          PY

      - name: Run package plus real ERes2Net embedding smoke
        shell: bash
        run: |
          set -euo pipefail
          mapfile -d '' -t SUSPECT_WAVS < "$RUNNER_TEMP/task12-suspect-wavs.list0"
          python3 scripts/ci/probe-eres2net-large.py \
            --model-dir "$ERES_MODEL_DIR" \
            --socket "$TASK12_SOCKET" \
            --embedding-wav "${SUSPECT_WAVS[0]}" \
            --output "$TASK12_OUT/eres2net-runtime-probe.json"

      - name: Calibrate XVector on the production microphone corpus
        shell: bash
        run: |
          set -euo pipefail
          mapfile -d '' -t SUSPECT_WAVS < "$RUNNER_TEMP/task12-suspect-wavs.list0"
          mapfile -d '' -t INTERROGATOR_WAVS < "$RUNNER_TEMP/task12-interrogator-wavs.list0"
          mapfile -d '' -t RECORDER_WAVS < "$RUNNER_TEMP/task12-recorder-wavs.list0"
          "$FUNASR_PYTHON" scripts/ci/rk3588-speech-calibrate.py \
            --socket "$TASK12_SOCKET" \
            --speaker-backend xvector \
            --suspect-wavs "${SUSPECT_WAVS[@]}" \
            --interrogator-wavs "${INTERROGATOR_WAVS[@]}" \
            --recorder-wavs "${RECORDER_WAVS[@]}" \
            --output "$TASK12_OUT/xvector-calibration.json"

      - name: Calibrate ERes2Net-large on the same production microphone corpus
        shell: bash
        run: |
          set -euo pipefail
          mapfile -d '' -t SUSPECT_WAVS < "$RUNNER_TEMP/task12-suspect-wavs.list0"
          mapfile -d '' -t INTERROGATOR_WAVS < "$RUNNER_TEMP/task12-interrogator-wavs.list0"
          mapfile -d '' -t RECORDER_WAVS < "$RUNNER_TEMP/task12-recorder-wavs.list0"
          "$FUNASR_PYTHON" scripts/ci/rk3588-speech-calibrate.py \
            --socket "$TASK12_SOCKET" \
            --speaker-backend eres2net_large \
            --suspect-wavs "${SUSPECT_WAVS[@]}" \
            --interrogator-wavs "${INTERROGATOR_WAVS[@]}" \
            --recorder-wavs "${RECORDER_WAVS[@]}" \
            --output "$TASK12_OUT/eres2net-calibration.json"

      - name: Run non-restarting smoke for both concrete backends
        shell: bash
        run: |
          set -euo pipefail
          mapfile -d '' -t SUSPECT_WAVS < "$RUNNER_TEMP/task12-suspect-wavs.list0"
          mapfile -d '' -t INTERROGATOR_WAVS < "$RUNNER_TEMP/task12-interrogator-wavs.list0"
          mapfile -d '' -t RECORDER_WAVS < "$RUNNER_TEMP/task12-recorder-wavs.list0"
          read -r XV_T XV_M < <(python3 - "$TASK12_OUT/xvector-calibration.json" <<'PY'
          import json, sys
          d=json.load(open(sys.argv[1], encoding='utf-8')); print(d['recommended_threshold'], d['recommended_margin'])
          PY
          )
          read -r ER_T ER_M < <(python3 - "$TASK12_OUT/eres2net-calibration.json" <<'PY'
          import json, sys
          d=json.load(open(sys.argv[1], encoding='utf-8')); print(d['recommended_threshold'], d['recommended_margin'])
          PY
          )
          "$FUNASR_PYTHON" scripts/ci/rk3588-speech-smoke.py \
            --socket "$TASK12_SOCKET" --speaker-backend xvector \
            --threshold "$XV_T" --margin "$XV_M" \
            --suspect-wav "${SUSPECT_WAVS[0]}" --interrogator-wav "${INTERROGATOR_WAVS[0]}" --recorder-wav "${RECORDER_WAVS[0]}" \
            --skip-systemd --skip-api --skip-mount --no-restart > "$TASK12_OUT/xvector-smoke.json"
          "$FUNASR_PYTHON" scripts/ci/rk3588-speech-smoke.py \
            --socket "$TASK12_SOCKET" --speaker-backend eres2net_large \
            --threshold "$ER_T" --margin "$ER_M" \
            --suspect-wav "${SUSPECT_WAVS[0]}" --interrogator-wav "${INTERROGATOR_WAVS[0]}" --recorder-wav "${RECORDER_WAVS[0]}" \
            --skip-systemd --skip-api --skip-mount --no-restart > "$TASK12_OUT/eres2net-smoke.json"

      - name: Verify independent calibration identities and operating points
        shell: bash
        run: |
          set -euo pipefail
          python3 - "$TASK12_OUT/xvector-calibration.json" "$TASK12_OUT/eres2net-calibration.json" <<'PY'
          import json, math, sys
          xv=json.load(open(sys.argv[1], encoding='utf-8'))
          er=json.load(open(sys.argv[2], encoding='utf-8'))
          assert xv['speaker_backend'] == 'xvector', xv
          assert er['speaker_backend'] == 'eres2net_large', er
          assert xv['calibration_id'] and er['calibration_id'] and xv['calibration_id'] != er['calibration_id']
          assert xv['model_fingerprint'] and er['model_fingerprint']
          for item in (xv, er):
              for key in ('recommended_threshold', 'recommended_margin'):
                  value=float(item[key]); assert math.isfinite(value) and 0.0 <= value <= 1.0
              assert item['status'] == 'safe'
          print(json.dumps({
              'xvector': {key: xv[key] for key in ('calibration_id','speaker_backend','model_fingerprint','recommended_threshold','recommended_margin')},
              'eres2net_large': {key: er[key] for key in ('calibration_id','speaker_backend','model_fingerprint','recommended_threshold','recommended_margin')},
          }, ensure_ascii=False, sort_keys=True, indent=2))
          print('TASK12_DUAL_SPEAKER_PROBE_COMPLETE')
          PY

      - name: Stop isolated worker
        if: always()
        shell: bash
        run: |
          set +e
          if [[ -f "$RUNNER_TEMP/task12-dual-speaker.pid" ]]; then
            PID="$(cat "$RUNNER_TEMP/task12-dual-speaker.pid")"
            kill "$PID" 2>/dev/null || true
            wait "$PID" 2>/dev/null || true
          fi
          rm -f "$RUNNER_TEMP/task12-dual-speaker.sock"

      - name: Upload JSON evidence only
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: task12-rk3588-dual-speaker-${{ github.run_id }}
          path: |
            ${{ runner.temp }}/task12-dual-speaker/eres2net-package.json
            ${{ runner.temp }}/task12-dual-speaker/eres2net-runtime-probe.json
            ${{ runner.temp }}/task12-dual-speaker/xvector-calibration.json
            ${{ runner.temp }}/task12-dual-speaker/eres2net-calibration.json
            ${{ runner.temp }}/task12-dual-speaker/xvector-smoke.json
            ${{ runner.temp }}/task12-dual-speaker/eres2net-smoke.json
          if-no-files-found: warn
          retention-days: 14
'''

path = Path('.github/workflows/rk3588-dual-speaker-probe.yml')
path.write_text(workflow, encoding='utf-8')
print('Task12 workflow GREEN apply complete')
