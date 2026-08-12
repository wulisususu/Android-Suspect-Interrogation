package com.wulisu.suspect.interrogation.llm

import android.os.SystemClock
import android.util.Log
import com.wulisu.suspect.interrogation.domain.BusinessException
import kotlinx.coroutines.asCoroutineDispatcher
import kotlinx.coroutines.withContext
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicBoolean

class RkllmEngine(
    override val modelSpec: LlmModelSpec,
    override val config: LlmGenerationConfig,
) : LlmEngine, RkllmNative.Callback {
    private val stateLock = Any()
    private val nativeDispatcher = Executors.newSingleThreadExecutor { task ->
        Thread(task, "rkllm-${modelSpec.id.hashCode()}").apply { isDaemon = true }
    }.asCoroutineDispatcher()
    private val released = AtomicBoolean(false)
    private val cancelRequested = AtomicBoolean(false)

    @Volatile
    private var handle = 0L
    @Volatile
    private var initializationMs = 0L
    @Volatile
    private var activeInput: LlmInput? = null
    @Volatile
    private var runStartedAt = 0L
    @Volatile
    private var firstTokenAt: Long? = null
    private val fragments = mutableListOf<String>()
    private val tokenIds = mutableListOf<Int>()
    private val accumulated = StringBuilder()

    override suspend fun initialize(): LlmInitializationMetrics = withContext(nativeDispatcher) {
        synchronized(stateLock) {
            if (handle != 0L) return@withContext LlmInitializationMetrics(initializationMs)
            if (released.get()) throw BusinessException("LLM_RELEASED", "LLM engine 已释放")
        }
        val startedAt = SystemClock.elapsedRealtime()
        val created = try {
            RkllmNative.create(modelSpec.absolutePath, config.maxContextLen, config.maxNewTokens, this@RkllmEngine)
        } catch (error: Throwable) {
            throw BusinessException("LLM_INITIALIZATION_FAILED", error.message ?: "RKLLM 初始化失败")
        }
        if (created == 0L) throw BusinessException("LLM_INITIALIZATION_FAILED", "rkllm_init 未返回有效 handle")
        synchronized(stateLock) {
            if (released.get()) {
                RkllmNative.destroy(created)
                throw BusinessException("LLM_RELEASED", "LLM engine 已释放")
            }
            handle = created
            initializationMs = SystemClock.elapsedRealtime() - startedAt
        }
        Log.i(TAG, "initialized model=${modelSpec.name} provider=${modelSpec.provider} size=${modelSpec.sizeBytes} runtime=$RKLLM_RUNTIME_VERSION ms=$initializationMs")
        LlmInitializationMetrics(initializationMs)
    }

    override suspend fun generate(input: LlmInput): LlmResult = withContext(nativeDispatcher) {
        val localHandle = synchronized(stateLock) {
            if (released.get() || handle == 0L) throw BusinessException("LLM_RELEASED", "LLM engine 未初始化或已释放")
            handle
        }
        synchronized(fragments) {
            fragments.clear()
            tokenIds.clear()
            accumulated.setLength(0)
        }
        activeInput = input
        cancelRequested.set(false)
        runStartedAt = SystemClock.elapsedRealtime()
        firstTokenAt = null
        val returnCode = try {
            RkllmNative.run(localHandle, input.prompt, input.role, input.config.maxNewTokens)
        } finally {
            activeInput = null
        }
        val wasCancelled = cancelRequested.getAndSet(false)
        val totalMs = SystemClock.elapsedRealtime() - runStartedAt
        val copiedFragments: List<String>
        val copiedTokens: List<Int>?
        synchronized(fragments) {
            copiedFragments = fragments.toList()
            copiedTokens = tokenIds.takeIf { it.isNotEmpty() }?.toList()
        }
        if (wasCancelled) {
            return@withContext LlmResult.cancelled(
                input = input,
                modelSpec = modelSpec,
                initializationMs = initializationMs,
                totalInferenceMs = totalMs,
                fragments = copiedFragments,
            )
        }
        if (returnCode != 0) {
            throw BusinessException("LLM_RUN_FAILED", "rkllm_run 返回错误码 $returnCode")
        }
        val firstMs = firstTokenAt?.minus(runStartedAt)
        Log.i(TAG, "generated model=${modelSpec.name} provider=${modelSpec.provider} firstMs=$firstMs totalMs=$totalMs fragments=${copiedFragments.size}")
        LlmResult.success(
            input = input,
            modelSpec = modelSpec,
            initializationMs = initializationMs,
            firstTokenLatencyMs = firstMs,
            totalInferenceMs = totalMs,
            fragments = copiedFragments,
            tokenIds = copiedTokens,
        )
    }

    override suspend fun cancel() {
        val localHandle = handle
        if (localHandle != 0L && activeInput != null) {
            cancelRequested.set(true)
            RkllmNative.abort(localHandle)
        }
    }

    override fun release() {
        if (!released.compareAndSet(false, true)) return
        val localHandle = synchronized(stateLock) {
            handle.also { handle = 0L }
        }
        if (localHandle != 0L) {
            cancelRequested.set(true)
            runCatching { RkllmNative.abort(localHandle) }
            runCatching { RkllmNative.destroy(localHandle) }
                .onFailure { Log.e(TAG, "rkllm_destroy failed for ${modelSpec.name}", it) }
        }
        nativeDispatcher.close()
    }

    override fun onNativeFragment(text: String, tokenId: Int, state: Int) {
        val input = activeInput ?: return
        if (state == STATE_ERROR) return
        if (text.isEmpty()) return
        val now = SystemClock.elapsedRealtime()
        if (firstTokenAt == null) firstTokenAt = now
        val snapshot = synchronized(fragments) {
            fragments += text
            if (tokenId >= 0) tokenIds += tokenId
            accumulated.append(text)
            accumulated.toString()
        }
        input.fragmentListener?.invoke(
            LlmFragment(
                generationId = input.generationId,
                text = text,
                accumulatedText = snapshot,
                tokenId = tokenId.takeIf { it >= 0 },
                elapsedMs = now - runStartedAt,
            ),
        )
    }

    companion object {
        private const val TAG = "OfflineRKLLM"
        private const val STATE_ERROR = 3
    }
}
