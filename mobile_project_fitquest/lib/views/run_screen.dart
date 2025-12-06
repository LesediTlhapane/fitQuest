import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../viewmodels/run_vm.dart';
import '../viewmodels/auth_vm.dart';
import '../services/firebase_service.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;

  @override
  Widget build(BuildContext context) {
    final run = Provider.of<RunViewModel>(context);
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("🏃 Run Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => run.resetRun(),
          ),
        ],
      ),

      body: Column(
        children: [
          // -------- Timer + Distance Stats --------
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statBox("⏱️ Time", _formatTime(run.seconds)),
                _statBox("📏 Distance", "${run.distance.toStringAsFixed(2)} km"),
              ],
            ),
          ),

          // -------- BUTTONS --------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start"),
                onPressed: run.isRunning ? null : run.startRun,
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.stop),
                label: const Text("Stop"),
                onPressed: run.isRunning ? () async {
                  run.stopRun();

                  // Save run
                  final data = run.buildRunData(auth.user!.uid);
                  await FirebaseService()
                      .saveRun(auth.user!['uid'], data, userId: '', distance: 0.0, durationSeconds: 0, route: [], timestamp: DateTime.now());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Run Saved!")),
                  );
                } : null,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // -------- LIVE MAP --------
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-26.2041, 28.0473), // Johannesburg default
                zoom: 14,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) => _mapController = controller,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}

extension on RunViewModel {
  buildRunData(String uid) {}
}

extension on User {
  operator [](String other) {}
}
