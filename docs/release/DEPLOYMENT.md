# Linux RK3588 Deployment and Recovery

## Standard layout

```text
/opt/suspect-interrogation/
  current -> releases/<timestamp-sha>/
  releases/
  models/                    # external model-management responsibility
/etc/suspect-interrogation/
  runtime.env
  ai-worker.env              # optional
  kiosk.env                  # optional
/var/lib/suspect-interrogation/
  interrogation.db
  reports/signatures/attachments as implemented by backend
  backups/
/var/log/suspect-interrogation/
```

Code, mutable data, configuration, model weights, and logs are intentionally separated.

## First install

From a checked-out release branch/repository:

```bash
sudo ./deploy/control.sh install
sudo ./deploy/control.sh deploy .
```

`install` is idempotent: it creates the dedicated service account, directories, restrictive configuration file, installs systemd units, reloads systemd, and enables the API/kiosk services.

## Deployment / upgrade

```bash
sudo ./deploy/control.sh deploy /path/to/source
sudo ./deploy/control.sh upgrade /path/to/source
```

The source is staged into a new timestamp+commit release directory. Python dependencies are installed into a release-local `.venv`; the Vue app is typechecked/built; preflight validation runs; then the `current` symlink is atomically switched.

If post-switch health fails, the prior symlink is restored and services are restarted on the previous release.

For a fully disconnected production board, set `SUSPECT_WHEELHOUSE` to a pre-populated local Python wheel directory. Model weights are never downloaded by this workflow.

## Health / status

```bash
sudo ./deploy/control.sh health
sudo ./deploy/control.sh status
curl http://127.0.0.1:8000/health/live
curl http://127.0.0.1:8000/health/ready
```

`live` means the API process responds. `ready` evaluates required storage/database checks and reports hardware/AI separately as optional capabilities.

## Rollback

```bash
sudo ./deploy/control.sh rollback
sudo ./deploy/control.sh rollback <release-directory-name>
```

Without an argument, the newest release other than `current` is selected. The symlink switch is atomic and followed by service restart/health verification.

## Backup

```bash
sudo ./deploy/control.sh backup
```

The SQLite database is copied using the SQLite online backup API, not filesystem `cp` of an actively written database. Other mutable files are staged, SHA-256 checksums are written, the snapshot is archived with a UTC timestamp, and retention is applied.

Configure retention with `SUSPECT_BACKUP_RETENTION` (default `7`).

## Restore

```bash
sudo ./deploy/control.sh restore /var/lib/suspect-interrogation/backups/<archive>.tar.gz
```

Restore verifies archive checksums and `PRAGMA integrity_check` before replacing live mutable data, then runs a second integrity check after restoration. A pre-restore filesystem copy is kept alongside the data directory for emergency recovery.

Stop/coordinate active business writes before a production restore. The script validates snapshot consistency but does not attempt distributed transaction coordination with future backend workers.

## Kiosk boot

```text
system boot
  -> interrogation-api.service
  -> readiness checks
  -> kiosk.service
  -> Chromium kiosk
  -> Vue MaintenanceGate / business UI
```

The launcher performs bounded readiness polling. The Vue application independently rechecks readiness and renders a maintenance state rather than a blank page.

## Qwen3-4B formal-record routing

Semantic formal-record routing is an opt-in production mode. The safe default remains:

```text
SUSPECT_FORMAL_ROUTING_MODE=legacy
```

The Qwen path preserves every raw ASR fragment as the evidence/source layer. Qwen only returns a constrained routing decision; deterministic backend policy performs the formal-record mutation. Low-confidence or ambiguous decisions remain `NEEDS_REVIEW` and require operator action. Frozen/signed formal records remain immutable.

### LlamaPi preconditions

The supported local endpoint is loopback-only by default:

```text
LLAMAPI_BASE_URL=http://127.0.0.1:9265/v1
LLAMAPI_MODEL_HINT=qwen3:4b
```

Before enabling Qwen routing, verify the existing LlamaPi service without restarting it:

```bash
systemctl is-active llamapi-server.service
curl -fsS http://127.0.0.1:9265/v1/models
```

The model list must resolve either the exact `qwen3:4b` ID or exactly one platform-specific ID beginning with `qwen3:4b@`. Application code intentionally does not hard-code an RK3588/platform suffix. Zero matches or multiple matches fail closed.

Do not reuse, stop, restart, or reconfigure unrelated services while performing this acceptance. In particular, any existing service on TCP/8000 is outside the LlamaPi routing path and must be left untouched.

### Read-only RK3588 acceptance

Run the dedicated `RK3588 Qwen Formal Routing Acceptance` workflow before a production switch. Its board stage is intentionally non-destructive: it verifies the LlamaPi service/model list, executes the A/B/C/D/E routing probe four times (20 inference requests), records p50/p95/max latency and LlamaPi RSS, observes TCP/8000 without modifying it, and uploads the evidence artifact.

The same probe can be run manually from a checked-out release on the board, provided the output remains under an allowed runtime directory:

```bash
export GITHUB_WORKSPACE="$PWD"
python3 scripts/ci/probe-llamapi-qwen-routing.py \
  --base-url http://127.0.0.1:9265/v1 \
  --model-hint qwen3:4b \
  --repetitions 4 \
  --timeout 120 \
  --output "$PWD/qwen-routing-probe.json"
```

Acceptance is successful only when all 20 samples satisfy the expected semantic classes and safety checks. A service/model-discovery failure, malformed/non-JSON response, wrong route, lost fact anchor, ambiguous model ID, or any individual failed sample blocks the production switch.

### Production switch after acceptance

`interrogation-api.service` already loads both `/etc/suspect-interrogation/runtime.env` and the optional `/etc/suspect-interrogation/ai-worker.env`; no systemd unit edit is required for this feature.

Place LlamaPi connection settings in `/etc/suspect-interrogation/ai-worker.env`:

```text
LLAMAPI_BASE_URL=http://127.0.0.1:9265/v1
LLAMAPI_MODEL_HINT=qwen3:4b
```

After a recorded RK3588 acceptance passes, set the routing mode in `/etc/suspect-interrogation/runtime.env`:

```text
SUSPECT_FORMAL_ROUTING_MODE=qwen
```

Then restart/redeploy only the project API through the normal deployment procedure and verify `/health/ready` plus a controlled formal-record session. Do not restart `llamapi-server.service` merely to switch the application's routing mode.

### Qwen routing rollback

If semantic routing is unavailable or acceptance/regression checks fail, return only the project routing mode to the deterministic compatibility path:

```text
SUSPECT_FORMAL_ROUTING_MODE=legacy
```

Restart/redeploy the project API normally. Raw ASR evidence is retained independently of formal projection, so this rollback does not require rewriting or deleting source fragments. The manual compatibility endpoint for individual speech-fragment processing remains available for controlled recovery.