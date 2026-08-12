package com.wulisu.suspect.interrogation.data

import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.service.AuditService
import com.wulisu.suspect.interrogation.service.AiProviderKind
import com.wulisu.suspect.interrogation.service.AiResponse
import com.wulisu.suspect.interrogation.service.CaseAiService
import com.wulisu.suspect.interrogation.service.CaseService
import com.wulisu.suspect.interrogation.service.FactService
import com.wulisu.suspect.interrogation.service.InterrogationService
import com.wulisu.suspect.interrogation.service.RecordService
import com.wulisu.suspect.interrogation.service.RoomCaseAiContextSource
import com.wulisu.suspect.interrogation.service.TimelineService
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class CaseIsolationTest {
    @Test
    fun readingUnknownCaseDoesNotCreateIt() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()
        val db = Room.inMemoryDatabaseBuilder(context, AppDatabase::class.java).build()
        try {
            val audit = AuditService(db.auditDao())
            val cases = CaseService(db, audit)
            val sessions = InterrogationService(db, cases, audit)
            val records = RecordService(db, cases, sessions, audit)

            val error = runCatching { records.list("missing-case") }.exceptionOrNull() as BusinessException

            assertEquals("CASE_NOT_FOUND", error.code)
            assertNull(db.caseDao().get("missing-case"))
        } finally {
            db.close()
        }
    }

    @Test
    fun caseAiReadsAndPersistsOnlyTheExplicitCase() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()
        val db = Room.inMemoryDatabaseBuilder(context, AppDatabase::class.java).build()
        try {
            val audit = AuditService(db.auditDao())
            val cases = CaseService(db, audit)
            val sessions = InterrogationService(db, cases, audit)
            val records = RecordService(db, cases, sessions, audit)
            val source = RoomCaseAiContextSource(
                cases,
                records,
                FactService(db.factDao(), cases),
                TimelineService(db.timelineDao(), cases, audit),
                db.aiCaseAnalysisDao(),
                audit,
            )
            val prompts = mutableListOf<String>()
            val caseAi = CaseAiService(source, generator = { messages ->
                val prompt = messages.joinToString("\n") { it.content }
                prompts += prompt
                AiResponse("analysis-${prompts.size}", AiProviderKind.LOCAL, "test-model")
            })
            cases.create(requestedId = "CASE-A", suspectName = "对象A")
            cases.create(requestedId = "CASE-B", suspectName = "对象B")
            val insufficient = runCatching { caseAi.analyze("CASE-A") }.exceptionOrNull() as BusinessException
            assertEquals("CASE_AI_INSUFFICIENT_DATA", insufficient.code)
            assertTrue(prompts.isEmpty())
            sessions.start("CASE-A")
            sessions.start("CASE-B")
            records.add("CASE-A", "A案问题", "民警")
            records.add("CASE-A", "A案回答", "嫌疑人")
            records.add("CASE-B", "B案问题", "民警")
            records.add("CASE-B", "B案回答", "嫌疑人")

            caseAi.analyze("CASE-A")
            caseAi.analyze("CASE-B")

            assertTrue(prompts[0].contains("CASE-A"))
            assertTrue(prompts[0].contains("A案回答"))
            assertFalse(prompts[0].contains("CASE-B"))
            assertFalse(prompts[0].contains("B案回答"))
            assertTrue(prompts[1].contains("CASE-B"))
            assertTrue(prompts[1].contains("B案回答"))
            assertFalse(prompts[1].contains("CASE-A"))
            assertFalse(prompts[1].contains("A案回答"))
            assertEquals(listOf("CASE-A"), caseAi.list("CASE-A").map { it.caseId })
            assertEquals(listOf("CASE-B"), caseAi.list("CASE-B").map { it.caseId })
        } finally {
            db.close()
        }
    }
}
