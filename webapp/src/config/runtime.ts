const ensureTrailingSlash = (value: string) => (value.endsWith('/') ? value : `${value}/`)

export const runtimeConfig = {
  apiBaseUrl: ensureTrailingSlash(
    import.meta.env.VITE_API_BASE_URL || 'https://uat.pediatrician-ai.fb.jnpinno.com/',
  ),
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
