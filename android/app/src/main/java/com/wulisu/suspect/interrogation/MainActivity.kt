package com.wulisu.suspect.interrogation

import android.annotation.SuppressLint
import android.Manifest
import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.view.ViewGroup
import android.webkit.*
import androidx.webkit.WebViewAssetLoader
import com.wulisu.suspect.interrogation.bridge.NativeBridge
import com.wulisu.suspect.interrogation.service.ModelCategory
import com.wulisu.suspect.interrogation.service.ModelImportSource
import kotlinx.coroutines.runBlocking
import java.io.ByteArrayInputStream

class MainActivity : Activity() {
    private lateinit var webView: WebView
    private lateinit var nativeBridge: NativeBridge
    private lateinit var appContainer: AppContainer
    private var pendingModelImport: PendingModelImport? = null
    private var pendingAsrRequest: String? = null
    private var pendingOcrImage: PendingOcrImage? = null

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val assetLoader = WebViewAssetLoader.Builder().addPathHandler("/assets/", WebViewAssetLoader.AssetsPathHandler(this)).build()
        webView = WebView(this).apply {
            layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
            settings.javaScriptEnabled = true
            settings.domStorageEnabled = true
            settings.cacheMode = WebSettings.LOAD_DEFAULT
            settings.allowFileAccess = false
            settings.allowContentAccess = true
            settings.mixedContentMode = WebSettings.MIXED_CONTENT_NEVER_ALLOW
            settings.setSupportMultipleWindows(false)
            webViewClient = object : WebViewClient() {
                override fun shouldInterceptRequest(view: WebView, request: WebResourceRequest): WebResourceResponse? {
                    if (request.url.scheme == "content") return null
                    if (request.url.host != "appassets.androidplatform.net") return WebResourceResponse("text/plain", "utf-8", ByteArrayInputStream(ByteArray(0)))
                    return assetLoader.shouldInterceptRequest(request.url)
                }
                override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean = request.url.host != "appassets.androidplatform.net"
            }
        }
        appContainer = (application as SuspectApplication).container
        nativeBridge = NativeBridge(
            webView,
            appContainer.rpcRouter,
            appContainer.asrController,
            appContainer.asrCapture,
            appContainer.ocrController,
            ::launchModelImport,
            ::launchOcrImagePick,
            ::launchOcrCameraCapture,
            ::ensureMicrophonePermission,
        )
        webView.addJavascriptInterface(nativeBridge, "NativeBridge")
        setContentView(webView)
        webView.loadUrl("https://appassets.androidplatform.net/assets/webapp/index.html")
    }

    private fun ensureMicrophonePermission(requestJson: String) {
        if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED) {
            nativeBridge.continueRequest(requestJson)
            return
        }
        pendingAsrRequest = requestJson
        requestPermissions(arrayOf(Manifest.permission.RECORD_AUDIO), REQUEST_RECORD_AUDIO)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != REQUEST_RECORD_AUDIO) return
        val request = pendingAsrRequest ?: return
        pendingAsrRequest = null
        if (grantResults.firstOrNull() == PackageManager.PERMISSION_GRANTED) {
            nativeBridge.continueRequest(request)
        } else {
            val requestId = runCatching { org.json.JSONObject(request).optString("id") }.getOrDefault("")
            nativeBridge.failRequest(requestId, "ASR_MICROPHONE_PERMISSION_DENIED", "麦克风权限被拒绝，无法开始离线识别")
        }
    }

    @Deprecated("The legacy result callback keeps this Activity dependency-free and supports API 23.")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_OCR_IMAGE) {
            val pending = pendingOcrImage ?: return
            pendingOcrImage = null
            val uri = data?.data
            if (resultCode != RESULT_OK || uri == null) {
                nativeBridge.failOcrImage(pending.requestId, "OCR_IMAGE_PICK_CANCELLED", "已取消选择图片")
                return
            }
            nativeBridge.continueOcrImage(pending.requestId, uri)
            return
        }
        if (requestCode == REQUEST_OCR_CAMERA) {
            val pending = pendingOcrImage ?: return
            pendingOcrImage = null
            if (resultCode != RESULT_OK || pending.filePath == null || pending.uri == null) {
                nativeBridge.failOcrImage(pending.requestId, "OCR_CAMERA_CANCELLED", "已取消拍照")
                return
            }
            nativeBridge.continueOcrCamera(pending.requestId, pending.filePath, pending.uri)
            return
        }
        if (requestCode != REQUEST_MODEL_FILE && requestCode != REQUEST_MODEL_DIRECTORY) return
        val pending = pendingModelImport ?: return
        pendingModelImport = null
        val uri = data?.data
        if (resultCode != RESULT_OK || uri == null) {
            nativeBridge.failModelImport(pending.requestId, "MODEL_IMPORT_CANCELLED", "已取消模型导入")
            return
        }

        runCatching {
            contentResolver.takePersistableUriPermission(uri, Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        nativeBridge.continueModelImport(pending.requestId, pending.category, pending.source, uri)
    }

    private fun launchModelImport(
        requestId: String,
        category: ModelCategory,
        source: ModelImportSource,
    ) {
        if (pendingModelImport != null) {
            nativeBridge.failModelImport(requestId, "MODEL_IMPORT_BUSY", "已有模型正在等待选择")
            return
        }

        val intent = when (source) {
            ModelImportSource.FILE -> Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                addCategory(Intent.CATEGORY_OPENABLE)
                type = "*/*"
            }
            ModelImportSource.DIRECTORY -> Intent(Intent.ACTION_OPEN_DOCUMENT_TREE)
        }.apply {
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
        }

        pendingModelImport = PendingModelImport(requestId, category, source)
        try {
            startActivityForResult(
                Intent.createChooser(intent, "选择 ${category.displayName} 模型"),
                if (source == ModelImportSource.FILE) REQUEST_MODEL_FILE else REQUEST_MODEL_DIRECTORY,
            )
        } catch (error: ActivityNotFoundException) {
            pendingModelImport = null
            nativeBridge.failModelImport(requestId, "MODEL_PICKER_UNAVAILABLE", "设备上没有可用的文件管理器")
        }
    }

    private fun launchOcrImagePick(requestId: String) {
        if (pendingOcrImage != null) {
            nativeBridge.failOcrImage(requestId, "OCR_IMAGE_PICK_BUSY", "已有 OCR 图片选择正在进行")
            return
        }
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "image/*"
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        pendingOcrImage = PendingOcrImage(requestId)
        try {
            startActivityForResult(Intent.createChooser(intent, "选择 OCR 图片"), REQUEST_OCR_IMAGE)
        } catch (error: ActivityNotFoundException) {
            pendingOcrImage = null
            nativeBridge.failOcrImage(requestId, "OCR_IMAGE_PICKER_UNAVAILABLE", "设备上没有可用的图片选择器")
        }
    }

    private fun launchOcrCameraCapture(requestId: String) {
        if (pendingOcrImage != null) {
            nativeBridge.failOcrImage(requestId, "OCR_CAMERA_BUSY", "已有 OCR 拍照正在进行")
            return
        }
        val (file, uri) = appContainer.ocrController.createCameraCaptureTarget()
        val intent = Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE).apply {
            putExtra(android.provider.MediaStore.EXTRA_OUTPUT, uri)
            addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION or Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        pendingOcrImage = PendingOcrImage(requestId, file.absolutePath, uri)
        try {
            startActivityForResult(intent, REQUEST_OCR_CAMERA)
        } catch (error: ActivityNotFoundException) {
            pendingOcrImage = null
            nativeBridge.failOcrImage(requestId, "OCR_CAMERA_UNAVAILABLE", "设备上没有可用的相机应用")
        }
    }

    override fun onDestroy() {
        pendingModelImport?.let {
            nativeBridge.failModelImport(it.requestId, "MODEL_IMPORT_CANCELLED", "页面已关闭，模型导入已取消")
        }
        pendingModelImport = null
        pendingAsrRequest = null
        pendingOcrImage?.let {
            nativeBridge.failOcrImage(it.requestId, "OCR_IMAGE_CANCELLED", "页面已关闭，OCR 图片操作已取消")
        }
        pendingOcrImage = null
        runBlocking { appContainer.asrCapture.stopActive() }
        appContainer.asrController.release()
        appContainer.ocrController.release()
        nativeBridge.close(); webView.removeJavascriptInterface("NativeBridge"); webView.destroy(); super.onDestroy()
    }

    private data class PendingModelImport(
        val requestId: String,
        val category: ModelCategory,
        val source: ModelImportSource,
    )

    private data class PendingOcrImage(
        val requestId: String,
        val filePath: String? = null,
        val uri: Uri? = null,
    )

    companion object {
        private const val REQUEST_MODEL_FILE = 4101
        private const val REQUEST_MODEL_DIRECTORY = 4102
        private const val REQUEST_RECORD_AUDIO = 4103
        private const val REQUEST_OCR_IMAGE = 4104
        private const val REQUEST_OCR_CAMERA = 4105
    }
}
