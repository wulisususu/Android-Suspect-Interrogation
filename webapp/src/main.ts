import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { initializeAudioInputMode } from './config/audioInput'
import './styles.css'
import './ai-settings.css'
import './workspace-pages.css'

async function bootstrap() {
  await initializeAudioInputMode()
  const { default: App } = await import('./App.vue')
  createApp(App).use(createPinia()).mount('#app')
}

void bootstrap()
