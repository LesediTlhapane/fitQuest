import 'package:flutter/material.dart';
import '../widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Home",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            HomeCard(
              title: "Start Run",
              icon: Icons.directions_run_rounded,
              gradient: const [
                Color(0xFF4FACFE),
                Color(0xFF00F2FE),
              ],
              onTap: () => Navigator.pushNamed(context, "/run"),
            ),

            HomeCard(
              title: "My Plans",
              icon: Icons.calendar_month_rounded,
              gradient: const [
                Color(0xFF43CBFF),
                Color(0xFF9708CC),
              ],
              onTap: () => Navigator.pushNamed(context, "/plans"),
            ),

            HomeCard(
              title: "Club",
              icon: Icons.groups_rounded,
              gradient: const [
                Color(0xFFFF6FD8),
                Color(0xFFFF8C3A),
              ],
              onTap: () => Navigator.pushNamed(context, "/club"),
            ),
          ],
        ),
      ),
    );
  }
}
