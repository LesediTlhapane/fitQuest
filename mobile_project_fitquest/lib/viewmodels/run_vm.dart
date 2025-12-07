// lib/viewmodels/run_vm.dart
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../services/sync_service.dart';

class RunViewModel with ChangeNotifier {
  int _seconds = 0;
  double _distanceMeters = 0.0;
  bool _isRunning = false;
  List<Map<String, dynamic>> _runHistory = [];
  
  SyncService? _syncService;
  
  int get seconds => _seconds;
  double get distanceMeters => _distanceMeters;
  bool get isRunning => _isRunning;
  List<Map<String, dynamic>> get runHistory => _runHistory;

  void setSyncService(SyncService syncService) {
    _syncService = syncService;
  }

  // Method that your HomeScreen expects
  void updateRun(int seconds, double distanceMeters) {
    _seconds = seconds;
    _distanceMeters = distanceMeters;
    notifyListeners();
  }

  void updateDistance(double meters) {
    _distanceMeters = meters;
    notifyListeners();
  }

  void updateTime(int seconds) {
    _seconds = seconds;
    notifyListeners();
  }

  void start() {
    _isRunning = true;
    _seconds = 0;
    _distanceMeters = 0.0;
    notifyListeners();
  }

  void stop() {
    _isRunning = false;
    
    // Save to history
    final runData = {
      'date': DateTime.now(),
      'duration': _seconds,
      'distance': _distanceMeters,
      'pace': _seconds > 0 && _distanceMeters > 0 
          ? (_seconds / 60) / (_distanceMeters / 1000) 
          : 0,
      'type': 'outdoor',
    };
    
    _runHistory.add(runData);
    
    // Save locally if sync service is available
    if (_syncService != null) {
      _saveRunLocally();
    }
    
    notifyListeners();
  }

  void reset() {
    _isRunning = false;
    _seconds = 0;
    _distanceMeters = 0.0;
    notifyListeners();
  }

  void tick() {
    if (_isRunning) {
      _seconds++;
      // Simulate distance increase (approx 3 m/s or 10.8 km/h)
      _distanceMeters += 3.0;
      notifyListeners();
    }
  }

  // Clear run history if needed
  void clearHistory() {
    _runHistory.clear();
    notifyListeners();
  }

  // Get total distance from history
  double get totalDistance {
    return _runHistory.fold(0.0, (sum, run) => sum + (run['distance'] as double));
  }

  // Get total time from history
  int get totalTime {
    return _runHistory.fold(0, (sum, run) => sum + (run['duration'] as int));
  }

  Future<void> _saveRunLocally() async {
    if (_syncService == null) return;
    
    try {
      await _syncService!.saveRunLocally(
        distance: _distanceMeters,
        duration: _seconds,
        pace: _seconds > 0 && _distanceMeters > 0 
            ? (_seconds / 60) / (_distanceMeters / 1000) 
            : 0,
        type: 'outdoor',
        path: json.encode([]), // Empty path for simulation
      );
    } catch (e) {
      print('Error saving run locally: $e');
    }
  }

  // Load local runs on startup
  Future<void> loadLocalRuns() async {
    if (_syncService == null) return;
    
    try {
      final localRuns = await _syncService!.getLocalRuns();
      _runHistory.addAll(localRuns.map((run) => {
        'date': DateTime.parse(run['date'] as String),
        'duration': run['duration'] as int,
        'distance': run['distance'] as double,
        'pace': run['pace'] as double,
        'type': run['type'] as String,
        'isLocal': run['synced'] == 0,
      }).toList());
      notifyListeners();
    } catch (e) {
      print('Error loading local runs: $e');
    }
  }
}