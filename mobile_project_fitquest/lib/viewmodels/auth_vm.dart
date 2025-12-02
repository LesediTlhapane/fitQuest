import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseService service;
  AuthViewModel(this.service) {
    _checkUser();
  }

  bool isLoggedIn = false;
  String? errorMessage;

  void _checkUser() {
    isLoggedIn = service.currentUser() != null;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    errorMessage = null;
    try {
      await service.login(email, password);
      isLoggedIn = true;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    errorMessage = null;
    try {
      await service.signUp(email, password);
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await service.logout();
    isLoggedIn = false;
    notifyListeners();
  }
}

