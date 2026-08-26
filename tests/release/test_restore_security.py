import io
import os
import subprocess
import tarfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def test_restore_rejects_path_traversal_archive(tmp_path):
    archive = tmp_path / 'malicious.tar.gz'
    payload = b'escape-attempt'
    with tarfile.open(archive, 'w:gz') as tf:
        member = tarfile.TarInfo('../escaped.txt')
        member.size = len(payload)
        tf.addfile(member, io.BytesIO(payload))

    data_dir = tmp_path / 'data'
    data_dir.mkdir()
    db_path = data_dir / 'interrogation.db'
    db_path.write_bytes(b'not-used')
    escaped = tmp_path / 'escaped.txt'

    result = subprocess.run(
        [str(ROOT / 'scripts' / 'restore.sh'), str(archive), '--yes'],
        cwd=ROOT,
        env={
            **os.environ,
            'SUSPECT_DATA_DIR': str(data_dir),
            'SUSPECT_DB_PATH': str(db_path),
        },
        text=True,
        capture_output=True,
    )

    assert result.returncode != 0
    assert 'unsafe archive path' in (result.stdout + result.stderr)
    assert not escaped.exists()
