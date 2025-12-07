import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<String?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user profile in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'fullName': '$firstName $lastName',
        'age': age,
        'gender': gender,
        'createdAt': DateTime.now(),
        'totalDistance': 0.0,
        'totalTime': 0,
        'workoutsCompleted': 0,
        'profileImage': '',
      });

      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Sign in with email and password
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get user profile data
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String uid,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    String? profileImage,
  }) async {
    try {
      Map<String, dynamic> updates = {};
      if (firstName != null) updates['firstName'] = firstName;
      if (lastName != null) updates['lastName'] = lastName;
      if (age != null) updates['age'] = age;
      if (gender != null) updates['gender'] = gender;
      if (profileImage != null) updates['profileImage'] = profileImage;
      if (firstName != null && lastName != null) {
        updates['fullName'] = '$firstName $lastName';
      }

      await _firestore.collection('users').doc(uid).update(updates);
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  // Update user stats after a run
  Future<void> updateUserStats({
    required String uid,
    required double distance,
    required int time,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'totalDistance': FieldValue.increment(distance),
        'totalTime': FieldValue.increment(time),
        'workoutsCompleted': FieldValue.increment(1),
        'lastWorkout': DateTime.now(),
      });
    } catch (e) {
      print('Error updating user stats: $e');
    }
  }

  // Check if user exists
  Future<bool> userExists(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();
      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }

  // Alias methods for compatibility with existing code
  Future<String?> login(String email, String password) async {
    return await signIn(email, password);
  }

  Future<void> logout() async {
    await signOut();
  }
}