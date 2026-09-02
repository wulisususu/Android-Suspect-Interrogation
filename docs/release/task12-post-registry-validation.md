# Task 12 post-registry hosted validation trigger

This documentation-only commit exists to run the standard Linux hosted gate after locking the ERes2Net-large registry entry from real RK3588 package evidence.

Validated Task 12 facts before this trigger:

- `speaker.default` remains XVector; no production speaker-backend selection changed.
- The actual ModelScope ERes2Net-large package was downloaded only into `RUNNER_TEMP` on the RK3588 and removed after the probe.
- The real package loaded successfully on RK3588 and produced a 512-dimensional embedding through the production adapter.
- Registry required files are limited to the two runtime assets observed in that real package: `configuration.json` and `pretrained_eres2net.pt`.
- No raw WAV/PCM or embedding vector is stored in repository evidence.
- Production board installation and real three-identity calibration remain separate prerequisites; this trigger does not claim Task 12 completion.
