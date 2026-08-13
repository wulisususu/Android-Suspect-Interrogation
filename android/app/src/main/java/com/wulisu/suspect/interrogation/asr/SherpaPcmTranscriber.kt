package com.wulisu.suspect.interrogation.asr

import android.content.Context
import android.os.SystemClock
import com.k2fsa.sherpa.onnx.OnlineRecognizer
import com.k2fsa.sherpa.onnx.OnlineRecognizerConfig
import com.wulisu.suspect.interrogation.domain.BusinessException

internal object SherpaPcmTranscriber {
    private const val SAMPLE_RATE = 16_000
    private const val SAMPLES_PER_BATCH = 1_600

    fun transcribe(
        context: Context,
        spec: AsrModelSpec,
        config: OnlineRecognizerConfig,
        samples: ShortArray,
        sampleRate: Int,
    ): AsrFinalResult {
        if (sampleRate != SAMPLE_RATE) {
            throw BusinessException("ASR_PCM_SAMPLE_RATE_UNSUPPORTED", "离线 PCM 必须为 16kHz 单声道")
        }
        if (samples.isEmpty()) {
            throw BusinessException("ASR_PCM_EMPTY", "离线 PCM 不能为空")
        }
        verifyAssets(context, spec)
        loadNativeRuntime()

        val startedAtMs = System.currentTimeMillis()
        val startedElapsed = SystemClock.elapsedRealtime()
        val recognizer = try {
            OnlineRecognizer(assetManager = context.assets, config = config)
        } catch (error: Throwable) {
            throw BusinessException("ASR_PCM_TRANSCRIPTION_FAILED", error.message ?: "离线 PCM 识别初始化失败")
        }
        val stream = try {
            recognizer.createStream()
        } catch (error: Throwable) {
            recognizer.release()
            throw BusinessException("ASR_PCM_TRANSCRIPTION_FAILED", error.message ?: "离线 PCM stream 创建失败")
        }

        try {
            val textParts = mutableListOf<String>()
            val confidenceParts = mutableListOf<Double>()

            fun decodeReady() {
                while (recognizer.isReady(stream)) recognizer.decode(stream)
            }

            fun collectCurrent(reset: Boolean) {
                val result = recognizer.getResult(stream)
                result.text.trim().takeIf { it.isNotEmpty() }?.let(textParts::add)
                AsrConfidence.fromLogProbabilities(result.ysProbs)?.let(confidenceParts::add)
                if (reset) recognizer.reset(stream)
            }

            var offset = 0
            while (offset < samples.size) {
                val count = minOf(SAMPLES_PER_BATCH, samples.size - offset)
                val normalized = FloatArray(count) { index -> samples[offset + index] / 32768.0f }
                stream.acceptWaveform(normalized, sampleRate)
                decodeReady()
                if (recognizer.isEndpoint(stream)) collectCurrent(reset = true)
                offset += count
            }

            stream.inputFinished()
            decodeReady()
            collectCurrent(reset = false)

            return AsrFinalResult(
                text = textParts.joinToString(separator = "").trim(),
                startedAtMs = startedAtMs,
                endedAtMs = System.currentTimeMillis(),
                latencyMs = SystemClock.elapsedRealtime() - startedElapsed,
                confidence = confidenceParts.takeIf { it.isNotEmpty() }?.average(),
            )
        } catch (error: Throwable) {
            if (error is BusinessException) throw error
            throw BusinessException("ASR_PCM_TRANSCRIPTION_FAILED", error.message ?: "离线 PCM 识别失败")
        } finally {
            runCatching { stream.release() }
            runCatching { recognizer.release() }
        }
    }

    private fun verifyAssets(context: Context, spec: AsrModelSpec) {
        spec.requiredAssets.forEach { path ->
            runCatching {
                if (path.endsWith(".rknn") || path.endsWith(".onnx")) {
                    context.assets.openFd(path).use { check(it.length > 0L) }
                } else {
                    context.assets.open(path).use { check(it.read() >= 0) }
                }
            }.getOrElse { error ->
                throw BusinessException("ASR_MODEL_ASSET_MISSING", "无法读取模型文件 $path: ${error.message}")
            }
        }
    }

    @Synchronized
    private fun loadNativeRuntime() {
        if (nativeLoaded) return
        System.loadLibrary("rknnrt")
        System.loadLibrary("sherpa-onnx-jni")
        nativeLoaded = true
    }

    @Volatile
    private var nativeLoaded = false
}
