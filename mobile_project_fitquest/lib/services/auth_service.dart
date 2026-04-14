import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';




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
        'createdAt': FieldValue.serverTimestamp(),
        'totalDistance': 0.0,
        'totalTime': 0,
        'workoutsCompleted': 0,
        'profileImage': '',
        'clubs': [],
        'events': [],
        'challenges': [],
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

  // Alias for login (for compatibility)
  Future<String?> login(String email, String password) async {
    return await signIn(email, password);
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Alias for logout (for compatibility)
  Future<void> logout() async {
    await signOut();
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
      rethrow;
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
        'lastWorkout': FieldValue.serverTimestamp(),
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

  // Save notification to database
  Future<String?> saveNotification({
    required String uid,
    required String type,
    required String title,
    required String message,
    Map<String, dynamic>? data,
  }) async {
    try {
      // Get user details for the notification
      final userDoc = await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data() as Map<String, dynamic>?;
      
      await _firestore.collection('notifications').add({
        'uid': uid,
        'type': type,
        'title': title,
        'message': message,
        'data': data ?? {},
        'userName': userData?['fullName'] ?? 'User',
        'userImage': userData?['profileImage'] ?? '',
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null; // Success
    } catch (e) {
      print('Error saving notification: $e');
      return e.toString();
    }
  }

  // Get user notifications
  Stream<List<Map<String, dynamic>>> getUserNotifications(String uid) {
    return _firestore
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = doc.data();
              return {
                'id': doc.id,
                ...data,
                'timestamp': (data['timestamp'] as Timestamp?)?.toDate(),
                'createdAt': (data['createdAt'] as Timestamp?)?.toDate(),
              };
            })
            .toList());
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).update({
        'read': true,
        'readAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  // Mark all notifications as read for a user
  Future<void> markAllNotificationsAsRead(String uid) async {
    try {
      final notifications = await _firestore
          .collection('notifications')
          .where('uid', isEqualTo: uid)
          .where('read', isEqualTo: false)
          .get();
      
      final batch = _firestore.batch();
      for (final doc in notifications.docs) {
        batch.update(doc.reference, {
          'read': true,
          'readAt': FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    } catch (e) {
      print('Error marking all notifications as read: $e');
    }
  }

  // Save run to database
  Future<String?> saveRun({
    required String uid,
    required double distance,
    required int duration,
    required double pace,
    required List<LatLng>? path,
    required String type,
  }) async {
    try {
      final runData = {
        'uid': uid,
        'distance': distance,
        'duration': duration,
        'pace': pace,
        'path': path != null ? path.map((p) => {'lat': p.latitude, 'lng': p.longitude}).toList() : null,
        'type': type,
        'date': FieldValue.serverTimestamp(),
        'calories': (distance * 60).round(), // Rough estimate
      };
      
      await _firestore.collection('runs').add(runData);
      
      // Update user stats
      await updateUserStats(
        uid: uid,
        distance: distance,
        time: duration,
      );
      
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // Save workout to database
  Future<String?> saveWorkout({
    required String uid,
    required String type,
    required int duration,
    required int calories,
    String? notes,
  }) async {
    try {
      final workoutData = {
        'uid': uid,
        'type': type,
        'duration': duration,
        'calories': calories,
        'notes': notes,
        'date': FieldValue.serverTimestamp(),
      };
      
      await _firestore.collection('workouts').add(workoutData);
      
      // Update user stats
      await updateUserStats(
        uid: uid,
        distance: 0,
        time: duration,
      );
      
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // Add user to a club
  Future<void> addUserToClub(String uid, String clubName) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'clubs': FieldValue.arrayUnion([clubName]),
        'lastClubJoined': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding user to club: $e');
      rethrow;
    }
  }

  // Add user to an event
  Future<void> addUserToEvent(String uid, String eventName) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'events': FieldValue.arrayUnion([eventName]),
        'lastEventRSVP': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding user to event: $e');
      rethrow;
    }
  }

  // Add user to a challenge
  Future<void> addUserToChallenge(String uid, String challengeName) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'challenges': FieldValue.arrayUnion([challengeName]),
        'lastChallengeJoined': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding user to challenge: $e');
      rethrow;
    }
  }
}