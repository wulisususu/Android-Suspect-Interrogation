package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.data.AiCaseAnalysisDao
import com.wulisu.suspect.interrogation.data.AiCaseAnalysisEntity
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.CaseSummary
import com.wulisu.suspect.interrogation.domain.FactItem
import com.wulisu.suspect.interrogation.domain.TimelineEvent
import com.wulisu.suspect.interrogation.domain.TranscriptMessage
import org.json.JSONArray
import org.json.JSONObject
import java.util.UUID

data class CaseAiContext(
    val caseSummary: CaseSummary,
    val records: List<TranscriptMessage>,
    val facts: List<FactItem>,
    val timeline: List<TimelineEvent>,
)

data class CaseAiAnalysisMetadata(
    val schemaVersion: Int = 1,
    val contextHash: String,
    val sourceRecordIds: List<String>,
    val sourceFactIds: List<String>,
    val sourceTimelineIds: List<String>,
    val promptTemplateVersion: String,
    val runtimeVersion: String,
    val generationConfigJson: String,
    val modelId: String?,
    val modelFileHash: String?,
    val estimatedInputTokens: Int,
    val inputBudgetTokens: Int,
    val estimatedContextTokens: Int,
    val contextBudgetTokens: Int,
) {
    companion object {
        fun legacy() = CaseAiAnalysisMetadata(
            schemaVersion = 0,
            contextHash = "",
            sourceRecordIds = emptyList(),
            sourceFactIds = emptyList(),
            sourceTimelineIds = emptyList(),
            promptTemplateVersion = "legacy-v0",
            runtimeVersion = "unknown",
            generationConfigJson = "{}",
            modelId = null,
            modelFileHash = null,
            estimatedInputTokens = 0,
            inputBudgetTokens = 0,
            estimatedContextTokens = 0,
            contextBudgetTokens = 0,
        )
    }
}

data class CaseAiAnalysis(
    val id: String,
    val caseId: String,
    val text: String,
    val provider: AiProviderKind,
    val model: String,
    val createdAt: Long,
    val metadata: CaseAiAnalysisMetadata = CaseAiAnalysisMetadata.legacy(),
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
                metadataJson = analysis.metadata.toStorageJson(),
            ),
        )
        audit.append(
            analysis.caseId,
            "AI_CASE_ANALYSIS_CREATE",
            "AI_CASE_ANALYSIS",
            analysis.id,
            JSONObject()
                .put("contextHash", analysis.metadata.contextHash)
                .put("promptTemplateVersion", analysis.metadata.promptTemplateVersion)
                .put("sourceRecordCount", analysis.metadata.sourceRecordIds.size)
                .put("sourceFactCount", analysis.metadata.sourceFactIds.size)
                .put("sourceTimelineCount", analysis.metadata.sourceTimelineIds.size)
                .put("estimatedInputTokens", analysis.metadata.estimatedInputTokens)
                .put("inputBudgetTokens", analysis.metadata.inputBudgetTokens),
        )
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
                metadata = CaseAiAnalysisMetadata.fromStorageJson(row.metadataJson),
            )
        }
    }
}

class CaseAiService(
    private val contextSource: CaseAiContextSource,
    private val generator: suspend (List<AiMessage>) -> AiResponse,
    private val clock: () -> Long = System::currentTimeMillis,
    private val idGenerator: () -> String = { UUID.randomUUID().toString() },
    private val budgetEstimator: ContextBudgetEstimator = ContextBudgetEstimator(),
    private val contextPacker: CaseAiContextPacker = CaseAiContextPacker(budgetEstimator),
) {
    suspend fun analyze(caseId: String): CaseAiAnalysis {
        val context = loadSufficientContext(caseId)
        val prepared = preparePrompt(context, "请对当前案件已有资料进行审慎分析。")
        val response = generator(prepared.messages)
        if (response.text.isBlank()) throw BusinessException("CASE_AI_EMPTY_RESULT", "本案 AI 推理没有返回内容")
        return CaseAiAnalysis(
            id = idGenerator(),
            caseId = context.caseSummary.id,
            text = response.text,
            provider = response.provider,
            model = response.model,
            createdAt = clock(),
            metadata = CaseAiAnalysisMetadata(
                contextHash = prepared.packed.contextHash,
                sourceRecordIds = prepared.packed.sourceRecordIds,
                sourceFactIds = prepared.packed.sourceFactIds,
                sourceTimelineIds = prepared.packed.sourceTimelineIds,
                promptTemplateVersion = CaseAnalysisPromptTemplate.version,
                runtimeVersion = response.generationMetadata.runtimeVersion,
                generationConfigJson = response.generationMetadata.generationConfigJson,
                modelId = response.generationMetadata.modelId,
                modelFileHash = response.generationMetadata.modelFileHash,
                estimatedInputTokens = prepared.estimatedInputTokens,
                inputBudgetTokens = budgetEstimator.maxInputTokens,
                estimatedContextTokens = prepared.packed.estimatedContextTokens,
                contextBudgetTokens = prepared.packed.contextBudgetTokens,
            ),
        ).also { contextSource.save(it) }
    }

    suspend fun inquiry(caseId: String, message: String): AiResponse {
        val clean = message.trim()
        if (clean.isEmpty()) throw BusinessException("EMPTY_AI_MESSAGE", "AI 请求内容不能为空")
        val context = loadSufficientContext(caseId)
        return generator(preparePrompt(context, clean).messages)
    }

    suspend fun list(caseId: String): List<CaseAiAnalysis> = contextSource.list(caseId)

    private suspend fun loadSufficientContext(caseId: String): CaseAiContext {
        val context = contextSource.load(caseId)
        if (context.caseSummary.id != caseId) {
            throw BusinessException("CASE_AI_CONTEXT_MISMATCH", "案件上下文与请求 caseId 不一致，已拒绝 AI 请求")
        }
        val confirmed = context.records.filter { it.confirmed && it.text.isNotBlank() }
        if (confirmed.none { it.speaker == "嫌疑人" }) {
            throw BusinessException(
                "CASE_AI_INSUFFICIENT_DATA",
                "当前案件暂无足够的正式审讯记录，至少需要一条嫌疑人回答后才能生成本案推理。",
            )
        }
        return context.copy(records = confirmed)
    }

    private fun preparePrompt(context: CaseAiContext, request: String): PreparedPrompt {
        val requestBlock = "本次任务：$request"
        val fixedMessages = listOf(
            AiMessage(role = "system", content = CaseAnalysisPromptTemplate.systemPrompt),
            AiMessage(role = "user", content = requestBlock),
        )
        val fixedTokens = budgetEstimator.estimateMessages(fixedMessages)
        val contextBudget = budgetEstimator.maxInputTokens - fixedTokens
        if (contextBudget < MIN_CONTEXT_BUDGET_TOKENS) {
            throw BusinessException("AI_REQUEST_TOO_LARGE", "本次 AI 请求内容超过输入预算，请缩短问题后重试")
        }

        val packed = contextPacker.pack(context, contextBudget)
        val messages = listOf(
            AiMessage(role = "system", content = CaseAnalysisPromptTemplate.systemPrompt),
            AiMessage(role = "user", content = "${packed.canonicalContext}\n\n$requestBlock"),
        )
        val estimated = budgetEstimator.estimateMessages(messages)
        if (estimated > budgetEstimator.maxInputTokens) {
            throw BusinessException("CASE_AI_CONTEXT_TOO_LARGE", "案件上下文超过输入预算，已拒绝发送不完整记录")
        }
        return PreparedPrompt(messages, packed, estimated)
    }

    private data class PreparedPrompt(
        val messages: List<AiMessage>,
        val packed: PackedCaseAiContext,
        val estimatedInputTokens: Int,
    )

    companion object {
        private const val MIN_CONTEXT_BUDGET_TOKENS = 128
    }
}

private fun CaseAiAnalysisMetadata.toStorageJson(): String {
    val generationConfig = runCatching { JSONObject(generationConfigJson) }.getOrElse { JSONObject() }
    return JSONObject()
        .put("schemaVersion", schemaVersion)
        .put("contextHash", contextHash)
        .put("sourceRecordIds", JSONArray(sourceRecordIds))
        .put("sourceFactIds", JSONArray(sourceFactIds))
        .put("sourceTimelineIds", JSONArray(sourceTimelineIds))
        .put("promptTemplateVersion", promptTemplateVersion)
        .put("runtimeVersion", runtimeVersion)
        .put("generationConfig", generationConfig)
        .put("modelId", modelId ?: JSONObject.NULL)
        .put("modelFileHash", modelFileHash ?: JSONObject.NULL)
        .put("estimatedInputTokens", estimatedInputTokens)
        .put("inputBudgetTokens", inputBudgetTokens)
        .put("estimatedContextTokens", estimatedContextTokens)
        .put("contextBudgetTokens", contextBudgetTokens)
        .toString()
}

private fun CaseAiAnalysisMetadata.Companion.fromStorageJson(raw: String): CaseAiAnalysisMetadata = runCatching {
    val json = JSONObject(raw)
    if (json.optInt("schemaVersion", 0) <= 0 || json.optString("contextHash").isBlank()) {
        return@runCatching legacy()
    }
    CaseAiAnalysisMetadata(
        schemaVersion = json.optInt("schemaVersion", 1),
        contextHash = json.optString("contextHash"),
        sourceRecordIds = json.stringList("sourceRecordIds"),
        sourceFactIds = json.stringList("sourceFactIds"),
        sourceTimelineIds = json.stringList("sourceTimelineIds"),
        promptTemplateVersion = json.optString("promptTemplateVersion", "legacy-v0"),
        runtimeVersion = json.optString("runtimeVersion", "unknown"),
        generationConfigJson = json.optJSONObject("generationConfig")?.toString() ?: "{}",
        modelId = json.optionalString("modelId"),
        modelFileHash = json.optionalString("modelFileHash"),
        estimatedInputTokens = json.optInt("estimatedInputTokens", 0),
        inputBudgetTokens = json.optInt("inputBudgetTokens", 0),
        estimatedContextTokens = json.optInt("estimatedContextTokens", 0),
        contextBudgetTokens = json.optInt("contextBudgetTokens", 0),
    )
}.getOrElse { legacy() }

private fun JSONObject.stringList(key: String): List<String> {
    val array = optJSONArray(key) ?: return emptyList()
    return buildList {
        for (index in 0 until array.length()) {
            array.optString(index).takeIf { it.isNotBlank() }?.let(::add)
        }
    }
}

private fun JSONObject.optionalString(key: String): String? =
    if (!has(key) || isNull(key)) null else optString(key).takeIf { it.isNotBlank() }
