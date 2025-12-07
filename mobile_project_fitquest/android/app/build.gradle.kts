plugins {
    id("com.android.application")
    // Firebase Configuration
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0.0'
}

android {
    namespace = "com.fitquest.app"
    compileSdk = 34  // Updated to latest
    ndkVersion = "25.2.9519653"  // Explicit NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17  // Updated to 17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.fitquest.app"  // Changed from example to your app
        minSdk = 21  // Updated from flutter.minSdkVersion for better compatibility
        targetSdk = 34  // Updated to latest
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
        multiDexEnabled = true  // Added for Firebase
        
        // Add these configurations
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        
        // For Google Maps
        manifestPlaceholders += [
            googleMapApiKey: localProperties.getProperty('google.maps.api.key', '')
        ]
    }

    buildTypes {
        debug {
            // Enable debug mode
            debuggable true
            minifyEnabled false
            shrinkResources false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            
            // Add debug manifest placeholders
            manifestPlaceholders += [
                appName: "FitQuest (Debug)",
                googleMapApiKey: localProperties.getProperty('google.maps.api.key.debug', '')
            ]
        }
        release {
            // Release configuration
            debuggable false
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
            signingConfig = signingConfigs.getByName("debug")  // Change this for production
            
            // Add release manifest placeholders
            manifestPlaceholders += [
                appName: "FitQuest",
                googleMapApiKey: localProperties.getProperty('google.maps.api.key', '')
            ]
        }
    }
    
    // Enable view binding and data binding
    buildFeatures {
        viewBinding true
        dataBinding true
    }
    
    // Configure packaging options
    packagingOptions {
        resources {
            excludes += ['/META-INF/AL2.0', '/META-INF/LGPL2.1', 'META-INF/DEPENDENCIES']
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Flutter engine
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.9.22")
    
    // MultiDex support for Firebase
    implementation("androidx.multidex:multidex:2.0.1")
    
    // Firebase dependencies
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    
    // Google Play Services
    implementation("com.google.android.gms:play-services-location:21.0.1")
    implementation("com.google.android.gms:play-services-maps:18.2.0")
    implementation("com.google.android.gms:play-services-auth:20.7.0")
    
    // Support libraries
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.11.0")
    
    // Testing dependencies
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}

apply plugin: 'com.google.gms.google-services'