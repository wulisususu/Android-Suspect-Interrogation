plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("org.jetbrains.kotlin.kapt")
}

val generatedWebAssets = layout.buildDirectory.dir("generated/webappAssets")

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
        minSdk = 23
        targetSdk = 36
        versionCode = 1
        versionName = "0.2.0"

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
        getByName("main").assets.srcDir(generatedWebAssets)
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
    implementation("androidx.webkit:webkit:1.15.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.10.2")

    val roomVersion = "2.8.4"
    implementation("androidx.room:room-runtime:$roomVersion")
    implementation("androidx.room:room-ktx:$roomVersion")
    kapt("androidx.room:room-compiler:$roomVersion")

    implementation("net.zetetic:sqlcipher-android:4.17.0@aar")
    implementation("androidx.sqlite:sqlite:2.6.2")

    testImplementation("junit:junit:4.13.2")
}

tasks.named("preBuild").configure { dependsOn(syncWebapp) }
