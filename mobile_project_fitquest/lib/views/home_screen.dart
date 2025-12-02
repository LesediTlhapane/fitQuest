import 'package:flutter/material.dart';
import '../widgets/colorful_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(
        children: [
          ColorfulCard(title: "Start Run", icon: Icons.directions_run),
          ColorfulCard(title: "My Plans", icon: Icons.calendar_month),
          ColorfulCard(title: "Club", icon: Icons.group),
        ],
      ),
    );
  }
}
