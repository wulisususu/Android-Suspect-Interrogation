package com.wulisu.suspect.interrogation.llm

import com.wulisu.suspect.interrogation.domain.BusinessException
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

class LlmControllerTest {
    @Test
    fun `select rejects incompatible model without releasing current engine`() = runBlocking {
        val current = spec("one")
        val incompatible = spec(
            id = "rk3588",
            targetPlatform = LlmTargetPlatform.RK3588,
            compatibility = LlmCompatibility.PLATFORM_MISMATCH,
        )
        val repository = FakeRepository(current, listOf(current, incompatible))
        val engine = BlockingFakeEngine(current, config())
        val controller = controller(repository, engine)

        val error = runCatching { controller.selectModel(incompatible.id) }.exceptionOrNull() as BusinessException

        assertEquals("LLM_PLATFORM_MISMATCH", error.code)
        assertEquals(0, engine.releaseCount)
        assertEquals(current.id, repository.selected()?.id)
    }

    @Test
    fun `select releases old engine before persisting compatible model`() = runBlocking {
        val events = mutableListOf<String>()
        val current = spec("one")
        val next = spec("two")
        val repository = FakeRepository(current, listOf(current, next), events)
        val engine = BlockingFakeEngine(current, config()) { events += "release" }
        val controller = controller(repository, engine)

        controller.selectModel(next.id)

        assertEquals(listOf("release", "persist:${next.id}"), events)
        assertEquals(next.id, repository.selected()?.id)
    }

    @Test
    fun `parallel generate is rejected and cancel permits a later generate`() = runBlocking {
        val repository = FakeRepository(spec("one"))
        val engine = BlockingFakeEngine(repository.selected()!!, config())
        val controller = controller(repository, engine)

        val first = async(Dispatchers.Default) {
            controller.generate(LlmInput("g1", "first", config()))
        }
        assertTrue(engine.started.await(5, TimeUnit.SECONDS))

        val error = runCatching {
            controller.generate(LlmInput("g2", "second", config()))
        }.exceptionOrNull() as BusinessException
        assertEquals("LLM_GENERATION_BUSY", error.code)

        controller.cancel()
        assertFalse(first.await().finished)
        assertEquals(null, controller.status().error)
        assertEquals("third", controller.generate(LlmInput("g3", "third", config())).outputText)
    }

    @Test
    fun `controller release is idempotent`() = runBlocking {
        val repository = FakeRepository(spec("one"))
        val engine = BlockingFakeEngine(repository.selected()!!, config())
        val controller = controller(repository, engine)

        controller.release()
        controller.release()

        assertEquals(1, engine.releaseCount)
    }

    private fun controller(repository: FakeRepository, engine: BlockingFakeEngine): LlmController {
        val switcher = LlmEngineSwitcher { _, _ -> engine }
        switcher.switchTo(repository.selected()!!, engine.config)
        return LlmController(repository, FakeConfigurationStore(), switcher)
    }

    private class FakeRepository(
        initial: LlmModelSpec?,
        private val models: List<LlmModelSpec> = listOfNotNull(initial),
        private val events: MutableList<String> = mutableListOf(),
    ) : LlmModelRepository {
        private var current = initial

        override fun selected(): LlmModelSpec? = current
        override fun find(modelId: String): LlmModelSpec? = models.firstOrNull { it.id == modelId }
        override fun persistSelection(modelId: String?) {
            events += "persist:$modelId"
            current = modelId?.let(::find)
        }
        override fun storagePermissionGranted(): Boolean = true
    }

    private class FakeConfigurationStore : LlmConfigurationStore {
        private var value = config()
        override fun load(): LlmGenerationConfig = value
        override fun save(config: LlmGenerationConfig) {
            value = config
        }
    }

    private class BlockingFakeEngine(
        override val modelSpec: LlmModelSpec,
        override val config: LlmGenerationConfig,
        private val onRelease: () -> Unit = {},
    ) : LlmEngine {
        val started = CountDownLatch(1)
        private val cancelled = CountDownLatch(1)
        var releaseCount = 0
        private var generationCount = 0

        override suspend fun initialize() = LlmInitializationMetrics(7)

        override suspend fun generate(input: LlmInput): LlmResult {
            generationCount += 1
            if (generationCount == 1) {
                started.countDown()
                cancelled.await(5, TimeUnit.SECONDS)
                return LlmResult.cancelled(input, modelSpec, 7, 9)
            }
            input.fragmentListener?.invoke(LlmFragment(input.generationId, input.prompt, input.prompt, null, 1))
            return LlmResult.success(input, modelSpec, 7, 1, 2, listOf(input.prompt))
        }

        override suspend fun cancel() {
            cancelled.countDown()
        }

        override fun release() {
            releaseCount += 1
            onRelease()
        }
    }

    companion object {
        private fun spec(
            id: String,
            targetPlatform: LlmTargetPlatform = LlmTargetPlatform.RK3576,
            compatibility: LlmCompatibility = LlmCompatibility.READY,
        ) = LlmModelSpec(
            id = id,
            name = id,
            absolutePath = "/models/$id.rkllm",
            sizeBytes = 1,
            targetPlatform = targetPlatform,
            complete = true,
            compatibility = compatibility,
        )

        private fun config() = LlmGenerationConfig(64, 1024)
    }
}
