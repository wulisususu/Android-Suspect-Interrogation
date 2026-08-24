package com.wulisu.suspect.interrogation.asr

import android.content.Context
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.data.CaseEntity
import com.wulisu.suspect.interrogation.data.SessionEntity
import com.wulisu.suspect.interrogation.service.AuditService
import com.wulisu.suspect.interrogation.service.CaseService
import com.wulisu.suspect.interrogation.service.InterrogationService
import com.wulisu.suspect.interrogation.service.RecordService
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class AsrCaptureFinalizationTest {
    private lateinit var context: Context
    private lateinit var db: AppDatabase
    private lateinit var manager: AsrCaptureSessionManager

    @Before
    fun setUp() = runBlocking {
        context = ApplicationProvider.getApplicationContext()
        db = Room.inMemoryDatabaseBuilder(context, AppDatabase::class.java).build()
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
        db.sessionDao().insert(
            SessionEntity(SESSION_ID, CASE_ID, "RUNNING", "IDENTITY", 1L, null, null, 1L),
        )
    }

    @After
    fun tearDown() {
        if (::manager.isInitialized) manager.close()
        db.close()
    }

    @Test
    fun stopPersistsFinalResultBeforeReturningAndIsIdempotent() = runBlocking {
        val runtime = FakeCaptureRuntime("停止时最终文字")
        manager = newManager(runtime)
        runtime.listener = manager

        val started = manager.start(CASE_ID)
        val stopped = manager.stop(CASE_ID)
        val stoppedAgain = manager.stop(CASE_ID)

        assertFalse(stopped.running)
        assertEquals(started.captureSessionId, stopped.captureSessionId)
        assertEquals(listOf("停止时最终文字"), stopped.fragments.map { it.editedText })
        assertEquals(1, db.asrTemporaryFragmentDao().listPending(started.captureSessionId!!).size)
        assertEquals(1, stoppedAgain.fragments.size)
    }

    @Test
    fun blankFinalResultDoesNotCreateFragment() = runBlocking {
        val runtime = FakeCaptureRuntime("   ")
        manager = newManager(runtime)
        runtime.listener = manager

        val started = manager.start(CASE_ID)
        val stopped = manager.stop(CASE_ID)

        assertEquals(emptyList<TemporaryAsrFragment>(), stopped.fragments)
        assertEquals(0, db.asrTemporaryFragmentDao().listPending(started.captureSessionId!!).size)
    }

    private fun newManager(runtime: AsrCaptureRuntime): AsrCaptureSessionManager {
        val audit = AuditService(db.auditDao())
        val cases = CaseService(db, audit)
        val sessions = InterrogationService(db, cases, audit)
        val records = RecordService(db, cases, sessions, audit)
        return AsrCaptureSessionManager(context, db, sessions, records, audit, runtime)
    }

    private class FakeCaptureRuntime(private val finalText: String) : AsrCaptureRuntime {
        lateinit var listener: AsrListener
        private var running = false

        override fun status() = AsrRuntimeStatus(
            selectedModelId = "ASR:asr/fake",
            selectedModelName = "Fake ASR",
            activeModelId = if (running) "ASR:asr/fake" else null,
            provider = "cpu",
            running = running,
            initialized = running,
            initializationMs = 0,
            firstTokenLatencyMs = null,
            utteranceLatencyMs = null,
            partialText = "",
            finalText = "",
            finalResults = emptyList(),
            error = null,
        )

        override fun start(): AsrRuntimeStatus {
            running = true
            return status()
        }

        override fun stop(): AsrRuntimeStatus {
            listener.onFinalResult(AsrFinalResult(finalText, 100L, 200L, 10L, 0.9))
            running = false
            return status()
        }
    }

    companion object {
        private const val CASE_ID = "case-finalization-test"
        private const val SESSION_ID = "session-finalization-test"
    }
}
