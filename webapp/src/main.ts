import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import './styles.css'
import './ai-settings.css'
import './workspace-pages.css'

createApp(App).use(createPinia()).mount('#app')
