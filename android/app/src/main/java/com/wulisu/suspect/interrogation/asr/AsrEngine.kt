package com.wulisu.suspect.interrogation.asr

data class AsrStartMetrics(
    val initializationMs: Long,
)

data class AsrFinalResult(
    val text: String,
    val startedAtMs: Long,
    val endedAtMs: Long,
    val latencyMs: Long,
    val confidence: Double?,
)

interface AsrListener {
    fun onAudioSamples(samples: ShortArray, count: Int, sampleRate: Int, capturedAtMs: Long) = Unit
    fun onPartialResult(text: String, firstTokenLatencyMs: Long?)
    fun onFinalResult(result: AsrFinalResult)
    fun onError(code: String, message: String)
}

object NoopAsrListener : AsrListener {
    override fun onAudioSamples(samples: ShortArray, count: Int, sampleRate: Int, capturedAtMs: Long) = Unit
    override fun onPartialResult(text: String, firstTokenLatencyMs: Long?) = Unit
    override fun onFinalResult(result: AsrFinalResult) = Unit
    override fun onError(code: String, message: String) = Unit
}

interface AsrEngine {
    val spec: AsrModelSpec
    fun start(listener: AsrListener): AsrStartMetrics
    fun stop()
    fun release()
}

class AsrEngineSwitcher(
    private val factory: (AsrModelSpec) -> AsrEngine,
) {
    var currentEngine: AsrEngine? = null
        private set

    @Synchronized
    fun switchTo(spec: AsrModelSpec): AsrEngine {
        currentEngine?.takeIf { it.spec.id == spec.id }?.let { return it }
        currentEngine?.release()
        return factory(spec).also { currentEngine = it }
    }

    @Synchronized
    fun stop() {
        currentEngine?.stop()
    }

    @Synchronized
    fun release() {
        currentEngine?.release()
        currentEngine = null
    }
}
