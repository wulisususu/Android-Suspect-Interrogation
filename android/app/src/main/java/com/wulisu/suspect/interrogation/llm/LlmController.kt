package com.wulisu.suspect.interrogation.llm

import com.wulisu.suspect.interrogation.domain.BusinessException
import java.util.concurrent.atomic.AtomicBoolean

interface LlmModelRepository {
    fun selected(): LlmModelSpec?
    fun find(modelId: String): LlmModelSpec?
    fun persistSelection(modelId: String?)
    fun storagePermissionGranted(): Boolean
}

interface LlmConfigurationStore {
    fun load(): LlmGenerationConfig
    fun save(config: LlmGenerationConfig)
}

class LlmController(
    private val models: LlmModelRepository,
    private val configurationStore: LlmConfigurationStore,
    private val switcher: LlmEngineSwitcher,
) {
    private val busy = AtomicBoolean(false)

    @Volatile
    private var generationId: String? = null
    @Volatile
    private var initialized = false
    @Volatile
    private var initializationMs: Long? = null
    @Volatile
    private var firstTokenLatencyMs: Long? = null
    @Volatile
    private var totalInferenceMs: Long? = null
    @Volatile
    private var error: String? = null
    @Volatile
    private var statusListener: ((LlmRuntimeStatus) -> Unit)? = null
    @Volatile
    private var fragmentListener: ((LlmFragment) -> Unit)? = null

    fun status(): LlmRuntimeStatus {
        val selected = models.selected()
        return LlmRuntimeStatus(
            selectedModelId = selected?.id,
            selectedModelName = selected?.name,
            activeModelId = switcher.currentEngine?.modelSpec?.id,
            storagePermissionGranted = models.storagePermissionGranted(),
            initialized = initialized,
            busy = busy.get(),
            generationId = generationId,
            config = configurationStore.load(),
            initializationMs = initializationMs,
            firstTokenLatencyMs = firstTokenLatencyMs,
            totalInferenceMs = totalInferenceMs,
            error = error,
        )
    }

    fun setStatusListener(listener: ((LlmRuntimeStatus) -> Unit)?) {
        statusListener = listener
    }

    fun setFragmentListener(listener: ((LlmFragment) -> Unit)?) {
        fragmentListener = listener
    }

    @Synchronized
    fun selectModel(modelId: String?): LlmRuntimeStatus {
        if (busy.get()) {
            throw BusinessException("LLM_GENERATION_BUSY", "生成期间不能切换 LLM 模型")
        }
        val cleanId = modelId?.trim().orEmpty()
        if (cleanId.isEmpty()) {
            switcher.release()
            initialized = false
            models.persistSelection(null)
            notifyStatus()
            return status()
        }
        val spec = models.find(cleanId)
            ?: throw BusinessException("LLM_MODEL_NOT_FOUND", "所选 LLM 模型不存在，请重新扫描")
        if (!spec.complete) {
            throw BusinessException("LLM_MODEL_INCOMPLETE", "所选 LLM 模型文件不完整")
        }
        when (spec.compatibility) {
            LlmCompatibility.READY -> Unit
            LlmCompatibility.PLATFORM_MISMATCH -> throw BusinessException(
                "LLM_PLATFORM_MISMATCH",
                "${spec.targetPlatform.name} 模型不能在当前 RK3576 设备上运行",
            )
            LlmCompatibility.UNREADABLE -> throw BusinessException("LLM_MODEL_UNREADABLE", "所选 LLM 模型不可读")
            LlmCompatibility.INCOMPLETE -> throw BusinessException("LLM_MODEL_INCOMPLETE", "所选 LLM 模型文件不完整")
            LlmCompatibility.UNSUPPORTED -> throw BusinessException("LLM_MODEL_UNSUPPORTED", "所选 LLM 模型平台未知")
        }
        if (models.selected()?.id == spec.id) return status()
        switcher.release()
        initialized = false
        models.persistSelection(spec.id)
        error = null
        notifyStatus()
        return status()
    }

    suspend fun generate(input: LlmInput): LlmResult {
        if (!busy.compareAndSet(false, true)) {
            throw BusinessException("LLM_GENERATION_BUSY", "已有 LLM 生成任务正在运行")
        }
        generationId = input.generationId
        error = null
        notifyStatus()
        try {
            if (!models.storagePermissionGranted()) {
                throw BusinessException("LLM_STORAGE_PERMISSION_REQUIRED", "尚未授予模型目录访问权限")
            }
            if (input.prompt.isBlank()) {
                throw BusinessException("LLM_INPUT_EMPTY", "Prompt 不能为空")
            }
            val spec = models.selected()
                ?: throw BusinessException("LLM_MODEL_NOT_SELECTED", "尚未选择 LLM 模型")
            configurationStore.save(input.config)
            val engine = switcher.switchTo(spec, input.config)
            val metrics = engine.initialize()
            initialized = true
            initializationMs = metrics.initializationMs
            notifyStatus()
            val result = engine.generate(
                input.copy(fragmentListener = { fragment ->
                    input.fragmentListener?.invoke(fragment)
                    fragmentListener?.invoke(fragment)
                }),
            )
            firstTokenLatencyMs = result.firstTokenLatencyMs
            totalInferenceMs = result.totalInferenceMs
            error = result.error.takeUnless { it == "LLM_CANCELLED" }
            return result
        } catch (failure: BusinessException) {
            error = failure.code
            throw failure
        } finally {
            busy.set(false)
            generationId = null
            notifyStatus()
        }
    }

    suspend fun cancel(): LlmRuntimeStatus {
        switcher.currentEngine?.cancel()
        return status()
    }

    suspend fun release(): LlmRuntimeStatus {
        if (busy.get()) switcher.currentEngine?.cancel()
        switcher.release()
        initialized = false
        generationId = null
        notifyStatus()
        return status()
    }

    private fun notifyStatus() {
        statusListener?.invoke(status())
    }
}
