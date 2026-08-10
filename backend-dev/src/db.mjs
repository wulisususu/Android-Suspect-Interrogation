import fs from 'node:fs'
import path from 'node:path'
import { DatabaseSync } from 'node:sqlite'

function resolveDbPath() {
  const configured = process.env.DB_PATH || './data/suspect-interrogation.db'
  return path.resolve(process.cwd(), configured)
}

const dbPath = resolveDbPath()
fs.mkdirSync(path.dirname(dbPath), { recursive: true })

export const db = new DatabaseSync(dbPath)
db.exec(`
  PRAGMA foreign_keys = ON;
  PRAGMA journal_mode = WAL;
  PRAGMA synchronous = NORMAL;

  CREATE TABLE IF NOT EXISTS cases (
    id TEXT PRIMARY KEY,
    suspect_name TEXT NOT NULL DEFAULT '待录入',
    gender TEXT,
    age TEXT,
    officer_name TEXT NOT NULL DEFAULT '当前警官',
    state TEXT NOT NULL DEFAULT 'DRAFT',
    stage TEXT NOT NULL DEFAULT 'IDENTITY',
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
  );

  CREATE TABLE IF NOT EXISTS interrogation_sessions (
    id TEXT PRIMARY KEY,
    case_id TEXT NOT NULL,
    status TEXT NOT NULL,
    stage TEXT NOT NULL,
    started_at INTEGER,
    paused_at INTEGER,
    ended_at INTEGER,
    updated_at INTEGER NOT NULL,
    FOREIGN KEY(case_id) REFERENCES cases(id)
  );

  CREATE INDEX IF NOT EXISTS idx_sessions_case ON interrogation_sessions(case_id, updated_at DESC);

  CREATE TABLE IF NOT EXISTS qa_records (
    id TEXT PRIMARY KEY,
    case_id TEXT NOT NULL,
    session_id TEXT,
    seq INTEGER NOT NULL,
    speaker TEXT NOT NULL,
    text TEXT NOT NULL,
    mark TEXT NOT NULL DEFAULT '',
    confirmed INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    deleted_at INTEGER,
    FOREIGN KEY(case_id) REFERENCES cases(id),
    FOREIGN KEY(session_id) REFERENCES interrogation_sessions(id)
  );

  CREATE UNIQUE INDEX IF NOT EXISTS idx_qa_case_seq ON qa_records(case_id, seq) WHERE deleted_at IS NULL;
  CREATE INDEX IF NOT EXISTS idx_qa_case_created ON qa_records(case_id, created_at);

  CREATE TABLE IF NOT EXISTS qa_revisions (
    id TEXT PRIMARY KEY,
    qa_id TEXT NOT NULL,
    case_id TEXT NOT NULL,
    version INTEGER NOT NULL,
    old_text TEXT NOT NULL,
    new_text TEXT NOT NULL,
    reason TEXT,
    created_at INTEGER NOT NULL,
    FOREIGN KEY(qa_id) REFERENCES qa_records(id),
    FOREIGN KEY(case_id) REFERENCES cases(id)
  );

  CREATE INDEX IF NOT EXISTS idx_revision_qa ON qa_revisions(qa_id, version DESC);
  CREATE INDEX IF NOT EXISTS idx_revision_case ON qa_revisions(case_id, created_at DESC);

  CREATE TABLE IF NOT EXISTS facts (
    case_id TEXT NOT NULL,
    fact_key TEXT NOT NULL,
    label TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    suggestion TEXT,
    updated_at INTEGER NOT NULL,
    PRIMARY KEY(case_id, fact_key),
    FOREIGN KEY(case_id) REFERENCES cases(id)
  );

  CREATE TABLE IF NOT EXISTS timeline_events (
    id TEXT PRIMARY KEY,
    case_id TEXT NOT NULL,
    time_label TEXT NOT NULL,
    title TEXT NOT NULL,
    detail TEXT NOT NULL,
    evidence_json TEXT NOT NULL DEFAULT '[]',
    created_at INTEGER NOT NULL,
    FOREIGN KEY(case_id) REFERENCES cases(id)
  );

  CREATE INDEX IF NOT EXISTS idx_timeline_case ON timeline_events(case_id, created_at);

  CREATE TABLE IF NOT EXISTS ai_suggestions (
    id TEXT PRIMARY KEY,
    case_id TEXT NOT NULL,
    kind TEXT NOT NULL,
    input_text TEXT,
    output_text TEXT NOT NULL,
    created_at INTEGER NOT NULL,
    FOREIGN KEY(case_id) REFERENCES cases(id)
  );

  CREATE TABLE IF NOT EXISTS audit_logs (
    id TEXT PRIMARY KEY,
    case_id TEXT,
    action TEXT NOT NULL,
    target_type TEXT,
    target_id TEXT,
    detail_json TEXT NOT NULL DEFAULT '{}',
    created_at INTEGER NOT NULL,
    FOREIGN KEY(case_id) REFERENCES cases(id)
  );

  CREATE INDEX IF NOT EXISTS idx_audit_case ON audit_logs(case_id, created_at DESC);
`)

export function transaction(fn) {
  db.exec('BEGIN IMMEDIATE')
  try {
    const result = fn()
    db.exec('COMMIT')
    return result
  } catch (error) {
    db.exec('ROLLBACK')
    throw error
  }
}
