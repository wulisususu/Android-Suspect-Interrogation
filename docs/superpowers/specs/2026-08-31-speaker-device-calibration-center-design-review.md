# Calibration Spec Self-Review

- Placeholder scan: no TBD/TODO placeholders.
- Consistency: runtime fallback, stale-model/stale-mic semantics, session immutability, and system-settings ownership are mutually consistent.
- Scope: one cohesive subsystem; no unrelated refactors included.
- Ambiguity resolved: minimum corpus is 3 officers x 3 compatible samples; DB calibration lifecycle becomes authoritative after first DB calibration; stale DB calibration cannot be bypassed by legacy env values; active sessions freeze calibration values at start.
