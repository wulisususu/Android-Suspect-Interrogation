# Task 6 post-apply regression marker

This no-code release note exists to trigger the normal Linux CI path filters after bot-authored production fixes.

Task 6 production commit under validation: `a00f7197` (`fix: preserve xvector session compatibility`).

Evidence before that production commit was created:

- Task 4–6 specialist gate: **62 passed**.
- Previously failing regression files: **22 passed**.
- Full backend Python regression: **360 passed**.
- Gate run: `33580140858`.

The Task 6 production fix preserves the historical default-XVector public contract while continuing to bind non-default ERes2Net sessions explicitly.

A separate pre-existing Browser screenshot QA blocker was subsequently root-caused to malformed SFC boundaries in `FormalTemplatePanel.vue`: its scoped style block was nested inside the template, so the Vite dev server returned HTTP 500 for that module and `App.vue` failed to import. The deterministic SFC gate `33580974435` passed the structural regression test, full Vue tests, typecheck/build, and direct Vite dev-server module smoke before committing fix `7ac1da70` (`fix: close formal template before scoped styles`).

This user-authored documentation-only update triggers the standard pull-request Linux CI against the actual post-fix tree. This document is not completion evidence: Task 6 remains incomplete until the standard Linux hosted gate reaches the required result, including Browser screenshot QA and release integration/E2E.
