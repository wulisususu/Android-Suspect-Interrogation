package com.wulisu.suspect.interrogation.data

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.Index

@Entity(tableName = "cases")
data class CaseEntity(
    @androidx.room.PrimaryKey val id: String,
    val suspectName: String,
    val gender: String?,
    val age: String?,
    val idNumber: String?,
    val nation: String?,
    val birthDate: String?,
    val address: String?,
    val identitySource: String?,
    val identityCapturedAt: Long?,
    val officerName: String,
    val state: String,
    val stage: String,
    val createdAt: Long,
    val updatedAt: Long,
)

@Entity(
    tableName = "interrogation_sessions",
    foreignKeys = [ForeignKey(entity = CaseEntity::class, parentColumns = ["id"], childColumns = ["caseId"], onDelete = ForeignKey.CASCADE)],
    indices = [Index("caseId")],
)
data class SessionEntity(
    @androidx.room.PrimaryKey val id: String,
    val caseId: String,
    val status: String,
    val stage: String,
    val startedAt: Long?,
    val pausedAt: Long?,
    val endedAt: Long?,
    val updatedAt: Long,
)

@Entity(
    tableName = "qa_records",
    foreignKeys = [
        ForeignKey(entity = CaseEntity::class, parentColumns = ["id"], childColumns = ["caseId"], onDelete = ForeignKey.CASCADE),
        ForeignKey(entity = SessionEntity::class, parentColumns = ["id"], childColumns = ["sessionId"], onDelete = ForeignKey.SET_NULL),
    ],
    indices = [Index("caseId"), Index("sessionId"), Index(value = ["caseId", "seq"], unique = true)],
)
data class QaRecordEntity(
    @androidx.room.PrimaryKey val id: String,
    val caseId: String,
    val sessionId: String?,
    val seq: Int,
    val speaker: String,
    val text: String,
    val mark: String,
    val confirmed: Boolean,
    val createdAt: Long,
    val updatedAt: Long,
)

@Entity(
    tableName = "qa_revisions",
    foreignKeys = [
        ForeignKey(entity = QaRecordEntity::class, parentColumns = ["id"], childColumns = ["qaId"], onDelete = ForeignKey.CASCADE),
        ForeignKey(entity = CaseEntity::class, parentColumns = ["id"], childColumns = ["caseId"], onDelete = ForeignKey.CASCADE),
    ],
    indices = [Index("qaId"), Index("caseId"), Index(value = ["qaId", "version"], unique = true)],
)
data class QaRevisionEntity(
    @androidx.room.PrimaryKey val id: String,
    val qaId: String,
    val caseId: String,
    val version: Int,
    val oldText: String,
    val newText: String,
    val reason: String,
    val createdAt: Long,
)

@Entity(
    tableName = "facts",
    primaryKeys = ["caseId", "factKey"],
    foreignKeys = [ForeignKey(entity = CaseEntity::class, parentColumns = ["id"], childColumns = ["caseId"], onDelete = ForeignKey.CASCADE)],
    indices = [Index("caseId")],
)
data class FactEntity(
    val caseId: String,
    val factKey: String,
    val sortOrder: Int,
    val label: String,
    val value: String,
    val status: String,
    val suggestion: String?,
    val updatedAt: Long,
)

@Entity(
    tableName = "timeline_events",
    foreignKeys = [ForeignKey(entity = CaseEntity::class, parentColumns = ["id"], childColumns = ["caseId"], onDelete = ForeignKey.CASCADE)],
    indices = [Index("caseId")],
)
data class TimelineEntity(
    @androidx.room.PrimaryKey val id: String,
    val caseId: String,
    val timeLabel: String,
    val title: String,
    val detail: String,
    val evidenceJson: String,
    val createdAt: Long,
)

@Entity(tableName = "audit_logs", indices = [Index("caseId"), Index("createdAt")])
data class AuditLogEntity(
    @androidx.room.PrimaryKey val id: String,
    val caseId: String?,
    val action: String,
    val targetType: String?,
    val targetId: String?,
    val detailJson: String,
    val createdAt: Long,
)

@Entity(
    tableName = "asr_capture_sessions",
    foreignKeys = [
        ForeignKey(entity = CaseEntity::class, parentColumns = ["id"], childColumns = ["caseId"], onDelete = ForeignKey.CASCADE),
        ForeignKey(entity = SessionEntity::class, parentColumns = ["id"], childColumns = ["interrogationSessionId"], onDelete = ForeignKey.CASCADE),
    ],
    indices = [Index("caseId"), Index("interrogationSessionId"), Index(value = ["caseId", "startedAt"])],
)
data class AsrCaptureSessionEntity(
    @androidx.room.PrimaryKey val id: String,
    val caseId: String,
    val interrogationSessionId: String,
    val modelId: String,
    val modelName: String,
    val provider: String,
    val sherpaVersion: String,
    val sampleRate: Int,
    val audioRelativePath: String,
    val startedAt: Long,
    val endedAt: Long?,
    val state: String,
    val error: String?,
)

@Entity(
    tableName = "asr_temporary_fragments",
    foreignKeys = [
        ForeignKey(entity = AsrCaptureSessionEntity::class, parentColumns = ["id"], childColumns = ["captureSessionId"], onDelete = ForeignKey.CASCADE),
        ForeignKey(entity = CaseEntity::class, parentColumns = ["id"], childColumns = ["caseId"], onDelete = ForeignKey.CASCADE),
        ForeignKey(entity = QaRecordEntity::class, parentColumns = ["id"], childColumns = ["confirmedQaId"], onDelete = ForeignKey.SET_NULL),
    ],
    indices = [
        Index("captureSessionId"),
        Index("caseId"),
        Index("confirmedQaId"),
        Index(value = ["captureSessionId", "ordinal"], unique = true),
    ],
)
data class AsrTemporaryFragmentEntity(
    @androidx.room.PrimaryKey val id: String,
    val captureSessionId: String,
    val caseId: String,
    val ordinal: Int,
    val startedAtMs: Long,
    val endedAtMs: Long,
    val audioStartOffsetMs: Long,
    val audioEndOffsetMs: Long,
    val rawText: String,
    val editedText: String,
    val speaker: String,
    val speakerSource: String,
    val confidence: Double?,
    val confidenceSource: String,
    val state: String,
    val confirmedQaId: String?,
    val createdAt: Long,
    val updatedAt: Long,
)
