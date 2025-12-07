// lib/views/home_screen.dart (update the SliverAppBar section)
import 'package:fitquest/views/activity_screen.dart';
import 'package:fitquest/views/club_screen.dart';
import 'package:fitquest/views/profile_screen.dart'; // ADD THIS IMPORT
import 'package:fitquest/views/run_screen.dart';
import 'package:fitquest/views/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../viewmodels/auth_vm.dart';
import '../viewmodels/run_vm.dart';

class HomeScreenEnhanced extends StatelessWidget {
  const HomeScreenEnhanced({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    final runVm = Provider.of<RunViewModel>(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // App Bar with notifications
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'FitQuest',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade700, Colors.purple.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 20,
                      top: 60,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          size: 50,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            auth.user?.displayName?.split(' ').first ?? 'Champion',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ADD THESE ACTIONS
            actions: [
              // Profile Icon
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              // Notification Icon
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Notifications'),
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                        body: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.notifications, size: 80, color: Colors.purple),
                              SizedBox(height: 20),
                              Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'Your notifications will appear here.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          
          // ... REST OF YOUR HOMESCREEN CODE (keep all your existing code below)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey[50]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem(
                            'Total Distance',
                            '${runVm.totalDistance.toStringAsFixed(1)} km',
                            Icons.directions_run,
                            Colors.blue,
                          ),
                          _buildStatItem(
                            'Workouts',
                            '${runVm.runHistory.length}',
                            Icons.fitness_center,
                            Colors.green,
                          ),
                          _buildStatItem(
                            'Active Days',
                            '7',
                            Icons.calendar_today,
                            Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.65,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.purpleAccent],
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Weekly Progress',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '65% to goal',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Quick Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      _buildActionCard(
                        title: 'Start Run',
                        subtitle: 'Track your run',
                        icon: Icons.directions_run,
                        color: Colors.blue,
                        gradient: const [Colors.blue, Colors.lightBlue],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RunScreen(),
                            ),
                          );
                        },
                      ),
                      _buildActionCard(
                        title: 'Workout',
                        subtitle: 'Choose exercise',
                        icon: Icons.fitness_center,
                        color: Colors.green,
                        gradient: const [Colors.green, Colors.lightGreen],
                        onTap: () => _showWorkoutDialog(context),
                      ),
                      _buildActionCard(
                        title: 'Clubs',
                        subtitle: 'Join communities',
                        icon: Icons.people,
                        color: Colors.orange,
                        gradient: const [Colors.orange, Colors.deepOrangeAccent],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ClubsScreen(),
                            ),
                          );
                        },
                      ),
                      _buildActionCard(
                        title: 'Stats',
                        subtitle: 'View analytics',
                        icon: Icons.analytics,
                        color: Colors.purple,
                        gradient: const [Colors.purple, Colors.deepPurple],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const StatsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Recent Activity
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Activity',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.more_horiz, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ..._buildRecentActivities(),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ActivityScreen(),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View All Activity',
                                style: TextStyle(color: Colors.purple),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward, size: 16, color: Colors.purple),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Share Progress Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade600, Colors.purple.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () => _shareProgress(context),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.share, color: Colors.white, size: 24),
                          const SizedBox(width: 10),
                          const Text(
                            'Share Your Progress',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 32),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRecentActivities() {
    return [
      _buildActivityItem('Morning Run', '5.2 km • 32 min', 'Today, 7:30 AM', Icons.directions_run, Colors.blue),
      _buildActivityItem('Gym Session', 'Strength Training • 45 min', 'Yesterday', Icons.fitness_center, Colors.green),
      _buildActivityItem('Evening Yoga', 'Flexibility • 30 min', '2 days ago', Icons.self_improvement, Colors.purple),
    ];
  }

  Widget _buildActivityItem(String title, String details, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ));
    }
  }

  Future<void> _showWorkoutDialog(BuildContext context) async {
    final selectedType = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Workout'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildWorkoutOption(context, 'Morning Run', Icons.directions_run, Colors.blue),
              _buildWorkoutOption(context, 'Gym Session', Icons.fitness_center, Colors.green),
              _buildWorkoutOption(context, 'Evening Yoga', Icons.self_improvement, Colors.purple),
              _buildWorkoutOption(context, 'Weekend Hike', Icons.terrain, Colors.brown),
              _buildWorkoutOption(context, 'Swimming', Icons.pool, Colors.cyan),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
        ],
      ),
    );

    if (selectedType != null) {
      final duration = await _showDurationDialog(context);
      if (duration != null) {
        final auth = Provider.of<AuthViewModel>(context, listen: false);
        if (auth.user != null) {
          await auth.saveWorkout(
            type: selectedType,
            duration: duration,
            calories: duration * 10,
          );
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Workout logged successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    }
  }

  Widget _buildWorkoutOption(BuildContext context, String title, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop(title);
      },
    );
  }

  Future<int?> _showDurationDialog(BuildContext context) async {
    int selectedDuration = 30;
    
    return await showDialog<int>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Select Duration'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$selectedDuration minutes',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: selectedDuration.toDouble(),
                  min: 5,
                  max: 180,
                  divisions: 35,
                  label: '$selectedDuration min',
                  onChanged: (value) {
                    setState(() {
                      selectedDuration = value.round();
                    });
                  },
                  activeColor: Colors.purple,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [5, 30, 60, 90, 120].map((duration) {
                    return ChoiceChip(
                      label: Text('$duration min'),
                      selected: selectedDuration == duration,
                      onSelected: (selected) {
                        setState(() {
                          selectedDuration = duration;
                        });
                      },
                      selectedColor: Colors.purple,
                      labelStyle: TextStyle(
                        color: selectedDuration == duration ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(selectedDuration),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('START'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _shareProgress(BuildContext context) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final runVm = Provider.of<RunViewModel>(context, listen: false);
    
    final message = '''
🚀 FitQuest Progress Update 🚀

🏃 Total Distance: ${runVm.totalDistance.toStringAsFixed(1)} km
💪 Workouts Completed: ${runVm.runHistory.length}
🔥 Active Days This Week: 7
🎯 Weekly Goal Progress: 65%

Keep pushing! 💪

#FitQuest #FitnessJourney #Progress
''';
    
    try {
      await Share.share(
        message,
        subject: 'My FitQuest Progress',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
