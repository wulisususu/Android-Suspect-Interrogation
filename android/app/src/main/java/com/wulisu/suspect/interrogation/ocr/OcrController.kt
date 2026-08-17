package com.wulisu.suspect.interrogation.ocr

import android.content.Context
import android.net.Uri
import android.os.SystemClock
import android.util.Log
import androidx.core.content.FileProvider
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.service.LocalModelCatalog
import com.wulisu.suspect.interrogation.service.LocalModelDescriptor
import com.wulisu.suspect.interrogation.service.ModelCategory
import com.wulisu.suspect.interrogation.service.ModelManager
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.InputStream
import java.util.UUID

data class OcrRuntimeStatus(
    val selectedModelId: String?,
    val selectedModelName: String?,
    val activeModelId: String?,
    val provider: String?,
    val modelFormat: String?,
    val initialized: Boolean,
    val busy: Boolean,
    val imageReady: Boolean,
    val previewUri: String?,
    val initializationMs: Long?,
    val recognitionMs: Long?,
    val lastResult: OcrResult?,
    val error: String?,
)

data class OcrPreviewResource(
    val mimeType: String,
    val stream: InputStream,
)

class OcrController(
    private val context: Context,
    private val modelManager: ModelManager,
) {
    private val operationLock = Any()
    private val controlLock = Any()
    private val cacheRoot = File(context.cacheDir, "ocr").apply { mkdirs() }
    @Volatile
    private var activeModelRoot: File? = null
    private val switcher = OcrEngineSwitcher { spec ->
        when {
            spec.provider == "onnxruntime-cpu" -> OnnxPpocrV4Engine(
                modelRoot = requireNotNull(activeModelRoot),
                dictionary = loadPpocrV4Dictionary(requireNotNull(activeModelRoot)),
                modelSpec = spec,
            )
            spec.provider == "paddle-inference" -> PaddlePirOcrEngine(spec)
            else -> throw BusinessException("OCR_RUNTIME_UNSUPPORTED", "不支持的 OCR provider: ${spec.provider}")
        }
    }

    @Volatile
    private var statusListener: ((OcrRuntimeStatus) -> Unit)? = null
    @Volatile
    private var currentImage: File? = null
    @Volatile
    private var currentPreviewUri: String? = null
    @Volatile
    private var currentPreviewMimeType: String = "image/jpeg"
    @Volatile
    private var state = initialStatus()

    fun setStatusListener(listener: ((OcrRuntimeStatus) -> Unit)?) {
        statusListener = listener
    }

    fun status(): OcrRuntimeStatus = synchronized(controlLock) {
        state = state.withSelected(resolveSelectedDescriptor())
        state
    }

    fun selectModel(modelId: String?): LocalModelCatalog = synchronized(operationLock) {
        val cleanId = modelId?.trim().orEmpty()
        if (cleanId.isBlank()) {
            switcher.release()
            activeModelRoot = null
            val catalog = modelManager.select(ModelCategory.OCR, null)
            synchronized(controlLock) {
                state = initialStatus().copy(imageReady = currentImage?.isFile == true, previewUri = currentPreviewUri)
                emitState()
            }
            return@synchronized catalog
        }
        val descriptor = modelManager.list().models.firstOrNull { it.category == ModelCategory.OCR && it.id == cleanId }
            ?: throw BusinessException("OCR_MODEL_NOT_FOUND", "所选 OCR 模型不存在，请重新扫描")
        if (!descriptor.complete) throw BusinessException("OCR_MODEL_INCOMPLETE", "OCR 模型文件不完整")
        if (!descriptor.runtimeReady) {
            throw BusinessException("OCR_RUNTIME_UNAVAILABLE", "OCR 模型 ${descriptor.name} 与当前 APK runtime 不匹配")
        }
        switcher.release()
        activeModelRoot = null
        val catalog = modelManager.select(ModelCategory.OCR, descriptor.id)
        synchronized(controlLock) {
            state = state.withSelected(descriptor).copy(
                activeModelId = null,
                initialized = false,
                initializationMs = null,
                recognitionMs = null,
                error = null,
            )
            emitState()
        }
        catalog
    }

    fun useImage(uri: Uri): OcrRuntimeStatus = synchronized(operationLock) {
        val file = copyImageToCache(uri)
        synchronized(controlLock) {
            currentImage?.takeIf { it != file }?.delete()
            currentImage = file
            currentPreviewMimeType = context.contentResolver.getType(uri)
                ?.takeIf { it.startsWith("image/") }
                ?: "image/jpeg"
            currentPreviewUri = previewUrl()
            state = state.copy(
                imageReady = true,
                previewUri = currentPreviewUri,
                recognitionMs = null,
                lastResult = null,
                error = null,
            )
            emitState()
            state
        }
    }

    fun createCameraCaptureTarget(): Pair<File, Uri> {
        cacheRoot.mkdirs()
        val file = File(cacheRoot, "capture-${System.currentTimeMillis()}.jpg")
        val uri = FileProvider.getUriForFile(context, "${context.packageName}.files", file)
        return file to uri
    }

    fun useCapturedImage(file: File, uri: Uri): OcrRuntimeStatus = synchronized(operationLock) {
        if (!file.isFile || file.length() == 0L) {
            throw BusinessException("OCR_CAPTURE_EMPTY", "相机没有返回可用图片")
        }
        synchronized(controlLock) {
            currentImage?.takeIf { it != file }?.delete()
            currentImage = file
            currentPreviewMimeType = "image/jpeg"
            currentPreviewUri = previewUrl()
            state = state.copy(
                imageReady = true,
                previewUri = currentPreviewUri,
                recognitionMs = null,
                lastResult = null,
                error = null,
            )
            emitState()
            state
        }
    }

    fun openPreview(): OcrPreviewResource? = synchronized(operationLock) {
        val image = currentImage?.takeIf { it.isFile } ?: return@synchronized null
        OcrPreviewResource(currentPreviewMimeType, FileInputStream(image))
    }

    fun recognize(): OcrResult = synchronized(operationLock) {
        val image = currentImage?.takeIf { it.isFile }
            ?: throw BusinessException("OCR_IMAGE_REQUIRED", "请先选择图片或拍照")
        val descriptor = resolveSelectedDescriptor()
            ?: throw BusinessException("OCR_MODEL_REQUIRED", "请先选择可运行的 OCR 模型")
        if (!descriptor.complete) throw BusinessException("OCR_MODEL_INCOMPLETE", "OCR 模型文件不完整")
        if (!descriptor.runtimeReady) throw BusinessException("OCR_RUNTIME_UNAVAILABLE", "当前 OCR 模型与 APK runtime 不匹配")
        val spec = specFromDescriptor(descriptor)
        activeModelRoot = File(descriptor.absolutePath)
        val engine = switcher.switchTo(spec)
        synchronized(controlLock) {
            state = state.withSelected(descriptor).copy(
                activeModelId = descriptor.id,
                busy = true,
                error = null,
            )
            emitState()
        }
        try {
            val result = engine.recognize(OcrInput(image)).copy(previewUri = currentPreviewUri)
            synchronized(controlLock) {
                state = state.copy(
                    busy = false,
                    initialized = true,
                    initializationMs = result.initializationMs,
                    recognitionMs = result.recognitionMs,
                    lastResult = result,
                    error = null,
                )
                emitState()
            }
            result
        } catch (error: Throwable) {
            synchronized(controlLock) {
                state = state.copy(
                    busy = false,
                    initialized = false,
                    error = error.message ?: "OCR 识别失败",
                )
                emitState()
            }
            throw error
        }
    }

    fun release(): OcrRuntimeStatus = synchronized(operationLock) {
        switcher.release()
        activeModelRoot = null
        synchronized(controlLock) {
            state = state.copy(activeModelId = null, initialized = false, busy = false)
            emitState()
            state
        }
    }

    private fun copyImageToCache(uri: Uri): File {
        cacheRoot.mkdirs()
        val file = File(cacheRoot, "image-${UUID.randomUUID()}.jpg")
        val input = context.contentResolver.openInputStream(uri)
            ?: throw BusinessException("OCR_IMAGE_READ_FAILED", "无法读取所选图片")
        input.use { source ->
            FileOutputStream(file).use { target -> source.copyTo(target) }
        }
        if (file.length() == 0L) {
            file.delete()
            throw BusinessException("OCR_IMAGE_EMPTY", "所选图片为空")
        }
        return file
    }

    private fun resolveSelectedDescriptor(): LocalModelDescriptor? =
        modelManager.selected(ModelCategory.OCR)

    private fun previewUrl(): String =
        "https://appassets.androidplatform.net/ocr-preview/current?version=${SystemClock.elapsedRealtime()}"

    private fun specFromDescriptor(descriptor: LocalModelDescriptor): OcrModelSpec {
        val known = when (descriptor.modelFormat) {
            OcrModelFormat.ONNX.wireValue -> OcrKnownModels.PPOCR_V4_ONNX
            OcrModelFormat.PADDLE_PIR.wireValue -> OcrKnownModels.PPOCR_V6_SMALL_PADDLE
            else -> throw BusinessException("OCR_MODEL_UNSUPPORTED", "不支持的 OCR 模型格式")
        }
        return known.copy(
            id = descriptor.id,
            displayName = descriptor.name,
            version = descriptor.version ?: known.version,
        )
    }

    private fun loadPpocrV4Dictionary(modelRoot: File): List<String> {
        val dictionaryFile = File(modelRoot, "ppocr_keys_v1.txt")
        if (!dictionaryFile.isFile || !dictionaryFile.canRead()) {
            throw BusinessException("OCR_DICTIONARY_MISSING", "无法读取 OCR 字典 ${dictionaryFile.absolutePath}")
        }
        val entries = dictionaryFile.bufferedReader(Charsets.UTF_8).useLines { lines ->
            lines.map { it }.toList()
        }
        return listOf("") + entries + listOf(" ")
    }

    private fun initialStatus() = OcrRuntimeStatus(
        selectedModelId = null,
        selectedModelName = null,
        activeModelId = null,
        provider = null,
        modelFormat = null,
        initialized = false,
        busy = false,
        imageReady = false,
        previewUri = null,
        initializationMs = null,
        recognitionMs = null,
        lastResult = null,
        error = null,
    ).withSelected(resolveSelectedDescriptor())

    private fun OcrRuntimeStatus.withSelected(descriptor: LocalModelDescriptor?) = copy(
        selectedModelId = descriptor?.id,
        selectedModelName = descriptor?.name,
        provider = descriptor?.provider,
        modelFormat = descriptor?.modelFormat,
    )

    private fun emitState() {
        statusListener?.invoke(state)
    }

    companion object {
        private const val TAG = "OfflineOcr"
    }
}
