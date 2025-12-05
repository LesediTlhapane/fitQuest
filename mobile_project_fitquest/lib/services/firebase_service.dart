import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitquest/firebase_options.dart';
import 'firebase_options.dart' hide DefaultFirebaseOptions;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  FirebaseAuth? _auth;

  FirebaseService() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Only initialize once
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    _auth = FirebaseAuth.instance;
  }

  // Get current user
  User? currentUser() {
    return _auth?.currentUser;
  }

  // Sign in with email & password
  Future<void> signIn(String email, String password) async {
    await _auth?.signInWithEmailAndPassword(email: email, password: password);
  }

  // Register new user
  Future<void> register(String email, String password) async {
    await _auth?.createUserWithEmailAndPassword(email: email, password: password);
  }

  // Logout
  Future<void> logout() async {
    await _auth?.signOut();
  }
}
