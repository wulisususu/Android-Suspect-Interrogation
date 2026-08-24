package com.wulisu.suspect.interrogation.service

import androidx.room.withTransaction
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.data.QaRecordEntity
import com.wulisu.suspect.interrogation.data.QaRevisionEntity
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.InterrogationRules
import com.wulisu.suspect.interrogation.domain.RecordMark
import com.wulisu.suspect.interrogation.domain.RecordRevision
import com.wulisu.suspect.interrogation.domain.Speaker
import com.wulisu.suspect.interrogation.domain.TranscriptMessage
import org.json.JSONObject
import java.util.UUID

class RecordService(private val db: AppDatabase, private val cases: CaseService, private val sessions: InterrogationService, private val audit: AuditService) {
    private val qaDao = db.qaDao(); private val revisionDao = db.revisionDao()

    suspend fun list(caseId: String): List<TranscriptMessage> { cases.get(caseId); return qaDao.list(caseId).map { it.toDomain() } }

    suspend fun add(caseId: String, text: String, speakerValue: String): TranscriptMessage = db.withTransaction {
        addWithinTransaction(caseId, text, speakerValue)
    }

    internal suspend fun addWithinTransaction(caseId: String, text: String, speakerValue: String): TranscriptMessage {
        cases.get(caseId)
        val clean = InterrogationRules.requireNonBlankMessage(text)
        val speaker = Speaker.fromWire(speakerValue)
        val session = sessions.activeRunning(caseId)
        val now = System.currentTimeMillis()
        val entity = QaRecordEntity(UUID.randomUUID().toString(), caseId, session.id, qaDao.maxSeq(caseId) + 1, speaker.wireValue, clean, RecordMark.NONE.wireValue, true, now, now)
        qaDao.insert(entity)
        audit.append(caseId, "QA_CREATE", "QA", entity.id, JSONObject().put("seq", entity.seq).put("speaker", entity.speaker))
        return entity.toDomain()
    }

    internal suspend fun getWithinTransaction(caseId: String, messageId: String): TranscriptMessage? =
        qaDao.get(caseId, messageId)?.toDomain()

    suspend fun update(caseId: String, messageId: String, text: String, reason: String): TranscriptMessage = db.withTransaction {
        updateWithinTransaction(caseId, messageId, text, reason)
    }

    internal suspend fun updateWithinTransaction(caseId: String, messageId: String, text: String, reason: String): TranscriptMessage {
        val current = qaDao.get(caseId, messageId) ?: throw BusinessException("QA_NOT_FOUND", "问答记录不存在")
        val clean = InterrogationRules.requireNonBlankMessage(text)
        if (clean == current.text) return current.toDomain()
        val version = revisionDao.maxVersion(messageId) + 1
        val now = System.currentTimeMillis()
        revisionDao.insert(QaRevisionEntity(UUID.randomUUID().toString(), messageId, caseId, version, current.text, clean, reason.ifBlank { "警官修订" }, now))
        val next = current.copy(text = clean, updatedAt = now); qaDao.update(next)
        audit.append(caseId, "QA_UPDATE", "QA", messageId, JSONObject().put("version", version).put("reason", reason))
        return next.toDomain()
    }

    suspend fun mark(caseId: String, messageId: String, markValue: String): TranscriptMessage = db.withTransaction {
        val current = qaDao.get(caseId, messageId) ?: throw BusinessException("QA_NOT_FOUND", "问答记录不存在")
        val mark = RecordMark.fromWire(markValue)
        val next = current.copy(mark = mark.wireValue, updatedAt = System.currentTimeMillis()); qaDao.update(next)
        audit.append(caseId, "QA_MARK", "QA", messageId, JSONObject().put("mark", mark.wireValue)); next.toDomain()
    }

    suspend fun revisions(caseId: String, messageId: String?): List<RecordRevision> {
        cases.get(caseId)
        val rows = if (messageId.isNullOrBlank()) revisionDao.listForCase(caseId) else revisionDao.listForQa(caseId, messageId)
        return rows.map { RecordRevision(it.id, it.qaId, it.version, it.oldText, it.newText, it.reason, it.createdAt) }
    }
}

private fun QaRecordEntity.toDomain() = TranscriptMessage(id, seq, speaker, text, mark, confirmed, createdAt, updatedAt)
