package com.wulisu.suspect.interrogation.asr

import android.content.Context
import android.util.Log
import androidx.room.withTransaction
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.data.AsrCaptureSessionEntity
import com.wulisu.suspect.interrogation.data.AsrTemporaryFragmentEntity
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.service.AuditService
import com.wulisu.suspect.interrogation.service.InterrogationService
import com.wulisu.suspect.interrogation.service.RecordService
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.asCoroutineDispatcher
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.io.File
import java.util.UUID
import java.util.concurrent.Executors

class AsrCaptureSessionManager(
    context: Context,
    private val db: AppDatabase,
    private val sessions: InterrogationService,
    private val records: RecordService,
    private val audit: AuditService,
    private val asr: AsrCaptureRuntime,
) : AsrListener {
    private val appContext = context.applicationContext
    private val captureDao = db.asrCaptureSessionDao()
    private val fragmentDao = db.asrTemporaryFragmentDao()
    private val dispatcher = Executors.newSingleThreadExecutor { runnable ->
        Thread(runnable, "asr-capture-store")
    }.asCoroutineDispatcher()
    private val scope = CoroutineScope(SupervisorJob() + dispatcher)
    private val activeLock = Any()

    @Volatile
    private var active: ActiveCapture? = null
    @Volatile
    private var statusListener: ((AsrCaptureStatus) -> Unit)? = null

    fun isRunning(): Boolean = active != null

    fun setStatusListener(listener: ((AsrCaptureStatus) -> Unit)?) {
        statusListener = listener
    }

    fun close() {
        statusListener = null
        scope.cancel()
        synchronized(activeLock) {
            runCatching { active?.writer?.close() }
            active = null
        }
        dispatcher.close()
    }

    suspend fun start(caseId: String): AsrCaptureStatus = withContext(dispatcher) {
        active?.let {
            if (it.entity.caseId != caseId) throw BusinessException("ASR_CAPTURE_BUSY", "另一案件正在连续录音")
            return@withContext it.snapshot()
        }
        val interrogationSession = sessions.activeRunning(caseId)
        if (appContext.filesDir.usableSpace < MIN_FREE_BYTES) {
            throw BusinessException("ASR_STORAGE_LOW", "可用存储空间不足 256 MB，无法开始连续录音")
        }

        captureDao.active(caseId)?.let { stale ->
            captureDao.update(stale.copy(state = CaptureSessionState.FAILED.name, endedAt = System.currentTimeMillis(), error = "应用进程中断"))
        }

        val runtime = asr.status()
        val captureId = UUID.randomUUID().toString()
        val relativePath = "asr-audio/${safePathSegment(caseId)}/$captureId/capture.wav"
        val writer = PcmWavWriter(File(appContext.filesDir, relativePath), runtime.sampleRate)
        val now = System.currentTimeMillis()
        val entity = AsrCaptureSessionEntity(
            id = captureId,
            caseId = caseId,
            interrogationSessionId = interrogationSession.id,
            modelId = runtime.selectedModelId,
            modelName = runtime.selectedModelName,
            provider = runtime.provider,
            sherpaVersion = runtime.sherpaVersion,
            sampleRate = runtime.sampleRate,
            audioRelativePath = relativePath,
            startedAt = now,
            endedAt = null,
            state = CaptureSessionState.RECORDING.name,
            error = null,
        )
        captureDao.insert(entity)
        val next = ActiveCapture(entity, writer, fragments = fragmentDao.list(caseId, false).toMutableList())
        synchronized(activeLock) { active = next }

        try {
            asr.start()
            audit.append(caseId, "ASR_CAPTURE_START", "ASR_CAPTURE", captureId, JSONObject().put("modelId", entity.modelId).put("provider", entity.provider))
            next.snapshot().also(::emit)
        } catch (error: Throwable) {
            synchronized(activeLock) { active = null }
            runCatching { writer.close() }
            captureDao.update(entity.copy(state = CaptureSessionState.FAILED.name, endedAt = System.currentTimeMillis(), error = error.message))
            throw error
        }
    }

    suspend fun stop(caseId: String): AsrCaptureStatus = withContext(dispatcher) {
        val current = synchronized(activeLock) {
            val value = active
            if (value != null && value.entity.caseId != caseId) throw BusinessException("ASR_CAPTURE_CASE_MISMATCH", "当前录音不属于此案件")
            value?.stopping = true
            value
        }
        if (current == null) return@withContext statusInternal(caseId)

        runCatching { current.writer.close() }.getOrElse { error ->
            Log.e(TAG, "Failed to finalize capture WAV", error)
        }
        asr.stop()
        persistPendingFinalResults(current)

        val endedAt = System.currentTimeMillis()
        val stopped = current.entity.copy(state = CaptureSessionState.STOPPED.name, endedAt = endedAt)
        captureDao.update(stopped)
        audit.append(caseId, "ASR_CAPTURE_STOP", "ASR_CAPTURE", stopped.id)
        synchronized(activeLock) {
            if (active === current) active = null
        }
        statusInternal(caseId).also(::emit)
    }

    suspend fun stopActive() {
        val caseId = active?.entity?.caseId ?: return
        stop(caseId)
    }

    suspend fun status(caseId: String): AsrCaptureStatus = withContext(dispatcher) {
        statusInternal(caseId)
    }

    suspend fun listFragments(caseId: String, includeConfirmed: Boolean): List<TemporaryAsrFragment> = withContext(dispatcher) {
        fragmentDao.list(caseId, includeConfirmed).map(::toDomain)
    }

    suspend fun updateFragment(caseId: String, fragmentId: String, editedText: String, speakerValue: String): TemporaryAsrFragment = withContext(dispatcher) {
        val current = fragmentDao.get(caseId, fragmentId)
            ?: throw BusinessException("ASR_FRAGMENT_NOT_FOUND", "临时片段不存在")
        if (current.state != TemporaryFragmentState.PENDING.name) {
            throw BusinessException("ASR_FRAGMENT_NOT_PENDING", "只有待确认片段可以修改")
        }
        val speaker = TemporarySpeaker.fromWire(speakerValue)
        val next = current.copy(
            editedText = editedText.trim(),
            speaker = speaker.name,
            speakerSource = if (speaker == TemporarySpeaker.UNKNOWN) SpeakerSource.UNASSIGNED.name else SpeakerSource.MANUAL.name,
            updatedAt = System.currentTimeMillis(),
        )
        fragmentDao.update(next)
        replaceActiveFragment(next)
        toDomain(next).also { emitActive() }
    }

    suspend fun confirmFragment(caseId: String, fragmentId: String): FragmentConfirmation = withContext(dispatcher) {
        confirmInternal(caseId, fragmentId).also { emitForCase(caseId) }
    }

    suspend fun confirmBatch(caseId: String, fragmentIds: List<String>): BatchFragmentConfirmation = withContext(dispatcher) {
        val confirmed = mutableListOf<FragmentConfirmation>()
        val failures = mutableListOf<FragmentConfirmationFailure>()
        fragmentIds.distinct().forEach { fragmentId ->
            try {
                confirmed += confirmInternal(caseId, fragmentId)
            } catch (error: BusinessException) {
                failures += FragmentConfirmationFailure(fragmentId, error.code, error.message)
            } catch (error: Throwable) {
                failures += FragmentConfirmationFailure(fragmentId, "INTERNAL_ERROR", error.message ?: "临时片段确认失败")
            }
        }
        emitForCase(caseId)
        BatchFragmentConfirmation(confirmed, failures)
    }

    suspend fun applyFragmentsToRecord(
        caseId: String,
        captureSessionId: String,
        fragmentIds: List<String>,
        recordId: String,
        text: String,
        reason: String,
    ): FragmentApplication = withContext(dispatcher) {
        val application = db.withTransaction {
            sessions.activeRunning(caseId)
            val ids = fragmentIds.distinct()
            if (ids.isEmpty()) throw BusinessException("ASR_FRAGMENT_REQUIRED", "请选择待写入的语音片段")
            val fragments = ids.map { fragmentId ->
                fragmentDao.get(caseId, fragmentId)
                    ?: throw BusinessException("ASR_FRAGMENT_NOT_FOUND", "临时片段不存在")
            }
            fragments.forEach { fragment ->
                if (fragment.captureSessionId != captureSessionId) {
                    throw BusinessException("ASR_FRAGMENT_CAPTURE_MISMATCH", "语音片段不属于当前录音会话")
                }
                if (fragment.state != TemporaryFragmentState.PENDING.name) {
                    throw BusinessException("ASR_FRAGMENT_NOT_PENDING", "只有待确认片段可以写入问答")
                }
            }
            val record = records.updateWithinTransaction(caseId, recordId, text, reason)
            val now = System.currentTimeMillis()
            val updated = fragments.map { fragment ->
                val next = fragment.copy(
                    state = TemporaryFragmentState.CONFIRMED.name,
                    confirmedQaId = record.id,
                    updatedAt = now,
                )
                fragmentDao.update(next)
                next
            }
            audit.append(
                caseId,
                "ASR_FRAGMENT_APPLY_TO_RECORD",
                "ASR_CAPTURE",
                captureSessionId,
                JSONObject().put("qaId", record.id).put("fragmentIds", ids),
            )
            FragmentApplication(updated.map(::toDomain), record)
        }
        application.fragments.forEach { removeActiveFragment(it.id) }
        emitForCase(caseId)
        application
    }

    suspend fun discardFragment(caseId: String, fragmentId: String): TemporaryAsrFragment = withContext(dispatcher) {
        val current = fragmentDao.get(caseId, fragmentId)
            ?: throw BusinessException("ASR_FRAGMENT_NOT_FOUND", "临时片段不存在")
        if (current.state != TemporaryFragmentState.PENDING.name) {
            throw BusinessException("ASR_FRAGMENT_NOT_PENDING", "只有待确认片段可以丢弃")
        }
        val next = current.copy(state = TemporaryFragmentState.DISCARDED.name, updatedAt = System.currentTimeMillis())
        fragmentDao.update(next)
        removeActiveFragment(next.id)
        toDomain(next).also { emitForCase(next.caseId) }
    }

    override fun onAudioSamples(samples: ShortArray, count: Int, sampleRate: Int, capturedAtMs: Long) {
        val current = synchronized(activeLock) { active?.takeUnless { it.stopping } } ?: return
        try {
            current.writer.append(samples, count)
        } catch (error: Throwable) {
            failFromCallback(current, "ASR_AUDIO_WRITE_FAILED", error.message ?: "录音文件写入失败")
        }
    }

    override fun onPartialResult(text: String, firstTokenLatencyMs: Long?) {
        val shouldEmit = synchronized(activeLock) {
            val current = active?.takeUnless { it.stopping }
            if (current == null) false else {
                current.partialText = text
                true
            }
        }
        if (shouldEmit) emitActive()
    }

    override fun onFinalResult(result: AsrFinalResult) {
        if (result.text.isBlank()) return
        synchronized(activeLock) {
            val current = active ?: return
            current.partialText = ""
            current.pendingFinalResults += result
        }
        emitActive()
    }

    override fun onError(code: String, message: String) {
        active?.let { failFromCallback(it, code, message) }
    }

    private suspend fun confirmInternal(caseId: String, fragmentId: String): FragmentConfirmation = db.withTransaction {
        val current = fragmentDao.get(caseId, fragmentId)
            ?: throw BusinessException("ASR_FRAGMENT_NOT_FOUND", "临时片段不存在")
        if (current.state == TemporaryFragmentState.CONFIRMED.name) {
            val qaId = current.confirmedQaId
                ?: throw BusinessException("ASR_FRAGMENT_CONFIRMATION_INVALID", "已确认片段缺少正式记录关联")
            val existing = records.getWithinTransaction(current.caseId, qaId)
                ?: throw BusinessException("QA_NOT_FOUND", "临时片段关联的正式问答不存在")
            return@withTransaction FragmentConfirmation(toDomain(current), existing)
        }
        if (current.state != TemporaryFragmentState.PENDING.name) {
            throw BusinessException("ASR_FRAGMENT_NOT_PENDING", "该临时片段已被丢弃")
        }
        val speaker = TemporarySpeaker.fromWire(current.speaker)
        val confirmable = CaptureFragmentRules.requireConfirmable(current.editedText, speaker)
        val record = records.addWithinTransaction(current.caseId, confirmable.text, confirmable.formalSpeaker)
        val next = current.copy(
            editedText = confirmable.text,
            state = TemporaryFragmentState.CONFIRMED.name,
            confirmedQaId = record.id,
            updatedAt = System.currentTimeMillis(),
        )
        fragmentDao.update(next)
        audit.append(current.caseId, "ASR_FRAGMENT_CONFIRM", "ASR_FRAGMENT", current.id, JSONObject().put("qaId", record.id))
        removeActiveFragment(next.id)
        FragmentConfirmation(toDomain(next), record)
    }

    private fun failFromCallback(current: ActiveCapture, code: String, message: String) {
        val removed = synchronized(activeLock) {
            if (active !== current) return
            active = null
            current
        }
        runCatching { removed.writer.close() }
        scope.launch {
            val failed = removed.entity.copy(state = CaptureSessionState.FAILED.name, endedAt = System.currentTimeMillis(), error = "$code: $message")
            captureDao.update(failed)
            audit.append(failed.caseId, "ASR_CAPTURE_FAILED", "ASR_CAPTURE", failed.id, JSONObject().put("code", code).put("message", message))
            asr.stop()
            statusInternal(failed.caseId).also(::emit)
        }
    }

    private suspend fun statusInternal(caseId: String): AsrCaptureStatus {
        active?.takeIf { it.entity.caseId == caseId }?.let { return it.snapshot() }
        val latest = captureDao.latest(caseId)
        if (latest?.state == CaptureSessionState.RECORDING.name) {
            val failed = latest.copy(state = CaptureSessionState.FAILED.name, endedAt = System.currentTimeMillis(), error = "应用进程中断")
            captureDao.update(failed)
            return statusFrom(caseId, failed, fragmentDao.list(caseId, false))
        }
        return statusFrom(caseId, latest, fragmentDao.list(caseId, false))
    }

    private fun statusFrom(caseId: String, session: AsrCaptureSessionEntity?, fragments: List<AsrTemporaryFragmentEntity>): AsrCaptureStatus =
        AsrCaptureStatus(
            caseId = caseId,
            captureSessionId = session?.id,
            running = session?.state == CaptureSessionState.RECORDING.name,
            startedAt = session?.startedAt,
            endedAt = session?.endedAt,
            modelId = session?.modelId,
            modelName = session?.modelName,
            provider = session?.provider,
            sampleRate = session?.sampleRate ?: 16_000,
            partialText = "",
            fragments = fragments.map(::toDomain),
            error = session?.error,
        )

    private fun ActiveCapture.snapshot(): AsrCaptureStatus = synchronized(activeLock) {
        AsrCaptureStatus(
            caseId = entity.caseId,
            captureSessionId = entity.id,
            running = true,
            startedAt = entity.startedAt,
            endedAt = null,
            modelId = entity.modelId,
            modelName = entity.modelName,
            provider = entity.provider,
            sampleRate = entity.sampleRate,
            partialText = partialText,
            fragments = fragments.map(::toDomain),
            error = null,
        )
    }

    private fun toDomain(entity: AsrTemporaryFragmentEntity): TemporaryAsrFragment = TemporaryAsrFragment(
        id = entity.id,
        captureSessionId = entity.captureSessionId,
        caseId = entity.caseId,
        ordinal = entity.ordinal,
        startedAtMs = entity.startedAtMs,
        endedAtMs = entity.endedAtMs,
        rawText = entity.rawText,
        editedText = entity.editedText,
        speaker = runCatching { TemporarySpeaker.valueOf(entity.speaker) }.getOrDefault(TemporarySpeaker.UNKNOWN),
        speakerSource = runCatching { SpeakerSource.valueOf(entity.speakerSource) }.getOrDefault(SpeakerSource.UNASSIGNED),
        confidence = entity.confidence,
        confidenceSource = runCatching { ConfidenceSource.valueOf(entity.confidenceSource) }.getOrDefault(ConfidenceSource.UNAVAILABLE),
        state = runCatching { TemporaryFragmentState.valueOf(entity.state) }.getOrDefault(TemporaryFragmentState.PENDING),
        confirmedQaId = entity.confirmedQaId,
        audio = CaptureAudioReference(
            captureSessionId = entity.captureSessionId,
            startOffsetMs = entity.audioStartOffsetMs,
            endOffsetMs = entity.audioEndOffsetMs,
            available = captureFile(entity.caseId, entity.captureSessionId).exists(),
        ),
        createdAt = entity.createdAt,
        updatedAt = entity.updatedAt,
    )

    private fun replaceActiveFragment(entity: AsrTemporaryFragmentEntity) {
        synchronized(activeLock) {
            val fragments = active?.takeIf { it.entity.caseId == entity.caseId }?.fragments ?: return
            val index = fragments.indexOfFirst { it.id == entity.id }
            if (index >= 0) fragments[index] = entity
        }
    }

    private fun removeActiveFragment(fragmentId: String) {
        synchronized(activeLock) { active?.fragments?.removeAll { it.id == fragmentId } }
    }

    private suspend fun emitForCase(caseId: String) {
        emit(statusInternal(caseId))
    }

    private suspend fun persistPendingFinalResults(current: ActiveCapture) {
        val results = synchronized(activeLock) {
            current.pendingFinalResults.toList().also { current.pendingFinalResults.clear() }
        }
        if (results.isEmpty()) return
        val entities = results.filter { it.text.isNotBlank() }.map { result ->
            val startOffset = (result.startedAtMs - current.entity.startedAt).coerceAtLeast(0L)
            val endOffset = (result.endedAtMs - current.entity.startedAt).coerceAtLeast(startOffset)
            AsrTemporaryFragmentEntity(
                id = UUID.randomUUID().toString(),
                captureSessionId = current.entity.id,
                caseId = current.entity.caseId,
                ordinal = current.nextOrdinal++,
                startedAtMs = result.startedAtMs,
                endedAtMs = result.endedAtMs,
                audioStartOffsetMs = startOffset,
                audioEndOffsetMs = endOffset,
                rawText = result.text.trim(),
                editedText = result.text.trim(),
                speaker = TemporarySpeaker.UNKNOWN.name,
                speakerSource = SpeakerSource.UNASSIGNED.name,
                confidence = result.confidence,
                confidenceSource = if (result.confidence == null) ConfidenceSource.UNAVAILABLE.name else ConfidenceSource.SHERPA_TOKEN_LOG_PROBS.name,
                state = TemporaryFragmentState.PENDING.name,
                confirmedQaId = null,
                createdAt = result.endedAtMs,
                updatedAt = result.endedAtMs,
            )
        }
        db.withTransaction {
            entities.forEach { entity -> fragmentDao.insert(entity) }
        }
        synchronized(activeLock) { current.fragments += entities }
    }

    private fun emitActive() {
        active?.snapshot()?.let(::emit)
    }

    private fun emit(status: AsrCaptureStatus) {
        statusListener?.invoke(status)
    }

    private fun captureFile(caseId: String, captureSessionId: String): File =
        File(appContext.filesDir, "asr-audio/${safePathSegment(caseId)}/$captureSessionId/capture.wav")

    private fun safePathSegment(value: String): String =
        value.replace(Regex("[^A-Za-z0-9._-]"), "_").replace("..", "_")

    private data class ActiveCapture(
        val entity: AsrCaptureSessionEntity,
        val writer: PcmWavWriter,
        var partialText: String = "",
        var nextOrdinal: Int = 1,
        var stopping: Boolean = false,
        val fragments: MutableList<AsrTemporaryFragmentEntity> = mutableListOf(),
        val pendingFinalResults: MutableList<AsrFinalResult> = mutableListOf(),
    )

    companion object {
        private const val TAG = "AsrCapture"
        private const val MIN_FREE_BYTES = 256L * 1024L * 1024L
    }
}
