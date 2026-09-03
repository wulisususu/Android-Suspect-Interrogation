# Inline voiceprint gate design

## Goal

Make suspect voiceprint enrollment a temporary prerequisite of the right-hand
live-dialogue panel.  The formal record remains visible and usable in the main
area without a voiceprint-preparation section consuming its height.

## Layout and state

Before a real suspect voiceprint is registered, the right panel shows:

- the browser microphone source and secure-context status;
- a compact suspect-only enrollment card with recording progress and controls;
- a clear statement that enrollment unlocks interrogation and live capture.

The middle column does not render microphone status, the voiceprint
preparation panel, police-role selectors, or calibration guidance.

After enrollment succeeds, the prerequisite card is removed.  The existing
live-dialogue panel occupies the full right panel and provides the normal
recording controls.  The top-level start-interrogation action remains disabled
until this transition.  A registered suspect continues to be the sole
requirement; police voiceprints remain optional administration in system
settings.

## Behavior and safety

The change is presentation and UI gating only.  Existing backend enforcement
of a real suspect voiceprint remains authoritative.  Browser microphone audio
continues to use the existing 16 kHz PCM/WSS path.  Voiceprint enrollment does
not create formal-record content, and unmatched speech remains a pending,
operator-confirmed fragment.

## Verification

Frontend tests will assert that the page places the enrollment gate in the
live-dialogue panel, removes the former middle-column panel, and disables the
start action before a suspect is ready.  Type checking, Vue tests, production
build, hosted CI, and RK3588 deployment checks will run before release.
