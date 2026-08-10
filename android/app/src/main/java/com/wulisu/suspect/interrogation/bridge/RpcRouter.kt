package com.wulisu.suspect.interrogation.bridge

import com.wulisu.suspect.interrogation.domain.*
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
        "case.create" -> cases.create(payload.nullableString("id"), payload.nullableString("suspectName"), payload.nullableString("gender"), payload.nullableString("age"), payload.nullableString("officerName")).toJson()
        "case.get" -> cases.get(payload.requiredString("caseId")).toJson()
        "case.update" -> cases.update(payload.requiredString("caseId"), payload.nullableString("suspectName"), payload.nullableString("gender"), payload.nullableString("age"), payload.nullableString("officerName"), payload.nullableString("state"), payload.nullableString("stage")?.let(::stageFromWire)).toJson()
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
        else -> throw BusinessException("ACTION_NOT_SUPPORTED", "未支持的 NativeBridge action: $action")
    }

    private fun success(id: String, data: Any?): String = JSONObject().put("id", id).put("ok", true).put("code", "OK").put("message", "").put("data", data ?: JSONObject.NULL).toString()
    private fun error(id: String, code: String, message: String): String = JSONObject().put("id", id).put("ok", false).put("code", code).put("message", message).put("data", JSONObject.NULL).toString()
}

private fun JSONObject.requiredString(key: String): String { val value = optString(key).trim(); if (value.isEmpty()) throw BusinessException("INVALID_ARGUMENT", "缺少参数: $key"); return value }
private fun JSONObject.nullableString(key: String): String? { if (!has(key) || isNull(key)) return null; return optString(key).takeIf { it.isNotBlank() } }
private fun JSONObject.nullableBoolean(key: String): Boolean? = if (!has(key) || isNull(key)) null else optBoolean(key)
private fun JSONObject.nullableInt(key: String): Int? = if (!has(key) || isNull(key)) null else optInt(key)
private fun JSONObject.nullableDouble(key: String): Double? = if (!has(key) || isNull(key)) null else optDouble(key)
private fun stageFromWire(value: String): InterrogationStage = runCatching { InterrogationStage.valueOf(value) }.getOrElse { throw BusinessException("INVALID_STAGE", "无效审讯阶段") }
private inline fun <T> List<T>.toJsonArray(mapper: (T) -> Any?): JSONArray = JSONArray().also { array -> forEach { array.put(mapper(it)) } }
private fun CaseSummary.toJson() = JSONObject().put("id", id).put("suspectName", suspectName).put("gender", gender).put("age", age).put("officerName", officerName).put("state", state).put("stage", stage.name).put("createdAt", createdAt).put("updatedAt", updatedAt)
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
