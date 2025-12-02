import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/run_vm.dart';

class RunScreen extends StatelessWidget {
  const RunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RunViewModel>(context);

    return Stack(
      children: [
        Container(color: Colors.grey.shade200), // Map placeholder

        Positioned.fill(
          child: Column(
            children: [
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Run',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.bookmark_border),
                  ],
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    'Map view goes here\n(Google Maps, Mapbox, or Leaflet)',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '${(vm.distanceMeters / 1000).toStringAsFixed(2)} km • ${vm.seconds}s',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),

                    // START / STOP BUTTON
                    GestureDetector(
                      onTap: () => vm.isRunning
                          ? vm.stopRun()
                          : vm.startRun(simulate: true),
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: vm.isRunning
                              ? Colors.redAccent
                              : Colors.yellowAccent,
                        ),
                        child: Center(
                          child: Text(
                            vm.isRunning ? 'STOP' : 'START',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Set a Goal'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
