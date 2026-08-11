package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class AsrModelSpecTest {
    @Test
    fun `zipformer is the default RKNN model with three RKNN graphs`() {
        val spec = AsrModelSpecs.ZIPFORMER_RK3576

        assertEquals(AsrModelId.ZIPFORMER_RK3576, AsrModelSpecs.default.id)
        assertEquals("rknn", spec.provider)
        assertEquals("zipformer", spec.modelType)
        assertEquals("models/zipformer_rk3576/encoder.rknn", spec.encoder)
        assertEquals("models/zipformer_rk3576/decoder.rknn", spec.decoder)
        assertEquals("models/zipformer_rk3576/joiner.rknn", spec.joiner)
        assertTrue(spec.requiredAssets.all { it.endsWith(".rknn") || it.endsWith("tokens.txt") })
    }

    @Test
    fun `paraformer uses only INT8 ONNX files on CPU`() {
        val spec = AsrModelSpecs.PARAFORMER_INT8

        assertEquals("cpu", spec.provider)
        assertEquals("paraformer", spec.modelType)
        assertEquals(4, spec.numThreads)
        assertEquals("models/paraformer_int8/encoder.int8.onnx", spec.encoder)
        assertEquals("models/paraformer_int8/decoder.int8.onnx", spec.decoder)
        assertTrue(spec.requiredAssets.none { it.endsWith("encoder.onnx") || it.endsWith("decoder.onnx") })
    }
}

