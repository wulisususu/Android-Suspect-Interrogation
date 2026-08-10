package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException

class DeviceService {
    fun invoke(type: String): Nothing = throw BusinessException("DEVICE_NOT_CONNECTED", "Android 业务后端已就绪，但 $type 厂商设备 SDK 尚未接入")
}

class AiService {
    fun inquiry(): Nothing = throw BusinessException("AI_RUNTIME_NOT_CONFIGURED", "正式 APK 未绑定本地 LLM Runtime；临时云端 API 仅保留在开发联调环境")
}
