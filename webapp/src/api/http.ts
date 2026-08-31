import axios from 'axios'
import { audioInputMode } from '../config/audioInput'
import { runtimeConfig } from '../config/runtime'

export const AUDIO_INPUT_REQUEST_HEADER = 'X-Suspect-Audio-Input'

export function currentAudioInputRequestHeaders(): Record<string, string> {
  return { [AUDIO_INPUT_REQUEST_HEADER]: audioInputMode }
}

export const http = axios.create({
  baseURL: runtimeConfig.apiBaseUrl,
  withCredentials: true,
  timeout: 30_000,
})

http.interceptors.request.use((config) => {
  config.headers[AUDIO_INPUT_REQUEST_HEADER] = audioInputMode
  return config
})
