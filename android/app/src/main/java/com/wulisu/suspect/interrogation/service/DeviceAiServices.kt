package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.domain.BusinessException

class DeviceService {
    fun invoke(type: String): Nothing = throw BusinessException(
        "DEVICE_NOT_CONNECTED",
        "Android 业务后端已就绪，但 $type 厂商设备 SDK 尚未接入",
    )
}
