import 'package:flutter_test/flutter_test.dart';
import '../lib/viewmodels/run_vm.dart';

void main() {
  group('RunViewModel Tests', () {
    late RunViewModel runViewModel;
    
    setUp(() {
      runViewModel = RunViewModel();
    });
    
    test('Initial values are zero', () {
      expect(runViewModel.seconds, 0);
      expect(runViewModel.distanceMeters, 0.0);
      expect(runViewModel.isRunning, false);
    });
    
    test('Start run sets isRunning to true', () {
      runViewModel.start();
      expect(runViewModel.isRunning, true);
    });
    
    test('Stop run sets isRunning to false', () {
      runViewModel.start();
      runViewModel.stop();
      expect(runViewModel.isRunning, false);
    });
    
    test('Reset clears all values', () {
      runViewModel.start();
      runViewModel.reset();
      expect(runViewModel.seconds, 0);
      expect(runViewModel.distanceMeters, 0.0);
      expect(runViewModel.isRunning, false);
    });
    
    test('Tick increments seconds when running', () {
      runViewModel.start();
      runViewModel.tick();
      expect(runViewModel.seconds, greaterThan(0));
    });
  });
}