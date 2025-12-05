// TODO Implement this library.// GENERATED FILE - DO NOT EDIT MANUALLY
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // 🔑 Replace the values below with the Web app configuration from Firebase
  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyBYqWXrf-MPVy-Q29mjyxwaC-gKFPSiS9g",

  authDomain: "mobile-project-fitquest-2ffef.firebaseapp.com",

  projectId: "mobile-project-fitquest-2ffef",

  storageBucket: "mobile-project-fitquest-2ffef.firebasestorage.app",

  messagingSenderId: "327076334604",

  appId: "1:327076334604:web:fceb4078ba4efb8b50b229",

  measurementId: "G-MSCSN5K6GD"

  );

  // Android configuration
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "PASTE_YOUR_ANDROID_API_KEY",
    appId: "PASTE_YOUR_ANDROID_APP_ID",
    messagingSenderId: "PASTE_YOUR_SENDER_ID",
    projectId: "PASTE_YOUR_PROJECT_ID",
    storageBucket: "PASTE_YOUR_PROJECT_ID.appspot.com",
  );

  // iOS placeholder
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "REPLACE_WITH_YOUR_IOS_API_KEY",
    appId: "REPLACE_WITH_YOUR_IOS_APP_ID",
    messagingSenderId: "REPLACE_WITH_YOUR_IOS_SENDER_ID",
    projectId: "PASTE_YOUR_PROJECT_ID",
    storageBucket: "PASTE_YOUR_PROJECT_ID.appspot.com",
    iosClientId: "REPLACE_WITH_YOUR_IOS_CLIENT_ID",
    iosBundleId: "REPLACE_WITH_YOUR_IOS_BUNDLE_ID",
  );
}
