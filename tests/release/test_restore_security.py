import io
import hashlib
import json
import os
import sqlite3
import subprocess
import tarfile
from pathlib import Path

from shell_scripts import script_command, script_environment


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
        script_command(ROOT / 'scripts' / 'restore.sh', str(archive), '--yes'),
        cwd=ROOT,
        env=script_environment({
            **os.environ,
            'SUSPECT_DATA_DIR': str(data_dir),
            'SUSPECT_DB_PATH': str(db_path),
        }),
        text=True,
        capture_output=True,
    )

    assert result.returncode != 0
    assert 'unsafe archive path' in (result.stdout + result.stderr)
    assert not escaped.exists()


def test_restore_rejects_audio_manifest_path_traversal_before_mutating_data(tmp_path):
    source_db = tmp_path / 'snapshot.db'
    connection = sqlite3.connect(source_db)
    connection.execute('CREATE TABLE cases(id INTEGER PRIMARY KEY)')
    connection.commit()
    connection.close()
    db_bytes = source_db.read_bytes()
    archive = tmp_path / 'malicious-audio-manifest.tar.gz'
    manifest = {
        'segments': [{
            'relativePath': 'audio/../outside.wav',
            'caseId': 'CASE-001',
            'captureId': 'CAPTURE-001',
            'captureCommittedSamples': 1,
            'segmentCommittedSamples': 1,
            'sha256': '0' * 64,
        }],
    }
    with tarfile.open(archive, 'w:gz') as tf:
        database = tarfile.TarInfo('data/interrogation.db')
        database.size = len(db_bytes)
        tf.addfile(database, io.BytesIO(db_bytes))
        checksum = tarfile.TarInfo('manifest.sha256')
        checksum_payload = f"{hashlib.sha256(db_bytes).hexdigest()}  ./interrogation.db\n".encode()
        checksum.size = len(checksum_payload)
        tf.addfile(checksum, io.BytesIO(checksum_payload))
        metadata = tarfile.TarInfo('metadata.env')
        metadata_payload = b'created_utc=20260924T000000Z\ndb=interrogation.db\n'
        metadata.size = len(metadata_payload)
        tf.addfile(metadata, io.BytesIO(metadata_payload))
        audio_manifest = tarfile.TarInfo('audio_manifest.json')
        audio_manifest_payload = json.dumps(manifest).encode()
        audio_manifest.size = len(audio_manifest_payload)
        tf.addfile(audio_manifest, io.BytesIO(audio_manifest_payload))

    data_dir = tmp_path / 'data'
    data_dir.mkdir()
    current_db = data_dir / 'interrogation.db'
    connection = sqlite3.connect(current_db)
    connection.execute('CREATE TABLE cases(value TEXT NOT NULL)')
    connection.execute("INSERT INTO cases VALUES ('current')")
    connection.commit()
    connection.close()
    before = current_db.read_bytes()

    result = subprocess.run(
        script_command(ROOT / 'scripts' / 'restore.sh', str(archive), '--yes'),
        cwd=ROOT,
        env=script_environment({
            **os.environ,
            'SUSPECT_DATA_DIR': str(data_dir),
            'SUSPECT_DB_PATH': str(current_db),
        }),
        text=True,
        capture_output=True,
    )

    assert result.returncode == 3
    assert 'audio evidence incomplete' in (result.stdout + result.stderr)
    assert current_db.read_bytes() == before
