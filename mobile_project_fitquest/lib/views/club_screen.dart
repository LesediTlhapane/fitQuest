// lib/views/club_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Club"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => auth.logout()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const Text('Local Clubs & Challenges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.group)),
                title: const Text('City Runners'),
                subtitle: const Text('5 upcoming runs • 120 members'),
                trailing: ElevatedButton(onPressed: () {}, child: const Text('Join')),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.emoji_events)),
                title: const Text('30-day running challenge'),
                subtitle: const Text('Beat daily distance goals'),
                trailing: ElevatedButton(onPressed: () {}, child: const Text('Take part')),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Ideas for Club screen:'),
            const SizedBox(height: 6),
            const Text('- Community feed of members runs\n- Upcoming group events\n- Create/view leaderboards\n- Chat / coordinate meetups'),
          ],
        ),
      ),
    );
  }
}
