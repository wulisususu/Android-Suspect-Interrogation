<script setup lang="ts">
import { ref } from 'vue'
import { deviceBridge } from '../native/deviceBridge'

const message = ref('')
const pending = ref('')

async function invoke(type: 'identity' | 'fingerprint' | 'signature') {
  pending.value = type
  message.value = ''
  try {
    if (type === 'identity') {
      const result = await deviceBridge.readIdentity()
      message.value = result.name ? `身份证：${result.name}` : '身份证读取完成'
    } else if (type === 'fingerprint') {
      const result = await deviceBridge.captureFingerprint()
      message.value = result.success ? '指纹采集完成' : '指纹采集未完成'
    } else {
      const result = await deviceBridge.captureSignature()
      message.value = result.success ? '签名采集完成' : '签名采集未完成'
    }
  } catch (error) {
    message.value = error instanceof Error ? error.message : String(error)
  } finally {
    pending.value = ''
  }
}
</script>

<template>
  <div class="device-actions">
    <button class="device-button" @click="invoke('identity')">{{ pending === 'identity' ? '读取中…' : '身份证' }}</button>
    <button class="device-button" @click="invoke('fingerprint')">{{ pending === 'fingerprint' ? '采集中…' : '指纹' }}</button>
    <button class="device-button" @click="invoke('signature')">{{ pending === 'signature' ? '签字中…' : '签名' }}</button>
    <span v-if="message" class="device-message">{{ message }}</span>
  </div>
</template>
