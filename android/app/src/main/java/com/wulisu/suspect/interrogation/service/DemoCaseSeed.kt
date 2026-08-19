package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.InterrogationStage

/**
 * TEMPORARY DEMO DATA.
 *
 * Everything in this file is fictional and exists only to preload one complete
 * demonstration case into the Android local database. Once the demo has been
 * opened on the target device, this source file and the AppContainer call can
 * be removed; the already-seeded Room/SQLCipher rows will remain on that device.
 */
class DemoCaseSeed(
    private val cases: CaseService,
    private val sessions: InterrogationService,
    private val records: RecordService,
    private val facts: FactService,
    private val timeline: TimelineService,
) {
    suspend fun seedIfNeeded() {
        if (caseExists()) return

        cases.create(
            requestedId = CASE_ID,
            suspectName = "林泽宇",
            gender = "男",
            age = "28",
            officerName = "周明远",
            idNumber = "34000019980317001X",
            nation = "汉",
            birthDate = "1998-03-17",
            address = "安徽省合肥市庐州新区春和路88号2幢503室",
            identitySource = "MANUAL",
            identityCapturedAt = System.currentTimeMillis(),
        )

        // Ensure the extended workspace facts exist before filling them.
        facts.list(CASE_ID)
        factValues.forEach { item ->
            facts.update(
                caseId = CASE_ID,
                factKey = item.key,
                value = item.value,
                status = "confirmed",
                suggestion = item.note,
            )
        }

        timelineItems.forEach { item ->
            timeline.add(CASE_ID, item.time, item.title, item.detail, item.evidence)
        }

        sessions.start(CASE_ID)
        sessions.changeStage(CASE_ID, InterrogationStage.STATEMENT)
        transcript.forEach { item ->
            records.add(CASE_ID, item.text, item.speaker)
        }
    }

    private suspend fun caseExists(): Boolean = try {
        cases.get(CASE_ID)
        true
    } catch (error: BusinessException) {
        if (error.code == "CASE_NOT_FOUND") false else throw error
    }

    private data class DemoFact(val key: String, val value: String, val note: String)
    private data class DemoTimeline(val time: String, val title: String, val detail: String, val evidence: List<String>)
    private data class DemoRecord(val speaker: String, val text: String)

    companion object {
        const val CASE_ID = "CASE-DEMO-20260819-01"

        private val factValues = listOf(
            DemoFact(
                "time",
                "主要作案及处置时段为2026年8月12日20时16分至22时05分；8月14日10时20分接受公安机关调查。",
                "时间点已由模拟口供、门店监控时间戳和平台操作记录相互印证。",
            ),
            DemoFact(
                "place",
                "南京市江宁区澄江路118号“汇邻便利店”后场仓库、门店后巷，以及嫌疑人位于云栖路66号的租住地。",
                "地点与模拟监控画面、门店平面位置和嫌疑人陈述一致。",
            ),
            DemoFact(
                "motive",
                "嫌疑人因网络借款到期、近期收入不稳定产生经济压力，临时起意盗取店内电子设备后变现。",
                "动机来自嫌疑人连续陈述及模拟手机账单信息，暂未发现他人指使。",
            ),
            DemoFact(
                "people",
                "嫌疑人林泽宇单独实施；赵某为当班店员，陈某为门店负责人，二人均作为相关证人出现，未发现共同作案人员。",
                "相关人员身份与角色已区分，当前无同伙线索。",
            ),
            DemoFact(
                "method",
                "嫌疑人利用曾做过配送兼职、熟悉后场动线的便利，趁后场门未完全闭合进入仓库，将货架上的电子设备装入随身配送包后带离。",
                "未使用破拆工具，进入方式和携带方式已在模拟口供中固定。",
            ),
            DemoFact(
                "process",
                "嫌疑人18时42分先进入门店观察，19时05分离开；20时16分从后巷返回并进入仓库，20时21分携物离开，20时38分回到租住地，21时10分发布二手交易信息，22时05分因害怕被发现删除信息。",
                "行为链条已按先后顺序拆分并对应时间线。",
            ),
            DemoFact(
                "evidence",
                "模拟证据包括门店前厅及后巷监控、库存盘点记录、嫌疑人手机定位记录、二手平台发布记录截图、租住地扣押物品照片及嫌疑人口供。",
                "各证据仅为演示占位，不代表真实案件证据。",
            ),
            DemoFact(
                "after",
                "嫌疑人将物品带回租住地，曾尝试在二手平台出售其中一部手机但未完成交易，随后删除发布信息；接受调查后指认物品存放位置并表示愿意退赔。",
                "赃物处置、网络发布和后续配合情况已形成闭环。",
            ),
            DemoFact(
                "current_address",
                "南京市江宁区云栖路66号清河公寓3栋1204室（虚构地址）",
                "模拟身份资料，供A页演示。",
            ),
            DemoFact(
                "case_type",
                "盗窃案（模拟演示）",
                "本案全部人物、地址、号码及事实均为虚构。",
            ),
        )

        private val timelineItems = listOf(
            DemoTimeline(
                "2026-08-12 18:42",
                "首次进入门店",
                "林泽宇进入“汇邻便利店”购买饮料，并在结账及停留过程中观察收银区、后场门和店员活动情况。",
                listOf("前厅监控01", "嫌疑人口供Q2"),
            ),
            DemoTimeline(
                "2026-08-12 19:05",
                "离店并在附近停留",
                "林泽宇离开门店后骑电动车到附近街口停留，期间产生盗取电子设备变现的想法。",
                listOf("门外监控02", "手机定位记录", "嫌疑人口供Q3"),
            ),
            DemoTimeline(
                "2026-08-12 20:16",
                "从后巷进入仓库",
                "林泽宇从门店后巷返回，发现后场门未完全闭合，进入仓库区域。",
                listOf("后巷监控03", "嫌疑人口供Q4"),
            ),
            DemoTimeline(
                "2026-08-12 20:18",
                "取走电子设备",
                "林泽宇从仓库货架取走2台平板电脑和3部未拆封手机，装入随身黑色配送包。",
                listOf("仓库监控04", "库存盘点记录", "嫌疑人口供Q5"),
            ),
            DemoTimeline(
                "2026-08-12 20:21",
                "携带物品离开",
                "林泽宇沿后巷离开现场，骑电动车返回租住地，未再次进入门店前厅。",
                listOf("后巷监控05", "手机定位记录"),
            ),
            DemoTimeline(
                "2026-08-12 20:38",
                "将物品带回租住地",
                "林泽宇回到云栖路租住地，将5件电子设备放入卧室衣柜下层纸箱。",
                listOf("手机定位记录", "扣押物品照片", "嫌疑人口供Q6"),
            ),
            DemoTimeline(
                "2026-08-12 21:10",
                "尝试发布二手交易信息",
                "林泽宇使用本人手机在二手交易平台发布其中1部手机的信息，拟低价出售，但未实际成交。",
                listOf("二手平台截图", "手机操作记录", "嫌疑人口供Q6"),
            ),
            DemoTimeline(
                "2026-08-12 22:05",
                "删除交易信息",
                "林泽宇担心门店发现货物丢失后报警，主动删除二手平台发布信息，物品继续存放在租住地。",
                listOf("平台操作记录", "嫌疑人口供Q6"),
            ),
            DemoTimeline(
                "2026-08-14 10:20",
                "接受调查并说明物品位置",
                "公安机关联系林泽宇后，其到场接受调查，对主要事实作出供述，并说明涉案物品存放位置。",
                listOf("到案记录（模拟）", "嫌疑人口供Q9-Q11"),
            ),
        )

        private val transcript = listOf(
            DemoRecord("民警", "请你核对并说明自己的基本身份信息，以及目前的居住情况。"),
            DemoRecord("嫌疑人", "我叫林泽宇，男，汉族，1998年3月17日出生，身份证登记住址是安徽省合肥市庐州新区春和路88号2幢503室。现在暂住在南京市江宁区云栖路66号清河公寓3栋1204室。我确认刚才登记的信息是我本人提供的。"),
            DemoRecord("民警", "请从你到便利店附近开始，按照时间顺序完整描述2026年8月12日晚上发生的事情。"),
            DemoRecord("嫌疑人", "当天18点40分左右我骑电动车到了澄江路，18点42分进了汇邻便利店买饮料。我以前做配送兼职时去过这家店，知道后面有仓库。19点05分左右我离开门店，在附近街口待了一阵。到20点16分左右，我从后巷又回到店后面，看见后场门没有完全关紧，就进去了。大概20点18分，我从货架上拿了2台平板电脑和3部没拆封的手机，装进自己的黑色配送包。20点21分左右我从后巷离开，骑车回住处，20点38分左右到家，把东西放进卧室衣柜下面的纸箱里。"),
            DemoRecord("民警", "你为什么要实施上述行为，当时是提前计划好的还是临时产生的想法？"),
            DemoRecord("嫌疑人", "主要是我当时欠了网络借款，工作收入又不稳定，催款比较急。我第一次进店的时候看到后场，就想到如果拿点值钱的东西卖掉可以周转。我不是很早以前就计划好的，是当天离店后在附近停留时越来越强烈地有了这个想法。现在看这就是我给自己找借口，经济困难也不能拿别人的东西。"),
            DemoRecord("民警", "实施过程中有没有准备撬棍、钥匙等工具，是否联系过其他人，或者有人帮助你进入仓库？"),
            DemoRecord("嫌疑人", "没有准备撬棍、钥匙之类的工具，也没有找别人帮忙。我只是因为以前送货知道后门的位置。那天我过去时看到门没有完全合上，就直接推门进去了。整个过程是我一个人做的，没有人指使我，也没有同伙。"),
            DemoRecord("民警", "你具体拿走了哪些物品，数量是多少，你当时是否知道这些物品不属于你？"),
            DemoRecord("嫌疑人", "我拿了2台平板电脑和3部没拆封的手机，一共5件，具体品牌和型号我当时没有仔细看。我很清楚这些是便利店仓库里的货，不是我的，也没有经过店里任何人同意。我还是把它们装进包里带走了。"),
            DemoRecord("民警", "离开现场后你如何处置这些物品，有没有出售、转移、丢弃或者交给他人？"),
            DemoRecord("嫌疑人", "我把5件东西都带回了租住地，放在卧室衣柜下面的纸箱里。当天21点10分左右，我用自己的手机在二手平台发了一条卖手机的信息，想低价卖一部，但是没有成交。到22点05分左右我越想越害怕，就把发布的信息删掉了。之后东西一直在我住处，没有再转移，也没有交给别人。"),
            DemoRecord("民警", "本案是否还有其他人参与、指使、帮助或者准备收购这些物品？"),
            DemoRecord("嫌疑人", "没有。店里的赵某和陈某我知道是谁，但他们和这件事没有关系，一个是当班店员，一个是店里负责人。我没有和任何人商量过偷东西，也没有提前联系收购的人。二手平台上的信息只是我自己发布的。"),
            DemoRecord("民警", "对于门店监控、库存盘点、你手机的定位和二手平台发布记录，你有什么异议？"),
            DemoRecord("嫌疑人", "如果这些记录显示的时间和我刚才说的基本一致，我没有异议。监控里进出门店和后巷的人是我，二手平台账号也是我本人使用的，手机定位也是我的手机产生的。库存具体价值我不清楚，但我承认拿走的是那5件电子设备。"),
            DemoRecord("民警", "你现在对自己的行为怎么认识，对造成的损失准备如何处理？"),
            DemoRecord("嫌疑人", "我知道自己的行为是错误的，也愿意承担相应责任。我愿意配合把还在住处的物品全部退还，如果有实际损失我愿意依法退赔。我也愿意配合核对物品型号、数量和相关记录。"),
            DemoRecord("民警", "对刚才所述主要事实你是否承认；对于依法告知的认罪认罚相关事项，你是什么态度？"),
            DemoRecord("嫌疑人", "我承认刚才说的主要事实，这些内容是我自己陈述的。我愿意依法认罪认罚，具体法律后果和程序我会在工作人员依法告知后再确认。"),
            DemoRecord("民警", "本次讯问中是否有人对你进行威胁、引诱、欺骗或者强迫你作出上述陈述？你是否还有需要补充或更正的内容？"),
            DemoRecord("嫌疑人", "没有人威胁、引诱、欺骗或者强迫我。以上内容是我根据自己的记忆陈述的。目前没有其他需要补充的，如果后面核对具体时间、物品型号有出入，我愿意根据客观记录再作更正。"),
        )
    }
}
