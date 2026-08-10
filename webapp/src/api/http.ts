import axios from 'axios'
import { getAuthorizationValue, runtimeConfig } from '../config/runtime'

export const http = axios.create({
  baseURL: runtimeConfig.apiBaseUrl,
  withCredentials: true,
  timeout: 30_000,
})

http.interceptors.request.use((config) => {
  const authorization = getAuthorizationValue()
  if (authorization) {
    config.headers.Authorization = authorization
  }
  return config
})
