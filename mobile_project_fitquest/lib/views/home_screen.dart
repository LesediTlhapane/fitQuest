// lib/views/home_screen.dart
import 'package:fitquest/views/activity_screen.dart';
import 'package:fitquest/views/run_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/run_vm.dart';
import '../viewmodels/auth_vm.dart';
import 'club_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Screens for bottom navigation
  final List<Widget> _screens = [
    const HomeContent(), // This is your current HomeScreen content
    const RunScreen(),
    const ClubScreen(),
    const ActivityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitQuest'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Run',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Activity',
          ),
        ],
      ),
    );
  }
}

// This is your current HomeScreen content - moved to a separate widget
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins}m ${secs}s';
  }

  @override
  Widget build(BuildContext context) {
    final runVm = Provider.of<RunViewModel>(context);
    final auth = Provider.of<AuthViewModel>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            auth.user != null ? 'Welcome back, ${auth.user!.displayName ?? "there"}! 👋' : 'Welcome back! 👋',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Ready for your next workout?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // top stat row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Last Run',
                  value: _formatTime(runVm.seconds),
                  icon: Icons.access_time,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Distance (m)',
                  value: runVm.distanceMeters.toStringAsFixed(0),
                  icon: Icons.timeline,
                  color: Colors.purple,
                ),
              ),
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
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _actionCard(Icons.directions_run, 'Start Run', Colors.blue, () {
                Navigator.pushNamed(context, '/run');
              }),
              _actionCard(Icons.fitness_center, 'Workout', Colors.green, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Workouts feature coming soon!')),
                );
              }),
              _actionCard(Icons.people, 'Clubs', Colors.orange, () {
                Navigator.pushNamed(context, '/clubs');
              }),
              _actionCard(Icons.bar_chart, 'Stats', Colors.purple, () {
                Navigator.pushNamed(context, '/activity');
              }),
            ],
          ),

          // Last row buttons
          const SizedBox(height: 16),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/activity');
                },
                icon: const Icon(Icons.history),
                label: const Text('View history'),
              ),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share feature coming soon!')),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Share progress'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(IconData icon, String title, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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