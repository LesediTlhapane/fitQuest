buildscript {
    ext.kotlin_version = '1.9.22'
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.4'  // Updated version
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath 'com.google.gms:google-services:4.3.15'  // Updated Firebase classpath
        
        // Performance monitoring (optional)
        classpath 'com.google.firebase:perf-plugin:1.4.2'
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.9'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }
    }
}

rootProject.buildDir = '../build'

subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
    
    // Configure each subproject
    project.afterEvaluate {
        if (project.hasProperty('android')) {
            android {
                compileSdk 34
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(':app')
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}

// Configure project properties
ext {
    compileSdkVersion = 34
    minSdkVersion = 21
    targetSdkVersion = 34
    buildToolsVersion = "34.0.0"
}