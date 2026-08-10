package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.data.FactDao
import com.wulisu.suspect.interrogation.data.TimelineDao
import com.wulisu.suspect.interrogation.data.TimelineEntity
import com.wulisu.suspect.interrogation.domain.FactItem
import com.wulisu.suspect.interrogation.domain.TimelineEvent
import org.json.JSONArray
import java.util.UUID

class FactService(private val dao: FactDao, private val cases: CaseService) {
    suspend fun list(caseId: String): List<FactItem> { cases.ensure(caseId); return dao.list(caseId).map { FactItem(it.factKey, it.label, it.value, it.status, it.suggestion) } }
}

class TimelineService(private val dao: TimelineDao, private val cases: CaseService, private val audit: AuditService) {
    suspend fun list(caseId: String): List<TimelineEvent> {
        cases.ensure(caseId)
        return dao.list(caseId).map {
            val array = JSONArray(it.evidenceJson); val evidence = buildList { for (index in 0 until array.length()) add(array.optString(index)) }
            TimelineEvent(it.id, it.timeLabel, it.title, it.detail, evidence)
        }
    }

    suspend fun add(caseId: String, time: String, title: String, detail: String, evidence: List<String>): TimelineEvent {
        cases.ensure(caseId)
        val entity = TimelineEntity(UUID.randomUUID().toString(), caseId, time, title, detail, JSONArray(evidence).toString(), System.currentTimeMillis())
        dao.insert(entity); audit.append(caseId, "TIMELINE_CREATE", "TIMELINE", entity.id)
        return TimelineEvent(entity.id, time, title, detail, evidence)
    }
}
