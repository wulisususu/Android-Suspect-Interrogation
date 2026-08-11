package com.wulisu.suspect.interrogation

import android.content.Context
import com.wulisu.suspect.interrogation.asr.AsrCaptureSessionManager
import com.wulisu.suspect.interrogation.asr.AsrController
import com.wulisu.suspect.interrogation.bridge.RpcRouter
import com.wulisu.suspect.interrogation.data.AppDatabase
import com.wulisu.suspect.interrogation.ocr.OcrController
import com.wulisu.suspect.interrogation.service.*
import kotlinx.coroutines.runBlocking

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
    val asrController = AsrController(context, modelManager)
    val ocrController = OcrController(context, modelManager)
    val asrCapture = AsrCaptureSessionManager(context, database, sessions, records, audit, asrController)
    private val aiSettings = AiSettingsStore(context)
    private val cloudAi = ZhipuAiProvider(aiSettings)
    private val localAi = LocalAiProvider(modelManager)
    private val aiRouter = AiRouter(aiSettings, cloudAi, localAi)
    private val ai = AiService(aiSettings, aiRouter)

    val rpcRouter = RpcRouter(cases, sessions, records, facts, timeline, audit, devices, ai, modelManager, asrController, asrCapture, ocrController)

    init {
        asrController.setCaptureListener(asrCapture)
        asrController.setCaptureRunningProvider(asrCapture::isRunning)
        modelManager.scanAsync()
        runBlocking { SeedData(cases, sessions, records).seedIfEmpty() }
    }
}
