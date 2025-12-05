import 'dart:async';
import 'package:flutter/material.dart';

class RunViewModel extends ChangeNotifier {
  bool isRunning = false;
  double distanceMeters = 0.0;
  int seconds = 0;

  Timer? _timer;
  Timer? _simLocationTimer;

  void startRun({bool simulate = false}) {
    if (isRunning) return;

    isRunning = true;
    notifyListeners();

    // timer for seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds++;
      notifyListeners();
    });

    // simulation of movement — 10 meters every 2 seconds
    if (simulate) {
      _simLocationTimer = Timer.periodic(const Duration(seconds: 2), (_) {
        distanceMeters += 10;
        notifyListeners();
      });
    }
  }

  Future<void> stopRun() async {
    if (!isRunning) return;

    isRunning = false;

    _timer?.cancel();
    _simLocationTimer?.cancel();

    _timer = null;
    _simLocationTimer = null;

    // Normally you would save the run here
    // For now it's a stub that does nothing

    notifyListeners();
  }

  void reset() {
    isRunning = false;
    seconds = 0;
    distanceMeters = 0.0;

    _timer?.cancel();
    _simLocationTimer?.cancel();

    notifyListeners();
  }
}



