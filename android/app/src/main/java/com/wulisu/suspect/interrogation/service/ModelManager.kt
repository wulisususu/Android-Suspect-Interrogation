package com.wulisu.suspect.interrogation.service

import android.content.Context
import android.net.Uri
import androidx.documentfile.provider.DocumentFile
import com.wulisu.suspect.interrogation.asr.AsrModelSpecs
import com.wulisu.suspect.interrogation.asr.BundledAsrModels
import com.wulisu.suspect.interrogation.domain.BusinessException
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
) {
    private val root = File(context.filesDir, "models")
    private val prefs = context.getSharedPreferences("local_model_settings", Context.MODE_PRIVATE)
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val bundledAsrModels = BundledAsrModels(context)
    private val externalModelRoots = listOf(File("/sdcard/models"))

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

        val fileCatalog = scanner.scan(root, selectedIds, externalRoots = externalModelRoots)
        var models = fileCatalog.models + bundledAsrModels.descriptors(selectedIds[ModelCategory.ASR])
        if (models.none { it.category == ModelCategory.ASR && it.selected }) {
            val defaultId = AsrModelSpecs.default.id.catalogId
            selectedIds[ModelCategory.ASR] = defaultId
            prefs.edit().putString(selectionKey(ModelCategory.ASR), defaultId).apply()
            models = fileCatalog.models.map { it.copy(selected = false) } + bundledAsrModels.descriptors(defaultId)
        }
        val catalog = LocalModelCatalog(fileCatalog.rootPath, models)
        clearMissingSelections(catalog, selectedIds)
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
    ) {
        val editor = prefs.edit()
        var changed = false
        selectedIds.forEach { (category, selectedId) ->
            if (catalog.models.none { it.category == category && it.id == selectedId }) {
                editor.remove(selectionKey(category))
                changed = true
            }
        }
        if (changed) editor.apply()
    }

    private fun selectionKey(category: ModelCategory) = "selected_${category.name.lowercase()}"
}
