# Task 10 post-apply validation

This commit intentionally changes documentation only. It exists to trigger the standard hosted PR validation after the Task 10 production UI commit `bb9772c15d6fb1ba7e13d36d8502a945a38ae1b0`, whose bot-authored PR checks were marked `action_required` by GitHub rather than executed.

Task 10 production behavior under validation:

- runtime selection exposes XVector, ERes2Net-large, and Compare;
- Compare requires an explicit authoritative backend;
- a not-ready backend cannot become authoritative;
- an unavailable secondary backend is diagnostic-only and may degrade Compare without changing the authoritative business decision;
- backend switching is rejected while formal or preparation capture is active and otherwise applies only to future sessions;
- calibration status/history/recompute are backend-scoped;
- case readiness in Compare is gated by the authoritative reference while both backend reference states are visible;
- the system settings UI exposes backend health, independent calibration state, and controlled-ground-truth placeholders without auto-selecting a winner;
- one-recording dual-backend readiness is visible in case preparation;
- historical `X_VECTOR` provenance remains readable while the UI type layer also accepts new `SPEAKER_EMBEDDING` provenance.

The standard Linux CI result from this user-authored trigger is the authoritative hosted integration evidence for closing Task 10. RK3588 hardware-specific dual-model evidence remains reserved for Task 12.
