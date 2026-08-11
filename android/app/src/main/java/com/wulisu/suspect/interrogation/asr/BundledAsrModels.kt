package com.wulisu.suspect.interrogation.asr

import android.content.Context
import com.wulisu.suspect.interrogation.service.LocalModelDescriptor
import com.wulisu.suspect.interrogation.service.ModelCategory
import com.wulisu.suspect.interrogation.service.ModelSourceKind

class BundledAsrModels(private val context: Context) {
    fun descriptors(selectedId: String?): List<LocalModelDescriptor> = AsrModelSpecs.all.map { spec ->
        LocalModelDescriptor(
            id = spec.id.catalogId,
            category = ModelCategory.ASR,
            name = spec.displayName,
            storageName = spec.assetRoot.substringAfterLast('/'),
            absolutePath = "asset:///${spec.assetRoot}",
            relativePath = "asset/${spec.assetRoot}",
            sizeBytes = spec.requiredAssets.sumOf(::assetSize),
            modifiedAt = 0L,
            sourceKind = ModelSourceKind.ASSET,
            archive = false,
            selected = selectedId == spec.id.catalogId,
            runtimeReady = true,
        )
    }

    private fun assetSize(path: String): Long = runCatching {
        context.assets.openFd(path).use { it.length }
    }.getOrElse {
        runCatching { context.assets.open(path).use { stream -> stream.available().toLong() } }.getOrDefault(0L)
    }
}
