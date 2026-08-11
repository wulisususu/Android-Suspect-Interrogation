package com.wulisu.suspect.interrogation.asr

import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.data.AsrCaptureSessionEntity
import com.wulisu.suspect.interrogation.data.AsrTemporaryFragmentEntity
import com.wulisu.suspect.interrogation.data.CaseEntity
import com.wulisu.suspect.interrogation.data.SessionEntity
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

    @Before
    fun setUp() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()
        db = Room.inMemoryDatabaseBuilder(context, AppDatabase::class.java).build()
        val audit = AuditService(db.auditDao())
        val cases = CaseService(db, audit)
        val sessions = InterrogationService(db, cases, audit)
        val records = RecordService(db, cases, sessions, audit)
        asr = AsrController(context, ModelManager(context))
        manager = AsrCaptureSessionManager(context, db, sessions, records, audit, asr)

        db.caseDao().insert(CaseEntity(CASE_ID, "测试对象", null, null, "测试警官", "INTERROGATING", "IDENTITY", 1L, 1L))
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

        val first = manager.confirmFragment("fragment-1")
        val second = manager.confirmFragment("fragment-1")

        assertEquals(first.record.id, second.record.id)
        assertEquals("人工修订文本", first.record.text)
        assertEquals("民警", first.record.speaker)
        assertEquals(1, db.qaDao().list(CASE_ID).size)
        val stored = db.asrTemporaryFragmentDao().get("fragment-1")!!
        assertEquals("原始 文本", stored.rawText)
        assertEquals("CONFIRMED", stored.state)
        assertEquals(first.record.id, stored.confirmedQaId)
    }

    @Test
    fun batchConfirmationKeepsEarlierSuccessWhenLaterFragmentIsInvalid() = runBlocking {
        insertFragment("fragment-valid", 1, "有效回答", "有效回答", "SUSPECT")
        insertFragment("fragment-invalid", 2, "待指定", "待指定", "UNKNOWN")

        val result = manager.confirmBatch(listOf("fragment-valid", "fragment-invalid"))

        assertEquals(1, result.confirmed.size)
        assertEquals(1, result.failures.size)
        assertEquals("fragment-invalid", result.failures.single().fragmentId)
        assertNotEquals("", result.failures.single().code)
        assertEquals(1, db.qaDao().list(CASE_ID).size)
        assertEquals("PENDING", db.asrTemporaryFragmentDao().get("fragment-invalid")!!.state)
    }

    private suspend fun insertFragment(id: String, ordinal: Int, rawText: String, editedText: String, speaker: String) {
        db.asrTemporaryFragmentDao().insert(
            AsrTemporaryFragmentEntity(
                id = id,
                captureSessionId = CAPTURE_ID,
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
