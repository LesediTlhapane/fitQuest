import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ---------------- AUTH ----------------

  Future<User?> signInAnonymously() async {
    final userCred = await _auth.signInAnonymously();
    return userCred.user;
  }

  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<User?> signUp(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // ---------------- RUNS ----------------

  Future<void> saveRunData(Map<String, dynamic> data) async {
    await _db.collection("runs").add(data);
  }

  Future<List<Map<String, dynamic>>> fetchRuns() async {
    final snapshot = await _db.collection("runs").get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
