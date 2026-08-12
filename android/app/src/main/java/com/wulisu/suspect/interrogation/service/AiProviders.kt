package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.llm.LlmController
import com.wulisu.suspect.interrogation.llm.LlmGenerationConfig
import com.wulisu.suspect.interrogation.llm.LlmInput
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONArray
import org.json.JSONObject
import java.io.BufferedReader
import java.net.HttpURLConnection
import java.net.URL
import java.util.UUID

interface AiProvider {
    val kind: AiProviderKind
    fun isAvailable(settings: AiSettings): Boolean
    fun currentModel(settings: AiSettings): String? = null
    suspend fun inquiry(messages: List<AiMessage>, settings: AiSettings): AiResponse
}

class ZhipuAiProvider(private val settingsStore: AiSettingsStore) : AiProvider {
    override val kind = AiProviderKind.CLOUD_ZHIPU

    override fun isAvailable(settings: AiSettings): Boolean = settingsStore.getApiKey().isNotBlank()

    override suspend fun inquiry(messages: List<AiMessage>, settings: AiSettings): AiResponse = withContext(Dispatchers.IO) {
        val apiKey = settingsStore.getApiKey().trim()
        if (apiKey.isBlank()) throw BusinessException("AI_CLOUD_KEY_MISSING", "智谱 API Key 尚未配置")

        val connection = (URL(settings.cloudBaseUrl).openConnection() as HttpURLConnection).apply {
            requestMethod = "POST"
            connectTimeout = 20_000
            readTimeout = 180_000
            doOutput = true
            setRequestProperty("Content-Type", "application/json")
            setRequestProperty("Accept", if (settings.stream) "text/event-stream" else "application/json")
            setRequestProperty("Authorization", "Bearer $apiKey")
        }

        try {
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
            val responseBody = source?.bufferedReader(Charsets.UTF_8)
                ?: throw BusinessException("AI_CLOUD_EMPTY_RESPONSE", "智谱 API 未返回响应体")

            val text = responseBody.use { reader ->
                if (status !in 200..299) {
                    val errorBody = reader.readText()
                    throw BusinessException("AI_CLOUD_HTTP_$status", parseCloudError(errorBody, status))
                }
                if (settings.stream) readStreamedContent(reader) else readJsonContent(reader.readText())
            }

            if (text.isBlank()) throw BusinessException("AI_CLOUD_EMPTY_CONTENT", "智谱 API 返回成功，但回答内容为空")
            AiResponse(text = text, provider = kind, model = settings.cloudModel)
        } finally {
            connection.disconnect()
        }
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

interface LocalLlmRuntime {
    fun isAvailable(model: LocalModelDescriptor): Boolean
    suspend fun inquiry(model: LocalModelDescriptor, messages: List<AiMessage>, settings: AiSettings): AiResponse
}

class UnavailableLocalLlmRuntime : LocalLlmRuntime {
    override fun isAvailable(model: LocalModelDescriptor): Boolean = false

    override suspend fun inquiry(
        model: LocalModelDescriptor,
        messages: List<AiMessage>,
        settings: AiSettings,
    ): AiResponse {
        throw BusinessException(
            "LOCAL_AI_RUNTIME_UNAVAILABLE",
            "已选择本地模型 ${model.name}，但 JNI / RKNN / ONNX / llama.cpp Runtime 尚未接入",
        )
    }
}

class ControllerLocalLlmRuntime(
    private val controller: LlmController,
) : LocalLlmRuntime {
    override fun isAvailable(model: LocalModelDescriptor): Boolean =
        model.runtimeReady && controller.status().storagePermissionGranted

    override suspend fun inquiry(
        model: LocalModelDescriptor,
        messages: List<AiMessage>,
        settings: AiSettings,
    ): AiResponse {
        val prompt = messages.joinToString("\n") { message -> "${message.role}: ${message.content}" }.trim()
        val currentConfig = controller.status().config
        val result = controller.generate(
            LlmInput(
                generationId = UUID.randomUUID().toString(),
                prompt = prompt,
                config = LlmGenerationConfig(
                    maxNewTokens = settings.maxTokens.coerceIn(1, 4096),
                    maxContextLen = currentConfig.maxContextLen,
                ),
            ),
        )
        return AiResponse(result.outputText, AiProviderKind.LOCAL, result.modelName)
    }
}

class LocalAiProvider(
    private val modelManager: ModelManager,
    private val runtime: LocalLlmRuntime = UnavailableLocalLlmRuntime(),
) : AiProvider {
    override val kind = AiProviderKind.LOCAL
    override fun isAvailable(settings: AiSettings): Boolean =
        modelManager.selected(ModelCategory.LLM)?.let(runtime::isAvailable) == true

    override fun currentModel(settings: AiSettings): String? =
        modelManager.selected(ModelCategory.LLM)?.name

    override suspend fun inquiry(messages: List<AiMessage>, settings: AiSettings): AiResponse {
        val model = modelManager.selected(ModelCategory.LLM)
            ?: throw BusinessException("LOCAL_MODEL_NOT_SELECTED", "尚未导入并选择 LLM 模型")
        if (!runtime.isAvailable(model)) {
            throw BusinessException("LOCAL_AI_RUNTIME_UNAVAILABLE", "本地模型 ${model.name} 已选择，但推理 Runtime 尚未接入")
        }
        return runtime.inquiry(model, messages, settings)
    }
}
