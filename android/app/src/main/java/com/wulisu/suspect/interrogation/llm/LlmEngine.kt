package com.wulisu.suspect.interrogation.llm

interface LlmEngine {
    val modelSpec: LlmModelSpec
    val config: LlmGenerationConfig
    suspend fun initialize(): LlmInitializationMetrics
    suspend fun generate(input: LlmInput): LlmResult
    suspend fun cancel()
    fun release()
}

class LlmEngineSwitcher(
    private val factory: (LlmModelSpec, LlmGenerationConfig) -> LlmEngine,
) {
    var currentEngine: LlmEngine? = null
        private set

    @Synchronized
    fun switchTo(spec: LlmModelSpec, config: LlmGenerationConfig): LlmEngine {
        currentEngine?.takeIf {
            it.modelSpec.id == spec.id && it.config.maxContextLen == config.maxContextLen
        }?.let { return it }
        currentEngine?.release()
        currentEngine = null
        return factory(spec, config).also { currentEngine = it }
    }

    @Synchronized
    fun release() {
        currentEngine?.release()
        currentEngine = null
    }
}
