import { callNative, isNativeBusinessRuntime } from '../native/rpcBridge'
import type { DocumentSignerRole, DocumentSigningState } from '../types/interrogation'

function requireNativeSigning() {
  if (!isNativeBusinessRuntime()) {
    throw new Error('电子签名与笔录冻结仅在 Android APK 本地数据库中运行')
  }
}

export async function fetchDocumentSigningState(caseId: string): Promise<DocumentSigningState | null> {
  if (!isNativeBusinessRuntime()) return null
  return callNative<DocumentSigningState | null>('document.signing.get', { caseId })
}

export async function freezeDocument(caseId: string): Promise<DocumentSigningState> {
  requireNativeSigning()
  return callNative<DocumentSigningState>('document.freeze', { caseId })
}

export async function signDocument(
  caseId: string,
  signerRole: DocumentSignerRole,
  signerName: string,
  imageDataUrl: string,
  strokesJson: string,
): Promise<DocumentSigningState> {
  requireNativeSigning()
  return callNative<DocumentSigningState>('document.sign', {
    caseId,
    signerRole,
    signerName,
    imageDataUrl,
    strokesJson,
  }, 60_000)
}
