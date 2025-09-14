plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ecom"
    compileSdk = 34
    ndkVersion = "27.2.12479018"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.ecom"
        minSdk = 23                    // Use 'minSdk' with Int, no quotes
        targetSdk = 34                 // Use 'targetSdk' with Int, no quotes
        versionCode = 2                // Int, no quotes
        versionName = "1.1.0"          // String with '='
        multiDexEnabled = true         // Boolean with '='
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false      // Use 'isMinifyEnabled' in Kotlin DSL
            isShrinkResources = false    // Use 'isShrinkResources' in Kotlin DSL
        }
    }
}

flutter {
    source = "../.."
}

// Google Services plugin is applied via the plugins block, no need to reapply here.
