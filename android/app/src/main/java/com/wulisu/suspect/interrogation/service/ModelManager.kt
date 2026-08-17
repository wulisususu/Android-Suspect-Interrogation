package com.wulisu.suspect.interrogation.service

import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Environment
import androidx.documentfile.provider.DocumentFile
import com.wulisu.suspect.interrogation.asr.AsrModelSpecs
import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.llm.LlmCompatibility
import com.wulisu.suspect.interrogation.llm.LlmDevicePlatform
import com.wulisu.suspect.interrogation.llm.LlmModelRepository
import com.wulisu.suspect.interrogation.llm.LlmModelSpec
import com.wulisu.suspect.interrogation.llm.LlmTargetPlatform
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream
import java.util.UUID

class ModelManager(
    private val context: Context,
    private val scanner: ModelCatalogScanner = ModelCatalogScanner(),
) : LlmModelRepository {
    private val root = File(ModelDirectories.ROOT_PATH)
    private val prefs = context.getSharedPreferences("local_model_settings", Context.MODE_PRIVATE)
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val llmRoot = File(root, ModelCategory.LLM.directoryName)
    private val legacyModelRoots = listOf(root)

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
        val fileCatalog = scanner.scan(
            root,
            selectedIds,
            externalRoots = legacyModelRoots,
            devicePlatform = devicePlatform(),
        )
        var models = fileCatalog.models
        if (models.none { it.category == ModelCategory.ASR && it.selected && it.runtimeReady }) {
            val fallback = models.firstOrNull {
                it.category == ModelCategory.ASR && it.id == AsrModelSpecs.default.id.catalogId && it.runtimeReady
            } ?: models.firstOrNull { it.category == ModelCategory.ASR && it.runtimeReady }
            if (fallback == null) {
                selectedIds.remove(ModelCategory.ASR)
                prefs.edit().remove(selectionKey(ModelCategory.ASR)).apply()
                models = models.map { if (it.category == ModelCategory.ASR) it.copy(selected = false) else it }
            } else {
                selectedIds[ModelCategory.ASR] = fallback.id
                prefs.edit().putString(selectionKey(ModelCategory.ASR), fallback.id).apply()
                models = models.map {
                    if (it.category == ModelCategory.ASR) it.copy(selected = it.id == fallback.id) else it
                }
            }
        }
        val catalog = LocalModelCatalog(fileCatalog.rootPath, models)
        clearMissingSelections(
            catalog,
            selectedIds,
            preserveMissingCategories = if (storagePermissionGranted()) emptySet() else ModelCategory.entries.toSet(),
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

    private fun importLlmFromUri(source: ModelImportSource, uri: Uri): LocalModelCatalog {
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
        val expectedSize = document.length()
        if (destination.exists()) {
            if (expectedSize > 0 && destination.length() == expectedSize) return scan()
            throw BusinessException("MODEL_IMPORT_NAME_CONFLICT", "同名 LLM 模型已存在且大小不同")
        }
        if (expectedSize > 0 && expectedSize > llmRoot.usableSpace) {
            throw BusinessException("MODEL_STORAGE_INSUFFICIENT", "设备存储空间不足，无法导入该 LLM 模型")
        }
        val temporary = File(llmRoot, ".importing-${UUID.randomUUID()}.part")
        try {
            val input = context.contentResolver.openInputStream(document.uri)
                ?: throw BusinessException("MODEL_IMPORT_READ_FAILED", "无法打开所选 LLM 模型")
            input.use { sourceStream ->
                FileOutputStream(temporary).use { destinationStream ->
                    sourceStream.copyTo(destinationStream, DEFAULT_BUFFER_SIZE)
                }
            }
            if (expectedSize > 0 && temporary.length() != expectedSize) {
                throw BusinessException("MODEL_IMPORT_INCOMPLETE", "LLM 模型复制不完整")
            }
            if (!temporary.renameTo(destination)) {
                throw BusinessException("MODEL_IMPORT_COMMIT_FAILED", "LLM 模型复制完成，但无法写入设备模型目录")
            }
            return scan()
        } catch (error: CancellationException) {
            temporary.delete()
            throw error
        } catch (error: BusinessException) {
            temporary.delete()
            throw error
        } catch (error: Throwable) {
            temporary.delete()
            throw BusinessException("MODEL_IMPORT_FAILED", error.message ?: "LLM 模型导入失败")
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

    private fun devicePlatform(): String = LlmDevicePlatform.fromProperties(
        socModel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) Build.SOC_MODEL else "",
        device = Build.DEVICE.orEmpty(),
        board = Build.BOARD.orEmpty(),
    )

    private fun LocalModelDescriptor.toLlmModelSpec(): LlmModelSpec = LlmModelSpec(
        id = id,
        name = name,
        absolutePath = absolutePath,
        sizeBytes = sizeBytes,
        targetPlatform = runCatching { LlmTargetPlatform.valueOf(targetPlatform.orEmpty()) }
            .getOrDefault(LlmTargetPlatform.UNKNOWN),
        complete = complete,
        compatibility = runCatching { LlmCompatibility.valueOf(compatibility.orEmpty()) }
            .getOrDefault(LlmCompatibility.UNSUPPORTED),
        provider = provider ?: com.wulisu.suspect.interrogation.llm.RKLLM_PROVIDER,
        modelFormat = modelFormat ?: "RKLLM",
        runtimeVersion = version ?: com.wulisu.suspect.interrogation.llm.RKLLM_RUNTIME_VERSION,
    )

    private fun selectionKey(category: ModelCategory) = "selected_${category.name.lowercase()}"
}
