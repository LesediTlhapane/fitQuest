import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class ActivityScreen extends StatelessWidget {
  final FirebaseService service = FirebaseService();

  ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Activity")),
      body: FutureBuilder(
        future: service.fetchRuns(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final runs = snapshot.data as List<Map<String, dynamic>>;

          return ListView.builder(
            itemCount: runs.length,
            itemBuilder: (context, i) {
              final run = runs[i];
              return ListTile(
                title: Text("Distance: ${run['distance']} km"),
                subtitle: Text("Duration: ${run['duration']} min"),
              );
            },
          );
        },
      ),
    );
  }
}
