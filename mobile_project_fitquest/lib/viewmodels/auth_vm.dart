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
    try {
      final user = service.currentUser();
      isLoggedIn = user != null;
    } catch (e) {
      print('Check user error: $e');
      isLoggedIn = false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await service.signIn(email, password);
      isLoggedIn = true;
      notifyListeners();
      return null;
    } catch (e) {
      print('Login error: $e');
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
      print('Register error: $e');
      return e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await service.logout();
    } catch (e) {
      print('Logout error: $e');
    } finally {
      isLoggedIn = false;
      notifyListeners();
    }
  }
}
