package com.wulisu.suspect.interrogation.data

import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.service.AuditService
import com.wulisu.suspect.interrogation.service.AiGenerationMetadata
import com.wulisu.suspect.interrogation.service.AiProviderKind
import com.wulisu.suspect.interrogation.service.AiResponse
import com.wulisu.suspect.interrogation.service.CASE_ANALYSIS_PROMPT_TEMPLATE_VERSION
import com.wulisu.suspect.interrogation.service.CaseAiService
import com.wulisu.suspect.interrogation.service.CaseService
import com.wulisu.suspect.interrogation.service.FactService
import com.wulisu.suspect.interrogation.service.InterrogationService
import com.wulisu.suspect.interrogation.service.RecordService
import com.wulisu.suspect.interrogation.service.RoomCaseAiContextSource
import com.wulisu.suspect.interrogation.service.TimelineService
import kotlinx.coroutines.runBlocking
import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
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
    fun caseAiReadsPersistsAndAuditsOnlyTheExplicitCase() = runBlocking {
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
                AiResponse(
                    text = "analysis-${prompts.size}",
                    provider = AiProviderKind.LOCAL,
                    model = "test-model",
                    generationMetadata = AiGenerationMetadata(
                        runtimeVersion = "1.3.0-test",
                        generationConfigJson = "{\"maxContextLen\":1024,\"maxNewTokens\":64}",
                        modelId = "test-model-id",
                    ),
                )
            })
            cases.create(requestedId = "CASE-A", suspectName = "对象A")
            cases.create(requestedId = "CASE-B", suspectName = "对象B")
            val insufficient = runCatching { caseAi.analyze("CASE-A") }.exceptionOrNull() as BusinessException
            assertEquals("CASE_AI_INSUFFICIENT_DATA", insufficient.code)
            assertTrue(prompts.isEmpty())
            sessions.start("CASE-A")
            sessions.start("CASE-B")
            val aQuestion = records.add("CASE-A", "A案问题", "民警")
            val aAnswer = records.add("CASE-A", "A案回答", "嫌疑人")
            val bQuestion = records.add("CASE-B", "B案问题", "民警")
            val bAnswer = records.add("CASE-B", "B案回答", "嫌疑人")

            val analysisA = caseAi.analyze("CASE-A")
            val analysisB = caseAi.analyze("CASE-B")

            assertTrue(prompts[0].contains("CASE-A"))
            assertTrue(prompts[0].contains("A案回答"))
            assertFalse(prompts[0].contains("CASE-B"))
            assertFalse(prompts[0].contains("B案回答"))
            assertTrue(prompts[1].contains("CASE-B"))
            assertTrue(prompts[1].contains("B案回答"))
            assertFalse(prompts[1].contains("CASE-A"))
            assertFalse(prompts[1].contains("A案回答"))

            assertEquals(listOf(aQuestion.id, aAnswer.id), analysisA.metadata.sourceRecordIds)
            assertEquals(listOf(bQuestion.id, bAnswer.id), analysisB.metadata.sourceRecordIds)
            assertFalse(analysisA.metadata.sourceRecordIds.contains(bAnswer.id))
            assertFalse(analysisB.metadata.sourceRecordIds.contains(aAnswer.id))

            val storedA = caseAi.list("CASE-A").single()
            val storedB = caseAi.list("CASE-B").single()
            assertEquals("CASE-A", storedA.caseId)
            assertEquals("CASE-B", storedB.caseId)
            assertEquals(analysisA.metadata, storedA.metadata)
            assertEquals(analysisB.metadata, storedB.metadata)
            assertEquals(CASE_ANALYSIS_PROMPT_TEMPLATE_VERSION, storedA.metadata.promptTemplateVersion)
            assertEquals("1.3.0-test", storedA.metadata.runtimeVersion)
            assertEquals("test-model-id", storedA.metadata.modelId)

            val rawMetadata = db.aiCaseAnalysisDao().list("CASE-A").single().metadataJson
            val metadataJson = JSONObject(rawMetadata)
            assertEquals(analysisA.metadata.contextHash, metadataJson.getString("contextHash"))
            assertEquals(CASE_ANALYSIS_PROMPT_TEMPLATE_VERSION, metadataJson.getString("promptTemplateVersion"))
            assertEquals(2, metadataJson.getJSONArray("sourceRecordIds").length())
        } finally {
            db.close()
        }
    }
}
