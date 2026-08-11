package com.wulisu.suspect.interrogation.asr

import android.content.Context
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.service.LocalModelCatalog
import com.wulisu.suspect.interrogation.service.ModelCategory
import com.wulisu.suspect.interrogation.service.ModelManager

const val SHERPA_ONNX_VERSION = "1.13.5"

data class AsrRuntimeStatus(
    val selectedModelId: String,
    val selectedModelName: String,
    val activeModelId: String?,
    val provider: String,
    val running: Boolean,
    val initialized: Boolean,
    val initializationMs: Long?,
    val firstTokenLatencyMs: Long?,
    val utteranceLatencyMs: Long?,
    val partialText: String,
    val finalText: String,
    val finalResults: List<AsrFinalResult>,
    val error: String?,
    val sherpaVersion: String = SHERPA_ONNX_VERSION,
    val sampleRate: Int = 16_000,
)

class AsrController(
    context: Context,
    private val modelManager: ModelManager,
) {
    private val operationLock = Any()
    private val controlLock = Any()
    private val switcher = AsrEngineSwitcher { spec ->
        when (spec.id) {
            AsrModelId.ZIPFORMER_RK3576 -> ZipformerRknnEngine(context.applicationContext)
            AsrModelId.PARAFORMER_INT8 -> ParaformerEngine(context.applicationContext)
        }
    }

    @Volatile
    private var statusListener: ((AsrRuntimeStatus) -> Unit)? = null
    @Volatile
    private var captureListener: AsrListener? = null
    @Volatile
    private var captureRunningProvider: (() -> Boolean)? = null
    @Volatile
    private var state = initialStatus(resolveSelectedSpec())

    private val engineListener = object : AsrListener {
        override fun onAudioSamples(samples: ShortArray, count: Int, sampleRate: Int, capturedAtMs: Long) {
            captureListener?.onAudioSamples(samples, count, sampleRate, capturedAtMs)
        }

        override fun onPartialResult(text: String, firstTokenLatencyMs: Long?) {
            synchronized(controlLock) {
                state = state.copy(
                    partialText = text,
                    firstTokenLatencyMs = firstTokenLatencyMs ?: state.firstTokenLatencyMs,
                    error = null,
                )
                emitState()
            }
            captureListener?.onPartialResult(text, firstTokenLatencyMs)
        }

        override fun onFinalResult(result: AsrFinalResult) {
            synchronized(controlLock) {
                val results = (state.finalResults + result).takeLast(MAX_FINAL_RESULTS)
                state = state.copy(
                    partialText = "",
                    finalText = result.text,
                    finalResults = results,
                    utteranceLatencyMs = result.latencyMs,
                    firstTokenLatencyMs = null,
                    error = null,
                )
                emitState()
            }
            captureListener?.onFinalResult(result)
        }

        override fun onError(code: String, message: String) {
            synchronized(controlLock) {
                state = state.copy(
                    running = false,
                    initialized = false,
                    partialText = "",
                    error = "$code: $message",
                )
                emitState()
            }
            captureListener?.onError(code, message)
        }
    }

    fun setStatusListener(listener: ((AsrRuntimeStatus) -> Unit)?) {
        statusListener = listener
    }

    fun setCaptureListener(listener: AsrListener?) {
        captureListener = listener
    }

    fun setCaptureRunningProvider(provider: (() -> Boolean)?) {
        captureRunningProvider = provider
    }

    fun status(): AsrRuntimeStatus = synchronized(controlLock) {
        val selected = resolveSelectedSpec()
        if (selected.id.catalogId != state.selectedModelId && !state.running) {
            state = initialStatus(selected).copy(finalResults = state.finalResults)
        }
        state
    }

    fun start(): AsrRuntimeStatus = synchronized(operationLock) operation@{
        val runningState = synchronized(controlLock) { state.takeIf { it.running } }
        if (runningState != null) return@operation runningState
        val selected = resolveSelectedSpec()
        val engine = switcher.switchTo(selected)
        synchronized(controlLock) {
            state = state.copy(
                selectedModelId = selected.id.catalogId,
                selectedModelName = selected.displayName,
                activeModelId = selected.id.catalogId,
                provider = selected.provider,
                running = true,
                initialized = false,
                partialText = "",
                error = null,
            )
            emitState()
        }
        try {
            val metrics = engine.start(engineListener)
            synchronized(controlLock) {
                state = state.copy(initialized = true, initializationMs = metrics.initializationMs)
                emitState()
                state
            }
        } catch (error: Throwable) {
            switcher.release()
            synchronized(controlLock) {
                state = state.copy(
                    activeModelId = null,
                    running = false,
                    initialized = false,
                    error = error.message ?: "ASR 启动失败",
                )
                emitState()
            }
            throw error
        }
    }

    fun stop(): AsrRuntimeStatus = synchronized(operationLock) {
        switcher.release()
        synchronized(controlLock) {
            state = state.copy(
                activeModelId = null,
                running = false,
                initialized = false,
                partialText = "",
            )
            emitState()
            state
        }
    }

    fun selectModel(modelId: String?): LocalModelCatalog = synchronized(operationLock) {
        if (captureRunningProvider?.invoke() == true) {
            throw BusinessException("ASR_CAPTURE_RUNNING", "请先停止连续录音再切换 ASR 模型")
        }
        val spec = if (modelId.isNullOrBlank()) {
            AsrModelSpecs.default
        } else {
            AsrModelSpecs.fromCatalogId(modelId)
                ?: throw BusinessException("ASR_MODEL_UNSUPPORTED", "当前 ASR Runtime 不支持所选模型")
        }
        switcher.release()
        val catalog = modelManager.select(ModelCategory.ASR, spec.id.catalogId)
        synchronized(controlLock) {
            state = initialStatus(spec).copy(finalResults = state.finalResults)
            emitState()
        }
        catalog
    }

    fun release() {
        synchronized(operationLock) {
            switcher.release()
            synchronized(controlLock) {
                state = state.copy(running = false, initialized = false, activeModelId = null, partialText = "")
                emitState()
            }
        }
    }

    private fun resolveSelectedSpec(): AsrModelSpec {
        val selectedId = modelManager.selected(ModelCategory.ASR)?.id
        return AsrModelSpecs.fromCatalogId(selectedId) ?: AsrModelSpecs.default
    }

    private fun initialStatus(spec: AsrModelSpec) = AsrRuntimeStatus(
        selectedModelId = spec.id.catalogId,
        selectedModelName = spec.displayName,
        activeModelId = null,
        provider = spec.provider,
        running = false,
        initialized = false,
        initializationMs = null,
        firstTokenLatencyMs = null,
        utteranceLatencyMs = null,
        partialText = "",
        finalText = "",
        finalResults = emptyList(),
        error = null,
    )

    private fun emitState() {
        statusListener?.invoke(state)
    }

    companion object {
        private const val MAX_FINAL_RESULTS = 50
    }
}
