import 'package:flutter/foundation.dart';

class RunViewModel extends ChangeNotifier {
  int _seconds = 0;
  double _distanceMeters = 0;
  bool _isRunning = false;

  int get seconds => _seconds;
  double get distanceMeters => _distanceMeters;
  bool get isRunning => _isRunning;

  void start() {
    _isRunning = true;
    _seconds = 0;
    _distanceMeters = 0;
    notifyListeners();
  }

  void stop() {
    _isRunning = false;
    notifyListeners();
  }

  void reset() {
    _isRunning = false;
    _seconds = 0;
    _distanceMeters = 0;
    notifyListeners();
  }

  void tick() {
    if (_isRunning) {
      _seconds++;
      notifyListeners();
    }
  }
}