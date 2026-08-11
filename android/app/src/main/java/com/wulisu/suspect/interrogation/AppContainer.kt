package com.wulisu.suspect.interrogation

import android.content.Context
import com.wulisu.suspect.interrogation.bridge.RpcRouter
import com.wulisu.suspect.interrogation.data.AppDatabase
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

    private val aiSettings = AiSettingsStore(context)
    private val cloudAi = ZhipuAiProvider(aiSettings)
    private val localAi = LocalAiProvider()
    private val aiRouter = AiRouter(aiSettings, cloudAi, localAi)
    private val ai = AiService(aiSettings, aiRouter)

    val rpcRouter = RpcRouter(cases, sessions, records, facts, timeline, audit, devices, ai)

    init {
        runBlocking { SeedData(cases, sessions, records).seedIfEmpty() }
    }
}
