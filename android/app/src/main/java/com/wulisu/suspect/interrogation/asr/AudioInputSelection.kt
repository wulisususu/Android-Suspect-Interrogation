package com.wulisu.suspect.interrogation.asr

import android.content.Context
import android.media.AudioDeviceInfo
import android.media.AudioManager

enum class AudioInputKind { BUILT_IN, USB, OTHER }

data class AudioInputCandidate(
    val id: Int,
    val kind: AudioInputKind,
    val name: String,
)

object AudioInputSelectionPolicy {
    /**
     * Pick the input the operator actually talks into. On this rig the on-board DMIC
     * (YF_033B) reports BUILT_IN but delivers only digital silence (-60 dBFS) — the real
     * microphone is the USB device (HK DXMIC V1). Prefer USB, fall back to built-in.
     */
    fun select(candidates: List<AudioInputCandidate>): AudioInputCandidate? =
        candidates.firstOrNull { it.kind == AudioInputKind.USB }
            ?: candidates.firstOrNull { it.kind == AudioInputKind.BUILT_IN }
}

internal class AndroidAudioInputSelector(context: Context) {
    private val audioManager = context.getSystemService(AudioManager::class.java)

    fun selectPreferred(): AudioDeviceInfo? {
        val devices = audioManager.getDevices(AudioManager.GET_DEVICES_INPUTS)
        val candidates = devices.map(::toCandidate)
        val selected = AudioInputSelectionPolicy.select(candidates) ?: return null
        return devices.firstOrNull { it.id == selected.id }
    }

    companion object {
        fun kind(device: AudioDeviceInfo?): AudioInputKind? = when (device?.type) {
            AudioDeviceInfo.TYPE_BUILTIN_MIC -> AudioInputKind.BUILT_IN
            AudioDeviceInfo.TYPE_USB_DEVICE,
            AudioDeviceInfo.TYPE_USB_HEADSET,
            AudioDeviceInfo.TYPE_USB_ACCESSORY,
            -> AudioInputKind.USB
            null -> null
            else -> AudioInputKind.OTHER
        }

        fun describe(device: AudioDeviceInfo?): String? = device?.let {
            val name = it.productName.toString().ifBlank { "未命名输入设备" }
            "$name (id=${it.id}, ${kind(it)?.name ?: AudioInputKind.OTHER.name})"
        }

        private fun toCandidate(device: AudioDeviceInfo) = AudioInputCandidate(
            id = device.id,
            kind = kind(device) ?: AudioInputKind.OTHER,
            name = device.productName.toString(),
        )
    }
}
