# commit: fix: preserve legacy formal workspace refresh
from pathlib import Path

path = Path("webapp/src/stores/templateInterrogation.ts")
text = path.read_text(encoding="utf-8")
old = '''  function handleAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {
    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return
    upsertDialogue(fragment, scope)
  }
'''
new = '''  function handleAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {
    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return
    upsertDialogue(fragment, scope)
    // Legacy projection mode has no committed QA routing revision event.
    // Keep this short refresh only as a compatibility fallback; qwen mode
    // still receives a second authoritative refresh after transaction commit.
    scheduleWorkspaceRefresh(scope)
  }
'''
if old not in text:
    raise SystemExit("expected handleAsrFragment block missing")
path.write_text(text.replace(old, new, 1), encoding="utf-8")
