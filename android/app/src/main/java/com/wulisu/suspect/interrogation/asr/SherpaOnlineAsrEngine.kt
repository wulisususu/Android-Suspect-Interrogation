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
                val stream = recognizer.createStream()
                this.stream = stream
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
                if (preferredInput != null && routedInput != null && AndroidAudioInputSelector.kind(routedInput) != AudioInputKind.BUILT_IN) {
                    throw BusinessException("ASR_AUDIO_ROUTE_FAILED", "系统未采用板载麦克风，实际路由为 ${AndroidAudioInputSelector.describe(routedInput)}")
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
                    { runAudioLoop(listener, recorder, recognizer, stream, preferredInput, routedInput) },
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
        stream: OnlineStream,
        preferredInput: AudioDeviceInfo?,
        initialRoutedInput: AudioDeviceInfo?,
    ) {
        Process.setThreadPriority(Process.THREAD_PRIORITY_AUDIO)
        val minBufferBytes = AudioRecord.getMinBufferSize(SAMPLE_RATE, CHANNEL_CONFIG, AUDIO_FORMAT)
        val samples = ShortArray(maxOf(minBufferBytes / 2, SAMPLES_PER_BATCH))
        var previousText = ""
        var windowStartedElapsed = SystemClock.elapsedRealtime()
        var speechStartedElapsed = 0L
        var speechStartedWall = 0L
        var firstTokenObserved = false
        val signalMonitor = PcmSignalMonitor(SAMPLE_RATE)
        var routedInput = initialRoutedInput
        var lastAudioStatus = AsrAudioInputStatus(
            preferredInput = AndroidAudioInputSelector.describe(preferredInput),
            routedInput = AndroidAudioInputSelector.describe(routedInput),
            routedInputKind = AndroidAudioInputSelector.kind(routedInput),
            peak = null,
            signalState = AudioSignalState.WAITING,
        )
        var lastAudioStatusAt = 0L

        fun decodeReady() {
            while (recognizer.isReady(stream)) {
                recognizer.decode(stream)
                val text = recognizer.getResult(stream).text.trim()
                if (text != previousText) {
                    val now = SystemClock.elapsedRealtime()
                    var firstTokenLatency: Long? = null
                    if (text.isNotEmpty() && !firstTokenObserved) {
                        firstTokenObserved = true
                        firstTokenLatency = now - speechStartedElapsed.takeIf { it > 0L }.let { it ?: windowStartedElapsed }
                    }
                    previousText = text
                    listener.onPartialResult(text, firstTokenLatency)
                }
            }
        }

        fun finalizeUtterance(reset: Boolean) {
            val recognizerResult = recognizer.getResult(stream)
            val text = recognizerResult.text.trim().ifEmpty { previousText }
            if (text.isNotEmpty()) {
                val endedElapsed = SystemClock.elapsedRealtime()
                val endedWall = System.currentTimeMillis()
                val startedElapsed = speechStartedElapsed.takeIf { it > 0L } ?: endedElapsed
                val startedWall = speechStartedWall.takeIf { it > 0L } ?: endedWall
                listener.onFinalResult(
                    AsrFinalResult(
                        text = text,
                        startedAtMs = startedWall,
                        endedAtMs = endedWall,
                        latencyMs = endedElapsed - startedElapsed,
                        confidence = AsrConfidence.fromLogProbabilities(recognizerResult.ysProbs),
                    ),
                )
            }
            if (reset) recognizer.reset(stream)
            previousText = ""
            speechStartedElapsed = 0L
            speechStartedWall = 0L
            firstTokenObserved = false
            windowStartedElapsed = SystemClock.elapsedRealtime()
        }

        try {
            while (recording.get()) {
                val count = recorder.read(samples, 0, samples.size, AudioRecord.READ_BLOCKING)
                if (count > 0) {
                    routedInput = recorder.routedDevice ?: routedInput
                    val routedKind = AndroidAudioInputSelector.kind(routedInput)
                    if (preferredInput != null && routedInput != null && routedKind != AudioInputKind.BUILT_IN) {
                        throw BusinessException("ASR_AUDIO_ROUTE_FAILED", "系统未采用板载麦克风，实际路由为 ${AndroidAudioInputSelector.describe(routedInput)}")
                    }
                    val signal = signalMonitor.accept(samples, count)
                    val audioStatus = AsrAudioInputStatus(
                        preferredInput = AndroidAudioInputSelector.describe(preferredInput),
                        routedInput = AndroidAudioInputSelector.describe(routedInput),
                        routedInputKind = routedKind,
                        peak = signal.peak,
                        signalState = signal.state,
                    )
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
                    if (speechStartedElapsed == 0L) {
                        val meanSquare = normalized.sumOf { sample -> (sample * sample).toDouble() } / count
                        if (meanSquare >= SPEECH_ACTIVITY_MEAN_SQUARE) {
                            speechStartedElapsed = SystemClock.elapsedRealtime()
                            speechStartedWall = System.currentTimeMillis()
                        }
                    }
                    stream.acceptWaveform(normalized, SAMPLE_RATE)
                    decodeReady()
                    if (recognizer.isEndpoint(stream)) finalizeUtterance(reset = true)
                } else if (count < 0 && recording.get()) {
                    throw IllegalStateException("AudioRecord.read failed: $count")
                }
            }

            stream.inputFinished()
            decodeReady()
            finalizeUtterance(reset = false)
        } catch (error: Throwable) {
            if (recording.get()) {
                Log.e(TAG, "ASR audio loop failed for ${spec.id.wireValue}", error)
                listener.onError(
                    (error as? BusinessException)?.code ?: "ASR_STREAM_FAILED",
                    error.message ?: "实时识别线程异常",
                )
            }
        } finally {
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
        private const val SAMPLE_RATE = 16_000
        private const val SAMPLES_PER_BATCH = 1_600
        private const val STOP_JOIN_TIMEOUT_MS = 5_000L
        private const val INTERRUPT_JOIN_TIMEOUT_MS = 1_000L
        private const val SPEECH_ACTIVITY_MEAN_SQUARE = 0.000225
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
