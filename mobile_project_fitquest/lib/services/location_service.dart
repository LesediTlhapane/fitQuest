import 'dart:async';
import 'dart:math';

class LocationPoint {
  final double delta; // meters since last update
  LocationPoint(this.delta);
}

class LocationService {
  /// Returns a continuous stream of distance deltas.
  Stream<LocationPoint> locationStream({bool simulate = false}) async* {
    if (simulate) {
      // simulated 5m every second
      while (true) {
        await Future.delayed(const Duration(seconds: 1));
        yield LocationPoint(5 + Random().nextDouble() * 2);
      }
    }

    // TODO: hook up to real GPS plugin here  
    // e.g., location package or geolocator
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield LocationPoint(0);
    }
  }
}
