from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def replace_once(path: str, old: str, new: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected exactly one anchor, found {count}: {old[:100]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def append_once(path: str, marker: str, addition: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    if addition.strip() in text:
        return
    if marker not in text:
        raise SystemExit(f"{path}: append marker not found: {marker!r}")
    target.write_text(text + addition, encoding="utf-8")


# ORM: persist explicit backend identity beside model/microphone identity.
replace_once(
    "linux/backend/app/database/voiceprint_models.py",
    "from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Integer, LargeBinary, String, UniqueConstraint",
    "from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Index, Integer, LargeBinary, String, UniqueConstraint",
)
replace_once(
    "linux/backend/app/database/voiceprint_models.py",
    "class SpeakerDeviceCalibration(Base):\n    \"\"\"Immutable device-specific speaker calibration history row.\"\"\"\n\n    __tablename__ = \"speaker_device_calibrations\"\n\n    id: Mapped[str] = mapped_column(String(64), primary_key=True)",
    "class SpeakerDeviceCalibration(Base):\n    \"\"\"Immutable device-specific speaker calibration history row.\"\"\"\n\n    __tablename__ = \"speaker_device_calibrations\"\n    __table_args__ = (\n        Index(\n            \"ix_speaker_device_calibration_scope\",\n            \"speaker_backend_key\",\n            \"speaker_model_fingerprint\",\n            \"microphone_fingerprint\",\n            \"created_at\",\n        ),\n    )\n\n    id: Mapped[str] = mapped_column(String(64), primary_key=True)",
)
replace_once(
    "linux/backend/app/database/voiceprint_models.py",
    "    algorithm_version: Mapped[str] = mapped_column(String(64), nullable=False)\n    speaker_model_id: Mapped[str] = mapped_column(String(128), nullable=False)",
    "    algorithm_version: Mapped[str] = mapped_column(String(64), nullable=False)\n    speaker_backend_key: Mapped[str] = mapped_column(String(64), default=\"xvector\", nullable=False, index=True)\n    speaker_model_id: Mapped[str] = mapped_column(String(128), nullable=False)",
)
replace_once(
    "linux/backend/app/database/voiceprint_models.py",
    "    calibration_status: Mapped[str] = mapped_column(String(32), nullable=False)\n    speaker_model_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True)",
    "    calibration_status: Mapped[str] = mapped_column(String(32), nullable=False)\n    speaker_backend_key: Mapped[str] = mapped_column(String(64), default=\"xvector\", nullable=False, index=True)\n    speaker_model_fingerprint: Mapped[str | None] = mapped_column(String(64), nullable=True)",
)

# Repository: optional scoped lookup remains backward compatible when filters are omitted.
replace_once(
    "linux/backend/app/repositories/speaker_calibrations.py",
    "    algorithm_version: str,\n    speaker_model_id: str,",
    "    algorithm_version: str,\n    speaker_backend_key: str = \"xvector\",\n    speaker_model_id: str,",
)
replace_once(
    "linux/backend/app/repositories/speaker_calibrations.py",
    "        \"algorithm_version\": str(algorithm_version),\n        \"speaker_model_id\": str(speaker_model_id),",
    "        \"algorithm_version\": str(algorithm_version),\n        \"speaker_backend_key\": str(speaker_backend_key or \"xvector\").strip().lower(),\n        \"speaker_model_id\": str(speaker_model_id),",
)
replace_once(
    "linux/backend/app/repositories/speaker_calibrations.py",
    "def latest_calibration(db: Session) -> SpeakerDeviceCalibration | None:\n    return db.scalars(\n        select(SpeakerDeviceCalibration)\n        .order_by(SpeakerDeviceCalibration.created_at.desc(), SpeakerDeviceCalibration.id.desc())\n        .limit(1)\n    ).first()\n\n\ndef list_calibrations(db: Session, *, limit: int = 100) -> list[SpeakerDeviceCalibration]:\n    return list(\n        db.scalars(\n            select(SpeakerDeviceCalibration)\n            .order_by(SpeakerDeviceCalibration.created_at.desc(), SpeakerDeviceCalibration.id.desc())\n            .limit(max(1, int(limit)))\n        )\n    )",
    "def latest_calibration(\n    db: Session,\n    *,\n    speaker_backend_key: str | None = None,\n    speaker_model_fingerprint: str | None = None,\n    microphone_fingerprint: str | None = None,\n) -> SpeakerDeviceCalibration | None:\n    query = select(SpeakerDeviceCalibration)\n    if speaker_backend_key is not None:\n        query = query.where(\n            SpeakerDeviceCalibration.speaker_backend_key == str(speaker_backend_key).strip().lower()\n        )\n    if speaker_model_fingerprint is not None:\n        query = query.where(\n            SpeakerDeviceCalibration.speaker_model_fingerprint == str(speaker_model_fingerprint)\n        )\n    if microphone_fingerprint is not None:\n        query = query.where(\n            SpeakerDeviceCalibration.microphone_fingerprint == str(microphone_fingerprint)\n        )\n    return db.scalars(\n        query.order_by(SpeakerDeviceCalibration.created_at.desc(), SpeakerDeviceCalibration.id.desc()).limit(1)\n    ).first()\n\n\ndef list_calibrations(\n    db: Session,\n    *,\n    limit: int = 100,\n    speaker_backend_key: str | None = None,\n) -> list[SpeakerDeviceCalibration]:\n    query = select(SpeakerDeviceCalibration)\n    if speaker_backend_key is not None:\n        query = query.where(\n            SpeakerDeviceCalibration.speaker_backend_key == str(speaker_backend_key).strip().lower()\n        )\n    return list(\n        db.scalars(\n            query.order_by(SpeakerDeviceCalibration.created_at.desc(), SpeakerDeviceCalibration.id.desc())\n            .limit(max(1, int(limit)))\n        )\n    )",
)
replace_once(
    "linux/backend/app/repositories/speaker_calibrations.py",
    "    calibration_status: str,\n    speaker_model_fingerprint: str | None,",
    "    calibration_status: str,\n    speaker_backend_key: str = \"xvector\",\n    speaker_model_fingerprint: str | None,",
)
replace_once(
    "linux/backend/app/repositories/speaker_calibrations.py",
    "        calibration_status=str(calibration_status),\n        speaker_model_fingerprint=(",
    "        calibration_status=str(calibration_status),\n        speaker_backend_key=str(speaker_backend_key or \"xvector\").strip().lower(),\n        speaker_model_fingerprint=(",
)

# Service: exact scope wins; stale detection never crosses backend spaces.
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "class CurrentSpeakerModelIdentity:\n    model_id: str\n    model_version: str | None\n    fingerprint: str",
    "class CurrentSpeakerModelIdentity:\n    model_id: str\n    model_version: str | None\n    fingerprint: str\n    backend_key: str = \"xvector\"",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "        corpus = self._compatible_corpus(model, microphone)\n        latest = calibration_repo.latest_calibration(self.db)\n\n        if latest is None:\n            status = CalibrationStatus.NOT_CALIBRATED\n            usable = False\n            reason = \"尚未完成设备声纹校准\"\n        elif latest.speaker_model_fingerprint != model.fingerprint:\n            status = CalibrationStatus.STALE_MODEL\n            usable = False\n            reason = \"XVector 模型已更换，需要重新校准\"\n        elif latest.microphone_fingerprint != microphone.fingerprint:\n            status = CalibrationStatus.STALE_MIC\n            usable = False\n            reason = \"检测到麦克风已更换，请重新校准\"\n        elif not corpus.ready:\n            status = CalibrationStatus.INSUFFICIENT_DATA\n            usable = False\n            reason = \"当前兼容民警声纹样本不足，无法形成完整设备校准\"\n        elif self._material_growth(latest, corpus):\n            status = CalibrationStatus.RECOMPUTE_RECOMMENDED\n            usable = True\n            reason = \"民警声纹库有效样本明显增加，建议重新计算校准\"\n        else:\n            status = CalibrationStatus.VALID\n            usable = True\n            reason = \"当前设备校准有效\"",
    "        corpus = self._compatible_corpus(model, microphone)\n        backend_key = str(model.backend_key or \"xvector\").strip().lower()\n        exact = calibration_repo.latest_calibration(\n            self.db,\n            speaker_backend_key=backend_key,\n            speaker_model_fingerprint=model.fingerprint,\n            microphone_fingerprint=microphone.fingerprint,\n        )\n        latest = exact\n\n        if exact is None:\n            same_backend_mic = calibration_repo.latest_calibration(\n                self.db,\n                speaker_backend_key=backend_key,\n                microphone_fingerprint=microphone.fingerprint,\n            )\n            same_backend_model = calibration_repo.latest_calibration(\n                self.db,\n                speaker_backend_key=backend_key,\n                speaker_model_fingerprint=model.fingerprint,\n            )\n            backend_latest = calibration_repo.latest_calibration(\n                self.db,\n                speaker_backend_key=backend_key,\n            )\n            if backend_latest is None:\n                status = CalibrationStatus.NOT_CALIBRATED\n                usable = False\n                reason = \"尚未完成当前声纹后端的设备校准\"\n            elif same_backend_mic is not None:\n                latest = same_backend_mic\n                status = CalibrationStatus.STALE_MODEL\n                usable = False\n                reason = \"当前声纹模型指纹已更换，需要重新校准\"\n            elif same_backend_model is not None:\n                latest = same_backend_model\n                status = CalibrationStatus.STALE_MIC\n                usable = False\n                reason = \"检测到麦克风已更换，请重新校准\"\n            else:\n                latest = backend_latest\n                status = (\n                    CalibrationStatus.STALE_MODEL\n                    if backend_latest.speaker_model_fingerprint != model.fingerprint\n                    else CalibrationStatus.STALE_MIC\n                )\n                usable = False\n                reason = (\n                    \"当前声纹模型指纹已更换，需要重新校准\"\n                    if status is CalibrationStatus.STALE_MODEL\n                    else \"检测到麦克风已更换，请重新校准\"\n                )\n        elif not corpus.ready:\n            status = CalibrationStatus.INSUFFICIENT_DATA\n            usable = False\n            reason = \"当前兼容民警声纹样本不足，无法形成完整设备校准\"\n        elif self._material_growth(exact, corpus):\n            status = CalibrationStatus.RECOMPUTE_RECOMMENDED\n            usable = True\n            reason = \"民警声纹库有效样本明显增加，建议重新计算校准\"\n        else:\n            status = CalibrationStatus.VALID\n            usable = True\n            reason = \"当前设备校准有效\"",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "            \"currentModel\": {\n                \"modelId\": model.model_id,",
    "            \"currentModel\": {\n                \"backendKey\": backend_key,\n                \"modelId\": model.model_id,",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "    def history(self, *, limit: int = 100) -> list[dict]:\n        return [self._calibration_dict(row) for row in calibration_repo.list_calibrations(self.db, limit=limit)]",
    "    def history(self, *, limit: int = 100) -> list[dict]:\n        model = self.model_provider()\n        backend_key = str(model.backend_key or \"xvector\").strip().lower()\n        return [\n            self._calibration_dict(row)\n            for row in calibration_repo.list_calibrations(\n                self.db, limit=limit, speaker_backend_key=backend_key\n            )\n        ]",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "            algorithm_version=ALGORITHM_VERSION,\n            speaker_model_id=model.model_id,",
    "            algorithm_version=ALGORITHM_VERSION,\n            speaker_backend_key=str(model.backend_key or \"xvector\").strip().lower(),\n            speaker_model_id=model.model_id,",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "                \"model_fingerprint\": row.speaker_model_fingerprint,\n                \"microphone_fingerprint\": row.microphone_fingerprint,",
    "                \"speaker_backend_key\": row.speaker_backend_key,\n                \"model_fingerprint\": row.speaker_model_fingerprint,\n                \"microphone_fingerprint\": row.microphone_fingerprint,",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "                OfficerVoiceSample.active.is_(True),\n                OfficerVoiceSample.audio_source == microphone.audio_source,",
    "                OfficerVoiceSample.active.is_(True),\n                OfficerVoiceSample.model_key == str(model.backend_key or \"xvector\").strip().lower(),\n                OfficerVoiceSample.audio_source == microphone.audio_source,",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_service.py",
    "            \"algorithmVersion\": row.algorithm_version,\n            \"speakerModelId\": row.speaker_model_id,",
    "            \"algorithmVersion\": row.algorithm_version,\n            \"speakerBackendKey\": row.speaker_backend_key,\n            \"speakerModelId\": row.speaker_model_id,",
)

# Runtime snapshot carries backend identity independently from provenance/model fingerprint.
replace_once(
    "linux/backend/app/services/speaker_calibration_runtime.py",
    "    speaker_model_fingerprint: str | None\n    microphone_fingerprint: str | None",
    "    speaker_model_fingerprint: str | None\n    microphone_fingerprint: str | None\n    speaker_backend_key: str | None = None",
)
replace_once(
    "linux/backend/app/services/speaker_calibration_runtime.py",
    "    model_fp = model.get(\"fingerprint\") if isinstance(model, dict) else None\n    mic_fp = microphone.get(\"fingerprint\") if isinstance(microphone, dict) else None",
    "    model_fp = model.get(\"fingerprint\") if isinstance(model, dict) else None\n    backend_key = model.get(\"backendKey\") if isinstance(model, dict) else None\n    mic_fp = microphone.get(\"fingerprint\") if isinstance(microphone, dict) else None",
)
# Add backend field to all four return constructors via the common microphone line.
path = ROOT / "linux/backend/app/services/speaker_calibration_runtime.py"
text = path.read_text(encoding="utf-8")
old = "            microphone_fingerprint=None if mic_fp is None else str(mic_fp),\n        )"
new = "            microphone_fingerprint=None if mic_fp is None else str(mic_fp),\n            speaker_backend_key=None if backend_key is None else str(backend_key),\n        )"
count = text.count(old)
if count != 3:
    raise SystemExit(f"speaker_calibration_runtime.py: expected 3 indented return anchors, found {count}")
text = text.replace(old, new)
old_last = "        microphone_fingerprint=None if mic_fp is None else str(mic_fp),\n    )"
new_last = "        microphone_fingerprint=None if mic_fp is None else str(mic_fp),\n        speaker_backend_key=None if backend_key is None else str(backend_key),\n    )"
if text.count(old_last) != 1:
    raise SystemExit("speaker_calibration_runtime.py: final return anchor mismatch")
path.write_text(text.replace(old_last, new_last, 1), encoding="utf-8")

# Formal capture freezes backend key in the immutable session calibration snapshot.
replace_once(
    "linux/backend/app/services/asr_capture_service.py",
    "                calibration_status=resolved.status,\n                speaker_model_fingerprint=resolved.speaker_model_fingerprint,",
    "                calibration_status=resolved.status,\n                speaker_backend_key=resolved.speaker_backend_key or self.speaker_model_key,\n                speaker_model_fingerprint=resolved.speaker_model_fingerprint,",
)

# App model identity now resolves the selected backend from worker backend health.
replace_once(
    "linux/backend/app/main.py",
    "    def current_model_identity() -> CurrentSpeakerModelIdentity:\n        try:\n            health = speech_client.health()\n        except Exception:\n            health = {}\n        fingerprint = str(health.get(\"speaker_model_fingerprint\") or \"UNAVAILABLE\")\n        return CurrentSpeakerModelIdentity(\n            str(health.get(\"speaker_model_id\") or \"xvector\"),\n            None if health.get(\"speaker_model_version\") is None else str(health.get(\"speaker_model_version\")),\n            fingerprint,\n        )",
    "    def current_model_identity() -> CurrentSpeakerModelIdentity:\n        backend_key = str(settings.speaker_backend or \"xvector\").strip().lower()\n        try:\n            health = speech_client.health()\n        except Exception:\n            health = {}\n        backend_health = None\n        all_backends = health.get(\"speaker_backends\") if isinstance(health, dict) else None\n        if isinstance(all_backends, dict):\n            candidate = all_backends.get(backend_key)\n            if isinstance(candidate, dict):\n                backend_health = candidate\n        if backend_health is None and backend_key == \"xvector\":\n            backend_health = health if isinstance(health, dict) else {}\n        backend_health = backend_health or {}\n        fingerprint = str(backend_health.get(\"model_fingerprint\") or backend_health.get(\"speaker_model_fingerprint\") or \"UNAVAILABLE\")\n        model_id = str(backend_health.get(\"model_id\") or backend_health.get(\"speaker_model_id\") or backend_key)\n        model_version_value = backend_health.get(\"model_version\", backend_health.get(\"speaker_model_version\"))\n        return CurrentSpeakerModelIdentity(\n            model_id,\n            None if model_version_value is None else str(model_version_value),\n            fingerprint,\n            backend_key=backend_key,\n        )",
)
replace_once(
    "linux/backend/app/main.py",
    "    app.state.speech_client = speech_client\n    app.state.voiceprint_capture = (",
    "    app.state.speech_client = speech_client\n    app.state.speaker_calibration_model_provider = current_model_identity\n    app.state.voiceprint_capture = (",
)

# Tests: make ERes service identity explicit and make migration head/schema assertions cover 0010.
replace_once(
    "linux/backend/tests/test_speaker_calibration_service.py",
    "    return SpeakerCalibrationService(\n        db,\n        model_provider=lambda: CurrentSpeakerModelIdentity(model_id, \"v1\", model_fp),",
    "    backend_key = \"eres2net_large\" if model_id == \"eres2net-large\" else \"xvector\"\n    return SpeakerCalibrationService(\n        db,\n        model_provider=lambda: CurrentSpeakerModelIdentity(model_id, \"v1\", model_fp, backend_key=backend_key),",
)
replace_once(
    "linux/backend/tests/test_speaker_calibration_service.py",
    "        assert created[\"calibration\"][\"speakerModelFingerprint\"] == MODEL_FP\n        assert created[\"calibration\"][\"microphoneFingerprint\"] == MIC_FP",
    "        assert created[\"calibration\"][\"speakerBackendKey\"] == \"xvector\"\n        assert created[\"calibration\"][\"speakerModelFingerprint\"] == MODEL_FP\n        assert created[\"calibration\"][\"microphoneFingerprint\"] == MIC_FP",
)
replace_once(
    "linux/backend/tests/test_migrations.py",
    "ALEMBIC_HEAD = \"0009_dual_speaker_backends\"",
    "ALEMBIC_HEAD = \"0010_backend_scoped_speaker_calibration\"",
)
replace_once(
    "linux/backend/tests/test_migrations.py",
    "        formal_columns = {item[\"name\"] for item in inspector.get_columns(\"case_questions\")}\n        assert {\"section_type\", \"template_key\", \"template_item_key\", \"locked\", \"formal_answer_text\", \"first_asked_at\"} <= formal_columns",
    "        calibration_columns = {item[\"name\"] for item in inspector.get_columns(\"speaker_device_calibrations\")}\n        snapshot_columns = {item[\"name\"] for item in inspector.get_columns(\"session_speaker_calibration_snapshots\")}\n        assert \"speaker_backend_key\" in calibration_columns\n        assert \"speaker_backend_key\" in snapshot_columns\n        formal_columns = {item[\"name\"] for item in inspector.get_columns(\"case_questions\")}\n        assert {\"section_type\", \"template_key\", \"template_item_key\", \"locked\", \"formal_answer_text\", \"first_asked_at\"} <= formal_columns",
)

# Migration: existing calibration rows are historical XVector and are backfilled explicitly.
migration = ROOT / "linux/backend/alembic/versions/0010_backend_scoped_speaker_calibration.py"
if migration.exists():
    raise SystemExit(f"migration already exists: {migration}")
migration.write_text('''\"\"\"Scope speaker calibration history by backend/model/microphone.\n\nRevision ID: 0010_backend_scoped_speaker_calibration\nRevises: 0009_dual_speaker_backends\n\"\"\"\n\nfrom __future__ import annotations\n\nfrom alembic import op\nimport sqlalchemy as sa\n\n\nrevision = \"0010_backend_scoped_speaker_calibration\"\ndown_revision = \"0009_dual_speaker_backends\"\nbranch_labels = None\ndepends_on = None\n\n\n_XVECTOR = \"xvector\"\n\n\ndef upgrade() -> None:\n    with op.batch_alter_table(\"speaker_device_calibrations\") as batch:\n        batch.add_column(\n            sa.Column(\"speaker_backend_key\", sa.String(length=64), nullable=False, server_default=_XVECTOR)\n        )\n        batch.create_index(\n            \"ix_speaker_device_calibrations_speaker_backend_key\",\n            [\"speaker_backend_key\"],\n            unique=False,\n        )\n        batch.create_index(\n            \"ix_speaker_device_calibration_scope\",\n            [\"speaker_backend_key\", \"speaker_model_fingerprint\", \"microphone_fingerprint\", \"created_at\"],\n            unique=False,\n        )\n\n    with op.batch_alter_table(\"session_speaker_calibration_snapshots\") as batch:\n        batch.add_column(\n            sa.Column(\"speaker_backend_key\", sa.String(length=64), nullable=False, server_default=_XVECTOR)\n        )\n        batch.create_index(\n            \"ix_session_speaker_calibration_snapshots_speaker_backend_key\",\n            [\"speaker_backend_key\"],\n            unique=False,\n        )\n\n\ndef downgrade() -> None:\n    with op.batch_alter_table(\"session_speaker_calibration_snapshots\") as batch:\n        batch.drop_index(\"ix_session_speaker_calibration_snapshots_speaker_backend_key\")\n        batch.drop_column(\"speaker_backend_key\")\n\n    with op.batch_alter_table(\"speaker_device_calibrations\") as batch:\n        batch.drop_index(\"ix_speaker_device_calibration_scope\")\n        batch.drop_index(\"ix_speaker_device_calibrations_speaker_backend_key\")\n        batch.drop_column(\"speaker_backend_key\")\n''', encoding="utf-8")

print("Task 8 calibration isolation production changes applied deterministically")
