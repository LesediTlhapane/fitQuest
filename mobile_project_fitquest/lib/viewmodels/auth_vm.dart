import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseService _firebase = FirebaseService();

  bool isLoading = false;
  String? error;

  AuthViewModel(FirebaseService firebaseService);

  Future<void> loginAnonymous() async {
    isLoading = true;
    notifyListeners();

    try {
      await _firebase.signInAnonymously();
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
