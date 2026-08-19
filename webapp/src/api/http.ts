import axios from 'axios'
import { runtimeConfig } from '../config/runtime'

export const http = axios.create({
  baseURL: runtimeConfig.apiBaseUrl,
  withCredentials: true,
  timeout: 30_000,
})
