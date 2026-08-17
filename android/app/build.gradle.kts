import java.util.zip.ZipFile

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("org.jetbrains.kotlin.kapt")
}

val generatedWebAssets = layout.buildDirectory.dir("generated/webappAssets")
val onnxRuntimeVersion = "1.27.0"
val onnxRuntimeJava by configurations.creating {
    isCanBeConsumed = false
    isCanBeResolved = true
}
val onnxRuntimeJavaDir = layout.buildDirectory.dir("generated/onnxruntime-java")
val extractOnnxRuntimeJava by tasks.registering(Copy::class) {
    from({ zipTree(onnxRuntimeJava.singleFile) }) {
        include("classes.jar")
        rename("classes.jar", "onnxruntime-android-$onnxRuntimeVersion-classes.jar")
    }
    into(onnxRuntimeJavaDir)
}
val onnxRuntimeJavaJar = files(
    onnxRuntimeJavaDir.map { it.file("onnxruntime-android-$onnxRuntimeVersion-classes.jar") },
).builtBy(extractOnnxRuntimeJava)
val onnxRuntimeNativeDir = layout.buildDirectory.dir("generated/onnxruntime-native")
val extractOnnxRuntimeNative by tasks.registering(Copy::class) {
    from({ zipTree(onnxRuntimeJava.singleFile) }) {
        include("jni/arm64-v8a/libonnxruntime4j_jni.so")
        eachFile { path = path.removePrefix("jni/") }
        includeEmptyDirs = false
    }
    into(onnxRuntimeNativeDir)
}

val syncWebapp by tasks.registering(Sync::class) {
    val webDist = rootProject.projectDir.resolve("../webapp/dist")
    from(webDist)
    into(generatedWebAssets.map { it.dir("webapp") })
    doFirst {
        if (!webDist.exists()) {
            throw GradleException("webapp/dist 不存在，请先在仓库 webapp/ 执行 npm install && npm run build")
        }
    }
}

android {
    namespace = "com.wulisu.suspect.interrogation"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.wulisu.suspect.interrogation"
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "0.2.0"

        ndk {
            abiFilters += "arm64-v8a"
        }

        externalNativeBuild {
            cmake {
                cppFlags += listOf("-std=c++17")
            }
        }

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    sourceSets {
        getByName("main") {
            assets.srcDir(generatedWebAssets)
            jniLibs.srcDir(onnxRuntimeNativeDir)
        }
        getByName("androidTest").assets.srcDir("$projectDir/schemas")
    }

    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
            version = "3.22.1"
        }
    }
}

kapt {
    arguments {
        arg("room.schemaLocation", "$projectDir/schemas")
    }
}

dependencies {
    // 1.17.0 remains on compileSdk 36; Core 1.18+ moves to 36.1/37 and would force an unrelated AGP 9 migration.
    implementation("androidx.core:core-ktx:1.17.0")
    implementation("androidx.documentfile:documentfile:1.1.0")
    implementation("androidx.exifinterface:exifinterface:1.4.1")
    implementation("androidx.webkit:webkit:1.15.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.10.2")

    // Keep the ORT Java/Kotlin API and JNI bridge from Maven, but source libonnxruntime.so only
    // from src/main/jniLibs so it stays ABI-aligned with the checked-in sherpa native bundle.
    onnxRuntimeJava("com.microsoft.onnxruntime:onnxruntime-android:$onnxRuntimeVersion@aar")
    implementation(onnxRuntimeJavaJar)

    val roomVersion = "2.8.4"
    implementation("androidx.room:room-runtime:$roomVersion")
    implementation("androidx.room:room-ktx:$roomVersion")
    kapt("androidx.room:room-compiler:$roomVersion")

    implementation("net.zetetic:sqlcipher-android:4.17.0@aar")
    implementation("androidx.sqlite:sqlite:2.6.2")

    testImplementation("junit:junit:4.13.2")
    testImplementation("org.json:json:20250517")
    androidTestImplementation("androidx.test.ext:junit:1.3.0")
    androidTestImplementation("androidx.test:runner:1.7.0")
    androidTestImplementation("androidx.room:room-testing:$roomVersion")
}

val verifyDebugOnnxRuntimeNative by tasks.registering {
    group = "verification"
    description = "Verifies the debug APK contains exactly one arm64-v8a ORT core and JNI bridge."
    dependsOn("assembleDebug")
    doLast {
        val apk = layout.buildDirectory.file("outputs/apk/debug/app-debug.apk").get().asFile
        if (!apk.isFile) throw GradleException("Debug APK not found: $apk")
        val requiredEntries = listOf(
            "lib/arm64-v8a/libonnxruntime.so",
            "lib/arm64-v8a/libonnxruntime4j_jni.so",
        )
        val entries = ZipFile(apk).use { zip ->
            zip.entries().asSequence()
                .map { it.name }
                .filter { it in requiredEntries }
                .toList()
        }
        val invalidEntries = requiredEntries.filter { required -> entries.count { it == required } != 1 }
        if (invalidEntries.isNotEmpty()) {
            throw GradleException("Expected exactly one of each ORT native library in APK; invalid: $invalidEntries; found: $entries")
        }
        logger.lifecycle("Verified APK ORT native libraries: ${entries.sorted()}")
    }
}

tasks.named("preBuild").configure {
    dependsOn(syncWebapp)
    dependsOn(extractOnnxRuntimeJava)
    dependsOn(extractOnnxRuntimeNative)
}
