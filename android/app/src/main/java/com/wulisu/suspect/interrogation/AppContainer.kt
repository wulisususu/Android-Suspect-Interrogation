package com.wulisu.suspect.interrogation

import android.content.Context
import com.wulisu.suspect.interrogation.asr.AsrCaptureSessionManager
import com.wulisu.suspect.interrogation.asr.AsrController
import com.wulisu.suspect.interrogation.bridge.RpcRouter
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.llm.LlmController
import com.wulisu.suspect.interrogation.llm.LlmEngineSwitcher
import com.wulisu.suspect.interrogation.llm.LlmSettingsStore
import com.wulisu.suspect.interrogation.llm.RkllmEngine
import com.wulisu.suspect.interrogation.ocr.OcrController
import com.wulisu.suspect.interrogation.service.*

class AppContainer(context: Context) {
    private val database = AppDatabase.build(context)
    private val audit = AuditService(database.auditDao())
    private val cases = CaseService(database, audit)
    private val sessions = InterrogationService(database, cases, audit)
    private val records = RecordService(database, cases, sessions, audit)
    private val facts = FactService(database.factDao(), cases)
    private val timeline = TimelineService(database.timelineDao(), cases, audit)
    private val devices = DeviceService()

    val modelManager = ModelManager(context)
    val llmController = LlmController(
        modelManager,
        LlmSettingsStore(context),
        LlmEngineSwitcher(::RkllmEngine),
    )
    val asrController = AsrController(context, modelManager)
    val ocrController = OcrController(context, modelManager)
    val asrCapture = AsrCaptureSessionManager(context, database, sessions, records, audit, asrController)
    private val aiSettings = AiSettingsStore(context)
    private val cloudAi = ZhipuAiProvider(aiSettings)
    private val localAi = LocalAiProvider(modelManager, ControllerLocalLlmRuntime(llmController))
    private val aiRouter = AiRouter(aiSettings, cloudAi, localAi)
    private val ai = AiService(aiSettings, aiRouter)
    private val caseAi = CaseAiService(
        RoomCaseAiContextSource(cases, records, facts, timeline, database.aiCaseAnalysisDao(), audit),
        aiRouter::inquiry,
        facts,
        timeline,
    )

    val rpcRouter = RpcRouter(cases, sessions, records, facts, timeline, audit, devices, ai, caseAi, modelManager, asrController, asrCapture, ocrController, llmController)

    init {
        asrController.setCaptureListener(asrCapture)
        asrController.setCaptureRunningProvider(asrCapture::isRunning)
        modelManager.scanAsync()
    }
}
