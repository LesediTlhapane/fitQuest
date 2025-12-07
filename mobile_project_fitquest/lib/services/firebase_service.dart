import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveRun({
    required String userId,
    required double distance,
    required int durationSeconds,
    required List<Map<String, dynamic>> route,
    required DateTime timestamp,
  }) async {
    await _db.collection('runs').add({
      'userId': userId,
      'distance': distance,
      'duration': durationSeconds,
      'route': route,
      'timestamp': timestamp.toIso8601String(),
      'date': timestamp,
    });
  }

  Future<List<Map<String, dynamic>>> getUserRuns(String userId) async {
    final snapshot = await _db
        .collection('runs')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();
    
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        ...data,
      };
    }).toList();
  }

  Future<void> addClubMember(String clubId, String userId) async {
    await _db.collection('clubs').doc(clubId).update({
      'members': FieldValue.arrayUnion([userId]),
    });
  }
}