// lib/widgets/home_card.dart
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white, size: 34),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70)
          ],
        ),
      ),
    );
  }
}
