# LAN HTTPS/TLS Design

## Goal

Switch the RK3588 suspect-interrogation service from LAN HTTP to trusted LAN HTTPS at `https://192.168.0.9:18080`, so browser microphone capture uses a normal secure context without Chromium's `--unsafely-treat-insecure-origin-as-secure` override.

## Scope

This design covers TLS termination, certificate generation and rotation, RK3588 trust installation, Windows trust bootstrap, Uvicorn/systemd startup, health checks, kiosk URLs, browser WebSocket protocol selection, deployment verification, rollback, and repository execution rules.

It does not change the existing FunASR service on TCP/8000, ASR models, voiceprint models, database schema, or business workflow.

## Fixed network contract

- Suspect-interrogation keeps TCP/18080.
- Production LAN URL becomes `https://192.168.0.9:18080`.
- RK3588 loopback URL becomes `https://127.0.0.1:18080`.
- Uvicorn continues listening on `0.0.0.0:18080`.
- TCP/8000 remains owned by the existing FunASR service and must not be stopped, restarted, rebound, or modified.
- No second reverse-proxy process or second public service port is introduced.

## TLS architecture

Use Uvicorn's native TLS support. Do not add Nginx or Caddy for this temporary LAN deployment.

The RK3588 maintains a private project CA under `/etc/suspect-interrogation/tls/` and a server certificate signed by that CA.

Files:

- `/etc/suspect-interrogation/tls/ca.key` — CA private key, root-only, mode `0600`.
- `/etc/suspect-interrogation/tls/ca.crt` — CA certificate, mode `0644`.
- `/etc/suspect-interrogation/tls/server.key` — server private key, `root:suspect-interrogation`, mode `0640`.
- `/etc/suspect-interrogation/tls/server.crt` — server certificate, mode `0644`.
- `/etc/suspect-interrogation/tls/server.csr` and transient OpenSSL config may be deleted after issuance.

No private key or generated certificate is committed to GitHub.

## Certificate identity and lifetime

The CA certificate is valid for 365 days.

The server leaf certificate is valid for 90 days and contains these SAN values:

- `IP:192.168.0.9`
- `IP:127.0.0.1`
- `DNS:localhost`

The LAN IP is configurable through `SUSPECT_TLS_LAN_IP`, defaulting to `192.168.0.9` in the production workflow.

The deployment helper reuses an existing valid CA. It renews the server certificate when any of these conditions is true:

1. no server certificate exists;
2. no server private key exists;
3. the server certificate expires within 30 days;
4. the configured LAN IP is not present in the certificate SAN;
5. the existing server certificate is not signed by the current project CA.

CA rotation is not automatic during ordinary deploys. If the CA expires or is deliberately rotated, Windows clients must import the new CA certificate again.

## RK3588 trust

The project CA certificate is installed into the RK3588 system trust store so curl and the local Chromium kiosk trust `https://127.0.0.1:18080` without insecure flags.

On Debian/Ubuntu this means installing a copy as:

`/usr/local/share/ca-certificates/suspect-interrogation-ca.crt`

and running `update-ca-certificates` when the CA is created or changed.

The kiosk must not use `--ignore-certificate-errors`.

## Windows trust bootstrap

The backend exposes the public CA certificate at:

`GET /api/v1/tls/ca.crt`

This endpoint returns only the public CA certificate. It never exposes private keys.

A repository script `scripts/windows/install-lan-ca.ps1` bootstraps trust from Windows:

1. download `https://192.168.0.9:18080/api/v1/tls/ca.crt` using `curl.exe -k` only for this one public-certificate bootstrap request;
2. display the SHA-256 fingerprint of the downloaded CA certificate;
3. import it into the Windows Local Machine Trusted Root store with `certutil -addstore -f Root`;
4. verify the certificate exists in the Root store;
5. verify `https://192.168.0.9:18080/health/live` without `-k`.

Administrator privileges are required for the Local Machine trust store.

After trust is installed, normal Edge/Chrome sessions use the LAN URL without `--unsafely-treat-insecure-origin-as-secure`.

## Uvicorn/systemd

`interrogation-api.service` starts Uvicorn with:

- `--host "$SUSPECT_API_HOST"`
- `--port "$SUSPECT_API_PORT"`
- `--ssl-certfile "$SUSPECT_TLS_CERT_FILE"`
- `--ssl-keyfile "$SUSPECT_TLS_KEY_FILE"`

Production runtime values:

- `SUSPECT_API_HOST=0.0.0.0`
- `SUSPECT_API_PORT=18080`
- `SUSPECT_TLS_ENABLED=true`
- `SUSPECT_TLS_CERT_FILE=/etc/suspect-interrogation/tls/server.crt`
- `SUSPECT_TLS_KEY_FILE=/etc/suspect-interrogation/tls/server.key`
- `SUSPECT_TLS_CA_FILE=/etc/suspect-interrogation/tls/ca.crt`
- `SUSPECT_TLS_LAN_IP=192.168.0.9`

The service user must be able to read the server key through group permissions, but not the CA private key.

## Health checks and release deployment

All production health checks use HTTPS.

The release control path must use:

`SUSPECT_HEALTH_BASE_URL=https://127.0.0.1:18080`

with curl configured to trust `/etc/suspect-interrogation/tls/ca.crt`.

Do not use `curl -k` for ordinary production health checks.

TLS material must be prepared before the new service is restarted. The deployment sequence is:

1. preflight OpenSSL and port safety;
2. ensure/reuse CA;
3. ensure/renew server certificate;
4. install/update RK3588 system trust;
5. stage and build the new release;
6. apply database migrations;
7. atomically switch the release;
8. restart `interrogation-api.service` and relevant existing units;
9. verify HTTPS health and frontend;
10. verify WSS-capable frontend source contract;
11. verify deployed SHA;
12. verify TCP/8000 is still owned by the pre-existing FunASR process.

If HTTPS health fails after the switch, the existing release rollback path is used. TLS material itself remains stable across rollback so both the new and previous application releases can use the same HTTPS endpoint.

## Kiosk

Kiosk environment becomes:

- `SUSPECT_KIOSK_READY_URL=https://127.0.0.1:18080/health/ready`
- `SUSPECT_KIOSK_URL=https://127.0.0.1:18080/`

`scripts/kiosk-launch.sh` must use the trusted system CA path and must not disable TLS verification.

## Browser microphone and WebSockets

The application already converts an HTTPS origin to WSS for browser ASR and voiceprint sockets. That behavior becomes mandatory and receives explicit regression coverage.

Examples:

- `https://192.168.0.9:18080` + formal ASR → `wss://192.168.0.9:18080/ws/asr/...`
- `https://192.168.0.9:18080` + question preparation → `wss://192.168.0.9:18080/ws/asr/.../question-preparation/...`
- `https://192.168.0.9:18080` + voiceprint enrollment → `wss://192.168.0.9:18080/ws/voiceprints/enrollment/...`

Browser microphone capability continues to use `window.isSecureContext` and `navigator.mediaDevices.getUserMedia`. With a trusted certificate, `window.isSecureContext` must be true for the LAN URL.

No application code should require the old Chromium unsafe-origin flag after this change.

## CA certificate endpoint

The CA endpoint is intentionally public because CA certificates are public trust material.

Requirements:

- response content type: `application/x-x509-ca-cert` or `application/pkix-cert`;
- only `/etc/suspect-interrogation/tls/ca.crt` may be served;
- missing file returns a controlled 503/404-style API error rather than exposing arbitrary filesystem paths;
- no directory listing;
- no private-key endpoint.

## Repository rule updates

`AGENTS.md` must be updated so the canonical production URL is `https://192.168.0.9:18080` and deployment verification explicitly includes trusted TLS and WSS behavior.

The existing rule that every `linux-adaptation` push triggers `RK3588 Production Redeploy` remains unchanged.

## Testing

TDD coverage must include:

1. TLS helper creates CA and server certificate with the required SAN values.
2. Re-running the helper reuses the same valid CA instead of rotating trust.
3. A leaf certificate within the renewal window is renewed under the same CA.
4. A changed `SUSPECT_TLS_LAN_IP` causes leaf renewal.
5. Uvicorn systemd command includes the TLS certificate and key arguments.
6. Health-check code uses HTTPS and CA verification, not `-k`.
7. Kiosk URLs use HTTPS.
8. HTTPS frontend origins produce WSS ASR and voiceprint URLs.
9. CA endpoint returns only the public CA certificate.
10. Windows installation script contains a bootstrap-only insecure download and a subsequent strict HTTPS verification.
11. Production workflow verifies exact deployed SHA, HTTPS health, database head, speech worker, TLS certificate SAN/fingerprint, WSS source contract, TCP/18080, and preserved TCP/8000.

## Production acceptance criteria

The task is complete only when the exact final GitHub SHA has been deployed and all of the following are true on the RK3588:

- `https://127.0.0.1:18080/health/live` succeeds with the project CA and without `-k`.
- `https://127.0.0.1:18080/health/ready` succeeds with the project CA and without `-k`.
- the certificate SAN contains `192.168.0.9`, `127.0.0.1`, and `localhost`.
- `/api/v1/tls/ca.crt` returns the current public CA certificate.
- `interrogation-api.service` is active on TCP/18080.
- the deployed release SHA equals the final GitHub SHA.
- database migration is at head.
- speech worker health reports ASR/VAD/speaker available according to the existing production runtime.
- TCP/8000 remains preserved and is not owned by the interrogation API.

Windows acceptance is complete after the CA is imported and Edge/Chrome can open `https://192.168.0.9:18080` without a certificate warning, `window.isSecureContext === true`, and browser microphone permission can be requested normally.

## Explicit non-goals

- No public Internet certificate or ACME automation.
- No domain name requirement.
- No Nginx/Caddy reverse proxy.
- No HSTS for this temporary LAN certificate design.
- No automatic CA rotation during normal deploys.
- No change to TCP/8000 or the existing FunASR process.
