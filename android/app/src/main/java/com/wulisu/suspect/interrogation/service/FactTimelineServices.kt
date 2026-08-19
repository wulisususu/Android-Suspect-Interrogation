package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.data.FactDao
import com.wulisu.suspect.interrogation.data.FactEntity
import com.wulisu.suspect.interrogation.data.TimelineDao
import com.wulisu.suspect.interrogation.data.TimelineEntity
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.FactItem
import com.wulisu.suspect.interrogation.domain.TimelineEvent
import org.json.JSONArray
import java.util.UUID

data class TimelineDraft(
    val time: String,
    val title: String,
    val detail: String,
    val evidence: List<String> = emptyList(),
)

class FactService(private val dao: FactDao, private val cases: CaseService) {
    suspend fun list(caseId: String): List<FactItem> {
        cases.get(caseId)
        ensureWorkspaceFacts(caseId)
        return dao.list(caseId).map(::toDomain)
    }

    suspend fun update(
        caseId: String,
        factKey: String,
        value: String? = null,
        status: String? = null,
        suggestion: String? = null,
    ): FactItem {
        cases.get(caseId)
        ensureWorkspaceFacts(caseId)
        val current = dao.get(caseId, factKey)
            ?: throw BusinessException("FACT_NOT_FOUND", "事实项不存在: $factKey")
        val nextStatus = status ?: current.status
        if (nextStatus !in ALLOWED_STATUSES) {
            throw BusinessException("INVALID_FACT_STATUS", "无效事实状态: $nextStatus")
        }
        val next = current.copy(
            value = value?.trim()?.takeIf { it.isNotEmpty() } ?: current.value,
            status = nextStatus,
            suggestion = suggestion ?: current.suggestion,
            updatedAt = System.currentTimeMillis(),
        )
        dao.insertAll(listOf(next))
        return toDomain(next)
    }

    private suspend fun ensureWorkspaceFacts(caseId: String) {
        val now = System.currentTimeMillis()
        val defaults = listOf(
            FactEntity(caseId, "people", 25, "相关人员", "待根据问答核实", "pending", "确认同伙、联系人及其分工。", now),
            FactEntity(caseId, "current_address", 90, "现住址", "未录入", "missing", null, now),
            FactEntity(caseId, "case_type", 91, "案件类型", "未录入", "missing", null, now),
        )
        val missing = defaults.filter { dao.get(caseId, it.factKey) == null }
        if (missing.isNotEmpty()) dao.insertAll(missing)
    }

    private fun toDomain(entity: FactEntity) = FactItem(
        entity.factKey,
        entity.label,
        entity.value,
        entity.status,
        entity.suggestion,
    )

    companion object {
        private val ALLOWED_STATUSES = setOf("confirmed", "pending", "conflict", "missing")
    }
}

class TimelineService(private val dao: TimelineDao, private val cases: CaseService, private val audit: AuditService) {
    suspend fun list(caseId: String): List<TimelineEvent> {
        cases.get(caseId)
        return dao.list(caseId).map {
            val array = JSONArray(it.evidenceJson)
            val evidence = buildList { for (index in 0 until array.length()) add(array.optString(index)) }
            TimelineEvent(it.id, it.timeLabel, it.title, it.detail, evidence)
        }
    }

    suspend fun add(caseId: String, time: String, title: String, detail: String, evidence: List<String>): TimelineEvent {
        cases.get(caseId)
        val entity = TimelineEntity(
            UUID.randomUUID().toString(),
            caseId,
            time,
            title,
            detail,
            JSONArray(evidence).toString(),
            System.currentTimeMillis(),
        )
        dao.insert(entity)
        audit.append(caseId, "TIMELINE_CREATE", "TIMELINE", entity.id)
        return TimelineEvent(entity.id, time, title, detail, evidence)
    }

    suspend fun replaceAiGenerated(caseId: String, drafts: List<TimelineDraft>) {
        cases.get(caseId)
        dao.deleteAiGenerated(caseId)
        drafts.forEach { draft ->
            add(
                caseId = caseId,
                time = draft.time,
                title = draft.title,
                detail = draft.detail,
                evidence = (draft.evidence + AI_MARKER).filter { it.isNotBlank() }.distinct(),
            )
        }
        audit.append(caseId, "AI_TIMELINE_REPLACE", "TIMELINE", caseId)
    }

    companion object {
        const val AI_MARKER = "AI推理"
    }
}
