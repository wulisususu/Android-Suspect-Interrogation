package com.wulisu.suspect.interrogation.service

import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Environment
import androidx.documentfile.provider.DocumentFile
import com.wulisu.suspect.interrogation.asr.AsrModelSpecs
import com.wulisu.suspect.interrogation.asr.BundledAsrModels
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.llm.LlmCompatibility
import com.wulisu.suspect.interrogation.llm.LlmDevicePlatform
import com.wulisu.suspect.interrogation.llm.LlmModelMetadata
import com.wulisu.suspect.interrogation.llm.LlmModelMetadataStore
import com.wulisu.suspect.interrogation.llm.LlmModelProbe
import com.wulisu.suspect.interrogation.llm.LlmModelRepository
import com.wulisu.suspect.interrogation.llm.LlmModelSpec
import com.wulisu.suspect.interrogation.llm.LlmTargetPlatform
import com.wulisu.suspect.interrogation.llm.RKLLM_RUNTIME_VERSION
import com.wulisu.suspect.interrogation.llm.rkllmProvider
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.currentCoroutineContext
import kotlinx.coroutines.ensureActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream
import java.security.MessageDigest
import java.util.UUID

class ModelManager(
    private val context: Context,
    private val scanner: ModelCatalogScanner = ModelCatalogScanner(),
) : LlmModelRepository {
    private val root = File(context.filesDir, "models")
    private val prefs = context.getSharedPreferences("local_model_settings", Context.MODE_PRIVATE)
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val bundledAsrModels = BundledAsrModels(context)
    private val llmRoot = File("/sdcard/models")
    private val externalModelRoots = listOf(llmRoot)

    @Volatile
    private var cachedCatalog = LocalModelCatalog(root.absolutePath, emptyList())
    @Volatile
    private var hasScanned = false

    fun scanAsync() {
        scope.launch { runCatching { scan() } }
    }

    @Synchronized
    fun scan(): LocalModelCatalog {
        val selectedIds = ModelCategory.entries.associateWith { category ->
            prefs.getString(selectionKey(category), null).orEmpty()
        }.filterValues { it.isNotBlank() }.toMutableMap()
        if (selectedIds[ModelCategory.ASR].isNullOrBlank()) {
            selectedIds[ModelCategory.ASR] = AsrModelSpecs.default.id.catalogId
            prefs.edit().putString(selectionKey(ModelCategory.ASR), AsrModelSpecs.default.id.catalogId).apply()
        }

        val fileCatalog = scanner.scan(
            root,
            selectedIds,
            externalRoots = externalModelRoots,
            devicePlatform = devicePlatform(),
        )
        var models = fileCatalog.models + bundledAsrModels.descriptors(selectedIds[ModelCategory.ASR])
        if (models.none { it.category == ModelCategory.ASR && it.selected }) {
            val defaultId = AsrModelSpecs.default.id.catalogId
            selectedIds[ModelCategory.ASR] = defaultId
            prefs.edit().putString(selectionKey(ModelCategory.ASR), defaultId).apply()
            models = fileCatalog.models.map { it.copy(selected = false) } + bundledAsrModels.descriptors(defaultId)
        }
        val catalog = LocalModelCatalog(fileCatalog.rootPath, models)
        clearMissingSelections(
            catalog,
            selectedIds,
            preserveMissingCategories = if (storagePermissionGranted()) emptySet() else setOf(ModelCategory.LLM),
        )
        cachedCatalog = catalog
        hasScanned = true
        return catalog
    }

    fun list(): LocalModelCatalog = scan()

    fun selected(category: ModelCategory): LocalModelDescriptor? =
        (if (hasScanned) cachedCatalog else scan()).selected(category)

    @Synchronized
    fun select(category: ModelCategory, modelId: String?): LocalModelCatalog {
        val cleanId = modelId?.trim().orEmpty()
        if (cleanId.isEmpty()) {
            prefs.edit().remove(selectionKey(category)).apply()
            return scan()
        }

        val model = scan().models.firstOrNull { it.category == category && it.id == cleanId }
            ?: throw BusinessException("MODEL_NOT_FOUND", "所选 ${category.displayName} 模型不存在，请重新扫描")
        prefs.edit().putString(selectionKey(category), model.id).apply()
        return scan()
    }

    suspend fun importFromUri(
        category: ModelCategory,
        source: ModelImportSource,
        uri: Uri,
    ): LocalModelCatalog = withContext(Dispatchers.IO) {
        if (category == ModelCategory.LLM) {
            return@withContext importLlmFromUri(source, uri)
        }
        val document = when (source) {
            ModelImportSource.FILE -> DocumentFile.fromSingleUri(context, uri)
            ModelImportSource.DIRECTORY -> DocumentFile.fromTreeUri(context, uri)
        } ?: throw BusinessException("MODEL_IMPORT_SOURCE_INVALID", "无法读取所选模型")

        if (source == ModelImportSource.FILE && !document.isFile) {
            throw BusinessException("MODEL_IMPORT_SOURCE_INVALID", "请选择模型文件")
        }
        if (source == ModelImportSource.DIRECTORY && !document.isDirectory) {
            throw BusinessException("MODEL_IMPORT_SOURCE_INVALID", "请选择模型目录")
        }

        val categoryRoot = File(root, category.directoryName).apply { mkdirs() }
        val sourceSize = document.length()
        if (sourceSize > 0 && sourceSize > categoryRoot.usableSpace) {
            throw BusinessException("MODEL_STORAGE_INSUFFICIENT", "设备存储空间不足，无法导入该模型")
        }
        val sourceName = safeStorageName(document.name ?: "model-${System.currentTimeMillis()}")
        val destination = uniqueDestination(categoryRoot, sourceName)
        val temporary = File(categoryRoot, ".importing-${UUID.randomUUID()}")

        try {
            copyDocument(document, temporary)
            if (!temporary.renameTo(destination)) {
                throw BusinessException("MODEL_IMPORT_COMMIT_FAILED", "模型复制完成，但无法写入模型目录")
            }
            scan()
        } catch (error: CancellationException) {
            temporary.deleteRecursively()
            throw error
        } catch (error: BusinessException) {
            temporary.deleteRecursively()
            throw error
        } catch (error: Throwable) {
            temporary.deleteRecursively()
            throw BusinessException("MODEL_IMPORT_FAILED", error.message ?: "模型导入失败")
        }
    }

    override fun selected(): LlmModelSpec? = selected(ModelCategory.LLM)?.toLlmModelSpec()

    override fun find(modelId: String): LlmModelSpec? =
        scan().models.firstOrNull { it.category == ModelCategory.LLM && it.id == modelId }?.toLlmModelSpec()

    override fun persistSelection(modelId: String?) {
        select(ModelCategory.LLM, modelId)
    }

    override fun storagePermissionGranted(): Boolean = when {
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.R -> Environment.isExternalStorageManager()
        else -> llmRoot.canRead() && llmRoot.canWrite()
    }

    override fun devicePlatform(): LlmTargetPlatform = LlmDevicePlatform.fromProperties(
        socModel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) Build.SOC_MODEL.orEmpty() else "",
        device = Build.DEVICE.orEmpty(),
        board = Build.BOARD.orEmpty(),
        hardware = Build.HARDWARE.orEmpty(),
    )

    private suspend fun importLlmFromUri(source: ModelImportSource, uri: Uri): LocalModelCatalog {
        if (!storagePermissionGranted()) {
            throw BusinessException("LLM_STORAGE_PERMISSION_REQUIRED", "请先授权 App 访问 Android 设备模型目录")
        }
        if (source != ModelImportSource.FILE) {
            throw BusinessException("MODEL_IMPORT_SOURCE_INVALID", "LLM 只能导入单个 .rkllm 文件")
        }
        val document = DocumentFile.fromSingleUri(context, uri)
            ?: throw BusinessException("MODEL_IMPORT_SOURCE_INVALID", "无法读取所选 LLM 模型")
        if (!document.isFile) throw BusinessException("MODEL_IMPORT_SOURCE_INVALID", "请选择 .rkllm 模型文件")
        val sourceName = safeStorageName(document.name ?: "model.rkllm")
        if (!sourceName.endsWith(".rkllm", ignoreCase = true)) {
            throw BusinessException("LLM_MODEL_UNSUPPORTED", "请选择 .rkllm 模型文件")
        }
        if (!llmRoot.exists() && !llmRoot.mkdirs()) {
            throw BusinessException("MODEL_IMPORT_WRITE_FAILED", "无法创建 Android 设备模型目录")
        }

        val destination = File(llmRoot, sourceName)
        val metadataDestination = LlmModelMetadataStore.sidecarFor(destination)
        if (destination.exists()) {
            throw BusinessException("MODEL_IMPORT_NAME_CONFLICT", "同名 LLM 模型已存在，请先移除或重命名")
        }
        if (metadataDestination.exists() && !metadataDestination.delete()) {
            throw BusinessException("MODEL_IMPORT_NAME_CONFLICT", "存在无法清理的同名 LLM metadata")
        }

        val expectedSize = document.length()
        if (expectedSize > 0 && expectedSize > llmRoot.usableSpace) {
            throw BusinessException("MODEL_STORAGE_INSUFFICIENT", "设备存储空间不足，无法导入该 LLM 模型")
        }

        val importId = UUID.randomUUID().toString()
        val temporary = File(llmRoot, ".importing-$importId.rkllm.part")
        val temporaryMetadata = File(llmRoot, ".importing-$importId.rkllm.json.part")
        var metadataCommitted = false
        var modelCommitted = false

        try {
            val copied = copyLlmWithSha256(document.uri, temporary)
            if (copied.size <= 0L || temporary.length() != copied.size) {
                throw BusinessException("MODEL_IMPORT_INCOMPLETE", "LLM 模型复制结果为空或大小异常")
            }
            if (expectedSize > 0L && copied.size != expectedSize) {
                throw BusinessException("MODEL_IMPORT_INCOMPLETE", "LLM 模型复制不完整")
            }

            val metadata = LlmModelMetadata(
                name = sourceName.removeSuffixIgnoreCase(".rkllm"),
                platform = LlmModelProbe.inferTrustedImportPlatform(sourceName),
                runtimeVersion = RKLLM_RUNTIME_VERSION,
                quantization = LlmModelProbe.inferQuantization(sourceName) ?: "UNKNOWN",
                size = copied.size,
                sha256 = copied.sha256,
                modelFormat = "RKLLM",
            )
            writeTextAndSync(temporaryMetadata, metadata.toJson().toString(2))

            if (!temporaryMetadata.renameTo(metadataDestination)) {
                throw BusinessException("MODEL_IMPORT_COMMIT_FAILED", "LLM metadata 无法原子写入模型目录")
            }
            metadataCommitted = true

            if (!temporary.renameTo(destination)) {
                throw BusinessException("MODEL_IMPORT_COMMIT_FAILED", "LLM 模型复制完成，但无法原子写入设备模型目录")
            }
            modelCommitted = true
            return scan()
        } catch (error: CancellationException) {
            throw error
        } catch (error: BusinessException) {
            throw error
        } catch (error: Throwable) {
            throw BusinessException("MODEL_IMPORT_FAILED", error.message ?: "LLM 模型导入失败")
        } finally {
            temporary.delete()
            temporaryMetadata.delete()
            if (metadataCommitted && !modelCommitted) metadataDestination.delete()
        }
    }

    private suspend fun copyLlmWithSha256(uri: Uri, destination: File): CopiedLlm {
        val digest = MessageDigest.getInstance("SHA-256")
        var copied = 0L
        val input = context.contentResolver.openInputStream(uri)
            ?: throw BusinessException("MODEL_IMPORT_READ_FAILED", "无法打开所选 LLM 模型")
        input.use { sourceStream ->
            FileOutputStream(destination).use { destinationStream ->
                val buffer = ByteArray(256 * 1024)
                while (true) {
                    currentCoroutineContext().ensureActive()
                    val count = sourceStream.read(buffer)
                    if (count < 0) break
                    if (count == 0) continue
                    destinationStream.write(buffer, 0, count)
                    digest.update(buffer, 0, count)
                    copied += count.toLong()
                }
                destinationStream.flush()
                destinationStream.fd.sync()
            }
        }
        return CopiedLlm(
            size = copied,
            sha256 = digest.digest().joinToString("") { byte -> "%02x".format(byte.toInt() and 0xff) },
        )
    }

    private fun writeTextAndSync(destination: File, text: String) {
        FileOutputStream(destination).use { stream ->
            stream.write(text.toByteArray(Charsets.UTF_8))
            stream.flush()
            stream.fd.sync()
        }
    }

    private fun copyDocument(source: DocumentFile, destination: File) {
        if (source.isDirectory) {
            if (!destination.mkdirs() && !destination.isDirectory) {
                throw BusinessException("MODEL_IMPORT_WRITE_FAILED", "无法创建模型目录")
            }
            source.listFiles().forEach { child ->
                val childName = safeStorageName(child.name ?: "model-part-${System.nanoTime()}")
                copyDocument(child, uniqueDestination(destination, childName))
            }
            return
        }

        destination.parentFile?.mkdirs()
        val input = context.contentResolver.openInputStream(source.uri)
            ?: throw BusinessException("MODEL_IMPORT_READ_FAILED", "无法打开所选模型文件")
        input.use { sourceStream ->
            FileOutputStream(destination).use { destinationStream ->
                sourceStream.copyTo(destinationStream, DEFAULT_BUFFER_SIZE)
            }
        }
    }

    private fun uniqueDestination(parent: File, requestedName: String): File {
        val initial = File(parent, requestedName)
        if (!initial.exists()) return initial
        val extensionIndex = requestedName.indexOf('.')
        val stem = if (extensionIndex > 0) requestedName.substring(0, extensionIndex) else requestedName
        val suffix = if (extensionIndex > 0) requestedName.substring(extensionIndex) else ""
        var index = 2
        while (true) {
            val candidate = File(parent, "$stem-$index$suffix")
            if (!candidate.exists()) return candidate
            index += 1
        }
    }

    private fun safeStorageName(value: String): String {
        val cleaned = value.trim()
            .replace(Regex("[\\\\/:*?\"<>|]"), "-")
            .trim('.', ' ')
        return cleaned.takeIf { it.isNotBlank() } ?: "model-${System.currentTimeMillis()}"
    }

    private fun clearMissingSelections(
        catalog: LocalModelCatalog,
        selectedIds: Map<ModelCategory, String>,
        preserveMissingCategories: Set<ModelCategory> = emptySet(),
    ) {
        val editor = prefs.edit()
        var changed = false
        selectedIds.forEach { (category, selectedId) ->
            if (category !in preserveMissingCategories && catalog.models.none { it.category == category && it.id == selectedId }) {
                editor.remove(selectionKey(category))
                changed = true
            }
        }
        if (changed) editor.apply()
    }

    private fun LocalModelDescriptor.toLlmModelSpec(): LlmModelSpec = LlmModelSpec(
        id = id,
        name = name,
        absolutePath = absolutePath,
        sizeBytes = sizeBytes,
        targetPlatform = runCatching { LlmTargetPlatform.valueOf(targetPlatform.orEmpty()) }
            .getOrDefault(LlmTargetPlatform.UNKNOWN),
        devicePlatform = runCatching { LlmTargetPlatform.valueOf(devicePlatform.orEmpty()) }
            .getOrDefault(devicePlatform()),
        complete = complete,
        compatibility = runCatching { LlmCompatibility.valueOf(compatibility.orEmpty()) }
            .getOrDefault(LlmCompatibility.UNSUPPORTED),
        provider = provider ?: rkllmProvider(devicePlatform()),
        modelFormat = modelFormat ?: "RKLLM",
        runtimeVersion = version ?: RKLLM_RUNTIME_VERSION,
        quantization = quantization,
        sha256 = sha256,
    )

    private fun selectionKey(category: ModelCategory) = "selected_${category.name.lowercase()}"

    private data class CopiedLlm(val size: Long, val sha256: String)

    private fun String.removeSuffixIgnoreCase(suffix: String): String =
        if (endsWith(suffix, ignoreCase = true)) dropLast(suffix.length) else this
}
