package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.FactItem
import com.wulisu.suspect.interrogation.domain.TimelineEvent
import com.wulisu.suspect.interrogation.domain.TranscriptMessage
import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import kotlin.math.max

const val CASE_ANALYSIS_PROMPT_TEMPLATE_VERSION = "case-analysis-v1"

object CaseAnalysisPromptTemplate {
    const val version: String = CASE_ANALYSIS_PROMPT_TEMPLATE_VERSION
    const val systemPrompt: String =
        "你是案件审讯辅助分析工具。只能依据下面数据库中真实存在的当前案件数据回答；不得补充、虚构或假设不存在的审讯内容、事实、证据、人物关系。不得引用其他案件。证据不足时必须明确说明不足，不能自行脑补。"
}

/**
 * RKLLM currently does not expose a tokenizer to this layer. This estimator deliberately
 * overestimates common Chinese/English tokenization by charging roughly one token per two
 * UTF-8 bytes plus fixed message framing overhead. The value is deterministic and bounded;
 * it can be replaced by a real tokenizer later without changing packing semantics.
 */
class ContextBudgetEstimator(
    val maxInputTokens: Int = DEFAULT_MAX_INPUT_TOKENS,
) {
    init {
        require(maxInputTokens >= MIN_INPUT_TOKENS) { "maxInputTokens must be >= $MIN_INPUT_TOKENS" }
    }

    fun estimateText(text: String): Int {
        if (text.isEmpty()) return 0
        val bytes = text.toByteArray(StandardCharsets.UTF_8).size
        return max(1, (bytes + 1) / 2)
    }

    fun estimateMessages(messages: List<AiMessage>): Int = messages.sumOf { message ->
        MESSAGE_OVERHEAD_TOKENS + estimateText(message.role) + estimateText(message.content)
    }

    companion object {
        const val DEFAULT_MAX_INPUT_TOKENS = 1_024
        private const val MIN_INPUT_TOKENS = 256
        private const val MESSAGE_OVERHEAD_TOKENS = 8
    }
}

data class PackedCaseAiContext(
    val canonicalContext: String,
    val contextHash: String,
    val sourceRecordIds: List<String>,
    val sourceFactIds: List<String>,
    val sourceTimelineIds: List<String>,
    val estimatedContextTokens: Int,
    val contextBudgetTokens: Int,
)

class CaseAiContextPacker(
    private val estimator: ContextBudgetEstimator,
) {
    fun pack(context: CaseAiContext, maxContextTokens: Int): PackedCaseAiContext {
        if (maxContextTokens <= 0) {
            throw BusinessException("CASE_AI_CONTEXT_TOO_LARGE", "当前案件上下文预算不足，无法构造安全的 AI 输入")
        }

        val records = context.records
            .filter { it.confirmed && it.text.isNotBlank() }
            .sortedWith(compareBy<TranscriptMessage>({ it.seq }, { it.id }))
        val facts = context.facts
            .filter { it.status == "confirmed" && it.value.isNotBlank() }
            .sortedBy { it.key }
        val timeline = context.timeline
            .filter { it.title.isNotBlank() || it.detail.isNotBlank() }
            .sortedWith(compareBy<TimelineEvent>({ normalize(it.time) }, { it.id }))

        val selectedFacts = mutableListOf<FactItem>()
        val selectedTimeline = mutableListOf<TimelineEvent>()
        val selectedRecords = linkedMapOf<String, TranscriptMessage>()

        fun renderCurrent(): String = render(
            context = context,
            facts = selectedFacts,
            timeline = selectedTimeline,
            records = selectedRecords.values.sortedWith(compareBy<TranscriptMessage>({ it.seq }, { it.id })),
        )

        // Priority 1: the case block is never truncated. If it cannot fit, reject instead of
        // cutting any field or sending a structurally incomplete case identity to the model.
        if (estimator.estimateText(renderCurrent()) > maxContextTokens) {
            throw BusinessException(
                "CASE_AI_CONTEXT_TOO_LARGE",
                "案件基本信息已超过上下文预算；为避免截断案件身份信息，本次拒绝生成。",
            )
        }

        // Priority 2: confirmed facts. Candidates are accepted/rejected as complete fact rows.
        facts.forEach { fact ->
            selectedFacts += fact
            if (estimator.estimateText(renderCurrent()) > maxContextTokens) {
                selectedFacts.removeAt(selectedFacts.lastIndex)
            }
        }

        // Priority 3: valid timeline rows, again only as complete rows.
        timeline.forEach { event ->
            selectedTimeline += event
            if (estimator.estimateText(renderCurrent()) > maxContextTokens) {
                selectedTimeline.removeAt(selectedTimeline.lastIndex)
            }
        }

        // Priority 4: recent formal interrogation records. Newest records get first chance to
        // consume the remaining budget; output is re-sorted chronologically after selection.
        val recentIds = records.takeLast(RECENT_RECORD_LIMIT).mapTo(hashSetOf()) { it.id }
        records.asReversed()
            .asSequence()
            .filter { it.id in recentIds }
            .forEach { tryAddRecord(it, selectedRecords, ::renderCurrent, maxContextTokens) }

        // Priority 5: older formal interrogation records, newest of the old history first.
        records.asReversed()
            .asSequence()
            .filter { it.id !in recentIds }
            .forEach { tryAddRecord(it, selectedRecords, ::renderCurrent, maxContextTokens) }

        val finalRecords = selectedRecords.values.sortedWith(compareBy<TranscriptMessage>({ it.seq }, { it.id }))
        val canonical = render(context, selectedFacts, selectedTimeline, finalRecords)
        val estimated = estimator.estimateText(canonical)
        check(estimated <= maxContextTokens) { "packed context exceeded its budget" }

        return PackedCaseAiContext(
            canonicalContext = canonical,
            contextHash = sha256(canonical),
            sourceRecordIds = finalRecords.map { it.id },
            sourceFactIds = selectedFacts.map { it.key },
            sourceTimelineIds = selectedTimeline.map { it.id },
            estimatedContextTokens = estimated,
            contextBudgetTokens = maxContextTokens,
        )
    }

    private fun tryAddRecord(
        record: TranscriptMessage,
        selected: LinkedHashMap<String, TranscriptMessage>,
        renderCurrent: () -> String,
        maxContextTokens: Int,
    ) {
        selected[record.id] = record
        if (estimator.estimateText(renderCurrent()) > maxContextTokens) {
            selected.remove(record.id)
        }
    }

    private fun render(
        context: CaseAiContext,
        facts: List<FactItem>,
        timeline: List<TimelineEvent>,
        records: List<TranscriptMessage>,
    ): String {
        val case = context.caseSummary
        return buildString {
            appendLine("[CASE]")
            appendLine("id=${normalize(case.id)}")
            appendLine(
                "对象=${normalize(case.suspectName)}；性别=${normalize(case.gender).ifBlank { "未录入" }}；" +
                    "年龄=${normalize(case.age).ifBlank { "未录入" }}；民族=${normalize(case.nation).ifBlank { "未录入" }}；" +
                    "出生日期=${normalize(case.birthDate).ifBlank { "未录入" }}；身份证号=${normalize(case.idNumber).ifBlank { "未录入" }}；" +
                    "住址=${normalize(case.address).ifBlank { "未录入" }}；承办民警=${normalize(case.officerName).ifBlank { "未录入" }}；" +
                    "阶段=${case.stage.name}；状态=${normalize(case.state)}",
            )
            appendLine("[CONFIRMED_FACTS]")
            if (facts.isEmpty()) {
                appendLine("- 无")
            } else {
                facts.forEach { fact ->
                    appendLine("- id=${normalize(fact.key)}；${normalize(fact.label)}：${normalize(fact.value)}")
                }
            }
            appendLine("[TIMELINE]")
            if (timeline.isEmpty()) {
                appendLine("- 无")
            } else {
                timeline.forEach { event ->
                    appendLine(
                        "- id=${normalize(event.id)}；${normalize(event.time)} ${normalize(event.title)}：${normalize(event.detail)}",
                    )
                }
            }
            appendLine("[CONFIRMED_INTERROGATION_RECORDS]")
            records.forEach { record ->
                appendLine(
                    "- id=${normalize(record.id)}；seq=${record.seq}；${normalize(record.speaker)}：${normalize(record.text)}",
                )
            }
        }.trimEnd()
    }

    private fun normalize(value: String): String = value
        .replace("\r\n", "\n")
        .replace('\r', '\n')
        .trim()
        .replace("\n", "\\n")

    private fun sha256(value: String): String = MessageDigest.getInstance("SHA-256")
        .digest(value.toByteArray(StandardCharsets.UTF_8))
        .joinToString(separator = "") { byte -> "%02x".format(byte) }

    companion object {
        private const val RECENT_RECORD_LIMIT = 16
    }
}
