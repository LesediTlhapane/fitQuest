import 'package:flutter/foundation.dart';

class RunViewModel with ChangeNotifier {
  int _seconds = 0;
  double _distanceMeters = 0.0; // Changed to double
  bool _isRunning = false;
  
  // Add a list to store run history
  List<Map<String, dynamic>> _runHistory = [];

  int get seconds => _seconds;
  double get distanceMeters => _distanceMeters;
  bool get isRunning => _isRunning;
  List<Map<String, dynamic>> get runHistory => _runHistory;

  // Method that your HomeScreen expects
  void updateRun(int seconds, double distanceMeters) {
    _seconds = seconds;
    _distanceMeters = distanceMeters;
    notifyListeners();
  }

  // Add this method if you need to manually set distance
  void updateDistance(double meters) {
    _distanceMeters = meters;
    notifyListeners();
  }

  // Add this method if you need to manually set time
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
    // Save to history when stopped
    _runHistory.add({
      'date': DateTime.now(),
      'duration': _seconds,
      'distance': _distanceMeters,
      'pace': _seconds > 0 && _distanceMeters > 0 
          ? (_seconds / 60) / (_distanceMeters / 1000) 
          : 0,
    });
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
}