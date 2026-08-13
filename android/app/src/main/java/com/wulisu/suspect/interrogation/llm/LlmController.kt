package com.wulisu.suspect.interrogation.llm

import com.wulisu.suspect.interrogation.domain.BusinessException
import java.util.concurrent.atomic.AtomicBoolean

interface LlmModelRepository {
    fun selected(): LlmModelSpec?
    fun find(modelId: String): LlmModelSpec?
    fun persistSelection(modelId: String?)
    fun storagePermissionGranted(): Boolean
    fun devicePlatform(): LlmTargetPlatform = LlmTargetPlatform.UNKNOWN
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
            provider = selected?.provider ?: rkllmProvider(models.devicePlatform()),
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
        validateRunnable(spec)
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
            validateRunnable(spec)
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

    private fun validateRunnable(spec: LlmModelSpec) {
        if (!spec.complete && spec.compatibility == LlmCompatibility.READY) {
            throw BusinessException("LLM_MODEL_INCOMPLETE", "所选 LLM 模型文件不完整")
        }
        when (spec.compatibility) {
            LlmCompatibility.READY -> Unit
            LlmCompatibility.PLATFORM_MISMATCH -> throw BusinessException(
                "LLM_PLATFORM_MISMATCH",
                "${spec.targetPlatform.name} 模型不能在当前 ${spec.devicePlatform.name} 设备上运行",
            )
            LlmCompatibility.RUNTIME_MISMATCH -> throw BusinessException(
                "LLM_RUNTIME_MISMATCH",
                "模型要求 RKLLM Runtime ${spec.runtimeVersion}，当前 Runtime 为 $RKLLM_RUNTIME_VERSION",
            )
            LlmCompatibility.METADATA_INVALID -> throw BusinessException(
                "LLM_METADATA_INVALID",
                "所选 LLM 模型 metadata 无效，请重新导入或修复 sidecar",
            )
            LlmCompatibility.UNREADABLE -> throw BusinessException("LLM_MODEL_UNREADABLE", "所选 LLM 模型不可读")
            LlmCompatibility.INCOMPLETE -> throw BusinessException("LLM_MODEL_INCOMPLETE", "所选 LLM 模型文件不完整")
            LlmCompatibility.UNSUPPORTED -> throw BusinessException(
                "LLM_MODEL_UNSUPPORTED",
                if (spec.devicePlatform == LlmTargetPlatform.UNKNOWN) {
                    "当前设备平台无法识别，仅支持 RK3576 / RK3588"
                } else {
                    "所选 LLM 模型缺少可验证的平台/格式信息"
                },
            )
        }
    }

    private fun notifyStatus() {
        statusListener?.invoke(status())
    }
}
