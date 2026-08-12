package com.wulisu.suspect.interrogation.service

import androidx.room.withTransaction
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.data.CaseEntity
import com.wulisu.suspect.interrogation.data.FactEntity
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.CaseSummary
import com.wulisu.suspect.interrogation.domain.InterrogationStage
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

class CaseService(private val db: AppDatabase, private val audit: AuditService) {
    private val caseDao = db.caseDao()
    private val factDao = db.factDao()

    suspend fun create(
        requestedId: String? = null,
        suspectName: String? = null,
        gender: String? = null,
        age: String? = null,
        officerName: String? = null,
        idNumber: String? = null,
        nation: String? = null,
        birthDate: String? = null,
        address: String? = null,
        identitySource: String? = null,
        identityCapturedAt: Long? = null,
    ): CaseSummary = db.withTransaction {
        val now = System.currentTimeMillis()
        val caseId = requestedId?.takeIf { it.isNotBlank() } ?: generateCaseId(now)
        if (caseDao.get(caseId) != null) throw BusinessException("CASE_EXISTS", "案件已存在")
        val source = normalizeIdentitySource(identitySource)
        val hasIdentity = listOf(idNumber, nation, birthDate, address).any { !it.isNullOrBlank() } || !suspectName.isNullOrBlank()
        val entity = CaseEntity(
            id = caseId,
            suspectName = suspectName?.trim()?.takeIf { it.isNotBlank() } ?: "待录入",
            gender = gender?.trim()?.takeIf { it.isNotBlank() },
            age = age?.trim()?.takeIf { it.isNotBlank() },
            idNumber = idNumber?.trim()?.uppercase(Locale.ROOT)?.takeIf { it.isNotBlank() },
            nation = nation?.trim()?.takeIf { it.isNotBlank() },
            birthDate = birthDate?.trim()?.takeIf { it.isNotBlank() },
            address = address?.trim()?.takeIf { it.isNotBlank() },
            identitySource = source,
            identityCapturedAt = identityCapturedAt ?: if (hasIdentity) now else null,
            officerName = officerName?.trim()?.takeIf { it.isNotBlank() } ?: "当前警官",
            state = "DRAFT",
            stage = InterrogationStage.IDENTITY.name,
            createdAt = now,
            updatedAt = now,
        )
        caseDao.insert(entity)
        seedFacts(caseId, now)
        audit.append(caseId, "CASE_CREATE", "CASE", caseId)
        entity.toDomain()
    }

    suspend fun get(caseId: String): CaseSummary = caseDao.get(caseId)?.toDomain() ?: throw BusinessException("CASE_NOT_FOUND", "案件不存在")
    suspend fun list(limit: Int = 100): List<CaseSummary> = caseDao.list(limit.coerceIn(1, 500)).map { it.toDomain() }
    suspend fun ensure(caseId: String): CaseSummary = caseDao.get(caseId)?.toDomain() ?: create(requestedId = caseId)

    suspend fun update(
        caseId: String,
        suspectName: String? = null,
        gender: String? = null,
        age: String? = null,
        officerName: String? = null,
        state: String? = null,
        stage: InterrogationStage? = null,
        idNumber: String? = null,
        nation: String? = null,
        birthDate: String? = null,
        address: String? = null,
        identitySource: String? = null,
        identityCapturedAt: Long? = null,
    ): CaseSummary = db.withTransaction {
        val current = caseDao.get(caseId) ?: throw BusinessException("CASE_NOT_FOUND", "案件不存在")
        val next = current.copy(
            suspectName = suspectName ?: current.suspectName,
            gender = gender ?: current.gender,
            age = age ?: current.age,
            idNumber = idNumber?.uppercase(Locale.ROOT) ?: current.idNumber,
            nation = nation ?: current.nation,
            birthDate = birthDate ?: current.birthDate,
            address = address ?: current.address,
            identitySource = identitySource?.let(::normalizeIdentitySource) ?: current.identitySource,
            identityCapturedAt = identityCapturedAt ?: current.identityCapturedAt,
            officerName = officerName ?: current.officerName,
            state = state ?: current.state,
            stage = stage?.name ?: current.stage,
            updatedAt = System.currentTimeMillis(),
        )
        caseDao.update(next)
        audit.append(caseId, "CASE_UPDATE", "CASE", caseId)
        next.toDomain()
    }

    suspend fun setStateAndStage(caseId: String, state: String? = null, stage: InterrogationStage? = null) {
        val current = caseDao.get(caseId) ?: throw BusinessException("CASE_NOT_FOUND", "案件不存在")
        caseDao.update(current.copy(state = state ?: current.state, stage = stage?.name ?: current.stage, updatedAt = System.currentTimeMillis()))
    }

    private suspend fun seedFacts(caseId: String, now: Long) {
        if (factDao.count(caseId) > 0) return
        val defaults = listOf(
            arrayOf("time", "时间", "待根据问答核实", "pending", "固定到达、离开和关键行为的具体时间。"),
            arrayOf("place", "地点", "待根据问答核实", "pending", "确认具体地点、入口和移动路线。"),
            arrayOf("motive", "动机 / 目的", "待核实", "pending", "追问事前联系、约定和准备行为。"),
            arrayOf("method", "手段 / 工具", "尚未固定", "missing", "确认工具来源、携带方式和最终去向。"),
            arrayOf("process", "行为经过", "尚未形成完整顺序", "missing", "把关键动作拆成连续问题逐项固定。"),
            arrayOf("evidence", "证据对应", "待绑定", "pending", "将回答与监控、照片、物证等证据编号关联。"),
            arrayOf("after", "事后处置 / 后果", "尚未固定", "missing", "确认离开路线、物品处置以及是否联系他人。"),
        )
        factDao.insertAll(defaults.mapIndexed { index, row -> FactEntity(caseId, row[0], index, row[1], row[2], row[3], row[4], now) })
    }

    private fun normalizeIdentitySource(value: String?): String? {
        val normalized = value?.trim()?.uppercase(Locale.ROOT)?.takeIf { it.isNotBlank() } ?: return null
        if (normalized !in setOf("MANUAL", "OCR")) {
            throw BusinessException("INVALID_IDENTITY_SOURCE", "身份录入来源仅支持 MANUAL 或 OCR")
        }
        return normalized
    }

    private fun generateCaseId(now: Long): String {
        val date = SimpleDateFormat("yyyyMMdd", Locale.US).format(Date(now))
        val suffix = java.util.UUID.randomUUID().toString().replace("-", "").take(5).uppercase(Locale.US)
        return "CASE-$date-$suffix"
    }
}

fun CaseEntity.toDomain() = CaseSummary(
    id = id,
    suspectName = suspectName,
    gender = gender.orEmpty(),
    age = age.orEmpty(),
    idNumber = idNumber.orEmpty(),
    nation = nation.orEmpty(),
    birthDate = birthDate.orEmpty(),
    address = address.orEmpty(),
    identitySource = identitySource.orEmpty(),
    identityCapturedAt = identityCapturedAt,
    officerName = officerName,
    state = state,
    stage = InterrogationStage.valueOf(stage),
    createdAt = createdAt,
    updatedAt = updatedAt,
)
