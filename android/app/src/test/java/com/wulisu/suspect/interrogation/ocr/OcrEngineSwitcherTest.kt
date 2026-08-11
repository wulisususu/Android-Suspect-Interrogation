package com.wulisu.suspect.interrogation.ocr

import org.junit.Assert.assertEquals
import org.junit.Assert.assertSame
import org.junit.Assert.assertNull
import org.junit.Test

class OcrEngineSwitcherTest {
    @Test
    fun `switching to a different model releases the previous engine`() {
        val first = FakeOcrEngine(OcrKnownModels.PPOCR_V4_ONNX)
        val second = FakeOcrEngine(OcrKnownModels.PPOCR_V6_SMALL_PADDLE)
        val switcher = OcrEngineSwitcher { spec ->
            if (spec.id == first.modelSpec.id) first else second
        }

        assertSame(first, switcher.switchTo(OcrKnownModels.PPOCR_V4_ONNX))
        assertSame(second, switcher.switchTo(OcrKnownModels.PPOCR_V6_SMALL_PADDLE))

        assertEquals(1, first.releaseCount)
        assertEquals(0, second.releaseCount)
        assertSame(second, switcher.currentEngine)
    }

    @Test
    fun `release clears the only resident engine`() {
        val engine = FakeOcrEngine(OcrKnownModels.PPOCR_V4_ONNX)
        val switcher = OcrEngineSwitcher { engine }

        switcher.switchTo(OcrKnownModels.PPOCR_V4_ONNX)
        switcher.release()

        assertEquals(1, engine.releaseCount)
        assertNull(switcher.currentEngine)
    }

    private class FakeOcrEngine(override val modelSpec: OcrModelSpec) : OcrEngine {
        var releaseCount = 0
        override fun initialize() = OcrInitializationMetrics(0)
        override fun recognize(input: OcrInput): OcrResult = OcrResult.empty(modelSpec, 0, 0, null, null)
        override fun release() {
            releaseCount += 1
        }
    }
}
