package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.data.AuditDao
import com.wulisu.suspect.interrogation.data.AuditLogEntity
import com.wulisu.suspect.interrogation.domain.AuditRecord
import org.json.JSONObject
import java.util.UUID

class AuditService(private val dao: AuditDao) {
    suspend fun append(caseId: String?, action: String, targetType: String? = null, targetId: String? = null, detail: JSONObject = JSONObject()) {
        dao.insert(AuditLogEntity(UUID.randomUUID().toString(), caseId, action, targetType, targetId, detail.toString(), System.currentTimeMillis()))
    }

    suspend fun list(caseId: String): List<AuditRecord> = dao.list(caseId).map {
        AuditRecord(it.id, it.caseId, it.action, it.targetType, it.targetId, it.detailJson, it.createdAt)
    }
}
