# LAN HTTPS/TLS Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Serve the suspect-interrogation application over trusted LAN HTTPS at `https://192.168.0.9:18080` with WSS browser audio, a locally managed project CA, and no change to TCP/8000.

**Architecture:** Uvicorn remains the only process bound to TCP/18080 and gains native TLS arguments. Deployment creates/reuses a private CA and signs a leaf certificate for `192.168.0.9`, `127.0.0.1`, and `localhost`; RK3588 trusts the CA locally, while Windows imports the public CA once. Existing frontend WebSocket builders continue deriving `wss://` from an HTTPS origin.

**Tech Stack:** Bash, OpenSSL, systemd, Uvicorn/FastAPI, Vue/TypeScript, PowerShell, GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-08-31-lan-https-tls-design.md`

## Global Constraints

- Canonical LAN URL: `https://192.168.0.9:18080`.
- Uvicorn continues to bind `0.0.0.0:18080`.
- No Nginx/Caddy and no extra application port.
- TCP/8000 belongs to the existing FunASR service and must not be stopped, restarted, rebound, or modified.
- CA private key and server private key must never be committed to GitHub.
- Ordinary production health checks must verify TLS with the project CA; `-k` is allowed only for the one-time Windows CA bootstrap download.
- Every final `linux-adaptation` push must complete Production Redeploy and exact-SHA verification before the task is reported complete.

---

### Task 1: Lock the TLS deployment contract with failing tests

**Files:**
- Create: `tests/release/test_lan_https_tls.py`
- Modify: `tests/release/test_control_shell.sh`
- Modify: `webapp/src/audio/browserAsrCapture.test.ts`
- Modify: `webapp/src/audio/browserVoiceprintCapture.test.ts`

**Interfaces:**
- Produces the executable contract for later tasks: TLS helper, HTTPS health configuration, Uvicorn TLS flags, WSS URL behavior, and public CA endpoint.

- [ ] **Step 1: Write failing release tests**

Require:

```python
assert Path('deploy/lib/tls.sh').exists()
service = Path('systemd/interrogation-api.service').read_text()
assert '--ssl-certfile "$SUSPECT_TLS_CERT_FILE"' in service
assert '--ssl-keyfile "$SUSPECT_TLS_KEY_FILE"' in service
control = Path('deploy/control.sh').read_text()
assert 'ensure_tls_material' in control
assert 'curl_tls' in control
workflow = Path('.github/workflows/rk3588-production-redeploy.yml').read_text()
assert 'https://127.0.0.1:${SUSPECT_DEPLOY_PORT}' in workflow
assert 'openssl x509' in workflow
```

Also require the Windows bootstrap script and API route source to exist.

- [ ] **Step 2: Add WSS regression tests**

Assert HTTPS origins generate `wss://` URLs for formal ASR, question preparation, and voiceprint enrollment.

- [ ] **Step 3: Run the focused test suite and confirm RED**

Run the existing release test command used by Linux CI plus Vue tests. Expected failures must point only to missing TLS functionality.

- [ ] **Step 4: Commit RED tests on the isolated branch**

Commit message: `test: define trusted LAN HTTPS contract`.

---

### Task 2: Implement deterministic CA and leaf certificate management

**Files:**
- Create: `deploy/lib/tls.sh`
- Modify: `deploy/control.sh`
- Modify: `deploy/suspect-interrogation.env.example`
- Test: `tests/release/test_lan_https_tls.py`

**Interfaces:**
- Produces `ensure_tls_material`, `install_tls_trust`, and `curl_tls` shell functions.
- Uses `SUSPECT_TLS_DIR`, `SUSPECT_TLS_LAN_IP`, `SUSPECT_TLS_CA_FILE`, `SUSPECT_TLS_CERT_FILE`, and `SUSPECT_TLS_KEY_FILE`.

- [ ] **Step 1: Implement `ensure_tls_material`**

Create `/etc/suspect-interrogation/tls` with secure ownership. Generate a 365-day private CA only when absent/invalid. Generate a 90-day leaf certificate with SAN entries:

```text
IP.1 = 192.168.0.9
IP.2 = 127.0.0.1
DNS.1 = localhost
```

Reuse the same valid CA across deploys. Renew only the leaf when missing, expiring within 30 days, signed by another CA, or missing the configured LAN IP SAN.

- [ ] **Step 2: Implement `install_tls_trust`**

Copy the public CA to `/usr/local/share/ca-certificates/suspect-interrogation-ca.crt` and run `update-ca-certificates` only when necessary.

- [ ] **Step 3: Implement `curl_tls`**

Use `curl --cacert "$SUSPECT_TLS_CA_FILE" ...`; never use `-k` in production health logic.

- [ ] **Step 4: Wire installation**

`install_runtime` must call TLS preparation before installing/restarting the API service and must upsert the TLS environment variables.

- [ ] **Step 5: Run focused release tests to GREEN**

Exercise certificate generation in a temporary directory with OpenSSL and inspect SANs/fingerprint/expiry.

- [ ] **Step 6: Commit**

Commit message: `feat: manage trusted LAN TLS certificates`.

---

### Task 3: Serve FastAPI/Uvicorn on HTTPS and expose the public CA

**Files:**
- Modify: `systemd/interrogation-api.service`
- Create: `linux/backend/app/api/tls.py`
- Modify: `linux/backend/app/main.py`
- Create/Modify: `linux/backend/tests/test_tls_api.py`

**Interfaces:**
- Produces `GET /api/v1/tls/ca.crt`.
- Uvicorn consumes `SUSPECT_TLS_CERT_FILE` and `SUSPECT_TLS_KEY_FILE`.

- [ ] **Step 1: Add failing API tests**

Test that the CA endpoint returns only a configured `.crt` file with certificate content and a certificate media type; missing certificate returns a controlled service error.

- [ ] **Step 2: Add TLS arguments to systemd ExecStart**

Append:

```text
--ssl-certfile "$SUSPECT_TLS_CERT_FILE" --ssl-keyfile "$SUSPECT_TLS_KEY_FILE"
```

- [ ] **Step 3: Add CA route**

Route reads only `SUSPECT_TLS_CA_FILE`; do not accept a user-provided path and do not expose any key.

- [ ] **Step 4: Register router in `app.main`**

- [ ] **Step 5: Run backend and release tests to GREEN**

- [ ] **Step 6: Commit**

Commit message: `feat: serve interrogation API over TLS`.

---

### Task 4: Convert release health checks, kiosk, and WebSockets to trusted HTTPS/WSS

**Files:**
- Modify: `deploy/control.sh`
- Modify: `scripts/kiosk-launch.sh`
- Modify: `.github/workflows/rk3588-production-redeploy.yml`
- Modify: `AGENTS.md`
- Test: release tests and Vue audio tests

**Interfaces:**
- All production health URLs become `https://127.0.0.1:18080`.
- Browser HTTPS origin produces WSS URLs through existing URL builders.

- [ ] **Step 1: Replace production HTTP health URLs with HTTPS**

Use `curl_tls`/`--cacert` for `/health/live`, `/health/ready`, root page, and `/api/v1/client-context`.

- [ ] **Step 2: Update kiosk environment**

Set:

```text
SUSPECT_KIOSK_READY_URL=https://127.0.0.1:18080/health/ready
SUSPECT_KIOSK_URL=https://127.0.0.1:18080/
```

Kiosk must rely on the installed system trust and must not use `--ignore-certificate-errors`.

- [ ] **Step 3: Strengthen WSS tests**

Require HTTPS → WSS for all browser audio entry points.

- [ ] **Step 4: Update repository Definition of Done**

Replace the canonical production HTTP URL with HTTPS and add trusted TLS/WSS verification.

- [ ] **Step 5: Run full hosted CI gates**

- [ ] **Step 6: Commit**

Commit message: `feat: switch LAN runtime checks to trusted HTTPS`.

---

### Task 5: Add Windows one-time CA trust bootstrap

**Files:**
- Create: `scripts/windows/install-lan-ca.ps1`
- Modify: `docs/lan-browser-audio-testing.md`
- Test: `tests/release/test_lan_https_tls.py`

**Interfaces:**
- User runs the script elevated on each Windows workstation once.

- [ ] **Step 1: Implement the script**

Default origin is `https://192.168.0.9:18080`. Use `curl.exe -k` only to download `/api/v1/tls/ca.crt`, calculate/display SHA-256, import to LocalMachine Root using `certutil -addstore -f Root`, then verify `/health/live` without `-k`.

- [ ] **Step 2: Remove dependence on unsafe-origin launcher from the normal path**

Keep any old script only as documented legacy fallback; HTTPS is canonical.

- [ ] **Step 3: Test script source contract**

Assert it has exactly one bootstrap insecure call and a strict HTTPS verification afterward.

- [ ] **Step 4: Commit**

Commit message: `feat: add Windows LAN CA trust bootstrap`.

---

### Task 6: Production deployment and acceptance

**Files:**
- Modify as needed: `.github/workflows/rk3588-production-redeploy.yml`

**Interfaces:**
- Final isolated-branch commit is fast-forwarded to `linux-adaptation` only after hosted tests pass.
- Push to `linux-adaptation` triggers Production Redeploy automatically.

- [ ] **Step 1: Run full hosted Linux CI on the final implementation**

Require backend tests, release tests, Vue tests/typecheck/build, browser QA, and E2E all green.

- [ ] **Step 2: Fast-forward `linux-adaptation` to the exact tested commit**

- [ ] **Step 3: Observe Production Redeploy**

It must create/reuse TLS material before restarting Uvicorn.

- [ ] **Step 4: Verify production HTTPS**

Without `-k`, using the project CA on RK3588:

```bash
curl --cacert /etc/suspect-interrogation/tls/ca.crt https://127.0.0.1:18080/health/live
curl --cacert /etc/suspect-interrogation/tls/ca.crt https://127.0.0.1:18080/health/ready
```

- [ ] **Step 5: Verify certificate**

Confirm issuer, expiry, and SANs for `192.168.0.9`, `127.0.0.1`, and `localhost`.

- [ ] **Step 6: Verify application/runtime state**

Confirm exact deployed SHA, database at head, speech worker healthy, WSS frontend contract present, Uvicorn bound to TCP/18080, and TCP/8000 still owned by the pre-existing FunASR processes.

- [ ] **Step 7: Windows acceptance handoff**

Provide the exact elevated PowerShell command for `install-lan-ca.ps1`. After import, Edge/Chrome must open `https://192.168.0.9:18080` without a certificate warning, report `window.isSecureContext === true`, and allow microphone permission normally.
