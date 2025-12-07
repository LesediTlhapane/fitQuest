import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  Timer? _timer;
  int _seconds = 0;
  double _distance = 0.0;
  bool _isRunning = false;
  List<Map<String, dynamic>> _runHistory = [];
  
  // flutter_map variables
  final MapController _mapController = MapController();
  final List<LatLng> _polylineCoordinates = [];
  LatLng? _currentLocation;
  bool _locationEnabled = false;
  
  // Default location (can be any location)
  static const LatLng _defaultLocation = LatLng(-26.195246, 28.034088); // Johannesburg

  @override
  void initState() {
    super.initState();
    _currentLocation = _defaultLocation;
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkLocationPermission() async {
    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && 
          permission != LocationPermission.always) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    setState(() {
      _locationEnabled = true;
    });

    // Get initial location
    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _mapController.move(_currentLocation!, 15.0);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _startRun() {
    if (!_isRunning) {
      setState(() {
        _isRunning = true;
        _seconds = 0;
        _distance = 0.0;
        _polylineCoordinates.clear();
        
        // Add starting point
        if (_currentLocation != null) {
          _polylineCoordinates.add(_currentLocation!);
        }
      });

      _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
        if (_isRunning && _locationEnabled) {
          try {
            Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            
            LatLng newLocation = LatLng(position.latitude, position.longitude);
            
            setState(() {
              _currentLocation = newLocation;
              _polylineCoordinates.add(newLocation);
              
              // Calculate distance
              if (_polylineCoordinates.length > 1) {
                _distance = _calculateTotalDistance();
              }
              
              // Center map on new location
              _mapController.move(newLocation, _mapController.zoom);
            });
          } catch (e) {
            print("Error updating location: $e");
          }
        }
        
        // Always update seconds
        if (_isRunning) {
          setState(() {
            _seconds++;
          });
        }
      });
    }
  }

  double _calculateTotalDistance() {
    double totalDistance = 0.0;
    for (int i = 1; i < _polylineCoordinates.length; i++) {
      totalDistance += const Distance().distance(
        _polylineCoordinates[i - 1],
        _polylineCoordinates[i],
      );
    }
    return totalDistance / 1000; // Convert to kilometers
  }

  void _stopRun() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      
      // Save the run
      _runHistory.add({
        'date': DateTime.now(),
        'duration': _seconds,
        'distance': _distance,
        'pace': _distance > 0 ? (_seconds / 60) / _distance : 0,
        'path': List<LatLng>.from(_polylineCoordinates),
      });
    });
  }

  void _resetRun() {
    setState(() {
      _isRunning = false;
      _seconds = 0;
      _distance = 0.0;
      _timer?.cancel();
      _polylineCoordinates.clear();
      _currentLocation = _defaultLocation;
      _mapController.move(_defaultLocation, 13.0);
    });
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Run Tracker'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Stats Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard('TIME', _formatTime(_seconds), Icons.timer),
                        _buildStatCard('DISTANCE', '${_distance.toStringAsFixed(2)} km', Icons.directions_run),
                        _buildStatCard('PACE', _distance > 0 ? '${((_seconds / 60) / _distance).toStringAsFixed(2)} min/km' : '0:00', Icons.speed),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Control Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildControlButton(
                          icon: _isRunning ? Icons.pause : Icons.play_arrow,
                          label: _isRunning ? 'PAUSE' : 'START',
                          color: _isRunning ? Colors.orange : Colors.green,
                          onPressed: _isRunning ? null : _startRun,
                        ),
                        const SizedBox(width: 16),
                        _buildControlButton(
                          icon: Icons.stop,
                          label: 'STOP',
                          color: Colors.red,
                          onPressed: _isRunning ? _stopRun : null,
                        ),
                        const SizedBox(width: 16),
                        _buildControlButton(
                          icon: Icons.refresh,
                          label: 'RESET',
                          color: Colors.blueGrey,
                          onPressed: _resetRun,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Map Card with flutter_map
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _buildMap(),
                ),
              ),
            ),
            
            // Location Status
            if (!_locationEnabled)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  color: Colors.orange[50],
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.location_off, color: Colors.orange, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Location Access',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Enable location for accurate tracking',
                                style: TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 6),
                              ElevatedButton(
                                onPressed: _checkLocationPermission,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  minimumSize: const Size(0, 0),
                                ),
                                child: const Text(
                                  'Enable',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            
            // Run History
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Runs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            if (_runHistory.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.directions_run, size: 60, color: Colors.grey[400]),
                      const SizedBox(height: 10),
                      const Text(
                        'No runs recorded yet',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Text('Start your first run above!'),
                    ],
                  ),
                ),
              )
            else
              ..._runHistory.reversed.map((run) => _buildRunHistoryItem(run)).toList(),
          ],
        ),
      ),
    );
  }
Widget _buildMap() {
  return FlutterMap(
    mapController: _mapController,
    options: MapOptions(
      center: _currentLocation ?? _defaultLocation,
      zoom: 15.0,
      maxZoom: 18.0,
      minZoom: 3.0,
      interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.fitquest',
        tileProvider: NetworkTileProvider(),
        retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
      ),
      PolylineLayer(
        polylines: [
          Polyline(
            points: _polylineCoordinates,
            color: Colors.blue.withOpacity(0.8),
            strokeWidth: 4.0,
          ),
        ],
      ),
      MarkerLayer(
        markers: [
          if (_currentLocation != null)
            Marker(
              point: _currentLocation!,
              width: 40,
              height: 40,
              child: const Icon(  // FIXED: Changed from 'builder' to 'child'
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
        ],
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.small(
                onPressed: () {
                  if (_currentLocation != null) {
                    _mapController.move(_currentLocation!, 15.0);
                  }
                },
                child: const Icon(Icons.my_location),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                onPressed: () {
                  _mapController.move(_mapController.center, _mapController.zoom + 1);
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                onPressed: () {
                  _mapController.move(_mapController.center, _mapController.zoom - 1);
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.purple),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: onPressed,
            iconSize: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildRunHistoryItem(Map<String, dynamic> run) {
    final date = run['date'] as DateTime;
    final duration = run['duration'] as int;
    final distance = run['distance'] as double;
    final pace = run['pace'] as double;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.directions_run, color: Colors.purple),
        title: Text('${distance.toStringAsFixed(2)} km Run'),
        subtitle: Text(
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} • '
          '${_formatTime(duration)} • '
          '${pace.toStringAsFixed(2)} min/km',
        ),
        trailing: Text(
          '${date.day}/${date.month}',
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}