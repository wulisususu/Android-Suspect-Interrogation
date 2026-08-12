package com.wulisu.suspect.interrogation.llm

import android.content.Context

class LlmSettingsStore(context: Context) : LlmConfigurationStore {
    private val prefs = context.getSharedPreferences("llm_generation_settings", Context.MODE_PRIVATE)

    override fun load() = LlmGenerationConfig(
        maxNewTokens = prefs.getInt("max_new_tokens", 64),
        maxContextLen = prefs.getInt("max_context_len", 1024),
    )

    override fun save(config: LlmGenerationConfig) {
        prefs.edit()
            .putInt("max_new_tokens", config.maxNewTokens)
            .putInt("max_context_len", config.maxContextLen)
            .apply()
    }
}
