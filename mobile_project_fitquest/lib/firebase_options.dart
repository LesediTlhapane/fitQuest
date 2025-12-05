// GENERATED FILE - DO NOT EDIT MANUALLY
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

  // Web configuration
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDsx0uyDleUPijPHDmMIGWqsunSnQZZ9ig",
    authDomain: "mobile-project-fitquest-2ffef.firebaseapp.com",
    projectId: "mobile-project-fitquest-2ffef",
    storageBucket: "mobile-project-fitquest-2ffef.appspot.com",
    messagingSenderId: "327076334604",
    appId: "1:327076334604:web:066efb6bd7b93bcdefb8d0",
    measurementId: "G-XXXXXXX", // optional
  );

  // Android configuration
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDsx0uyDleUPijPHDmMIGWqsunSnQZZ9ig",
    appId: "1:327076334604:android:bbc171da3aee02a350b229",
    messagingSenderId: "327076334604",
    projectId: "mobile-project-fitquest-2ffef",
    storageBucket: "mobile-project-fitquest-2ffef.appspot.com",
  );

  // iOS placeholder
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "REPLACE_WITH_YOUR_IOS_API_KEY",
    appId: "REPLACE_WITH_YOUR_IOS_APP_ID",
    messagingSenderId: "REPLACE_WITH_YOUR_IOS_SENDER_ID",
    projectId: "mobile-project-fitquest-2ffef",
    storageBucket: "mobile-project-fitquest-2ffef.appspot.com",
    iosClientId: "REPLACE_WITH_YOUR_IOS_CLIENT_ID",
    iosBundleId: "REPLACE_WITH_YOUR_IOS_BUNDLE_ID",
  );
}
