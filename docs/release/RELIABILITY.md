# Linux Reliability Test Matrix

| Failure / condition | Release-side protection | Automated evidence |
| --- | --- | --- |
| backend crash | `Restart=on-failure`, 2s restart delay | `tests/reliability/test_release_faults.py` + systemd contract |
| AI worker crash / absent model | AI is optional and not required by API unit | capability tests + systemd isolation test |
| WebSocket disconnect | frontend/backend remain independently restartable; full reconnect behavior remains core-workstream contract | release docs require HTTP-level E2E once core WebSocket implementation stabilizes |
| database unavailable/corrupt | readiness required DB check and SQLite quick/integrity checks | health tests + backup/restore tests |
| device unavailable | hardware capability reports `UNAVAILABLE` rather than crashing API | hardware mock test |
| disk low | readiness/check-release enforce configurable minimum free space | release fault static contract; RK/hosted preflight uses real `df` |
| GitHub fetch flaky | bounded partial+sparse checkout with retry, HTTP/1.1, low-speed abort | checkout static contract + RK3588 Actions job |
| frontend before backend ready | MaintenanceGate and bounded kiosk readiness polling | Vue health tests/source contract |
| bad release | atomic current symlink and automatic post-health rollback | deploy control contract + deployment script |
| live SQLite write during backup | SQLite online backup API | WAL-mode backup/restore test |

The two items that require the physical board or mature core runtime—real WebSocket reconnect under a process crash and real device hot-unplug—must be retained as RK3588 acceptance cases even when mock CI is green.
