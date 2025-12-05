import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseService service;

  bool isLoggedIn = false;
  bool loading = true;

  AuthViewModel(this.service) {
    _checkUser();
  }

  Future<void> _checkUser() async {
    final user = service.currentUser();
    isLoggedIn = user != null;
    loading = false;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      await service.signIn(email, password);
      isLoggedIn = true;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      await service.register(email, password);
      isLoggedIn = true;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await service.logout();
    isLoggedIn = false;
    notifyListeners();
  }
}
