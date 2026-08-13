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
            contextSource = FakeSource(context("CASE-A", listOf(record(1, "民警", "请说明情况")))),
            generator = { AiResponse("不应调用", AiProviderKind.LOCAL, "test") },
        )

        val error = runCatching { service.analyze("CASE-A") }.exceptionOrNull() as BusinessException

        assertEquals("CASE_AI_INSUFFICIENT_DATA", error.code)
    }

    @Test
    fun `analysis prompt contains only requested case context and audit metadata is saved`() = runBlocking {
        val source = FakeSource(
            context(
                "CASE-A",
                listOf(record(1, "民警", "A问题"), record(2, "嫌疑人", "A回答")),
                facts = listOf(FactItem("where", "地点", "A地点", "confirmed", null)),
                timeline = listOf(TimelineEvent("timeline-a", "10:00", "到场", "A时间线", emptyList())),
            ),
        )
        var messages = emptyList<AiMessage>()
        val service = CaseAiService(
            contextSource = source,
            generator = {
                messages = it
                AiResponse(
                    "仅基于 A 的分析",
                    AiProviderKind.LOCAL,
                    "LegalOne",
                    AiGenerationMetadata(
                        runtimeVersion = "1.3.0",
                        generationConfigJson = "{\"maxContextLen\":1024,\"maxNewTokens\":256}",
                        modelId = "legalone-rk3576",
                    ),
                )
            },
            clock = { 123L },
            idGenerator = { "analysis-a" },
        )

        val result = service.analyze("CASE-A")
        val prompt = messages.joinToString("\n") { it.content }

        assertTrue(prompt.contains("CASE-A"))
        assertTrue(prompt.contains("A问题"))
        assertTrue(prompt.contains("A回答"))
        assertTrue(prompt.contains("A地点"))
        assertTrue(prompt.contains("A时间线"))
        assertTrue(prompt.contains("不得补充、虚构或假设"))
        assertFalse(prompt.contains("CASE-B"))
        assertFalse(prompt.contains("B案内容"))
        assertEquals("CASE-A", result.caseId)
        assertEquals(CASE_ANALYSIS_PROMPT_TEMPLATE_VERSION, result.metadata.promptTemplateVersion)
        assertEquals("1.3.0", result.metadata.runtimeVersion)
        assertEquals("legalone-rk3576", result.metadata.modelId)
        assertEquals(listOf("民警-A问题", "嫌疑人-A回答"), result.metadata.sourceRecordIds)
        assertEquals(listOf("where"), result.metadata.sourceFactIds)
        assertEquals(listOf("timeline-a"), result.metadata.sourceTimelineIds)
        assertEquals(64, result.metadata.contextHash.length)
        assertTrue(result.metadata.estimatedInputTokens <= result.metadata.inputBudgetTokens)
        assertTrue(result.metadata.estimatedContextTokens <= result.metadata.contextBudgetTokens)
        assertEquals(listOf(result), source.saved)
    }

    @Test
    fun `long case is packed by complete records and stays inside deterministic budget`() = runBlocking {
        val records = (1..80).map { seq ->
            val speaker = if (seq % 2 == 0) "嫌疑人" else "民警"
            record(seq, speaker, "record-$seq-${"内容".repeat(35)}")
        }
        val value = context(
            "CASE-LONG",
            records,
            facts = (1..5).map { FactItem("fact-$it", "事实$it", "已确认$it", "confirmed", null) },
            timeline = (1..5).map { TimelineEvent("timeline-$it", "1$it:00", "事件$it", "有效详情$it", emptyList()) },
        )
        val source = FakeSource(value)
        var messages = emptyList<AiMessage>()
        val estimator = ContextBudgetEstimator(maxInputTokens = 900)
        val result = CaseAiService(
            contextSource = source,
            generator = {
                messages = it
                AiResponse("bounded", AiProviderKind.LOCAL, "test")
            },
            budgetEstimator = estimator,
        ).analyze("CASE-LONG")

        val prompt = messages.joinToString("\n") { it.content }
        assertTrue(result.metadata.estimatedInputTokens <= estimator.maxInputTokens)
        assertTrue(result.metadata.sourceRecordIds.size < records.size)
        assertTrue(result.metadata.sourceRecordIds.contains(records.last().id))
        assertEquals((1..5).map { "fact-$it" }, result.metadata.sourceFactIds)
        assertEquals((1..5).map { "timeline-$it" }, result.metadata.sourceTimelineIds)

        records.forEach { record ->
            if (record.id in result.metadata.sourceRecordIds) {
                assertTrue("selected record must be present in full", prompt.contains(record.text))
            } else {
                assertFalse("excluded record must not leak into prompt", prompt.contains(record.text))
            }
        }
    }

    @Test
    fun `context hash is stable for identical normalized packed context`() = runBlocking {
        val value = context(
            "CASE-HASH",
            listOf(
                record(1, "民警", "问题\r\n第二行"),
                record(2, "嫌疑人", "回答"),
            ),
            facts = listOf(FactItem("fact", "事实", "确认", "confirmed", null)),
        )
        val source = FakeSource(value)
        var id = 0
        val service = CaseAiService(
            contextSource = source,
            generator = { AiResponse("ok", AiProviderKind.CLOUD_ZHIPU, "glm") },
            idGenerator = { "analysis-${++id}" },
        )

        val first = service.analyze("CASE-HASH")
        val second = service.analyze("CASE-HASH")

        assertEquals(first.metadata.contextHash, second.metadata.contextHash)
        assertEquals(first.metadata.sourceRecordIds, second.metadata.sourceRecordIds)
        assertEquals(first.metadata.sourceFactIds, second.metadata.sourceFactIds)
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
        private fun context(
            caseId: String,
            records: List<TranscriptMessage>,
            facts: List<FactItem> = listOf(FactItem("time", "时间", "待根据问答核实", "pending", null)),
            timeline: List<TimelineEvent> = listOf(TimelineEvent("t1", "", "", "", emptyList())),
        ) = CaseAiContext(
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
            facts = facts,
            timeline = timeline,
        )

        private fun record(seq: Int, speaker: String, text: String) = TranscriptMessage(
            id = "$speaker-$text",
            seq = seq,
            speaker = speaker,
            text = text,
            mark = "",
            confirmed = true,
            createdAt = seq.toLong(),
            updatedAt = seq.toLong(),
        )
    }
}
