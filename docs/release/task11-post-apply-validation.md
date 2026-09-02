# Task 11 post-apply validation

This documentation-only commit triggers the standard hosted PR validation for Task 11 after production commit `bce75fa2b73bee312c364a4ecdede484e47c5b7e`. The bot-authored production commit itself was marked `action_required` by GitHub, so that status is not treated as a test result.

Task 11 production behavior under validation:

- rebuild accepts an explicit retained WAV or PCM16 source and currently targets `eres2net_large` only;
- reference generation reuses the same PCM validation, VAD/chunking, model-specific embedding extraction and aggregation path used by enrollment;
- no XVector embedding is consumed, copied, relabeled or converted into the ERes2Net-large model space;
- an existing target reference fails closed unless the operator explicitly supplies `--replace`;
- a missing source audio file returns `NEEDS_REENROLL` and creates no target reference;
- source audio is not copied into persistent application storage;
- `SPEAKER_REFERENCE_REBUILD` audit metadata records only identity/result metadata, normalized source PCM SHA-256 and a coarse source class; it does not record source file paths, raw audio/PCM or embeddings;
- suspect and officer model-specific references remain independently persisted;
- the maintenance command does not switch the runtime speaker backend or authoritative backend and does not restart unrelated services.

Task 11's deterministic gate already passed 7 rebuild contracts, 11 existing voiceprint service/repository tests, and 388 full backend tests. The standard Linux CI result from this user-authored trigger is the authoritative hosted integration evidence for closing Task 11. True RK3588 model/runtime/calibration validation remains Task 12.
