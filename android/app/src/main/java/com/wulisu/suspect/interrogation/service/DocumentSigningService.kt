package com.wulisu.suspect.interrogation.service

import android.os.Build
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.domain.BusinessException
import org.json.JSONArray
import org.json.JSONObject
import java.security.MessageDigest

/**
 * V1 local electronic-signature chain.
 *
 * The immutable document freeze and every signature are appended to the encrypted
 * audit log. A signature is always bound to a SHA-256 of the canonical C-page
 * document snapshot, never merely to a rendered screenshot.
 */
class DocumentSigningService(
    private val db: AppDatabase,
    private val cases: CaseService,
    private val audit: AuditService,
) {
    suspend fun current(caseId: String): DocumentSigningState? {
        cases.get(caseId)
        val events = audit.list(caseId)
        val freeze = events.firstOrNull { it.action == ACTION_FREEZE } ?: return null
        val detail = JSONObject(freeze.detailJson)
        val documentHash = detail.getString("documentHash")
        val version = detail.getInt("version")
        val signatures = events
            .asSequence()
            .filter { it.action == ACTION_SIGNATURE && it.targetId == freeze.targetId }
            .mapNotNull { record ->
                runCatching {
                    val item = JSONObject(record.detailJson)
                    if (item.optString("documentHash") != documentHash) return@runCatching null
                    DocumentSignatureState(
                        signerRole = item.getString("signerRole"),
                        signerName = item.getString("signerName"),
                        signedAt = item.getLong("signedAt"),
                        signatureHash = item.getString("signatureHash"),
                        imageDataUrl = item.getString("imageDataUrl"),
                        strokesJson = item.getString("strokesJson"),
                        deviceId = item.optString("deviceId"),
                    )
                }.getOrNull()
            }
            .filterNotNull()
            .sortedBy { it.signedAt }
            .toList()

        val canonicalNow = buildCanonicalSnapshot(caseId)
        val integrityValid = sha256(canonicalNow) == documentHash
        val lockEventExists = events.any { it.action == ACTION_LOCK && it.targetId == freeze.targetId }
        val bothSigned = REQUIRED_ROLES.all { role -> signatures.any { it.signerRole == role } }
        val status = if (lockEventExists && bothSigned && integrityValid) STATUS_LOCKED else STATUS_FROZEN

        return DocumentSigningState(
            caseId = caseId,
            version = version,
            documentId = freeze.targetId ?: "DOCUMENT_V$version",
            documentHash = documentHash,
            status = status,
            createdAt = freeze.createdAt,
            integrityValid = integrityValid,
            signatures = signatures,
        )
    }

    suspend fun freeze(caseId: String): DocumentSigningState {
        current(caseId)?.let { return it }
        val session = db.sessionDao().latest(caseId)
            ?: throw BusinessException("DOCUMENT_SESSION_NOT_FOUND", "当前案件没有可冻结的询问会话")
        if (session.status != "COMPLETED") {
            throw BusinessException("DOCUMENT_SESSION_NOT_FINISHED", "请先结束审讯，再冻结询问笔录")
        }

        val previousVersions = audit.list(caseId).count { it.action == ACTION_FREEZE }
        val version = previousVersions + 1
        val documentId = "DOCUMENT_V$version"
        val snapshot = buildCanonicalSnapshot(caseId)
        val documentHash = sha256(snapshot)
        audit.append(
            caseId = caseId,
            action = ACTION_FREEZE,
            targetType = "DOCUMENT",
            targetId = documentId,
            detail = JSONObject()
                .put("schemaVersion", 1)
                .put("version", version)
                .put("documentHash", documentHash)
                .put("snapshotJson", snapshot),
        )
        cases.update(caseId, state = "SIGNING", stage = com.wulisu.suspect.interrogation.domain.InterrogationStage.SIGNING)
        return current(caseId) ?: throw BusinessException("DOCUMENT_FREEZE_FAILED", "询问笔录冻结失败")
    }

    suspend fun sign(
        caseId: String,
        signerRole: String,
        signerName: String,
        imageDataUrl: String,
        strokesJson: String,
    ): DocumentSigningState {
        if (signerRole !in REQUIRED_ROLES) {
            throw BusinessException("INVALID_SIGNER_ROLE", "签名角色仅支持被询问人或民警")
        }
        val cleanName = signerName.trim()
        if (cleanName.isEmpty()) throw BusinessException("SIGNER_NAME_EMPTY", "签名人姓名不能为空")
        if (!imageDataUrl.startsWith("data:image/png;base64,") || imageDataUrl.length > MAX_SIGNATURE_IMAGE_CHARS) {
            throw BusinessException("INVALID_SIGNATURE_IMAGE", "电子签名图像格式或大小不符合要求")
        }
        if (strokesJson.isBlank() || strokesJson.length > MAX_STROKES_JSON_CHARS) {
            throw BusinessException("INVALID_SIGNATURE_STROKES", "电子签名笔迹数据为空或过大")
        }

        val state = current(caseId)
            ?: throw BusinessException("DOCUMENT_NOT_FROZEN", "请先结束审讯并冻结询问笔录")
        if (!state.integrityValid) {
            throw BusinessException("DOCUMENT_CHANGED_AFTER_FREEZE", "冻结后的笔录内容发生变化，禁止继续签名")
        }
        if (state.status == STATUS_LOCKED) {
            throw BusinessException("DOCUMENT_ALREADY_LOCKED", "询问笔录已经完成双方签名并锁定")
        }
        if (state.signatures.any { it.signerRole == signerRole }) {
            throw BusinessException("SIGNATURE_ALREADY_EXISTS", "该签名角色已经完成签名")
        }

        val signedAt = System.currentTimeMillis()
        val signatureHash = sha256(
            listOf(
                state.documentHash,
                signerRole,
                cleanName,
                signedAt.toString(),
                imageDataUrl,
                strokesJson,
            ).joinToString("|"),
        )
        val deviceId = buildDeviceId()
        audit.append(
            caseId = caseId,
            action = ACTION_SIGNATURE,
            targetType = "DOCUMENT_SIGNATURE",
            targetId = state.documentId,
            detail = JSONObject()
                .put("version", state.version)
                .put("documentHash", state.documentHash)
                .put("signerRole", signerRole)
                .put("signerName", cleanName)
                .put("signedAt", signedAt)
                .put("signatureHash", signatureHash)
                .put("imageDataUrl", imageDataUrl)
                .put("strokesJson", strokesJson)
                .put("deviceId", deviceId),
        )

        var next = current(caseId)
            ?: throw BusinessException("SIGNATURE_SAVE_FAILED", "电子签名保存失败")
        if (REQUIRED_ROLES.all { role -> next.signatures.any { it.signerRole == role } }) {
            if (!next.integrityValid) {
                throw BusinessException("DOCUMENT_CHANGED_AFTER_FREEZE", "笔录完整性校验失败，不能锁定")
            }
            audit.append(
                caseId = caseId,
                action = ACTION_LOCK,
                targetType = "DOCUMENT",
                targetId = next.documentId,
                detail = JSONObject()
                    .put("version", next.version)
                    .put("documentHash", next.documentHash)
                    .put("lockedAt", System.currentTimeMillis()),
            )
            cases.update(caseId, state = "COMPLETED", stage = com.wulisu.suspect.interrogation.domain.InterrogationStage.SIGNING)
            next = current(caseId)
                ?: throw BusinessException("DOCUMENT_LOCK_FAILED", "询问笔录锁定失败")
        }
        return next
    }

    suspend fun requireEditable(caseId: String) {
        if (current(caseId) != null) {
            throw BusinessException("DOCUMENT_FROZEN", "询问笔录已经冻结，不能继续修改固定信息或正式问答")
        }
    }

    private suspend fun buildCanonicalSnapshot(caseId: String): String {
        val case = cases.get(caseId)
        val facts = db.factDao().list(caseId).associateBy { it.factKey }
        val session = db.sessionDao().latest(caseId)
        val records = db.qaDao().list(caseId).sortedBy { it.seq }

        fun fact(key: String): String = facts[key]?.value.orEmpty()
        fun quoted(value: String?): String = JSONObject.quote(value.orEmpty())

        return buildString {
            append('{')
            append("\"schemaVersion\":1")
            append(",\"caseId\":").append(quoted(case.id))
            append(",\"suspectName\":").append(quoted(case.suspectName))
            append(",\"gender\":").append(quoted(case.gender))
            append(",\"nation\":").append(quoted(case.nation))
            append(",\"birthDate\":").append(quoted(case.birthDate))
            append(",\"age\":").append(quoted(case.age))
            append(",\"idDocumentType\":").append(quoted(fact("id_document_type")))
            append(",\"idNumber\":").append(quoted(case.idNumber))
            append(",\"idCardAddress\":").append(quoted(case.address))
            append(",\"currentAddress\":").append(quoted(fact("current_address")))
            append(",\"householdRegistration\":").append(quoted(fact("household_registration")))
            append(",\"contact\":").append(quoted(fact("contact")))
            append(",\"peoplesRepresentative\":").append(quoted(fact("peoples_representative")))
            append(",\"interrogationRound\":").append(quoted(fact("interrogation_round")))
            append(",\"interrogationPlace\":").append(quoted(fact("interrogation_place")))
            append(",\"officerName\":").append(quoted(case.officerName))
            append(",\"officerUnit\":").append(quoted(fact("officer_unit")))
            append(",\"recorderName\":").append(quoted(fact("recorder_name")))
            append(",\"recorderUnit\":").append(quoted(fact("recorder_unit")))
            append(",\"startedAt\":").append(session?.startedAt ?: 0L)
            append(",\"endedAt\":").append(session?.endedAt ?: 0L)
            append(",\"records\":[")
            records.forEachIndexed { index, record ->
                if (index > 0) append(',')
                append('{')
                append("\"id\":").append(quoted(record.id))
                append(",\"seq\":").append(record.seq)
                append(",\"speaker\":").append(quoted(record.speaker))
                append(",\"text\":").append(quoted(record.text))
                append('}')
            }
            append("]}")
        }
    }

    private fun buildDeviceId(): String = listOf(
        Build.MANUFACTURER,
        Build.MODEL,
        Build.DEVICE,
        Build.HARDWARE,
    ).joinToString("/") { it.orEmpty() }

    private fun sha256(value: String): String = MessageDigest.getInstance("SHA-256")
        .digest(value.toByteArray(Charsets.UTF_8))
        .joinToString("") { "%02x".format(it) }

    companion object {
        const val ROLE_SUSPECT = "SUSPECT"
        const val ROLE_OFFICER = "OFFICER"
        const val STATUS_FROZEN = "FROZEN"
        const val STATUS_LOCKED = "LOCKED"
        private const val ACTION_FREEZE = "DOCUMENT_FREEZE"
        private const val ACTION_SIGNATURE = "DOCUMENT_SIGNATURE"
        private const val ACTION_LOCK = "DOCUMENT_LOCK"
        private const val MAX_SIGNATURE_IMAGE_CHARS = 1_500_000
        private const val MAX_STROKES_JSON_CHARS = 1_000_000
        private val REQUIRED_ROLES = setOf(ROLE_SUSPECT, ROLE_OFFICER)
    }
}

data class DocumentSignatureState(
    val signerRole: String,
    val signerName: String,
    val signedAt: Long,
    val signatureHash: String,
    val imageDataUrl: String,
    val strokesJson: String,
    val deviceId: String,
) {
    fun toJson(): JSONObject = JSONObject()
        .put("signerRole", signerRole)
        .put("signerName", signerName)
        .put("signedAt", signedAt)
        .put("signatureHash", signatureHash)
        .put("imageDataUrl", imageDataUrl)
        .put("strokesJson", strokesJson)
        .put("deviceId", deviceId)
}

data class DocumentSigningState(
    val caseId: String,
    val version: Int,
    val documentId: String,
    val documentHash: String,
    val status: String,
    val createdAt: Long,
    val integrityValid: Boolean,
    val signatures: List<DocumentSignatureState>,
) {
    fun toJson(): JSONObject = JSONObject()
        .put("caseId", caseId)
        .put("version", version)
        .put("documentId", documentId)
        .put("documentHash", documentHash)
        .put("status", status)
        .put("createdAt", createdAt)
        .put("integrityValid", integrityValid)
        .put("signatures", JSONArray().also { array -> signatures.forEach { array.put(it.toJson()) } })
}
