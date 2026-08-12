package com.wulisu.suspect.interrogation.bridge

import android.net.Uri
import com.wulisu.suspect.interrogation.asr.AsrCaptureSessionManager
import com.wulisu.suspect.interrogation.asr.AsrCaptureStatus
import com.wulisu.suspect.interrogation.asr.AsrController
import com.wulisu.suspect.interrogation.asr.AsrFinalResult
import com.wulisu.suspect.interrogation.asr.AsrRuntimeStatus
import com.wulisu.suspect.interrogation.asr.BatchFragmentConfirmation
import com.wulisu.suspect.interrogation.asr.CaptureFragmentRules
import com.wulisu.suspect.interrogation.asr.FragmentConfirmation
import com.wulisu.suspect.interrogation.asr.TemporaryAsrFragment
import com.wulisu.suspect.interrogation.domain.*
import com.wulisu.suspect.interrogation.ocr.OcrController
import com.wulisu.suspect.interrogation.ocr.OcrRuntimeStatus
import com.wulisu.suspect.interrogation.ocr.toJson
import com.wulisu.suspect.interrogation.service.*
import org.json.JSONArray
import org.json.JSONObject

class RpcRouter(
    private val cases: CaseService,
    private val sessions: InterrogationService,
    private val records: RecordService,
    private val facts: FactService,
    private val timeline: TimelineService,
    private val audit: AuditService,
    private val devices: DeviceService,
    private val ai: AiService,
    private val models: ModelManager,
    private val asr: AsrController,
    private val asrCapture: AsrCaptureSessionManager,
    private val ocr: OcrController,
) {
    suspend fun handle(raw: String): String {
        val request = runCatching { JSONObject(raw) }.getOrElse { return error("", "INVALID_REQUEST", "NativeBridge 请求不是合法 JSON") }
        val id = request.optString("id")
        val action = request.optString("action")
        val payload = request.optJSONObject("payload") ?: JSONObject()
        return try { success(id, dispatch(action, payload)) }
        catch (error: BusinessException) { error(id, error.code, error.message) }
        catch (error: Throwable) { error(id, "INTERNAL_ERROR", error.message ?: "Android 后端内部错误") }
    }

    private suspend fun dispatch(action: String, payload: JSONObject): Any? = when (action) {
        "case.create" -> cases.create(
            requestedId = payload.nullableString("id"),
            suspectName = payload.nullableString("suspectName"),
            gender = payload.nullableString("gender"),
            age = payload.nullableString("age"),
            officerName = payload.nullableString("officerName"),
            idNumber = payload.nullableString("idNumber"),
            nation = payload.nullableString("nation"),
            birthDate = payload.nullableString("birthDate"),
            address = payload.nullableString("address"),
            identitySource = payload.nullableString("identitySource"),
            identityCapturedAt = payload.nullableLong("identityCapturedAt"),
        ).toJson()
        "case.list" -> cases.list(payload.optInt("limit", 100)).toJsonArray { it.toJson() }
        "case.get" -> cases.get(payload.requiredString("caseId")).toJson()
        "case.update" -> cases.update(
            caseId = payload.requiredString("caseId"),
            suspectName = payload.nullableString("suspectName"),
            gender = payload.nullableString("gender"),
            age = payload.nullableString("age"),
            officerName = payload.nullableString("officerName"),
            state = payload.nullableString("state"),
            stage = payload.nullableString("stage")?.let(::stageFromWire),
            idNumber = payload.nullableString("idNumber"),
            nation = payload.nullableString("nation"),
            birthDate = payload.nullableString("birthDate"),
            address = payload.nullableString("address"),
            identitySource = payload.nullableString("identitySource"),
            identityCapturedAt = payload.nullableLong("identityCapturedAt"),
        ).toJson()
        "session.get" -> sessions.state(payload.requiredString("caseId")).toJson()
        "session.start" -> sessions.start(payload.requiredString("caseId")).toJson()
        "session.pause" -> sessions.pause(payload.requiredString("caseId")).toJson()
        "session.resume" -> sessions.resume(payload.requiredString("caseId")).toJson()
        "session.finish" -> sessions.finish(payload.requiredString("caseId")).toJson()
        "session.stage" -> sessions.changeStage(payload.requiredString("caseId"), stageFromWire(payload.requiredString("stage"))).toJson()
        "record.list" -> records.list(payload.requiredString("caseId")).toJsonArray { it.toJson() }
        "record.add" -> records.add(payload.requiredString("caseId"), payload.requiredString("text"), payload.requiredString("from")).toJson()
        "record.update" -> records.update(payload.requiredString("caseId"), payload.requiredString("messageId"), payload.requiredString("text"), payload.optString("reason", "警官在审讯工作台修订")).toJson()
        "record.mark" -> records.mark(payload.requiredString("caseId"), payload.requiredString("messageId"), payload.optString("mark", "conflict")).toJson()
        "record.revisions" -> records.revisions(payload.requiredString("caseId"), payload.nullableString("messageId")).toJsonArray { it.toJson() }
        "fact.list" -> facts.list(payload.requiredString("caseId")).toJsonArray { it.toJson() }
        "timeline.list" -> timeline.list(payload.requiredString("caseId")).toJsonArray { it.toJson() }
        "audit.list" -> audit.list(payload.requiredString("caseId")).toJsonArray { it.toJson() }
        "device.action" -> devices.invoke(payload.requiredString("type"))
        "ai.settings.get" -> ai.status().toJson()
        "ai.settings.update" -> ai.updateSettings(
            mode = payload.nullableString("mode"),
            cloudBaseUrl = payload.nullableString("cloudBaseUrl"),
            cloudModel = payload.nullableString("cloudModel"),
            stream = payload.nullableBoolean("stream"),
            thinkingEnabled = payload.nullableBoolean("thinkingEnabled"),
            maxTokens = payload.nullableInt("maxTokens"),
            temperature = payload.nullableDouble("temperature"),
            apiKey = payload.nullableString("apiKey"),
            clearApiKey = payload.optBoolean("clearApiKey", false),
        ).toJson()
        "ai.inquiry" -> ai.inquiry(payload.requiredString("message")).toJson()
        "asr.status" -> asr.status().toJson()
        "asr.start" -> asr.start().toJson()
        "asr.stop" -> asr.stop().toJson()
        "asr.capture.status" -> asrCapture.status(payload.requiredString("caseId")).toJson()
        "asr.capture.start" -> asrCapture.start(payload.requiredString("caseId")).toJson()
        "asr.capture.stop" -> asrCapture.stop(payload.requiredString("caseId")).toJson()
        "asr.fragment.list" -> asrCapture.listFragments(payload.requiredString("caseId"), payload.optBoolean("includeConfirmed", false)).toJsonArray { it.toJson() }
        "asr.fragment.update" -> asrCapture.updateFragment(payload.requiredString("fragmentId"), payload.requiredString("editedText"), payload.requiredString("speaker")).toJson()
        "asr.fragment.confirm" -> asrCapture.confirmFragment(payload.requiredString("fragmentId")).toJson()
        "asr.fragment.confirmBatch" -> asrCapture.confirmBatch(payload.requiredStringList("fragmentIds")).toJson()
        "asr.fragment.discard" -> asrCapture.discardFragment(payload.requiredString("fragmentId")).toJson()
        "ocr.status" -> ocr.status().toJson()
        "ocr.model.list" -> models.list().toJson()
        "ocr.model.select" -> ocr.selectModel(payload.nullableString("modelId")).toJson()
        "ocr.image.use" -> ocr.useImage(Uri.parse(payload.requiredString("uri"))).toJson()
        "ocr.camera.use" -> ocr.useCapturedImage(
            file = java.io.File(payload.requiredString("path")),
            uri = Uri.parse(payload.requiredString("uri")),
        ).toJson()
        "ocr.recognize" -> ocr.recognize().toJson()
        "ocr.release" -> ocr.release().toJson()
        "model.scan" -> models.scan().toJson()
        "model.list" -> models.list().toJson()
        "model.select" -> {
            val category = payload.requiredModelCategory()
            when (category) {
                ModelCategory.ASR -> asr.selectModel(payload.nullableString("modelId")).toJson()
                ModelCategory.OCR -> ocr.selectModel(payload.nullableString("modelId")).toJson()
                else -> models.select(category, payload.nullableString("modelId")).toJson()
            }
        }
        "model.import" -> models.importFromUri(
            category = payload.requiredModelCategory(),
            source = payload.requiredModelImportSource(),
            uri = Uri.parse(payload.requiredString("uri")),
        ).toJson()
        else -> throw BusinessException("ACTION_NOT_SUPPORTED", "未支持的 NativeBridge action: $action")
    }

    private fun success(id: String, data: Any?): String = JSONObject().put("id", id).put("ok", true).put("code", "OK").put("message", "").put("data", data ?: JSONObject.NULL).toString()
    private fun error(id: String, code: String, message: String): String = JSONObject().put("id", id).put("ok", false).put("code", code).put("message", message).put("data", JSONObject.NULL).toString()
}

private fun JSONObject.requiredString(key: String): String { val value = optString(key).trim(); if (value.isEmpty()) throw BusinessException("INVALID_ARGUMENT", "缺少参数: $key"); return value }
private fun JSONObject.nullableString(key: String): String? { if (!has(key) || isNull(key)) return null; return optString(key).takeIf { it.isNotBlank() } }
private fun JSONObject.nullableBoolean(key: String): Boolean? = if (!has(key) || isNull(key)) null else optBoolean(key)
private fun JSONObject.nullableInt(key: String): Int? = if (!has(key) || isNull(key)) null else optInt(key)
private fun JSONObject.nullableLong(key: String): Long? = if (!has(key) || isNull(key)) null else optLong(key)
private fun JSONObject.nullableDouble(key: String): Double? = if (!has(key) || isNull(key)) null else optDouble(key)
private fun JSONObject.requiredStringList(key: String): List<String> {
    val array = optJSONArray(key) ?: throw BusinessException("INVALID_ARGUMENT", "缺少参数: $key")
    return buildList {
        for (index in 0 until array.length()) {
            array.optString(index).trim().takeIf { it.isNotEmpty() }?.let(::add)
        }
    }.ifEmpty { throw BusinessException("INVALID_ARGUMENT", "$key 不能为空") }
}
private fun JSONObject.requiredModelCategory(): ModelCategory =
    ModelCategory.fromWire(requiredString("category"))
        ?: throw BusinessException("INVALID_MODEL_CATEGORY", "无效的模型分类")
private fun JSONObject.requiredModelImportSource(): ModelImportSource =
    ModelImportSource.fromWire(requiredString("source"))
        ?: throw BusinessException("INVALID_MODEL_IMPORT_SOURCE", "无效的模型导入方式")
private fun stageFromWire(value: String): InterrogationStage = runCatching { InterrogationStage.valueOf(value) }.getOrElse { throw BusinessException("INVALID_STAGE", "无效审讯阶段") }
private inline fun <T> List<T>.toJsonArray(mapper: (T) -> Any?): JSONArray = JSONArray().also { array -> forEach { array.put(mapper(it)) } }
private fun CaseSummary.toJson() = JSONObject()
    .put("id", id)
    .put("suspectName", suspectName)
    .put("gender", gender)
    .put("age", age)
    .put("idNumber", idNumber)
    .put("nation", nation)
    .put("birthDate", birthDate)
    .put("address", address)
    .put("identitySource", identitySource)
    .put("identityCapturedAt", identityCapturedAt ?: JSONObject.NULL)
    .put("officerName", officerName)
    .put("state", state)
    .put("stage", stage.name)
    .put("createdAt", createdAt)
    .put("updatedAt", updatedAt)
private fun SessionState.toJson() = JSONObject().put("id", id ?: JSONObject.NULL).put("caseId", caseId).put("status", status.name).put("stage", stage.name).put("startedAt", startedAt ?: JSONObject.NULL).put("pausedAt", pausedAt ?: JSONObject.NULL).put("endedAt", endedAt ?: JSONObject.NULL).put("updatedAt", updatedAt)
private fun TranscriptMessage.toJson() = JSONObject().put("id", id).put("seq", seq).put("speaker", speaker).put("text", text).put("mark", mark).put("confirmed", confirmed).put("createdAt", createdAt).put("updatedAt", updatedAt)
private fun RecordRevision.toJson() = JSONObject().put("id", id).put("qaId", qaId).put("version", version).put("oldText", oldText).put("newText", newText).put("reason", reason).put("createdAt", createdAt)
private fun FactItem.toJson() = JSONObject().put("key", key).put("label", label).put("value", value).put("status", status).put("suggestion", suggestion ?: JSONObject.NULL)
private fun TimelineEvent.toJson() = JSONObject().put("id", id).put("time", time).put("title", title).put("detail", detail).put("evidence", JSONArray(evidence))
private fun AuditRecord.toJson() = JSONObject().put("id", id).put("caseId", caseId ?: JSONObject.NULL).put("action", action).put("targetType", targetType ?: JSONObject.NULL).put("targetId", targetId ?: JSONObject.NULL).put("detail", JSONObject(detailJson)).put("createdAt", createdAt)
private fun AiSettings.toJson() = JSONObject()
    .put("mode", mode.name)
    .put("cloudBaseUrl", cloudBaseUrl)
    .put("cloudModel", cloudModel)
    .put("stream", stream)
    .put("thinkingEnabled", thinkingEnabled)
    .put("maxTokens", maxTokens)
    .put("temperature", temperature)
    .put("apiKeyConfigured", apiKeyConfigured)
private fun AiRuntimeStatus.toJson() = JSONObject()
    .put("settings", settings.toJson())
    .put("activeProvider", activeProvider.name)
    .put("cloudConfigured", cloudConfigured)
    .put("localAvailable", localAvailable)
    .put("localModel", localModel ?: JSONObject.NULL)
private fun AiResponse.toJson() = JSONObject().put("text", text).put("provider", provider.name).put("model", model)
internal fun AsrRuntimeStatus.toJson() = JSONObject()
    .put("selectedModelId", selectedModelId)
    .put("selectedModelName", selectedModelName)
    .put("activeModelId", activeModelId ?: JSONObject.NULL)
    .put("provider", provider)
    .put("running", running)
    .put("initialized", initialized)
    .put("initializationMs", initializationMs ?: JSONObject.NULL)
    .put("firstTokenLatencyMs", firstTokenLatencyMs ?: JSONObject.NULL)
    .put("utteranceLatencyMs", utteranceLatencyMs ?: JSONObject.NULL)
    .put("partialText", partialText)
    .put("finalText", finalText)
    .put("finalResults", finalResults.toJsonArray { it.toJson() })
    .put("error", error ?: JSONObject.NULL)
    .put("sherpaVersion", sherpaVersion)
    .put("sampleRate", sampleRate)
private fun AsrFinalResult.toJson() = JSONObject()
    .put("text", text)
    .put("startedAtMs", startedAtMs)
    .put("endedAtMs", endedAtMs)
    .put("latencyMs", latencyMs)
    .put("confidence", confidence ?: JSONObject.NULL)
internal fun OcrRuntimeStatus.toJson() = JSONObject()
    .put("selectedModelId", selectedModelId ?: JSONObject.NULL)
    .put("selectedModelName", selectedModelName ?: JSONObject.NULL)
    .put("activeModelId", activeModelId ?: JSONObject.NULL)
    .put("provider", provider ?: JSONObject.NULL)
    .put("modelFormat", modelFormat ?: JSONObject.NULL)
    .put("initialized", initialized)
    .put("busy", busy)
    .put("imageReady", imageReady)
    .put("previewUri", previewUri ?: JSONObject.NULL)
    .put("initializationMs", initializationMs ?: JSONObject.NULL)
    .put("recognitionMs", recognitionMs ?: JSONObject.NULL)
    .put("lastResult", lastResult?.toJson() ?: JSONObject.NULL)
    .put("error", error ?: JSONObject.NULL)
internal fun AsrCaptureStatus.toJson() = JSONObject()
    .put("caseId", caseId)
    .put("captureSessionId", captureSessionId ?: JSONObject.NULL)
    .put("running", running)
    .put("startedAt", startedAt ?: JSONObject.NULL)
    .put("endedAt", endedAt ?: JSONObject.NULL)
    .put("modelId", modelId ?: JSONObject.NULL)
    .put("modelName", modelName ?: JSONObject.NULL)
    .put("provider", provider ?: JSONObject.NULL)
    .put("sampleRate", sampleRate)
    .put("partialText", partialText)
    .put("fragments", fragments.toJsonArray { it.toJson() })
    .put("error", error ?: JSONObject.NULL)
private fun TemporaryAsrFragment.toJson() = JSONObject()
    .put("id", id)
    .put("captureSessionId", captureSessionId)
    .put("caseId", caseId)
    .put("ordinal", ordinal)
    .put("startedAtMs", startedAtMs)
    .put("endedAtMs", endedAtMs)
    .put("rawText", rawText)
    .put("editedText", editedText)
    .put("speaker", speaker.name)
    .put("speakerSource", speakerSource.name)
    .put("confidence", confidence ?: JSONObject.NULL)
    .put("confidenceSource", confidenceSource.name)
    .put("lowConfidence", CaptureFragmentRules.isLowConfidence(confidence))
    .put("state", state.name)
    .put("confirmedQaId", confirmedQaId ?: JSONObject.NULL)
    .put(
        "audio",
        JSONObject()
            .put("captureSessionId", audio.captureSessionId)
            .put("startOffsetMs", audio.startOffsetMs)
            .put("endOffsetMs", audio.endOffsetMs)
            .put("available", audio.available),
    )
    .put("createdAt", createdAt)
    .put("updatedAt", updatedAt)
private fun FragmentConfirmation.toJson() = JSONObject().put("fragment", fragment.toJson()).put("record", record.toJson())
private fun BatchFragmentConfirmation.toJson() = JSONObject()
    .put("confirmed", confirmed.toJsonArray { it.toJson() })
    .put("failures", failures.toJsonArray { JSONObject().put("fragmentId", it.fragmentId).put("code", it.code).put("message", it.message) })
private fun LocalModelCatalog.toJson() = JSONObject()
    .put("rootPath", JSONObject.NULL)
    .put("models", models.toJsonArray { it.toJson() })
private fun LocalModelDescriptor.toJson() = JSONObject()
    .put("id", id)
    .put("category", category.name)
    .put("name", name)
    .put("storageName", storageName)
    .put("absolutePath", JSONObject.NULL)
    .put("relativePath", relativePath)
    .put("sizeBytes", sizeBytes)
    .put("modifiedAt", modifiedAt)
    .put("sourceKind", sourceKind.name)
    .put("archive", archive)
    .put("selected", selected)
    .put("runtimeReady", runtimeReady)
    .put("version", version ?: JSONObject.NULL)
    .put("modelFormat", modelFormat ?: JSONObject.NULL)
    .put("provider", provider ?: JSONObject.NULL)
    .put("complete", complete)
