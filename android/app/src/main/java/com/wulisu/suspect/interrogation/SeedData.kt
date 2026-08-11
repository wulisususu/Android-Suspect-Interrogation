package com.wulisu.suspect.interrogation

import com.wulisu.suspect.interrogation.domain.InterrogationStage
import com.wulisu.suspect.interrogation.service.CaseService
import com.wulisu.suspect.interrogation.service.InterrogationService
import com.wulisu.suspect.interrogation.service.RecordService

class SeedData(
    private val cases: CaseService,
    private val sessions: InterrogationService,
    private val records: RecordService,
) {
    suspend fun seedIfEmpty() {
        if (cases.list(1).isNotEmpty()) return
        for (demo in demos) {
            val created = cases.create(
                requestedId = demo.caseId,
                suspectName = demo.name,
                gender = demo.gender,
                age = demo.age,
                officerName = demo.officer,
            )
            sessions.start(created.id)
            for ((speaker, text) in demo.qa) {
                records.add(created.id, text, speaker)
            }
            sessions.changeStage(created.id, demo.stage)
        }
    }

    private data class DemoCase(
        val caseId: String?,
        val name: String,
        val gender: String,
        val age: String,
        val officer: String,
        val stage: InterrogationStage,
        val qa: List<Pair<String, String>>,
    )

    private val demos = listOf(
        DemoCase(
            caseId = null, name = "张三", gender = "男", age = "35", officer = "李警官",
            stage = InterrogationStage.FOLLOW_UP,
            qa = listOf(
                "民警" to "你叫什么名字，住哪里？",
                "嫌疑人" to "我叫张三，住城南区幸福路12号",
                "民警" to "3月15日晚上你在哪里？",
                "嫌疑人" to "那天晚上我在网吧通宵打游戏",
                "民警" to "但监控显示当晚11点你在幸福超市门口，你怎么解释？",
                "嫌疑人" to "……我记错了，我中途出去买过东西",
            ),
        ),
        DemoCase(
            caseId = null, name = "李四", gender = "男", age = "28", officer = "王警官",
            stage = InterrogationStage.STATEMENT,
            qa = listOf(
                "民警" to "昨晚在烧烤店门口和人发生冲突的是你吗？",
                "嫌疑人" to "是，但我是被打的，他们先动手",
                "民警" to "你的伤情鉴定是轻微伤，对方两人是轻伤，怎么回事？",
                "嫌疑人" to "我当时喝了酒，记不太清楚……",
                "民警" to "现场监控显示你先抄起板凳砸向对方，请如实交代",
                "嫌疑人" to "好吧，我承认，是我先动的手",
            ),
        ),
        DemoCase(
            caseId = null, name = "王五", gender = "女", age = "42", officer = "赵警官",
            stage = InterrogationStage.SIGNING,
            qa = listOf(
                "民警" to "你通过什么方式联系到受害人的？",
                "嫌疑人" to "网上认识的，她主动找的我",
                "民警" to "她给你转了多少钱？",
                "嫌疑人" to "总共转了我三万，但是是她自愿的",
                "民警" to "你自称是投资顾问，你实际有资质吗？",
                "嫌疑人" to "没有……我就是卖点消息",
            ),
        ),
        DemoCase(
            caseId = null, name = "赵六", gender = "男", age = "31", officer = "刘警官",
            stage = InterrogationStage.IDENTITY,
            qa = listOf(
                "民警" to "你把捡到的手机交给失主了吗？",
                "嫌疑人" to "交给了，就在派出所",
                "民警" to "但失主说手机里被删除了大量资料，怎么回事？",
                "嫌疑人" to "我……我打开看了一下，不小心删的",
            ),
        ),
    )
}
