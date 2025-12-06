import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitquest/services/firebase_service.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
final FirebaseAuth _auth = FirebaseAuth.instance;

User? _user;
User? get user => _user;

bool _loading = false;
bool get loading => _loading;

bool get isLoggedIn => _user != null;

AuthViewModel(FirebaseService firebaseService) {
_auth.authStateChanges().listen((u) {
_user = u;
notifyListeners();
});
}

Future<String?> login(String email, String password) async {
try {
_loading = true;
notifyListeners();

await _auth.signInWithEmailAndPassword(email: email, password: password);
return null;
} catch (e) {
return e.toString();
} finally {
_loading = false;
notifyListeners();
}
}

Future<String?> signup(String email, String password) async {
try {
_loading = true;
notifyListeners();

await _auth.createUserWithEmailAndPassword(email: email, password: password);
return null;
} catch (e) {
return e.toString();
} finally {
_loading = false;
notifyListeners();
}
}

Future<void> logout() async {
await _auth.signOut();
}

  Future<dynamic> register(String trim, String trim2) async {}
}