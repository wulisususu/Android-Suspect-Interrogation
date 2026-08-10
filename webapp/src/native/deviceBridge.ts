import { Capacitor, registerPlugin } from '@capacitor/core'

export interface IdentityResult {
  name?: string
  gender?: string
  nation?: string
  birthday?: string
  idNumber?: string
  address?: string
  portraitBase64?: string
}

export interface FingerprintResult {
  success: boolean
  quality?: number
  templateId?: string
  imageBase64?: string
}

export interface SignatureResult {
  success: boolean
  imageBase64?: string
  signedAt?: string
}

interface IdentityDevicePlugin {
  isAvailable(): Promise<{ available: boolean }>
  readIdentity(): Promise<IdentityResult>
}

interface FingerprintDevicePlugin {
  isAvailable(): Promise<{ available: boolean }>
  capture(): Promise<FingerprintResult>
}

interface SignaturePadPlugin {
  isAvailable(): Promise<{ available: boolean }>
  capture(): Promise<SignatureResult>
}

const IdentityDevice = registerPlugin<IdentityDevicePlugin>('IdentityDevice')
const FingerprintDevice = registerPlugin<FingerprintDevicePlugin>('FingerprintDevice')
const SignaturePad = registerPlugin<SignaturePadPlugin>('SignaturePad')

function ensureNative() {
  if (!Capacitor.isNativePlatform()) throw new Error('当前不是 Android 原生运行环境')
}

export function isNativeDeviceRuntime() {
  return Capacitor.isNativePlatform()
}

export const deviceBridge = {
  async readIdentity() {
    ensureNative()
    return IdentityDevice.readIdentity()
  },
  async captureFingerprint() {
    ensureNative()
    return FingerprintDevice.capture()
  },
  async captureSignature() {
    ensureNative()
    return SignaturePad.capture()
  },
}
