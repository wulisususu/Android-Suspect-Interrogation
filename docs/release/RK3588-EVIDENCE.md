# RK3588 CI Evidence

This file is updated only from actual GitHub Actions evidence; it must not claim a successful hardware run from static review alone.

## Expected runner

- labels: `self-hosted`, `rk3588`
- expected runner name: `rk3588-android-suspect`
- expected architecture: ARM64 / `aarch64`

## Checkout acceptance

The RK3588 job uses:

- partial clone: `--filter=blob:none`;
- sparse checkout: `.github linux webapp deploy scripts systemd tests docs`;
- maximum five fetch attempts;
- 120 second timeout per fetch attempt;
- `http.version HTTP/1.1`;
- `http.lowSpeedLimit 1024`;
- `http.lowSpeedTime 15`;
- exact `GITHUB_SHA` verification after checkout.

## Evidence status

Pending PR-triggered workflow execution. Populate this section from the real Actions run/job logs with:

- workflow run ID;
- RK3588 job ID;
- runner name;
- `uname -a` / architecture;
- checkout attempt count/result;
- Python smoke result;
- mock E2E result;
- Vue build result when Node is available;
- final job conclusion.
