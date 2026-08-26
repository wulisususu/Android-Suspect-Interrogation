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
