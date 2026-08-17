# Device application isolation

The RK3576 test device previously contained an old reverse-engineered package whose APK label was changed to `嫌疑人审核 AI 智能设备` even though its package and UI still belonged to the pediatric application:

```text
com.fb.doctor.assistant.clone/io.ionic.starter.MainActivity
```

This was not a Launcher shortcut alias. Launcher3 started the package's own `MAIN`/`LAUNCHER` activity. The device also contained `com.example.applauncher`, which stores explicit package-slot mappings.

Keep the two real products independent:

```text
Interrogation: com.wulisu.suspect.interrogation/.MainActivity
Medical:       com.fb.doctor.assistant.uat/io.ionic.starter.MainActivity
```

Disable the misleading clone and the shortcut mapper without uninstalling either package or clearing their data:

```bash
adb shell pm disable-user --user 0 com.fb.doctor.assistant.clone
adb shell pm disable-user --user 0 com.example.applauncher
```

Verify the disabled and enabled package sets:

```bash
adb shell pm list packages -d | grep -E \
  'com.fb.doctor.assistant.clone|com.example.applauncher'

adb shell pm list packages -e | grep -E \
  'com.fb.doctor.assistant.uat|com.wulisu.suspect.interrogation'
```

Verify that each real application launches only its own activity:

```bash
adb shell monkey -p com.fb.doctor.assistant.uat \
  -c android.intent.category.LAUNCHER 1

adb shell monkey -p com.wulisu.suspect.interrogation \
  -c android.intent.category.LAUNCHER 1
```

The disabled state persists across reboot. To recover either disabled package for diagnostics, explicitly enable it again:

```bash
adb shell pm enable --user 0 com.fb.doctor.assistant.clone
adb shell pm enable --user 0 com.example.applauncher
```
