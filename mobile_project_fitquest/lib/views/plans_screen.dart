// lib/views/plans_screen.dart
import 'package:flutter/material.dart';
import '../widgets/home_card.dart';
import 'fitquest_app.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workouts')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text('Choose a workout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // sample workouts
            HomeCard(
              title: 'Easy 20 min Run',
              icon: Icons.directions_run,
              gradient: const [Color(0xFF8AD1FF), Color(0xFF4DA8E9)],
              onTap: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(2),
            ),

            HomeCard(
              title: 'Interval 30 min',
              icon: Icons.timer,
              gradient: const [Color(0xFFFFB86B), Color(0xFFFB7C7C)],
              onTap: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(2),
            ),

            HomeCard(
              title: 'Gym - Strength 45 min',
              icon: Icons.fitness_center,
              gradient: const [Color(0xFFc3a5ff), Color(0xFF7F6BFF)],
              onTap: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(2),
            ),
            const SizedBox(height: 12),

            TextButton(
              onPressed: () {},
              child: const Text('Create custom workout'),
            )
          ],
        ),
      ),
    );
  }
}
 