package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.llm.LlmController
import com.wulisu.suspect.interrogation.llm.LlmInput
import java.util.UUID

interface LocalLlmRuntime {
    fun isAvailable(model: LocalModelDescriptor): Boolean
    suspend fun inquiry(model: LocalModelDescriptor, messages: List<AiMessage>): AiResponse
}

class UnavailableLocalLlmRuntime : LocalLlmRuntime {
    override fun isAvailable(model: LocalModelDescriptor): Boolean = false

    override suspend fun inquiry(
        model: LocalModelDescriptor,
        messages: List<AiMessage>,
    ): AiResponse {
        throw BusinessException(
            "LOCAL_AI_RUNTIME_UNAVAILABLE",
            "已选择本地模型 ${model.name}，但本地推理 Runtime 尚未接入",
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
    ): AiResponse {
        val prompt = messages.joinToString("\n") { message -> "${message.role}: ${message.content}" }.trim()
        val config = controller.status().config
        val result = controller.generate(
            LlmInput(
                generationId = UUID.randomUUID().toString(),
                prompt = prompt,
                config = config,
            ),
        )
        return AiResponse(
            text = result.outputText,
            provider = AiProviderKind.LOCAL,
            model = result.modelName,
            generationMetadata = AiGenerationMetadata(
                runtimeVersion = model.version ?: "unknown",
                generationConfigJson =
                    "{\"maxContextLen\":${config.maxContextLen},\"maxNewTokens\":${config.maxNewTokens}}",
                modelId = model.id,
            ),
        )
    }
}

class LocalAiProvider(
    private val modelManager: ModelManager,
    private val runtime: LocalLlmRuntime = UnavailableLocalLlmRuntime(),
) {
    fun isAvailable(): Boolean =
        modelManager.selected(ModelCategory.LLM)?.let(runtime::isAvailable) == true

    fun currentModel(): String? = modelManager.selected(ModelCategory.LLM)?.name

    suspend fun inquiry(messages: List<AiMessage>): AiResponse {
        val model = modelManager.selected(ModelCategory.LLM)
            ?: throw BusinessException("LOCAL_MODEL_NOT_SELECTED", "尚未导入并选择本地 LLM 模型")
        if (!runtime.isAvailable(model)) {
            throw BusinessException(
                "LOCAL_AI_RUNTIME_UNAVAILABLE",
                "本地模型 ${model.name} 已选择，但本地推理 Runtime 尚未就绪",
            )
        }
        return runtime.inquiry(model, messages)
    }
}
