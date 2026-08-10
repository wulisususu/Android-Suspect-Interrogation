package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException

class AiRouter(
    private val settingsStore: AiSettingsStore,
    private val cloud: AiProvider,
    private val local: AiProvider,
) {
    fun status(): AiRuntimeStatus {
        val settings = settingsStore.load()
        val cloudAvailable = cloud.isAvailable(settings)
        val localAvailable = local.isAvailable(settings)
        val active = when (settings.mode) {
            AiMode.CLOUD -> if (cloudAvailable) cloud.kind else AiProviderKind.UNAVAILABLE
            AiMode.LOCAL, AiMode.OFFLINE_ONLY -> if (localAvailable) local.kind else AiProviderKind.UNAVAILABLE
            AiMode.AUTO -> when {
                localAvailable -> local.kind
                cloudAvailable -> cloud.kind
                else -> AiProviderKind.UNAVAILABLE
            }
        }
        return AiRuntimeStatus(
            settings = settings,
            activeProvider = active,
            cloudConfigured = cloudAvailable,
            localAvailable = localAvailable,
            localModel = null,
        )
    }

    suspend fun inquiry(messages: List<AiMessage>): AiResponse {
        val settings = settingsStore.load()
        return when (settings.mode) {
            AiMode.CLOUD -> requireAvailable(cloud, settings).inquiry(messages, settings)
            AiMode.LOCAL -> requireAvailable(local, settings).inquiry(messages, settings)
            AiMode.OFFLINE_ONLY -> {
                if (!local.isAvailable(settings)) {
                    throw BusinessException("OFFLINE_AI_UNAVAILABLE", "当前为强制离线模式，本地模型不可用；不会回退到云端 API")
                }
                local.inquiry(messages, settings)
            }
            AiMode.AUTO -> when {
                local.isAvailable(settings) -> local.inquiry(messages, settings)
                cloud.isAvailable(settings) -> cloud.inquiry(messages, settings)
                else -> throw BusinessException("AI_PROVIDER_UNAVAILABLE", "自动模式下本地模型不可用，智谱 API Key 也未配置")
            }
        }
    }

    private fun requireAvailable(provider: AiProvider, settings: AiSettings): AiProvider {
        if (provider.isAvailable(settings)) return provider
        if (provider.kind == AiProviderKind.CLOUD_ZHIPU) {
            throw BusinessException("AI_CLOUD_KEY_MISSING", "当前选择云端模式，但智谱 API Key 尚未配置")
        }
        throw BusinessException("LOCAL_AI_NOT_CONFIGURED", "当前选择本地模式，但本地模型 Runtime 尚未接入")
    }
}

class AiService(
    private val settingsStore: AiSettingsStore,
    private val router: AiRouter,
) {
    fun status(): AiRuntimeStatus = router.status()

    fun updateSettings(
        mode: String? = null,
        cloudBaseUrl: String? = null,
        cloudModel: String? = null,
        stream: Boolean? = null,
        thinkingEnabled: Boolean? = null,
        maxTokens: Int? = null,
        temperature: Double? = null,
        apiKey: String? = null,
        clearApiKey: Boolean = false,
    ): AiRuntimeStatus {
        settingsStore.update(
            mode = mode?.let(AiMode::fromWire),
            cloudBaseUrl = cloudBaseUrl,
            cloudModel = cloudModel,
            stream = stream,
            thinkingEnabled = thinkingEnabled,
            maxTokens = maxTokens,
            temperature = temperature,
            apiKey = apiKey,
            clearApiKey = clearApiKey,
        )
        return router.status()
    }

    suspend fun inquiry(message: String): AiResponse {
        val clean = message.trim()
        if (clean.isEmpty()) throw BusinessException("EMPTY_AI_MESSAGE", "AI 请求内容不能为空")
        return router.inquiry(listOf(AiMessage(role = "user", content = clean)))
    }
}
