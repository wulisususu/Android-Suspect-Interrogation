package com.wulisu.suspect.interrogation.bridge

import android.net.Uri
import android.webkit.JavascriptInterface
import android.webkit.WebView
import com.wulisu.suspect.interrogation.asr.AsrCaptureSessionManager
import com.wulisu.suspect.interrogation.asr.AsrController
import com.wulisu.suspect.interrogation.ocr.OcrController
import com.wulisu.suspect.interrogation.llm.LlmController
import com.wulisu.suspect.interrogation.llm.toJson
import com.wulisu.suspect.interrogation.service.ModelCategory
import com.wulisu.suspect.interrogation.service.ModelImportSource
import kotlinx.coroutines.*
import org.json.JSONObject

class NativeBridge(
    private val webView: WebView,
    private val router: RpcRouter,
    private val asr: AsrController,
    private val asrCapture: AsrCaptureSessionManager,
    private val ocr: OcrController,
    private val llm: LlmController,
    private val modelImportLauncher: ((String, ModelCategory, ModelImportSource) -> Unit)? = null,
    private val ocrImagePickLauncher: ((String) -> Unit)? = null,
    private val ocrCameraCaptureLauncher: ((String) -> Unit)? = null,
    private val microphonePermissionLauncher: ((String) -> Unit)? = null,
    private val llmStoragePermissionLauncher: ((String) -> Unit)? = null,
) {
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    init {
        asr.setStatusListener { status -> deliverEvent("asr.status", status.toJson().toString()) }
        asrCapture.setStatusListener { status -> deliverEvent("asr.capture.status", status.toJson().toString()) }
        ocr.setStatusListener { status -> deliverEvent("ocr.status", status.toJson().toString()) }
        llm.setStatusListener { status -> deliverEvent("llm.status", status.toJson().toString()) }
        llm.setFragmentListener { fragment -> deliverEvent("llm.fragment", fragment.toJson().toString()) }
    }

    @JavascriptInterface
    fun call(requestJson: String) {
        val request = runCatching { JSONObject(requestJson) }.getOrNull()
        if (request?.optString("action") == "model.import.request") {
            requestModelImport(request)
            return
        }
        if (request?.optString("action") == "ocr.image.pick") {
            requestOcrImagePick(request)
            return
        }
        if (request?.optString("action") == "llm.storage.permission.request") {
            requestLlmStoragePermission(request)
            return
        }
        if (request != null && NativeExternalCaptureRequest.isDocumentCameraCapture(request)) {
            requestOcrCameraCapture(request)
            return
        }
        if (request?.optString("action") in setOf("asr.start", "asr.capture.start")) {
            val launcher = microphonePermissionLauncher
                ?: return failRequest(request?.optString("id").orEmpty(), "ASR_MICROPHONE_PERMISSION_UNAVAILABLE", "当前页面无法申请麦克风权限")
            scope.launch(Dispatchers.Main) { launcher(requestJson) }
            return
        }
        dispatch(requestJson)
    }

    fun continueRequest(requestJson: String) = dispatch(requestJson)

    fun failRequest(requestId: String, code: String, message: String) {
        deliver(
            JSONObject()
                .put("id", requestId)
                .put("ok", false)
                .put("code", code)
                .put("message", message)
                .put("data", JSONObject.NULL)
                .toString(),
        )
    }

    fun continueModelImport(
        requestId: String,
        category: ModelCategory,
        source: ModelImportSource,
        uri: Uri,
    ) {
        val request = JSONObject()
            .put("id", requestId)
            .put("action", "model.import")
            .put(
                "payload",
                JSONObject()
                    .put("category", category.name)
                    .put("source", source.name)
                    .put("uri", uri.toString()),
            )
        dispatch(request.toString())
    }

    fun continueOcrImage(requestId: String, uri: Uri) {
        val request = JSONObject()
            .put("id", requestId)
            .put("action", "ocr.image.use")
            .put("payload", JSONObject().put("uri", uri.toString()))
        dispatch(request.toString())
    }

    fun continueOcrCamera(requestId: String, path: String, uri: Uri) {
        val request = JSONObject()
            .put("id", requestId)
            .put("action", "ocr.camera.use")
            .put(
                "payload",
                JSONObject()
                    .put("path", path)
                    .put("uri", uri.toString()),
            )
        dispatch(request.toString())
    }

    fun failModelImport(requestId: String, code: String, message: String) {
        failRequest(requestId, code, message)
    }

    fun failOcrImage(requestId: String, code: String, message: String) {
        failRequest(requestId, code, message)
    }

    fun completeLlmStoragePermission(requestId: String) {
        deliver(
            JSONObject()
                .put("id", requestId)
                .put("ok", true)
                .put("code", "OK")
                .put("message", "")
                .put("data", llm.status().toJson())
                .toString(),
        )
    }

    private fun requestModelImport(request: JSONObject) {
        val requestId = request.optString("id")
        val payload = request.optJSONObject("payload") ?: JSONObject()
        val category = ModelCategory.fromWire(payload.optString("category"))
        val source = ModelImportSource.fromWire(payload.optString("source"))
        if (category == null) return failModelImport(requestId, "INVALID_MODEL_CATEGORY", "无效的模型分类")
        if (source == null) return failModelImport(requestId, "INVALID_MODEL_IMPORT_SOURCE", "无效的模型导入方式")
        val launcher = modelImportLauncher
            ?: return failModelImport(requestId, "MODEL_IMPORT_UNAVAILABLE", "当前 Android 页面未配置模型文件选择器")
        scope.launch(Dispatchers.Main) { launcher(requestId, category, source) }
    }

    private fun requestOcrImagePick(request: JSONObject) {
        val launcher = ocrImagePickLauncher
            ?: return failOcrImage(request.optString("id"), "OCR_IMAGE_PICK_UNAVAILABLE", "当前 Android 页面未配置图片选择器")
        scope.launch(Dispatchers.Main) { launcher(request.optString("id")) }
    }

    private fun requestLlmStoragePermission(request: JSONObject) {
        val launcher = llmStoragePermissionLauncher
            ?: return failRequest(request.optString("id"), "LLM_STORAGE_PERMISSION_UNAVAILABLE", "当前 Android 页面无法申请模型目录权限")
        scope.launch(Dispatchers.Main) { launcher(request.optString("id")) }
    }

    private fun requestOcrCameraCapture(request: JSONObject) {
        val launcher = ocrCameraCaptureLauncher
            ?: return failOcrImage(request.optString("id"), "OCR_CAMERA_UNAVAILABLE", "当前 Android 页面未配置相机")
        scope.launch(Dispatchers.Main) { launcher(request.optString("id")) }
    }

    private fun dispatch(requestJson: String) {
        scope.launch { deliver(router.handle(requestJson)) }
    }

    private fun deliver(response: String) {
        scope.launch(Dispatchers.Main) {
            val escaped = JSONObject.quote(response)
            webView.evaluateJavascript("window.__nativeBridgeResolve && window.__nativeBridgeResolve($escaped);", null)
        }
    }

    private fun deliverEvent(name: String, payload: String) {
        scope.launch(Dispatchers.Main) {
            webView.evaluateJavascript(
                "window.__nativeBridgeEvent && window.__nativeBridgeEvent(${JSONObject.quote(name)}, ${JSONObject.quote(payload)});",
                null,
            )
        }
    }

    fun close() {
        asr.setStatusListener(null)
        asrCapture.setStatusListener(null)
        ocr.setStatusListener(null)
        llm.setStatusListener(null)
        llm.setFragmentListener(null)
        scope.cancel()
    }
}
