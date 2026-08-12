package com.wulisu.suspect.interrogation.bridge

import org.json.JSONObject
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class NativeExternalCaptureRequestTest {
    @Test
    fun identityDeviceActionUsesDocumentCameraCapture() {
        val request = JSONObject()
            .put("action", "device.action")
            .put("payload", JSONObject().put("type", "identity"))

        assertTrue(NativeExternalCaptureRequest.isDocumentCameraCapture(request))
    }

    @Test
    fun scannerDeviceActionUsesDocumentCameraCapture() {
        val request = JSONObject()
            .put("action", "device.action")
            .put("payload", JSONObject().put("type", "scanner"))

        assertTrue(NativeExternalCaptureRequest.isDocumentCameraCapture(request))
    }

    @Test
    fun fingerprintDeviceActionDoesNotUseDocumentCameraCapture() {
        val request = JSONObject()
            .put("action", "device.action")
            .put("payload", JSONObject().put("type", "fingerprint"))

        assertFalse(NativeExternalCaptureRequest.isDocumentCameraCapture(request))
    }
}
