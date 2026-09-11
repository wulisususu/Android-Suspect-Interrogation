import sqlite3
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
DB = "/tmp/interrogation.db"

con = sqlite3.connect(f"file:{DB}?mode=ro", uri=True)
tables = [r[0] for r in con.execute("select name from sqlite_master where type='table'")]
targets = [t for t in tables if "calibration" in t.lower()]
print("calibration tables:", targets)

for t in targets:
    cols = [r[1] for r in con.execute(f"pragma table_info({t})")]
    print(f"\n== {t} ==")
    print("cols:", ", ".join(cols))
    rows = list(con.execute(f"select * from {t}"))
    print("rows:", len(rows))
    for row in rows:
        d = dict(zip(cols, row))
        keep = {k: v for k, v in d.items()
                if any(s in k.lower() for s in ("status", "state", "margin", "threshold", "backend", "fingerprint",
                                                "active", "created", "updated", "device", "mic"))
                and not isinstance(v, bytes)}
        print("  ", keep)

# what the runtime would resolve for a case: any active assignment / snapshot
for t in [x for x in tables if "session" in x.lower() and "voice" in x.lower()]:
    cols = [r[1] for r in con.execute(f"pragma table_info({t})")]
    print(f"\n== {t} ==")
    print("cols:", ", ".join(cols))
    for row in list(con.execute(f"select * from {t}"))[-3:]:
        d = dict(zip(cols, row))
        print("  ", {k: v for k, v in d.items() if not isinstance(v, bytes)})
