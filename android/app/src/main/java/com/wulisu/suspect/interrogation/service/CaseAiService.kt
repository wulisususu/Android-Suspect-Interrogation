package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.CaseSummary
import com.wulisu.suspect.interrogation.domain.FactItem
import com.wulisu.suspect.interrogation.domain.TimelineEvent
import com.wulisu.suspect.interrogation.domain.TranscriptMessage
import com.wulisu.suspect.interrogation.data.AiCaseAnalysisDao
import com.wulisu.suspect.interrogation.data.AiCaseAnalysisEntity
import java.util.UUID

data class CaseAiContext(
    val caseSummary: CaseSummary,
    val records: List<TranscriptMessage>,
    val facts: List<FactItem>,
    val timeline: List<TimelineEvent>,
)

data class CaseAiAnalysis(
    val id: String,
    val caseId: String,
    val text: String,
    val provider: AiProviderKind,
    val model: String,
    val createdAt: Long,
)

interface CaseAiContextSource {
    suspend fun load(caseId: String): CaseAiContext
    suspend fun save(analysis: CaseAiAnalysis)
    suspend fun list(caseId: String): List<CaseAiAnalysis>
}

class RoomCaseAiContextSource(
    private val cases: CaseService,
    private val records: RecordService,
    private val facts: FactService,
    private val timeline: TimelineService,
    private val analysisDao: AiCaseAnalysisDao,
    private val audit: AuditService,
) : CaseAiContextSource {
    override suspend fun load(caseId: String) = CaseAiContext(
        caseSummary = cases.get(caseId),
        records = records.list(caseId),
        facts = facts.list(caseId),
        timeline = timeline.list(caseId),
    )

    override suspend fun save(analysis: CaseAiAnalysis) {
        analysisDao.insert(
            AiCaseAnalysisEntity(
                id = analysis.id,
                caseId = analysis.caseId,
                text = analysis.text,
                provider = analysis.provider.name,
                model = analysis.model,
                createdAt = analysis.createdAt,
            ),
        )
        audit.append(analysis.caseId, "AI_CASE_ANALYSIS_CREATE", "AI_CASE_ANALYSIS", analysis.id)
    }

    override suspend fun list(caseId: String): List<CaseAiAnalysis> {
        cases.get(caseId)
        return analysisDao.list(caseId).map { row ->
            CaseAiAnalysis(
                id = row.id,
                caseId = row.caseId,
                text = row.text,
                provider = runCatching { AiProviderKind.valueOf(row.provider) }.getOrDefault(AiProviderKind.UNAVAILABLE),
                model = row.model,
                createdAt = row.createdAt,
            )
        }
    }
}

class CaseAiService(
    private val contextSource: CaseAiContextSource,
    private val generator: suspend (List<AiMessage>) -> AiResponse,
    private val clock: () -> Long = System::currentTimeMillis,
    private val idGenerator: () -> String = { UUID.randomUUID().toString() },
) {
    suspend fun analyze(caseId: String): CaseAiAnalysis {
        val context = loadSufficientContext(caseId)
        val response = generator(buildMessages(context, "请对当前案件已有资料进行审慎分析。"))
        if (response.text.isBlank()) throw BusinessException("CASE_AI_EMPTY_RESULT", "本案 AI 推理没有返回内容")
        return CaseAiAnalysis(
            id = idGenerator(),
            caseId = context.caseSummary.id,
            text = response.text,
            provider = response.provider,
            model = response.model,
            createdAt = clock(),
        ).also { contextSource.save(it) }
    }

    suspend fun inquiry(caseId: String, message: String): AiResponse {
        val clean = message.trim()
        if (clean.isEmpty()) throw BusinessException("EMPTY_AI_MESSAGE", "AI 请求内容不能为空")
        return generator(buildMessages(loadSufficientContext(caseId), clean))
    }

    suspend fun list(caseId: String): List<CaseAiAnalysis> = contextSource.list(caseId)

    private suspend fun loadSufficientContext(caseId: String): CaseAiContext {
        val context = contextSource.load(caseId)
        val confirmed = context.records.filter { it.confirmed && it.text.isNotBlank() }
        if (confirmed.none { it.speaker == "嫌疑人" }) {
            throw BusinessException(
                "CASE_AI_INSUFFICIENT_DATA",
                "当前案件暂无足够的正式审讯记录，至少需要一条嫌疑人回答后才能生成本案推理。",
            )
        }
        return context.copy(records = confirmed)
    }

    private fun buildMessages(context: CaseAiContext, request: String): List<AiMessage> {
        val case = context.caseSummary
        val actualFacts = context.facts.filter { it.status == "confirmed" && it.value.isNotBlank() }
        val actualTimeline = context.timeline.filter { it.title.isNotBlank() || it.detail.isNotBlank() }
        val source = buildString {
            appendLine("当前案件主键（必须严格隔离）：${case.id}")
            appendLine("案件基本信息：对象=${case.suspectName}；性别=${case.gender.ifBlank { "未录入" }}；年龄=${case.age.ifBlank { "未录入" }}；阶段=${case.stage.name}；状态=${case.state}")
            appendLine("正式审讯记录：")
            context.records.forEach { appendLine("- [${it.seq}] ${it.speaker}：${it.text}") }
            appendLine("已确认事实：")
            if (actualFacts.isEmpty()) appendLine("- 无") else actualFacts.forEach { appendLine("- ${it.label}：${it.value}") }
            appendLine("已录入时间线：")
            if (actualTimeline.isEmpty()) appendLine("- 无") else actualTimeline.forEach { appendLine("- ${it.time} ${it.title}：${it.detail}") }
        }.trim()
        return listOf(
            AiMessage(
                role = "system",
                content = "你是案件审讯辅助分析工具。只能依据下面数据库中真实存在的当前案件数据回答；不得补充、虚构或假设不存在的审讯内容、事实、证据、人物关系。不得引用其他案件。证据不足时必须明确说明不足，不能自行脑补。",
            ),
            AiMessage(role = "user", content = "$source\n\n本次任务：$request"),
        )
    }
}
