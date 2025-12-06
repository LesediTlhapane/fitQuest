// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_card.dart';
import '../widgets/stats_card.dart';
import '../viewmodels/run_vm.dart';
import 'fitquest_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins}m ${secs}s';
  }

  @override
  Widget build(BuildContext context) {
    final runVm = Provider.of<RunViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FitQuest"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back 👋", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            // top stat row
            Row(
              children: [
                Expanded(child: StatsCard(label: 'Last Run', value: _formatTime(runVm.seconds), icon: Icons.access_time)),
                const SizedBox(width: 12),
                Expanded(child: StatsCard(label: 'Distance (m)', value: runVm.distanceMeters.toStringAsFixed(0), icon: Icons.timeline)),
              ],
            ),

            const SizedBox(height: 16),

            // graph placeholder
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 3,
              child: Container(
                height: 140,
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Last 7 days', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    // simple visual "sparkline" placeholder
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.white, Colors.white.withOpacity(0.6)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomPaint(
                          painter: _SparklinePainter(runVm.seconds),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // quick actions
            HomeCard(
              title: "Start a Run",
              icon: Icons.directions_run_rounded,
              gradient: const [Color(0xFF7F6BFF), Color(0xFF5F4AE0)],
              onTap: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(2),
            ),

            HomeCard(
              title: "Workouts",
              icon: Icons.fitness_center,
              gradient: const [Color(0xFF4DD0E1), Color(0xFF00838F)],
              onTap: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(1),
            ),

            // last row: view history button
            const SizedBox(height: 8),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(4),
                  icon: const Icon(Icons.history),
                  label: const Text('View history'),
                ),
                const SizedBox(width: 12),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text('Share progress'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final int seconds;
  _SparklinePainter(this.seconds);

  @override
  void paint(Canvas canvas, Size size) {
    final paints = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final points = 12;
    for (int i = 0; i < points; i++) {
      final x = (size.width / (points - 1)) * i;
      final noise = (seconds % 30) / 30.0; // animated-ish number
      final y = size.height * (0.5 + (0.35 * (i / points - 0.5)) * (0.7 + noise));
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
    }

    canvas.drawPath(path, paints);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter old) => old.seconds != seconds;
}
