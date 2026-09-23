const LEASE_CONFLICT_RETRY_DELAY_MS = 1_500

export class BrowserCaptureResumeGate {
  private attemptedKey: string | null = null
  private retry: { key: string; after: number } | null = null
  private notifiedConflictKey: string | null = null

  shouldAttempt(key: string, now = Date.now()) {
    if (this.attemptedKey === key) return false
    return this.retry?.key !== key || now >= this.retry.after
  }

  markAttempted(key: string) {
    this.attemptedKey = key
  }

  leaseConflict(key: string, now = Date.now()) {
    if (this.attemptedKey === key) this.attemptedKey = null
    this.retry = { key, after: now + LEASE_CONFLICT_RETRY_DELAY_MS }
    if (this.notifiedConflictKey === key) return false
    this.notifiedConflictKey = key
    return true
  }

  reset() {
    this.attemptedKey = null
    this.retry = null
    this.notifiedConflictKey = null
  }
}
