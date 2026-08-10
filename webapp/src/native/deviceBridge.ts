import { callNative, isNativeBusinessRuntime } from './rpcBridge'

export interface IdentityResult { success?: boolean; name?: string; gender?: string; nation?: string; birthday?: string; idNumber?: string; address?: string; portraitBase64?: string }
export interface FingerprintResult { success: boolean; quality?: number; templateId?: string; imageBase64?: string }
export interface SignatureResult { success: boolean; imageBase64?: string; signedAt?: string }

export function isNativeDeviceRuntime() { return isNativeBusinessRuntime() }

export const deviceBridge = {
  readIdentity() { return callNative<IdentityResult>('device.action', { type: 'identity' }) },
  captureFingerprint() { return callNative<FingerprintResult>('device.action', { type: 'fingerprint' }) },
  captureSignature() { return callNative<SignatureResult>('device.action', { type: 'signature' }) },
}
