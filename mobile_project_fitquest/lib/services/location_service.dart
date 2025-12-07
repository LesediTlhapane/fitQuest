import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:latlong2/latlong.dart';

class LocationService {
  StreamController<LatLng> _locationController = StreamController<LatLng>.broadcast();
  Stream<LatLng> get locationStream => _locationController.stream;
  
  List<LatLng> _pathPoints = [];
  List<LatLng> get pathPoints => _pathPoints;
  
  Future<bool> _checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    
    return true;
  }
  
  Future<void> startTracking() async {
    if (!await _checkPermissions()) {
      throw Exception('Location permissions not granted');
    }
    
    _pathPoints.clear();
    
    // Get initial position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    
    LatLng initialPoint = LatLng(position.latitude, position.longitude);
    _pathPoints.add(initialPoint);
    _locationController.add(initialPoint);
    
    // Listen to position updates
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5, // meters
      ),
    ).listen((Position position) {
      LatLng point = LatLng(position.latitude, position.longitude);
      _pathPoints.add(point);
      _locationController.add(point);
    });
  }
  
  void stopTracking() {
    // Stream will be closed when service is disposed
  }
  
  double calculateDistance(List<LatLng> path) {
    if (path.length < 2) return 0.0;
    
    double totalDistance = 0.0;
    for (int i = 1; i < path.length; i++) {
      totalDistance += _calculateDistanceBetween(
        path[i-1].latitude,
        path[i-1].longitude,
        path[i].latitude,
        path[i].longitude,
      );
    }
    
    return totalDistance;
  }
  
  double _calculateDistanceBetween(double lat1, double lon1, double lat2, double lon2) {
    const Distance distance = Distance();
    return distance.as(LengthUnit.Meter, LatLng(lat1, lon1), LatLng(lat2, lon2));
  }
  
  void dispose() {
    _locationController.close();
  }
}