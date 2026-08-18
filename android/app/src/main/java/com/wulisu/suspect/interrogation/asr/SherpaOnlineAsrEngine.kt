package com.wulisu.suspect.interrogation.asr

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.media.AudioDeviceInfo
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Process
import android.os.SystemClock
import android.util.Log
import androidx.core.content.ContextCompat
import com.k2fsa.sherpa.onnx.OnlineRecognizer
import com.k2fsa.sherpa.onnx.OnlineRecognizerConfig
import com.k2fsa.sherpa.onnx.OnlineStream
import com.k2fsa.sherpa.onnx.VersionInfo
import com.wulisu.suspect.interrogation.domain.BusinessException
import java.util.concurrent.atomic.AtomicBoolean

abstract class SherpaOnlineAsrEngine(
    protected val context: Context,
    final override val spec: AsrModelSpec,
) : AsrEngine, PcmTranscribableAsrEngine {
    private val resourceLock = Any()
    private val recording = AtomicBoolean(false)
    private val audioInputSelector = AndroidAudioInputSelector(context)

    @Volatile
    private var recognizer: OnlineRecognizer? = null
    @Volatile
    private var stream: OnlineStream? = null
    @Volatile
    private var audioRecord: AudioRecord? = null
    @Volatile
    private var audioThread: Thread? = null

    protected abstract fun recognizerConfig(): OnlineRecognizerConfig

    @SuppressLint("MissingPermission")
    override fun start(listener: AsrListener): AsrStartMetrics {
        synchronized(resourceLock) {
            if (recording.get()) throw BusinessException("ASR_ALREADY_RUNNING", "实时识别已经在运行")
            if (ContextCompat.checkSelfPermission(context, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                throw BusinessException("ASR_MICROPHONE_PERMISSION_REQUIRED", "需要麦克风权限才能开始实时识别")
            }
            verifyAssets()
            SherpaNativeRuntime.ensureLoaded()

            val initializationStarted = SystemClock.elapsedRealtime()
            logModelConfiguration()
            try {
                val recognizer = OnlineRecognizer(config = recognizerConfig())
                this.recognizer = recognizer
                // No long-lived main stream: the RKNN provider on this device never reports
                // isReady() while a stream is fed incrementally, so the audio loop decodes
                // each accumulated window as a finished utterance on a fresh per-segment stream.
                val preferredInput = audioInputSelector.selectPreferred()
                val recorder = createAudioRecord(preferredInput)
                this.audioRecord = recorder
                val initializationMs = SystemClock.elapsedRealtime() - initializationStarted

                recording.set(true)
                recorder.startRecording()
                if (recorder.recordingState != AudioRecord.RECORDSTATE_RECORDING) {
                    throw BusinessException("ASR_AUDIO_START_FAILED", "麦克风未进入录音状态")
                }
                val routedInput = recorder.routedDevice
                val preferredKind = AndroidAudioInputSelector.kind(preferredInput)
                if (preferredInput != null && routedInput != null && preferredKind != null &&
                    AndroidAudioInputSelector.kind(routedInput) != preferredKind
                ) {
                    throw BusinessException("ASR_AUDIO_ROUTE_FAILED", "系统未采用所选麦克风，实际路由为 ${AndroidAudioInputSelector.describe(routedInput)}")
                }
                val initialAudioStatus = AsrAudioInputStatus(
                    preferredInput = AndroidAudioInputSelector.describe(preferredInput),
                    routedInput = AndroidAudioInputSelector.describe(routedInput),
                    routedInputKind = AndroidAudioInputSelector.kind(routedInput),
                    peak = null,
                    signalState = AudioSignalState.WAITING,
                )
                listener.onAudioInputStatus(initialAudioStatus)

                val thread = Thread(
                    { runAudioLoop(listener, recorder, recognizer, preferredInput, routedInput) },
                    "offline-asr-${spec.id.wireValue}",
                )
                audioThread = thread
                thread.start()
                Log.i(
                    TAG,
                    "ASR initialized model=${spec.id.wireValue} provider=${spec.provider} initMs=$initializationMs " +
                        "sherpa=${VersionInfo.version} preferredInput=${initialAudioStatus.preferredInput} routedInput=${initialAudioStatus.routedInput}",
                )
                return AsrStartMetrics(initializationMs)
            } catch (error: Throwable) {
                recording.set(false)
                cleanupResources()
                if (error is BusinessException) throw error
                throw BusinessException("ASR_INITIALIZATION_FAILED", error.message ?: "ASR 模型初始化失败")
            }
        }
    }

    override fun transcribePcm(input: AsrPcmInput): AsrFinalResult {
        require(input.sampleRate > 0) { "sampleRate must be positive" }
        require(input.samples.isNotEmpty()) { "PCM samples must not be empty" }
        synchronized(resourceLock) {
            if (recording.get()) throw BusinessException("ASR_ALREADY_RUNNING", "实时识别运行时不能执行离线 PCM smoke")
        }

        verifyAssets()
        SherpaNativeRuntime.ensureLoaded()
        logModelConfiguration()

        val startedElapsed = SystemClock.elapsedRealtime()
        val startedWall = System.currentTimeMillis()
        val localRecognizer = try {
            OnlineRecognizer(config = recognizerConfig())
        } catch (error: Throwable) {
            throw BusinessException("ASR_INITIALIZATION_FAILED", error.message ?: "ASR 模型初始化失败")
        }
        val localStream = localRecognizer.createStream()
        return try {
            localStream.acceptWaveform(input.samples, input.sampleRate)
            localStream.inputFinished()
            while (localRecognizer.isReady(localStream)) {
                localRecognizer.decode(localStream)
            }
            val recognizerResult = localRecognizer.getResult(localStream)
            val endedWall = System.currentTimeMillis()
            AsrFinalResult(
                text = recognizerResult.text.trim(),
                startedAtMs = startedWall,
                endedAtMs = endedWall,
                latencyMs = SystemClock.elapsedRealtime() - startedElapsed,
                confidence = AsrConfidence.fromLogProbabilities(recognizerResult.ysProbs),
            )
        } finally {
            runCatching { localStream.release() }
            runCatching { localRecognizer.release() }
        }
    }

    override fun stop() {
        recording.set(false)
        runCatching { audioRecord?.stop() }
        val thread = audioThread
        if (thread != null && thread !== Thread.currentThread()) {
            runCatching { thread.join(STOP_JOIN_TIMEOUT_MS) }
            if (thread.isAlive) {
                Log.w(TAG, "ASR audio thread did not stop within ${STOP_JOIN_TIMEOUT_MS}ms; interrupting")
                thread.interrupt()
                runCatching { thread.join(INTERRUPT_JOIN_TIMEOUT_MS) }
            }
            if (thread.isAlive) {
                Log.e(TAG, "ASR audio thread is still active; resources will be released by the thread")
                return
            }
        }
        cleanupResources()
    }

    override fun release() {
        stop()
    }

    private fun runAudioLoop(
        listener: AsrListener,
        recorder: AudioRecord,
        recognizer: OnlineRecognizer,
        preferredInput: AudioDeviceInfo?,
        initialRoutedInput: AudioDeviceInfo?,
    ) {
        Process.setThreadPriority(Process.THREAD_PRIORITY_AUDIO)
        val minBufferBytes = AudioRecord.getMinBufferSize(SAMPLE_RATE, CHANNEL_CONFIG, AUDIO_FORMAT)
        val samples = ShortArray(maxOf(minBufferBytes / 2, SAMPLES_PER_BATCH))
        val signalMonitor = PcmSignalMonitor(SAMPLE_RATE, silenceWindowSeconds = SILENT_ABORT_SECONDS)
        var routedInput = initialRoutedInput
        var lastAudioStatus = AsrAudioInputStatus(
            preferredInput = AndroidAudioInputSelector.describe(preferredInput),
            routedInput = AndroidAudioInputSelector.describe(routedInput),
            routedInputKind = AndroidAudioInputSelector.kind(routedInput),
            peak = null,
            signalState = AudioSignalState.WAITING,
        )
        var lastAudioStatusAt = 0L
        var lastDiagnosticAt = 0L

        // Segment-as-offline pipeline. RKNN Zipformer in this sherpa-onnx build never
        // reports isReady() while a stream is fed incrementally (streaming path dead),
        // but it decodes correctly once inputFinished() has been called. So we accumulate
        // audio into fixed windows and decode each window as a finished utterance on a
        // fresh stream, from a dedicated decoder thread so recording never blocks.
        val segmentBuffer = FloatArray(SEGMENT_SAMPLES)
        var segmentFilled = 0
        val segments = java.util.concurrent.LinkedBlockingQueue<FloatArray>()
        val transcript = StringBuilder()
        val decodeRunning = AtomicBoolean(true)
        val startedElapsed = SystemClock.elapsedRealtime()
        val startedWall = System.currentTimeMillis()

        fun normalizeSegment(src: FloatArray): FloatArray {
            var peak = 0f
            var sumSq = 0.0
            for (s in src) {
                val a = if (s < 0f) -s else s
                if (a > peak) peak = a
                sumSq += (s * s).toDouble()
            }
            val rms = kotlin.math.sqrt(sumSq / src.size).toFloat()
            // Loudness normalization: bring quiet input (this device's mic returns only a
            // few % of full scale for real speech) up to a decodable level. Whisper tolerates
            // low levels; zipformer/paraformer here decode effectively only above ~12-50% FS.
            val gain = if (rms > 0f) {
                minOf(NORMALIZE_MAX_GAIN, NORMALIZE_CEILING / peak, NORMALIZE_TARGET_RMS / rms)
            } else 0f
            val normalized = FloatArray(src.size) { i -> src[i] * gain }
            Log.i(
                OHASR_TAG,
                "segment level: rawPeak=${(peak * 32768f).toInt()} rawRmsDbfs=${(20.0 * kotlin.math.log10(rms.toDouble() + 1e-9)).toInt()}dB" +
                    " gain=${"%.1f".format(gain)} outPeak=${(peak * gain * 32768f).toInt()}",
            )
            return normalized
        }

        fun decodeSegment(rawSamples: FloatArray) {
            val normalized = normalizeSegment(rawSamples)
            val segStream = recognizer.createStream()
            try {
                segStream.acceptWaveform(normalized, SAMPLE_RATE)
                segStream.inputFinished()
                var text = ""
                while (recognizer.isReady(segStream)) {
                    recognizer.decode(segStream)
                    text = recognizer.getResult(segStream).text.trim()
                }
                if (text.isNotEmpty()) {
                    transcript.append(text)
                    val cumulative = transcript.toString()
                    listener.onPartialResult(cumulative, null)
                    Log.i(OHASR_TAG, "segment: '$text' cumulative='${cumulative.take(96)}'")
                } else {
                    Log.d(OHASR_TAG, "segment decoded empty (${rawSamples.size / SAMPLE_RATE}s window)")
                }
            } finally {
                runCatching { segStream.release() }
            }
        }

        val decodeThread = Thread(
            {
                while (decodeRunning.get() || !segments.isEmpty()) {
                    val segment = segments.poll(200, java.util.concurrent.TimeUnit.MILLISECONDS) ?: continue
                    runCatching { decodeSegment(segment) }
                        .onFailure { Log.e(OHASR_TAG, "segment decode failed", it) }
                }
                Log.i(OHASR_TAG, "decoder thread finished")
            },
            "offline-asr-seg-${spec.id.wireValue}",
        ).apply { start() }

        try {
            while (recording.get()) {
                val count = recorder.read(samples, 0, samples.size, AudioRecord.READ_BLOCKING)
                if (count > 0) {
                    routedInput = recorder.routedDevice ?: routedInput
                    val routedKind = AndroidAudioInputSelector.kind(routedInput)
                    val preferredKind = AndroidAudioInputSelector.kind(preferredInput)
                    if (preferredInput != null && routedInput != null && preferredKind != null && routedKind != preferredKind) {
                        throw BusinessException("ASR_AUDIO_ROUTE_FAILED", "系统未采用所选麦克风，实际路由为 ${AndroidAudioInputSelector.describe(routedInput)}")
                    }
                    val signal = signalMonitor.accept(samples, count)
                    val audioStatus = AsrAudioInputStatus(
                        preferredInput = AndroidAudioInputSelector.describe(preferredInput),
                        routedInput = AndroidAudioInputSelector.describe(routedInput),
                        routedInputKind = routedKind,
                        peak = signal.peak,
                        signalState = signal.state,
                    )
                    if (SystemClock.elapsedRealtime() - lastDiagnosticAt >= DIAGNOSTIC_INTERVAL_MS) {
                        lastDiagnosticAt = SystemClock.elapsedRealtime()
                        Log.i(
                            OHASR_TAG,
                            "audio peak=${signal.peak} state=${signal.state} routed=${AndroidAudioInputSelector.describe(routedInput)} " +
                                "queued=${segments.size} cumulative='${transcript.takeLast(48)}'",
                        )
                    }
                    val now = SystemClock.elapsedRealtime()
                    if (
                        audioStatus.signalState != lastAudioStatus.signalState ||
                        audioStatus.routedInput != lastAudioStatus.routedInput ||
                        now - lastAudioStatusAt >= AUDIO_STATUS_INTERVAL_MS
                    ) {
                        listener.onAudioInputStatus(audioStatus)
                        lastAudioStatus = audioStatus
                        lastAudioStatusAt = now
                    }
                    if (signal.state == AudioSignalState.SILENT && routedKind != AudioInputKind.BUILT_IN) {
                        throw BusinessException(
                            "ASR_AUDIO_NO_SIGNAL",
                            "当前输入 ${audioStatus.routedInput ?: "未知设备"} 连续 3 秒无有效声音，请检查 USB audio-service 或板载麦克风路由",
                        )
                    }
                    listener.onAudioSamples(samples, count, SAMPLE_RATE, System.currentTimeMillis())
                    val normalized = FloatArray(count) { index -> samples[index] / 32768.0f }
                    // accumulate into the current segment window (v1: fixed windows, no overlap)
                    val copyLen = minOf(count, segmentBuffer.size - segmentFilled)
                    System.arraycopy(normalized, 0, segmentBuffer, segmentFilled, copyLen)
                    segmentFilled += copyLen
                    if (segmentFilled >= segmentBuffer.size) {
                        segments.offer(segmentBuffer.copyOf())
                        segmentFilled = 0
                    }
                } else if (count < 0 && recording.get()) {
                    throw IllegalStateException("AudioRecord.read failed: $count")
                }
            }
        } catch (error: Throwable) {
            if (recording.get()) {
                Log.e(TAG, "ASR audio loop failed for ${spec.id.wireValue}", error)
                listener.onError(
                    (error as? BusinessException)?.code ?: "ASR_STREAM_FAILED",
                    error.message ?: "实时识别线程异常",
                )
            }
        } finally {
            // flush the remaining tail as a final short segment, then let the decoder drain
            if (segmentFilled > 0) {
                segments.offer(segmentBuffer.copyOf(segmentFilled))
                segmentFilled = 0
            }
            decodeRunning.set(false)
            runCatching { decodeThread.join(DECODER_JOIN_TIMEOUT_MS) }
            val transcriptText = transcript.toString()
            if (transcriptText.isNotEmpty()) {
                listener.onFinalResult(
                    AsrFinalResult(
                        text = transcriptText,
                        startedAtMs = startedWall,
                        endedAtMs = System.currentTimeMillis(),
                        latencyMs = SystemClock.elapsedRealtime() - startedElapsed,
                        confidence = null,
                    ),
                )
                Log.i(OHASR_TAG, "final: '$transcriptText'")
            }
            recording.set(false)
            cleanupResources()
        }
    }

    @SuppressLint("MissingPermission")
    private fun createAudioRecord(preferredInput: AudioDeviceInfo?): AudioRecord {
        val minBufferBytes = AudioRecord.getMinBufferSize(SAMPLE_RATE, CHANNEL_CONFIG, AUDIO_FORMAT)
        if (minBufferBytes <= 0) throw BusinessException("ASR_AUDIO_FORMAT_UNSUPPORTED", "设备不支持 16kHz 单声道 PCM 录音")
        val bufferBytes = maxOf(minBufferBytes * 2, SAMPLES_PER_BATCH * 2)
        val recorder = AudioRecord.Builder()
            .setAudioSource(MediaRecorder.AudioSource.VOICE_RECOGNITION)
            .setAudioFormat(
                AudioFormat.Builder()
                    .setEncoding(AUDIO_FORMAT)
                    .setSampleRate(SAMPLE_RATE)
                    .setChannelMask(CHANNEL_CONFIG)
                    .build(),
            )
            .setBufferSizeInBytes(bufferBytes)
            .build()
        if (preferredInput != null && !recorder.setPreferredDevice(preferredInput)) {
            recorder.release()
            throw BusinessException("ASR_AUDIO_ROUTE_FAILED", "无法切换到板载麦克风 ${AndroidAudioInputSelector.describe(preferredInput)}")
        }
        if (recorder.state != AudioRecord.STATE_INITIALIZED) {
            recorder.release()
            throw BusinessException("ASR_AUDIO_INITIALIZATION_FAILED", "麦克风初始化失败")
        }
        return recorder
    }

    private fun verifyAssets() {
        spec.requiredFiles.forEach { path ->
            val file = java.io.File(path)
            if (!file.isFile || !file.canRead() || file.length() <= 0L) {
                throw BusinessException("ASR_MODEL_FILE_MISSING", "无法读取模型文件 $path")
            }
        }
    }

    private fun logModelConfiguration() {
        val files = spec.requiredFiles.joinToString(separator = ",")
        Log.i(TAG, "Loading ASR model=${spec.id.wireValue} provider=${spec.provider} modelType=${spec.modelType} files=$files")
    }

    private fun cleanupResources() {
        synchronized(resourceLock) {
            runCatching { stream?.release() }
            stream = null
            runCatching { recognizer?.release() }
            recognizer = null
            runCatching { audioRecord?.release() }
            audioRecord = null
            if (audioThread === Thread.currentThread() || audioThread?.isAlive != true) audioThread = null
        }
    }

    companion object {
        private const val TAG = "OfflineAsr"
        private const val OHASR_TAG = "OhASR"
        private const val SAMPLE_RATE = 16_000
        private const val SAMPLES_PER_BATCH = 1_600
        private const val STOP_JOIN_TIMEOUT_MS = 40_000L
        private const val DECODER_JOIN_TIMEOUT_MS = 35_000L
        private const val INTERRUPT_JOIN_TIMEOUT_MS = 1_000L
        private const val DIAGNOSTIC_INTERVAL_MS = 5_000L
        private const val SEGMENT_SAMPLES = 128_000 // 8 seconds of 16 kHz audio per decode window
        // Interrogation flow has pauses longer than 3s; only abort when the (now preferred
        // USB) mic shows true silence for a long stretch - typically a detached/broken mic.
        private const val SILENT_ABORT_SECONDS = 20
        private const val NORMALIZE_CEILING = 0.95f
        private const val NORMALIZE_MAX_GAIN = 64f
        private const val NORMALIZE_TARGET_RMS = 0.05f // ~-26 dBFS target loudness
        private const val AUDIO_STATUS_INTERVAL_MS = 500L
        private const val CHANNEL_CONFIG = AudioFormat.CHANNEL_IN_MONO
        private const val AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT
    }
}

private object SherpaNativeRuntime {
    @Volatile
    private var loaded = false

    @Synchronized
    fun ensureLoaded() {
        if (loaded) return
        System.loadLibrary("rknnrt")
        System.loadLibrary("sherpa-onnx-jni")
        loaded = true
    }
}
