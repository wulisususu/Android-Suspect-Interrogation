<script setup lang="ts">
import { ref } from 'vue'
import { backendErrorMessage, invokeDeviceAction } from '../api/interrogation'
import { deviceBridge, isNativeDeviceRuntime } from '../native/deviceBridge'

const message = ref('')
const pending = ref('')

async function invoke(type: 'fingerprint' | 'signature') {
  pending.value = type
  message.value = ''
  try {
    if (isNativeDeviceRuntime()) {
      if (type === 'fingerprint') {
        const result = await deviceBridge.captureFingerprint()
        message.value = result.success ? '指纹采集完成' : '指纹采集未完成'
      } else {
        const result = await deviceBridge.captureSignature()
        message.value = result.success ? '签名采集完成' : '签名采集未完成'
      }
      return
    }

    const result = await invokeDeviceAction(type)
    message.value = result.message || (result.simulated ? '设备模拟联调完成' : '设备操作完成')
  } catch (error) {
    message.value = backendErrorMessage(error)
  } finally {
    pending.value = ''
  }
}
</script>

<template>
  <div class="device-actions">
    <button class="device-button" @click="invoke('fingerprint')">{{ pending === 'fingerprint' ? '采集中…' : '指纹' }}</button>
    <button class="device-button" @click="invoke('signature')">{{ pending === 'signature' ? '签字中…' : '签名' }}</button>
    <span v-if="message" class="device-message">{{ message }}</span>
  </div>
</template>
