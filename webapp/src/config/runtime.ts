const ensureTrailingSlash = (value: string) => (value.endsWith('/') ? value : `${value}/`)
const browserOrigin = typeof window === 'undefined' ? 'http://127.0.0.1:8080' : window.location.origin

export const runtimeConfig = {
  apiBaseUrl: ensureTrailingSlash(import.meta.env.VITE_API_BASE_URL || browserOrigin),
  authMode: import.meta.env.VITE_AUTH_MODE || 'raw',
  explicitToken: import.meta.env.VITE_AUTH_TOKEN || '',
}

export function getAuthToken(): string {
  return runtimeConfig.explicitToken || localStorage.getItem('user_token') || ''
}

export function getAuthorizationValue(): string | undefined {
  const token = getAuthToken().trim()
  if (!token) return undefined

  if (runtimeConfig.authMode === 'raw') return token
  if (/^Bearer\s+/i.test(token)) return token
  return `Bearer ${token}`
}
