import 'package:flutter_test/flutter_test.dart';
import 'package:fitquest/services/sync_service.dart';
import 'package:fitquest/services/auth_service.dart';
import 'package:fitquest/services/firebase_service.dart';

void main() {
  late SyncService syncService;

  setUp(() {
    // Create instances of required services
    final authService = AuthService();
    final firebaseService = FirebaseService();
    
    // Pass them to SyncService constructor
    syncService = SyncService(authService, firebaseService);
  });

  test('saveRunLocally does not throw', () async {
    expect(() async {
      await syncService.saveRunLocally(
        distance: 5.0,
        duration: 300,
        pace: 6.0,
        type: 'outdoor',
        path: '[]',
      );
    }, returnsNormally);
  });

  test('getLocalRuns returns List', () async {
    final result = await syncService.getLocalRuns();
    expect(result, isA<List>());
  });

  test('deleteLocalData does not throw', () async {
    expect(() async => await syncService.deleteLocalData(), returnsNormally);
  });

  test('syncAllData does not throw', () async {
    expect(() async => await syncService.syncAllData(), returnsNormally);
  });
}