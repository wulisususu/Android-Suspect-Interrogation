package com.wulisu.suspect.interrogation.domain

enum class InterrogationStage {
    IDENTITY,
    STATEMENT,
    FOLLOW_UP,
    SIGNING,
}

enum class SessionStatus {
    READY,
    RUNNING,
    PAUSED,
    COMPLETED,
}

enum class Speaker(val wireValue: String) {
    OFFICER("民警"),
    SUSPECT("嫌疑人");

    companion object {
        fun fromWire(value: String): Speaker = entries.firstOrNull { it.wireValue == value }
            ?: throw BusinessException("INVALID_SPEAKER", "仅允许民警或嫌疑人写入正式问答")
    }
}

enum class RecordMark(val wireValue: String) {
    NONE(""),
    CONFLICT("conflict"),
    CONFIRMED("confirmed"),
    PENDING("pending");

    companion object {
        fun fromWire(value: String): RecordMark = entries.firstOrNull { it.wireValue == value }
            ?: throw BusinessException("INVALID_MARK", "无效标记类型")
    }
}

data class CaseSummary(
    val id: String,
    val suspectName: String,
    val gender: String,
    val age: String,
    val idNumber: String,
    val nation: String,
    val birthDate: String,
    val address: String,
    val identitySource: String,
    val identityCapturedAt: Long?,
    val officerName: String,
    val state: String,
    val stage: InterrogationStage,
    val createdAt: Long,
    val updatedAt: Long,
)

data class SessionState(
    val id: String?,
    val caseId: String,
    val status: SessionStatus,
    val stage: InterrogationStage,
    val startedAt: Long?,
    val pausedAt: Long?,
    val endedAt: Long?,
    val updatedAt: Long,
)

data class TranscriptMessage(
    val id: String,
    val seq: Int,
    val speaker: String,
    val text: String,
    val mark: String,
    val confirmed: Boolean,
    val createdAt: Long,
    val updatedAt: Long,
)

data class RecordRevision(
    val id: String,
    val qaId: String,
    val version: Int,
    val oldText: String,
    val newText: String,
    val reason: String,
    val createdAt: Long,
)

data class FactItem(
    val key: String,
    val label: String,
    val value: String,
    val status: String,
    val suggestion: String?,
)

data class TimelineEvent(
    val id: String,
    val time: String,
    val title: String,
    val detail: String,
    val evidence: List<String>,
)

data class AuditRecord(
    val id: String,
    val caseId: String?,
    val action: String,
    val targetType: String?,
    val targetId: String?,
    val detailJson: String,
    val createdAt: Long,
)

class BusinessException(
    val code: String,
    override val message: String,
) : RuntimeException(message)
