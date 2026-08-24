package com.wulisu.suspect.interrogation.asr

import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.data.AsrCaptureSessionEntity
import com.wulisu.suspect.interrogation.data.AsrTemporaryFragmentEntity
import com.wulisu.suspect.interrogation.data.CaseEntity
import com.wulisu.suspect.interrogation.data.SessionEntity
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.service.AuditService
import com.wulisu.suspect.interrogation.service.CaseService
import com.wulisu.suspect.interrogation.service.InterrogationService
import com.wulisu.suspect.interrogation.service.ModelManager
import com.wulisu.suspect.interrogation.service.RecordService
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotEquals
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class AsrFragmentConfirmationTest {
    private lateinit var db: AppDatabase
    private lateinit var asr: AsrController
    private lateinit var manager: AsrCaptureSessionManager
    private lateinit var records: RecordService

    @Before
    fun setUp() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()
        db = Room.inMemoryDatabaseBuilder(context, AppDatabase::class.java).build()
        val audit = AuditService(db.auditDao())
        val cases = CaseService(db, audit)
        val sessions = InterrogationService(db, cases, audit)
        records = RecordService(db, cases, sessions, audit)
        asr = AsrController(context, ModelManager(context))
        manager = AsrCaptureSessionManager(context, db, sessions, records, audit, asr)

        db.caseDao().insert(
            CaseEntity(
                id = CASE_ID,
                suspectName = "测试对象",
                gender = null,
                age = null,
                idNumber = null,
                nation = null,
                birthDate = null,
                address = null,
                identitySource = null,
                identityCapturedAt = null,
                officerName = "测试警官",
                state = "INTERROGATING",
                stage = "IDENTITY",
                createdAt = 1L,
                updatedAt = 1L,
            ),
        )
        db.sessionDao().insert(SessionEntity(SESSION_ID, CASE_ID, "RUNNING", "IDENTITY", 1L, null, null, 1L))
        db.asrCaptureSessionDao().insert(
            AsrCaptureSessionEntity(CAPTURE_ID, CASE_ID, SESSION_ID, "model", "Zipformer", "rknn", SHERPA_ONNX_VERSION, 16_000, "missing.wav", 1L, 2L, "STOPPED", null),
        )
    }

    @After
    fun tearDown() {
        manager.close()
        asr.release()
        db.close()
    }

    @Test
    fun confirmationIsIdempotentAndPreservesRawText() = runBlocking {
        insertFragment("fragment-1", 1, "原始 文本", "人工修订文本", "OFFICER")

        val first = manager.confirmFragment(CASE_ID, "fragment-1")
        val second = manager.confirmFragment(CASE_ID, "fragment-1")

        assertEquals(first.record.id, second.record.id)
        assertEquals("人工修订文本", first.record.text)
        assertEquals("民警", first.record.speaker)
        assertEquals(1, db.qaDao().list(CASE_ID).size)
        val stored = db.asrTemporaryFragmentDao().get(CASE_ID, "fragment-1")!!
        assertEquals("原始 文本", stored.rawText)
        assertEquals("CONFIRMED", stored.state)
        assertEquals(first.record.id, stored.confirmedQaId)
    }

    @Test
    fun batchConfirmationKeepsEarlierSuccessWhenLaterFragmentIsInvalid() = runBlocking {
        insertFragment("fragment-valid", 1, "有效回答", "有效回答", "SUSPECT")
        insertFragment("fragment-invalid", 2, "待指定", "待指定", "UNKNOWN")

        val result = manager.confirmBatch(CASE_ID, listOf("fragment-valid", "fragment-invalid"))

        assertEquals(1, result.confirmed.size)
        assertEquals(1, result.failures.size)
        assertEquals("fragment-invalid", result.failures.single().fragmentId)
        assertNotEquals("", result.failures.single().code)
        assertEquals(1, db.qaDao().list(CASE_ID).size)
        assertEquals("PENDING", db.asrTemporaryFragmentDao().get(CASE_ID, "fragment-invalid")!!.state)
    }

    @Test
    fun fragmentFromAnotherCaseCannotBeConfirmed() = runBlocking {
        insertFragment("fragment-foreign", 1, "A案回答", "A案回答", "SUSPECT")

        val error = runCatching { manager.confirmFragment("case-b", "fragment-foreign") }.exceptionOrNull() as com.wulisu.suspect.interrogation.domain.BusinessException

        assertEquals("ASR_FRAGMENT_NOT_FOUND", error.code)
        assertEquals("PENDING", db.asrTemporaryFragmentDao().get(CASE_ID, "fragment-foreign")!!.state)
        assertEquals(0, db.qaDao().list(CASE_ID).size)
    }

    @Test
    fun applyingFragmentsUpdatesOnlyTheTargetRecordAndConfirmsEveryFragment() = runBlocking {
        val target = records.add(CASE_ID, "嫌疑人于案发当晚", "嫌疑人")
        val other = records.add(CASE_ID, "另一条正式记录", "民警")
        insertFragment("fragment-1", 2, "经过", "经过", "UNKNOWN")
        insertFragment("fragment-2", 1, "说明", "说明", "UNKNOWN")

        val application = manager.applyFragmentsToRecord(
            caseId = CASE_ID,
            captureSessionId = CAPTURE_ID,
            fragmentIds = listOf("fragment-1", "fragment-2"),
            recordId = target.id,
            text = "嫌疑人于案发当晚说明经过",
            reason = "语音识别插入",
        )

        assertEquals(target.id, application.record.id)
        assertEquals("嫌疑人于案发当晚说明经过", application.record.text)
        assertEquals("另一条正式记录", db.qaDao().get(CASE_ID, other.id)!!.text)
        assertEquals(2, application.fragments.size)
        assertEquals("CONFIRMED", db.asrTemporaryFragmentDao().get(CASE_ID, "fragment-1")!!.state)
        assertEquals(target.id, db.asrTemporaryFragmentDao().get(CASE_ID, "fragment-1")!!.confirmedQaId)
        assertEquals(1, records.revisions(CASE_ID, target.id).size)
    }

    @Test
    fun applyingFragmentsRollsBackWhenAnyFragmentIsOutsideTheCapture() = runBlocking {
        val target = records.add(CASE_ID, "原始内容", "嫌疑人")
        insertFragment("fragment-valid", 1, "有效", "有效", "UNKNOWN")
        db.asrCaptureSessionDao().insert(
            AsrCaptureSessionEntity("other-capture", CASE_ID, SESSION_ID, "model", "Zipformer", "rknn", SHERPA_ONNX_VERSION, 16_000, "other.wav", 3L, 4L, "STOPPED", null),
        )
        insertFragment("fragment-foreign-capture", 2, "无效", "无效", "UNKNOWN", "other-capture")

        val error = runCatching {
            manager.applyFragmentsToRecord(
                caseId = CASE_ID,
                captureSessionId = CAPTURE_ID,
                fragmentIds = listOf("fragment-valid", "fragment-foreign-capture"),
                recordId = target.id,
                text = "原始内容有效无效",
                reason = "语音识别插入",
            )
        }.exceptionOrNull() as BusinessException

        assertEquals("ASR_FRAGMENT_CAPTURE_MISMATCH", error.code)
        assertEquals("原始内容", db.qaDao().get(CASE_ID, target.id)!!.text)
        assertEquals("PENDING", db.asrTemporaryFragmentDao().get(CASE_ID, "fragment-valid")!!.state)
        assertEquals(0, records.revisions(CASE_ID, target.id).size)
    }

    private suspend fun insertFragment(
        id: String,
        ordinal: Int,
        rawText: String,
        editedText: String,
        speaker: String,
        captureSessionId: String = CAPTURE_ID,
    ) {
        db.asrTemporaryFragmentDao().insert(
            AsrTemporaryFragmentEntity(
                id = id,
                captureSessionId = captureSessionId,
                caseId = CASE_ID,
                ordinal = ordinal,
                startedAtMs = ordinal * 1000L,
                endedAtMs = ordinal * 1000L + 800L,
                audioStartOffsetMs = ordinal * 1000L,
                audioEndOffsetMs = ordinal * 1000L + 800L,
                rawText = rawText,
                editedText = editedText,
                speaker = speaker,
                speakerSource = if (speaker == "UNKNOWN") "UNASSIGNED" else "MANUAL",
                confidence = 0.8,
                confidenceSource = "SHERPA_TOKEN_LOG_PROBS",
                state = "PENDING",
                confirmedQaId = null,
                createdAt = ordinal.toLong(),
                updatedAt = ordinal.toLong(),
            ),
        )
    }

    companion object {
        private const val CASE_ID = "case-asr-test"
        private const val SESSION_ID = "session-asr-test"
        private const val CAPTURE_ID = "capture-asr-test"
    }
}
