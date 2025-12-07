// lib/services/sync_service.dart
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/auth_service.dart';
import '../services/firebase_service.dart';

class SyncService {
  final AuthService _authService;
  final FirebaseService _firebaseService;
  
  SyncService(
    this._authService,
    this._firebaseService,
  );
  
  Future<bool> isOnline() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      print('Error checking connectivity: $e');
      return false;
    }
  }

  Future<dynamic> getLocalRuns() async {}

  Future<void> saveRunLocally({required double distance, required int duration, required num pace, required String type, required String path}) async {}

  Future<void> deleteLocalData() async {}

  Future<void> syncAllData() async {}
  
  // This method is no longer needed since we're using shared_preferences
  // Remove or comment out the saveWorkout call from line 166
  // Or update it to use a different method
}