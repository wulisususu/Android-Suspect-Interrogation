# Validation Notes

This file distinguishes implementation evidence from runtime evidence.

## Current branch

- Branch: `linux-release-hardening`
- Base: `linux-adaptation`
- Base SHA at branch creation: `02a846fa89185f545de31c9093c361762c37ea91`

## Verification policy

A file being committed is **not** treated as proof that it works. Runtime evidence must come from GitHub Actions job status/logs or from the RK3588 self-hosted runner.

The assistant-side isolated container could not resolve `github.com`, so a full local clone/test run was not possible. That external environment limitation is intentionally recorded rather than reported as a pass.

## Expected CI evidence

The `Linux CI` workflow must provide:

1. `Linux hosted gate` success, covering backend import, Python tests, DB gate, API contracts, hardware/AI mocks, Vue tests/typecheck/build, release script syntax/contracts, backup/restore, E2E and reliability tests.
2. `RK3588 smoke` success on `[self-hosted, rk3588]`, including exact-SHA sparse/partial checkout, runner identity, backend import/health and release smoke checks.

If either job fails, its job log is the authoritative defect source and the branch must be fixed before release sign-off.
