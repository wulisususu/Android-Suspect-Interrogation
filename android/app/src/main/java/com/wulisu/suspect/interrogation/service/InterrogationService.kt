package com.wulisu.suspect.interrogation.service

import androidx.room.withTransaction
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.data.SessionEntity
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.InterrogationRules
import com.wulisu.suspect.interrogation.domain.InterrogationStage
import com.wulisu.suspect.interrogation.domain.SessionState
import com.wulisu.suspect.interrogation.domain.SessionStatus
import java.util.UUID

class InterrogationService(private val db: AppDatabase, private val cases: CaseService, private val audit: AuditService) {
    private val dao = db.sessionDao()

    suspend fun state(caseId: String): SessionState {
        val case = cases.ensure(caseId)
        return (dao.active(caseId) ?: dao.latest(caseId))?.toDomain() ?: SessionState(null, case.id, SessionStatus.READY, case.stage, null, null, null, case.updatedAt)
    }

    suspend fun start(caseId: String): SessionState = db.withTransaction {
        cases.ensure(caseId)
        dao.active(caseId)?.let { return@withTransaction it.toDomain() }
        val now = System.currentTimeMillis()
        val entity = SessionEntity(UUID.randomUUID().toString(), caseId, SessionStatus.RUNNING.name, InterrogationStage.IDENTITY.name, now, null, null, now)
        dao.insert(entity)
        cases.setStateAndStage(caseId, "INTERROGATING", InterrogationStage.IDENTITY)
        audit.append(caseId, "SESSION_START", "SESSION", entity.id)
        entity.toDomain()
    }

    suspend fun pause(caseId: String): SessionState = db.withTransaction {
        val current = dao.active(caseId) ?: throw BusinessException("SESSION_NOT_RUNNING", "当前没有正在进行的审讯")
        InterrogationRules.requireCanPause(SessionStatus.valueOf(current.status))
        val now = System.currentTimeMillis()
        val next = current.copy(status = SessionStatus.PAUSED.name, pausedAt = now, updatedAt = now)
        dao.update(next); audit.append(caseId, "SESSION_PAUSE", "SESSION", current.id); next.toDomain()
    }

    suspend fun resume(caseId: String): SessionState = db.withTransaction {
        val current = dao.active(caseId) ?: throw BusinessException("SESSION_NOT_PAUSED", "当前审讯不是暂停状态")
        InterrogationRules.requireCanResume(SessionStatus.valueOf(current.status))
        val next = current.copy(status = SessionStatus.RUNNING.name, pausedAt = null, updatedAt = System.currentTimeMillis())
        dao.update(next); audit.append(caseId, "SESSION_RESUME", "SESSION", current.id); next.toDomain()
    }

    suspend fun finish(caseId: String): SessionState = db.withTransaction {
        val current = dao.active(caseId) ?: throw BusinessException("SESSION_NOT_ACTIVE", "当前没有可结束的审讯")
        val now = System.currentTimeMillis()
        val next = current.copy(status = SessionStatus.COMPLETED.name, endedAt = now, updatedAt = now)
        dao.update(next); cases.setStateAndStage(caseId, state = "REVIEWING"); audit.append(caseId, "SESSION_FINISH", "SESSION", current.id); next.toDomain()
    }

    suspend fun changeStage(caseId: String, stage: InterrogationStage): SessionState = db.withTransaction {
        InterrogationRules.requireValidStage(stage)
        val current = dao.active(caseId) ?: throw BusinessException("SESSION_NOT_ACTIVE", "请先开始审讯再切换阶段")
        val next = current.copy(stage = stage.name, updatedAt = System.currentTimeMillis())
        dao.update(next); cases.setStateAndStage(caseId, stage = stage); audit.append(caseId, "SESSION_CHANGE_STAGE", "SESSION", current.id); next.toDomain()
    }

    suspend fun activeRunning(caseId: String): SessionEntity {
        val current = dao.active(caseId) ?: throw BusinessException("SESSION_NOT_ACTIVE", "请先开始审讯再记录问答")
        InterrogationRules.requireCanRecord(SessionStatus.valueOf(current.status))
        return current
    }
}

private fun SessionEntity.toDomain() = SessionState(id, caseId, SessionStatus.valueOf(status), InterrogationStage.valueOf(stage), startedAt, pausedAt, endedAt, updatedAt)
