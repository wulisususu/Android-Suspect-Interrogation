package com.wulisu.suspect.interrogation.service

enum class AiMode {
    CLOUD,
    LOCAL,
    AUTO,
    OFFLINE_ONLY;

    companion object {
        fun fromWire(value: String?): AiMode = entries.firstOrNull { it.name == value?.uppercase() } ?: CLOUD
    }
}

enum class AiProviderKind {
    CLOUD_ZHIPU,
    LOCAL,
    UNAVAILABLE,
}

data class AiMessage(
    val role: String,
    val content: String,
)

data class AiSettings(
    val mode: AiMode = AiMode.CLOUD,
    val cloudBaseUrl: String = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
    val cloudModel: String = "glm-4.7",
    val stream: Boolean = true,
    val thinkingEnabled: Boolean = true,
    val maxTokens: Int = 65_536,
    val temperature: Double = 1.0,
    val apiKeyConfigured: Boolean = false,
)

data class AiRuntimeStatus(
    val settings: AiSettings,
    val activeProvider: AiProviderKind,
    val cloudConfigured: Boolean,
    val localAvailable: Boolean,
    val localModel: String? = null,
)

data class AiGenerationMetadata(
    val runtimeVersion: String = "unknown",
    val generationConfigJson: String = "{}",
    val modelId: String? = null,
    val modelFileHash: String? = null,
)

data class AiResponse(
    val text: String,
    val provider: AiProviderKind,
    val model: String,
    val generationMetadata: AiGenerationMetadata = AiGenerationMetadata(),
)
