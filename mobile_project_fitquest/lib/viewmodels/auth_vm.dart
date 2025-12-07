import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthViewModel with ChangeNotifier {
  final AuthService _authService;
  User? _user;
  bool _loading = false;
  String _error = '';

  AuthViewModel(this._authService) {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get loading => _loading;
  bool get isLoggedIn => _user != null;
  String get error => _error;

  Map<String, dynamic>? get userProfile => null;

  Future<bool> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
  }) async {
    try {
      _loading = true;
      _error = '';
      notifyListeners();
      
      final error = await _authService.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        age: age,
        gender: gender,
      );
      
      if (error == null) {
        return true;
      } else {
        _error = error;
        return false;
      }
    } on FirebaseAuthException catch (e) {
      _error = _getErrorMessage(e.code);
      return false;
    } catch (e) {
      _error = 'An error occurred. Please try again.';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Helper method for backward compatibility (optional)
  Future<bool> signupSimple(String email, String password, String name) async {
    // Split name into first and last name
    final names = name.split(' ');
    final firstName = names.isNotEmpty ? names[0] : '';
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';
    
    return await signup(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      age: 25, // Default age
      gender: 'Prefer not to say', // Default gender
    );
  }

  Future<bool> login(String email, String password) async {
    try {
      _loading = true;
      _error = '';
      notifyListeners();
      
      final error = await _authService.login(email, password);
      
      if (error == null) {
        return true;
      } else {
        _error = error;
        return false;
      }
    } on FirebaseAuthException catch (e) {
      _error = _getErrorMessage(e.code);
      return false;
    } catch (e) {
      _error = 'An error occurred. Please try again.';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      _error = 'Failed to logout. Please try again.';
      notifyListeners();
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // Alias for signOut to match both naming conventions
  Future<void> signOut() async {
    await logout();
  }
}