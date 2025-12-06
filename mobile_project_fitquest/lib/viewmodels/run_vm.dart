import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class RunViewModel extends ChangeNotifier {
int _seconds = 0;
int get seconds => _seconds;

double _distanceMeters = 0;
double get distanceMeters => _distanceMeters;

/// In case UI expects `.distance`
double get distance => _distanceMeters.toDouble();

bool _isRunning = false;
bool get isRunning => _isRunning;

List<Position> _routePositions = [];
List<Position> get routePositions => List.unmodifiable(_routePositions);

void startRun() => start();
void stopRun() => stop();
void resetRun() => reset();

void start() {
_isRunning = true;
_seconds = 0;
_distanceMeters = 0;
_routePositions.clear();
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
_routePositions.clear();
notifyListeners();
}

void tick() {
if (_isRunning) {
_seconds++;
notifyListeners();
}
}

void addLocation(Position pos) {
if (_routePositions.isNotEmpty) {
final last = _routePositions.last;
final meters = Geolocator.distanceBetween(
last.latitude,
last.longitude,
pos.latitude,
pos.longitude,
);


  buildRunData(String uid) {}


}}}