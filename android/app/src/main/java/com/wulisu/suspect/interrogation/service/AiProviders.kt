package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONArray
import org.json.JSONObject
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

interface AiProvider {
    val kind: AiProviderKind
    fun isAvailable(settings: AiSettings): Boolean
    suspend fun inquiry(messages: List<AiMessage>, settings: AiSettings): AiResponse
}

class ZhipuAiProvider(private val settingsStore: AiSettingsStore) : AiProvider {
    override val kind = AiProviderKind.CLOUD_ZHIPU

    override fun isAvailable(settings: AiSettings): Boolean = settingsStore.getApiKey().isNotBlank()

    override suspend fun inquiry(messages: List<AiMessage>, settings: AiSettings): AiResponse = withContext(Dispatchers.IO) {
        val apiKey = settingsStore.getApiKey().trim()
        if (apiKey.isBlank()) throw@withContext BusinessException("AI_CLOUD_KEY_MISSING", "智谱 API Key 尚未配置")

        val connection = (URL(settings.cloudBaseUrl).openConnection() as HttpURLConnection).apply {
            requestMethod = "POST"
            connectTimeout = 20_000
            readTimeout = 180_000
            doOutput = true
            setRequestProperty("Content-Type", "application/json")
            setRequestProperty("Accept", if (settings.stream) "text/event-stream" else "application/json")
            setRequestProperty("Authorization", "Bearer $apiKey")
        }

        val body = JSONObject()
            .put("model", settings.cloudModel)
            .put("messages", JSONArray().also { array ->
                messages.forEach { message ->
                    array.put(JSONObject().put("role", message.role).put("content", message.content))
                }
            })
            .put("thinking", JSONObject().put("type", if (settings.thinkingEnabled) "enabled" else "disabled"))
            .put("stream", settings.stream)
            .put("max_tokens", settings.maxTokens)
            .put("temperature", settings.temperature)
            .toString()

        connection.outputStream.use { it.write(body.toByteArray(Charsets.UTF_8)) }
        val status = connection.responseCode
        val source = if (status in 200..299) connection.inputStream else connection.errorStream
        val text = source?.bufferedReader(Charsets.UTF_8)?.use { reader ->
            if (status !in 200..299) {
                val errorBody = reader.readText()
                throw@use BusinessException("AI_CLOUD_HTTP_$status", parseCloudError(errorBody, status))
            }
            if (settings.stream) readStreamedContent(reader) else readJsonContent(reader.readText())
        } ?: throw@withContext BusinessException("AI_CLOUD_EMPTY_RESPONSE", "智谱 API 未返回响应体")

        if (text.isBlank()) throw@withContext BusinessException("AI_CLOUD_EMPTY_CONTENT", "智谱 API 返回成功，但回答内容为空")
        AiResponse(text = text, provider = kind, model = settings.cloudModel)
    }

    private fun readStreamedContent(reader: BufferedReader): String {
        val output = StringBuilder()
        reader.forEachLine { rawLine ->
            val line = rawLine.trim()
            if (!line.startsWith("data:")) return@forEachLine
            val data = line.removePrefix("data:").trim()
            if (data.isBlank() || data == "[DONE]") return@forEachLine
            runCatching {
                val json = JSONObject(data)
                val choices = json.optJSONArray("choices") ?: return@runCatching
                val delta = choices.optJSONObject(0)?.optJSONObject("delta") ?: return@runCatching
                val content = delta.optString("content")
                if (content.isNotEmpty()) output.append(content)
            }
        }
        return output.toString()
    }

    private fun readJsonContent(raw: String): String {
        val json = JSONObject(raw)
        val choices = json.optJSONArray("choices") ?: return ""
        val message = choices.optJSONObject(0)?.optJSONObject("message") ?: return ""
        return message.optString("content")
    }

    private fun parseCloudError(raw: String, status: Int): String = runCatching {
        val json = JSONObject(raw)
        val error = json.optJSONObject("error")
        error?.optString("message")?.takeIf { it.isNotBlank() }
            ?: json.optString("message").takeIf { it.isNotBlank() }
            ?: "智谱 API 请求失败（HTTP $status）"
    }.getOrDefault("智谱 API 请求失败（HTTP $status）")
}

class LocalAiProvider : AiProvider {
    override val kind = AiProviderKind.LOCAL
    override fun isAvailable(settings: AiSettings): Boolean = false

    override suspend fun inquiry(messages: List<AiMessage>, settings: AiSettings): AiResponse {
        throw BusinessException("LOCAL_AI_NOT_CONFIGURED", "本地模型 Provider 接口已就绪，但 JNI / RKNN / llama.cpp Runtime 尚未接入")
    }
}
