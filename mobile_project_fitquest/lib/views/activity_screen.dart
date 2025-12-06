// lib/views/activity_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';
import '../viewmodels/run_vm.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final runVm = Provider.of<RunViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () async => auth.logout()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 6),
            const Text('Recent activity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  _activityCard(title: 'Morning Run', duration: '32m', distance: '5.2 km'),
                  _activityCard(title: 'Gym Session', duration: '45m', distance: '-'),
                  // Example: include a real run using runVm values
                  ListTile(
                    leading: const Icon(Icons.directions_run),
                    title: const Text('Live session (simulated)'),
                    subtitle: Text('Time: ${runVm.seconds}s • ${runVm.distanceMeters.toStringAsFixed(0)} m'),
                    trailing: runVm.isRunning ? const Icon(Icons.fiber_manual_record, color: Colors.red) : null,
                    onTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityCard({required String title, required String duration, required String distance}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.map),
        title: Text(title),
        subtitle: Text('Duration: $duration'),
        trailing: Text(distance),
      ),
    );
  }
}
