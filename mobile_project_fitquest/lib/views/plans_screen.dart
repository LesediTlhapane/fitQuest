import 'package:flutter/material.dart';
import '../widgets/colorful_card.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Plans")),
      body: ListView(
        children: const [
          ColorfulCard(title: "5K Beginner Plan", icon: Icons.flag),
          ColorfulCard(title: "10K Runner Plan", icon: Icons.flag_circle),
          ColorfulCard(title: "Half Marathon Plan", icon: Icons.emoji_events),
        ],
      ),
    );
  }
}
