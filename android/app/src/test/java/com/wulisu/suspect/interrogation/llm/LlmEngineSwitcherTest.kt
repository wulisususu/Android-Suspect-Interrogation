package com.wulisu.suspect.interrogation.llm

import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertSame
import org.junit.Test

class LlmEngineSwitcherTest {
    @Test
    fun `switch releases old engine before creating replacement`() {
        val events = mutableListOf<String>()
        val switcher = LlmEngineSwitcher { spec, config ->
            events += "create:${spec.id}"
            FakeEngine(spec, config) { events += "release:${spec.id}" }
        }

        switcher.switchTo(spec("one"), config())
        switcher.switchTo(spec("two"), config())

        assertEquals(listOf("create:one", "release:one", "create:two"), events)
    }

    @Test
    fun `same model and context reuses engine`() {
        var created = 0
        val switcher = LlmEngineSwitcher { spec, config ->
            FakeEngine(spec, config).also { created += 1 }
        }

        val first = switcher.switchTo(spec("one"), config())
        val second = switcher.switchTo(spec("one"), config(maxNewTokens = 128))

        assertSame(first, second)
        assertEquals(1, created)
    }

    @Test
    fun `changed context releases and recreates engine`() {
        val events = mutableListOf<String>()
        val switcher = LlmEngineSwitcher { spec, config ->
            events += "create:${config.maxContextLen}"
            FakeEngine(spec, config) { events += "release:${config.maxContextLen}" }
        }

        switcher.switchTo(spec("one"), config(maxContextLen = 1024))
        switcher.switchTo(spec("one"), config(maxContextLen = 2048))

        assertEquals(listOf("create:1024", "release:1024", "create:2048"), events)
    }

    @Test
    fun `release is idempotent`() {
        val engine = FakeEngine(spec("one"), config())
        val switcher = LlmEngineSwitcher { _, _ -> engine }
        switcher.switchTo(spec("one"), config())

        switcher.release()
        switcher.release()

        assertEquals(1, engine.releaseCount)
    }

    private class FakeEngine(
        override val modelSpec: LlmModelSpec,
        override val config: LlmGenerationConfig,
        private val onRelease: () -> Unit = {},
    ) : LlmEngine {
        var releaseCount = 0

        override suspend fun initialize() = LlmInitializationMetrics(0)

        override suspend fun generate(input: LlmInput) = LlmResult.success(input, modelSpec, 0, null, 0, emptyList())

        override suspend fun cancel() = Unit

        override fun release() {
            releaseCount += 1
            onRelease()
        }
    }

    private fun spec(id: String) = LlmModelSpec(
        id = id,
        name = id,
        absolutePath = "/models/$id.rkllm",
        sizeBytes = 1,
        targetPlatform = LlmTargetPlatform.RK3576,
    )

    private fun config(maxNewTokens: Int = 64, maxContextLen: Int = 1024) =
        LlmGenerationConfig(maxNewTokens, maxContextLen)
}
