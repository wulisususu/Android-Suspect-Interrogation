package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test
import java.io.File

class AsrNativeLibraryCompatibilityTest {
    @Test
    fun `sherpa and packaged onnxruntime require the same Ort symbol version`() {
        val root = File("src/main/jniLibs/arm64-v8a")
        val sherpa = File(root, "libsherpa-onnx-jni.so").readBytes().toString(Charsets.ISO_8859_1)
        val ort = File(root, "libonnxruntime.so").readBytes().toString(Charsets.ISO_8859_1)

        assertTrue(sherpa.contains("VERS_1.27.0"))
        assertFalse(sherpa.contains("VERS_1.27.1"))
        assertTrue(ort.contains("VERS_1.27.0"))
    }
}
