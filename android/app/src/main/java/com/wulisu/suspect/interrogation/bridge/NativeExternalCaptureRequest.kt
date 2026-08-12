package com.wulisu.suspect.interrogation.bridge

import org.json.JSONObject

object NativeExternalCaptureRequest {
    fun isDocumentCameraCapture(request: JSONObject?): Boolean {
        if (request == null) return false
        val action = request.optString("action")
        if (action == "ocr.camera.capture") return true
        if (action != "device.action") return false
        val type = request.optJSONObject("payload")?.optString("type").orEmpty()
        return type == "identity" || type == "scanner"
    }
}
