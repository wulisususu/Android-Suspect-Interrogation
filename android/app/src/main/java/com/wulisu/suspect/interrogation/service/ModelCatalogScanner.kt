package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.ocr.OcrModelProbe
import java.io.File

class ModelCatalogScanner {
    fun scan(
        root: File,
        selectedIds: Map<ModelCategory, String> = emptyMap(),
        runtimeReadyIds: Set<String> = emptySet(),
        externalRoots: List<File> = emptyList(),
    ): LocalModelCatalog {
        root.mkdirs()
        val models = ModelCategory.entries.flatMap { category ->
            val categoryRoot = File(root, category.directoryName).apply { mkdirs() }
            if (category == ModelCategory.OCR) {
                ocrDescriptors(root, categoryRoot, externalRoots, selectedIds[category])
            } else {
                categoryRoot.listFiles()
                    .orEmpty()
                    .asSequence()
                    .filter(::isVisibleModelEntry)
                    .map { entry -> descriptor(root, category, entry, selectedIds[category], runtimeReadyIds) }
                    .sortedBy { it.name.lowercase() }
                    .toList()
            }
        }
        return LocalModelCatalog(rootPath = root.absolutePath, models = models)
    }

    private fun descriptor(
        root: File,
        category: ModelCategory,
        entry: File,
        selectedId: String?,
        runtimeReadyIds: Set<String>,
    ): LocalModelDescriptor {
        val relativePath = entry.relativeTo(root).invariantSeparatorsPath
        val id = "${category.name}:$relativePath"
        return LocalModelDescriptor(
            id = id,
            category = category,
            name = displayName(entry),
            storageName = entry.name,
            absolutePath = entry.absolutePath,
            relativePath = relativePath,
            sizeBytes = entry.totalSize(),
            modifiedAt = entry.lastModified(),
            sourceKind = if (entry.isDirectory) ModelSourceKind.DIRECTORY else ModelSourceKind.FILE,
            archive = entry.isFile && ARCHIVE_SUFFIXES.any { entry.name.lowercase().endsWith(it) },
            selected = selectedId == id,
            runtimeReady = id in runtimeReadyIds,
        )
    }

    private fun ocrDescriptors(
        privateRoot: File,
        categoryRoot: File,
        externalRoots: List<File>,
        selectedId: String?,
    ): List<LocalModelDescriptor> {
        val candidates = buildList {
            addAll(ocrScanDirectories(categoryRoot))
            externalRoots.forEach { externalRoot ->
                addAll(ocrScanDirectories(File(externalRoot, ModelCategory.OCR.directoryName)))
                addAll(ocrScanDirectories(externalRoot))
            }
        }.distinctBy { it.root.absolutePath + "|" + it.spec.id }

        return candidates.map { candidate ->
            val relativePath = if (candidate.root.absolutePath.startsWith(privateRoot.absolutePath)) {
                candidate.root.relativeTo(privateRoot).invariantSeparatorsPath
            } else {
                "external/${candidate.root.name}/${candidate.spec.id}"
            }
            val id = "${ModelCategory.OCR.name}:$relativePath/${candidate.spec.id}"
            LocalModelDescriptor(
                id = id,
                category = ModelCategory.OCR,
                name = candidate.spec.displayName,
                storageName = candidate.root.name,
                absolutePath = candidate.root.absolutePath,
                relativePath = relativePath,
                sizeBytes = candidate.sizeBytes,
                modifiedAt = candidate.modifiedAt,
                sourceKind = ModelSourceKind.DIRECTORY,
                archive = false,
                selected = selectedId == id,
                runtimeReady = candidate.runtimeReady,
                version = candidate.spec.version,
                modelFormat = candidate.spec.format.wireValue,
                provider = candidate.spec.provider,
                complete = candidate.complete,
            )
        }.sortedWith(compareBy({ !it.runtimeReady }, { it.name.lowercase() }, { it.relativePath }))
    }

    private fun ocrScanDirectories(root: File): List<com.wulisu.suspect.interrogation.ocr.OcrModelCandidate> {
        if (!root.exists() || !root.isDirectory) return emptyList()
        return buildList {
            addAll(OcrModelProbe.probe(root))
            root.listFiles().orEmpty()
                .filter { it.isDirectory && isVisibleModelEntry(it) }
                .forEach { addAll(OcrModelProbe.probe(it)) }
        }
    }

    private fun displayName(entry: File): String {
        if (entry.isDirectory) return entry.name
        val lowerName = entry.name.lowercase()
        val suffix = DISPLAY_SUFFIXES.firstOrNull(lowerName::endsWith) ?: return entry.nameWithoutExtension
        return entry.name.dropLast(suffix.length).ifBlank { entry.name }
    }

    private fun isVisibleModelEntry(entry: File): Boolean =
        entry.name.isNotBlank() && !entry.name.startsWith(".") && !entry.name.endsWith(".part")

    private fun File.totalSize(): Long {
        if (isFile) return length()
        return runCatching {
            walkTopDown().filter { it.isFile }.sumOf { it.length() }
        }.getOrDefault(0L)
    }

    companion object {
        private val ARCHIVE_SUFFIXES = listOf(".tar.bz2", ".tar.gz", ".tar.xz", ".zip", ".7z")
        private val DISPLAY_SUFFIXES = ARCHIVE_SUFFIXES + listOf(".onnx", ".rknn", ".gguf", ".bin")
    }
}
