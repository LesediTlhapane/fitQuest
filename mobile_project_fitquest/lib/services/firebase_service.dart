import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<void> saveRun(param0, data, {
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
});
}
}
