import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

const developmentBackend = 'http://127.0.0.1:8080'

export default defineConfig({
  base: './',
  plugins: [vue()],
  server: {
    host: '0.0.0.0',
    port: 5173,
    proxy: {
      '/api': developmentBackend,
      '/work': developmentBackend,
      '/health': developmentBackend,
    },
  },
  build: { target: 'es2022', sourcemap: true },
})
