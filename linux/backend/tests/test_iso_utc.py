from datetime import datetime, timezone

from app.services.serializers import iso_utc


def test_iso_utc_appends_offset_to_naive_utc_values():
    naive = datetime(2026, 9, 21, 2, 16, 58, 962540)
    # Naive datetimes are UTC by convention (SQLite strips tzinfo on round-trip).
    # Without the explicit offset browsers parse them as local time and every
    # displayed/sorted timestamp shifts by the timezone offset.
    assert iso_utc(naive) == "2026-09-21T02:16:58.962540+00:00"


def test_iso_utc_keeps_aware_values_and_handles_none():
    aware = datetime(2026, 9, 21, 10, 16, 58, tzinfo=timezone.utc)
    assert iso_utc(aware) == "2026-09-21T10:16:58+00:00"
    assert iso_utc(None) is None
