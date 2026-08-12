package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.CaseSummary
import com.wulisu.suspect.interrogation.domain.FactItem
import com.wulisu.suspect.interrogation.domain.InterrogationStage
import com.wulisu.suspect.interrogation.domain.TimelineEvent
import com.wulisu.suspect.interrogation.domain.TranscriptMessage
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class CaseAiServiceTest {
    @Test
    fun `empty case is rejected before invoking model`() = runBlocking {
        var calls = 0
        val service = CaseAiService(
            contextSource = FakeSource(context("CASE-A", emptyList())),
            generator = {
                calls += 1
                AiResponse("不应调用", AiProviderKind.LOCAL, "test")
            },
        )

        val error = runCatching { service.analyze("CASE-A") }.exceptionOrNull() as BusinessException

        assertEquals("CASE_AI_INSUFFICIENT_DATA", error.code)
        assertEquals(0, calls)
    }

    @Test
    fun `officer question without suspect answer is insufficient`() = runBlocking {
        val service = CaseAiService(
            contextSource = FakeSource(context("CASE-A", listOf(record("民警", "请说明情况")))),
            generator = { AiResponse("不应调用", AiProviderKind.LOCAL, "test") },
        )

        val error = runCatching { service.analyze("CASE-A") }.exceptionOrNull() as BusinessException

        assertEquals("CASE_AI_INSUFFICIENT_DATA", error.code)
    }

    @Test
    fun `analysis prompt contains only requested case context and is saved to that case`() = runBlocking {
        val source = FakeSource(
            context(
                "CASE-A",
                listOf(record("民警", "A问题"), record("嫌疑人", "A回答")),
            ),
        )
        var messages = emptyList<AiMessage>()
        val service = CaseAiService(
            contextSource = source,
            generator = {
                messages = it
                AiResponse("仅基于 A 的分析", AiProviderKind.LOCAL, "LegalOne")
            },
            clock = { 123L },
            idGenerator = { "analysis-a" },
        )

        val result = service.analyze("CASE-A")
        val prompt = messages.joinToString("\n") { it.content }

        assertTrue(prompt.contains("CASE-A"))
        assertTrue(prompt.contains("A问题"))
        assertTrue(prompt.contains("A回答"))
        assertTrue(prompt.contains("不得补充、虚构或假设"))
        assertFalse(prompt.contains("CASE-B"))
        assertFalse(prompt.contains("B案内容"))
        assertEquals("CASE-A", result.caseId)
        assertEquals(listOf(result), source.saved)
    }

    private class FakeSource(private val value: CaseAiContext) : CaseAiContextSource {
        val saved = mutableListOf<CaseAiAnalysis>()
        override suspend fun load(caseId: String): CaseAiContext {
            assertEquals(value.caseSummary.id, caseId)
            return value
        }
        override suspend fun save(analysis: CaseAiAnalysis) {
            saved += analysis
        }
        override suspend fun list(caseId: String): List<CaseAiAnalysis> = saved.filter { it.caseId == caseId }
    }

    companion object {
        private fun context(caseId: String, records: List<TranscriptMessage>) = CaseAiContext(
            caseSummary = CaseSummary(
                id = caseId,
                suspectName = "测试对象",
                gender = "",
                age = "",
                idNumber = "",
                nation = "",
                birthDate = "",
                address = "",
                identitySource = "",
                identityCapturedAt = null,
                officerName = "测试民警",
                state = "INTERROGATING",
                stage = InterrogationStage.STATEMENT,
                createdAt = 1L,
                updatedAt = 2L,
            ),
            records = records,
            facts = listOf(FactItem("time", "时间", "待根据问答核实", "pending", null)),
            timeline = listOf(TimelineEvent("t1", "", "", "", emptyList())),
        )

        private fun record(speaker: String, text: String) = TranscriptMessage(
            id = "$speaker-$text",
            seq = 1,
            speaker = speaker,
            text = text,
            mark = "",
            confirmed = true,
            createdAt = 1L,
            updatedAt = 1L,
        )
    }
}
