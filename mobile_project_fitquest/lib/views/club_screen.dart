import 'package:flutter/material.dart';

class ClubScreen extends StatelessWidget {
  final List<String> mockGroups = [
    "Runners Club",
    "Fit Buddies",
    "Ultra Trail Crew",
  ];

  ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Club")),
      body: ListView.builder(
        itemCount: mockGroups.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(mockGroups[i]),
        ),
      ),
    );
  }
}
