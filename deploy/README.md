# MOSS RK3588 Worker — Offline Production Deployment (Task 14)

Phase-2, on-device runbook. Phase 1 (this repository) ships the code, the
systemd assets, the manifest-rebuild tool and this document; nothing here has
been executed on the board yet. Existing FunASR/speech services are never
touched: no step below stops, restarts, rebinds or reconfigures TCP/8000 or
`speech_worker` (AGENTS.md Port safety).

## 0. What ships where

| Asset | Repo path | Board destination |
| --- | --- | --- |
| Worker unit | `systemd/moss-worker.service` | `/etc/systemd/system/moss-worker.service` |
| tmpfiles fragment | `deploy/tmpfiles-suspect-interrogation.conf` | `/etc/tmpfiles.d/suspect-interrogation-moss.conf` |
| Env file template | (see §3) | `/etc/suspect-interrogation/moss-worker.env` (chmod 640, root:suspect-interrogation) |
| Manifest rebuild tool | `deploy/rebuild_moss_manifest.py` | stays in the release checkout |
| Worker code | `linux/backend/moss_worker/` | `/opt/suspect-interrogation/current/linux/backend/moss_worker/` (via release deploy) |
| Isolated child env | — | `/opt/suspect-interrogation/runtime/moss-env` (Python 3.10) |
| Model bundle | — | `/opt/suspect-interrogation/models/moss-rk3588` (read-only to the unit) |
| Spool | — | `/var/lib/suspect-interrogation/moss` |
| Logs | — | journald (`journalctl -u moss-worker`) |

Unit contract tests live in `tests/release/test_moss_systemd_and_deploy.py`
(unit flags, tmpfiles line, runbook dry-run) and
`tests/release/test_systemd_units.py` (pre-existing units stay untouched).

## 1. Hard prerequisite: rebuild the bundle manifest BEFORE enabling the worker

Verified on the RK3588 (read-only inspection, 2026-09-08):
`/home/youyeetoo/moss-build/bundle-v2/manifest.json` carries the
pre-revision policy (`target=12 / fallback=10 / minimum=8`) and SHA-256
`a50ce60b04e3715a4ce9d05381336fd95072f359c7883115e946d55321657e69`. Under
the approved policy (target=10 / fallback=8 / minimum=8,
`tools/moss_rk3588/validate_bundle.py POLICY`) that manifest fails the
worker's bundle check closed with `MOSS_BUNDLE_INVALID`. Deploying the new
worker without rebuilding the manifest would therefore guarantee a
not-ready MOSS capability.

The bundle-v2 manifest also records its build inputs on the original build
host (`/home/mm/moss-build/source/MOSS-Transcribe-Diarize-upstream`,
commit `61bc29cd…`); the youyeetoo board only stores the finished artifacts
under `/home/youyeetoo/moss-build/bundle-v2`. Re-staging the MOSS source
checkout and the HF checkpoint (paths below) is part of this step.

On the board, with the new checkout active and the build venv (torch +
numpy) that produced `bundle-v2`:

```bash
# 1) Prove the old bundle is rejected (expected: policy error, exit 1)
python3 -m tools.moss_rk3588.validate_bundle /opt/suspect-interrogation/models/moss-rk3588

# 2) Preflight the rebuild (safe everywhere, no writes)
python3 deploy/rebuild_moss_manifest.py --dry-run \
  --old-bundle /opt/suspect-interrogation/models/moss-rk3588 \
  --assets     /home/youyeetoo/moss-build/bundle-v2 \
  --source     /home/youyeetoo/moss-build/source/MOSS-Transcribe-Diarize-upstream \
  --checkpoint /home/youyeetoo/moss-build/source/MOSS-Transcribe-Diarize \
  --provenance /home/youyeetoo/moss-build/provenance.json \
  --output     /home/youyeetoo/moss-build/bundle-v3

# 3) Real rebuild: build_manifest.py embeds the new POLICY automatically,
#    validates the staged assets, copies artifacts exclusively and
#    revalidates the copied bundle.
python3 deploy/rebuild_moss_manifest.py \
  --old-bundle /opt/suspect-interrogation/models/moss-rk3588 \
  --assets     /home/youyeetoo/moss-build/bundle-v2 \
  --source     /home/youyeetoo/moss-build/source/MOSS-Transcribe-Diarize-upstream \
  --checkpoint /home/youyeetoo/moss-build/source/MOSS-Transcribe-Diarize \
  --provenance /home/youyeetoo/moss-build/provenance.json \
  --output     /home/youyeetoo/moss-build/bundle-v3

# 4) Independent re-validation (must print "valid": true)
python3 -m tools.moss_rk3588.validate_bundle /home/youyeetoo/moss-build/bundle-v3

# 5) New manifest SHA-256 (the value the worker must be pinned to)
sha256sum /home/youyeetoo/moss-build/bundle-v3/manifest.json
```

(Adjust `--source/--checkpoint/--provenance` to the actual staged paths used
for `bundle-v2`; `--allow-dirty` exists for a dirty MOSS source checkout and
should stay unused.)

## 2. Install the child runtime env (isolated Python 3.10)

```bash
sudo python3.10 -m venv /opt/suspect-interrogation/runtime/moss-env
sudo /opt/suspect-interrogation/runtime/moss-env/bin/pip install \
  --no-index --find-links /home/youyeetoo/offline-wheels \
  -r linux/backend/requirements-moss-rk3588.txt
sudo /opt/suspect-interrogation/runtime/moss-env/bin/pip install \
  --no-index --find-links /home/youyeetoo/offline-wheels \
  rknn-toolkit-lite2==2.3.2 rkllm==1.3.0
```

The pinned shared libraries (`librknnrt.so`, `librkllmrt.so`, SHA-256s are
burned into `moss_worker/runtime.py`) stay where they were verified, e.g.
`/opt/suspect-interrogation/runtime/moss-env/lib/...`; their exact paths go
into the env file below. Never retarget `/lib` or `/usr/lib`.

## 3. Configure and install the unit

`/etc/suspect-interrogation/moss-worker.env` (chmod 640
root:suspect-interrogation; per-deployment values only):

```ini
MOSS_MODEL_MANIFEST_SHA256=<sha256 from §1 step 5>
MOSS_RUNTIME_VERSIONS={"rknn": "2.3.2", "rkllm": "1.3.0", "python": "3.10"}
MOSS_RKNN_LIBRARY=/opt/suspect-interrogation/runtime/moss-env/lib/librknnrt.so
MOSS_RKLLM_LIBRARY=/opt/suspect-interrogation/runtime/moss-env/lib/librkllmrt.so
```

Socket, spool root, model bundle path and the child interpreter are stable
and already set inside the unit (`SUSPECT_MOSS_SOCKET`, `MOSS_SPOOL_ROOT`,
`MOSS_MODEL_BUNDLE`, `MOSS_CHILD_PYTHON`, `MOSS_CANCEL_GRACE`).

```bash
sudo cp systemd/moss-worker.service /etc/systemd/system/
sudo cp deploy/tmpfiles-suspect-interrogation.conf /etc/tmpfiles.d/suspect-interrogation-moss.conf
sudo systemd-tmpfiles --create /etc/tmpfiles.d/suspect-interrogation-moss.conf
sudo install -d -o suspect-interrogation -g suspect-interrogation /var/lib/suspect-interrogation/moss
# §1 step 6: atomic read-only install of the rebuilt bundle
# (first install: /opt/suspect-interrogation/models currently holds only funasr)
sudo rsync -a /home/youyeetoo/moss-build/bundle-v3/ /opt/suspect-interrogation/models/moss-rk3588-new/
sudo chown -R root:root /opt/suspect-interrogation/models/moss-rk3588-new
sudo chmod -R a-w /opt/suspect-interrogation/models/moss-rk3588-new
sudo test ! -e /opt/suspect-interrogation/models/moss-rk3588 && \
  sudo mv /opt/suspect-interrogation/models/moss-rk3588-new /opt/suspect-interrogation/models/moss-rk3588
sudo systemctl daemon-reload
sudo systemctl enable --now moss-worker.service
```

`RuntimeDirectory=suspect-interrogation` (mode 0750) plus the tmpfiles
fragment guarantee `/run/suspect-interrogation` exists; the worker itself
binds and `chmod 0660` the socket in `MossWorkerServer.bind()`.

### Socket permission verification (production gate 2)

```bash
stat -c '%a %U:%G' /run/suspect-interrogation/moss.sock   # expect: 660 suspect-interrogation suspect-interrogation
```

### FunASR / TCP-8000 preservation (production gate 7)

```bash
systemctl is-active funasr.service   # unchanged, active (unit name per existing deployment)
ss -ltnp | grep ':8000'              # same owner/process as before the deploy
```

The moss unit references no FunASR paths, no `speech.sock` and runs no
`systemctl` commands; installing it cannot disturb the existing worker.

## 4. Health verification (production gates 3/10)

The moss socket speaks the length-prefixed JSON protocol (not HTTP), so use
the committed client for the worker health op:

```bash
cd /opt/suspect-interrogation/current/linux/backend && \
/opt/suspect-interrogation/current/.venv/bin/python - <<'PY'
from app.ai.moss.client import MossWorkerClient
health = MossWorkerClient("/run/suspect-interrogation/moss.sock").health()
assert health["status"] == "ok"
assert health["queue_depth"] == 0 and health["active_job"] is None
print(health["manifest_sha256"], health["runtime_versions"])
PY
```

Expect: `status=ok`, `queue_depth=0`, `active_job=null`,
`manifest_sha256` equal to §1 step 5, pinned `runtime_versions`.
`journalctl -u moss-worker -n 80` must show the child startup handshake with
passing self-tests (the on-board Gate A equivalent: RKNN feature tensor +
RKLLM fixed prompt through the rebuilt bundle).

App readiness with MOSS enabled (`MOSS_ENABLED=1` in
`/etc/suspect-interrogation/runtime.env`, then
`sudo systemctl restart interrogation-api.service`):

```bash
curl --cacert /etc/suspect-interrogation/tls/ca.crt \
  https://192.168.0.9:18080/health/live
curl --cacert /etc/suspect-interrogation/tls/ca.crt \
  https://192.168.0.9:18080/health/ready | \
  jq '.status, .capabilities.moss'
```

`capabilities.moss` now reports `queueDepth`/`activeJob` verbatim from the
worker (`null` while idle) and `required=false` — MOSS never changes
readiness, realtime ASR stays independent.

## 5. Crash recovery verification (production gates 1/6)

```bash
MAINPID=$(systemctl show -p MainPID --value moss-worker)
kill -9 "$MAINPID"
sleep 8
systemctl is-active moss-worker.service        # active (Restart=on-failure, RestartSec=5s)
journalctl -u moss-worker -n 40                # fresh start, child self-test passed again
```

After the restart the worker rebinds the socket (stale socket replaced only
when provably dead), the health op answers again, and every durable spool
job still resolves:

```bash
# job_id of a job submitted before the kill:
... MossWorkerClient("/run/suspect-interrogation/moss.sock").get_job("<job_id>").state
```

Recovery boundary (by design, a2d1b28 supervisor semantics): COMPLETED /
FAILED / CANCELLED jobs and all window checkpoints are durable in the spool
and answer after the crash; a job that was QUEUED or mid-RUNNING at the kill
survives on disk but is not rescheduled automatically — the worker's
in-memory queue starts empty and `resume()` is worker-internal (not a socket
op). Re-submit the audio as a new job; completed windows are never
recomputed.

## 6. Rollback

```bash
sudo systemctl stop moss-worker.service
sudo systemctl disable moss-worker.service
# neutralize the app capability without touching realtime ASR:
#   set MOSS_ENABLED=0 in /etc/suspect-interrogation/runtime.env and
#   sudo systemctl restart interrogation-api.service
sudo /opt/suspect-interrogation/current/deploy/control.sh rollback   # atomic release switch
# restore the previous bundle directory if needed (bundle-v3 was never
# deleted; the old directory is replaced only by the §3 atomic mv)
```

`MOSS_ENABLED=0` reports the capability as DISABLED and leaves readiness and
FunASR untouched.

## 7. Definition of Done reminder

Per `AGENTS.md`, this deployment is only "complete" after: the exact final
commit SHA is deployed, `/health/live` + `/health/ready` pass with
certificate verification (no `-k`), the release SHA matches the pushed
commit, TCP/8000 is proven preserved, and the socket/health/recovery checks
above are recorded (evidence goes to `docs/release/RK3588-EVIDENCE.md`).
