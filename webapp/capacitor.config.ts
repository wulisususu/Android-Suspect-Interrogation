import type { CapacitorConfig } from '@capacitor/cli'

const config: CapacitorConfig = {
  appId: 'com.wulisu.suspect.interrogation',
  appName: '案件审讯工作台',
  webDir: 'dist',
  bundledWebRuntime: false,
  server: {
    androidScheme: 'https',
  },
  android: {
    webContentsDebuggingEnabled: true,
  },
}

export default config
