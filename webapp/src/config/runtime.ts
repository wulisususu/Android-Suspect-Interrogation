const ensureTrailingSlash = (value: string) => (value.endsWith('/') ? value : `${value}/`)
const browserOrigin = typeof window === 'undefined' ? 'http://127.0.0.1:8080' : window.location.origin

export const runtimeConfig = {
  apiBaseUrl: ensureTrailingSlash(import.meta.env.VITE_API_BASE_URL || browserOrigin),
}
