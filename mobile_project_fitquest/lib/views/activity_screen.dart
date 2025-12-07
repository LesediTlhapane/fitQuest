import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity & Stats'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      '📊 Weekly Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Distance', '32.5 km', Icons.directions_run),
                        _buildStatItem('Duration', '4h 30m', Icons.timer),
                        _buildStatItem('Calories', '1,850', Icons.local_fire_department),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Weekly Chart
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      child: _buildWeeklyChart(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Activity Feed
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            _buildActivityItem(
              'Morning Run',
              '5.2 km • 32 min',
              'Today, 7:30 AM',
              Icons.directions_run,
              Colors.blue,
              320,
            ),
            _buildActivityItem(
              'Gym Session',
              'Strength Training • 45 min',
              'Yesterday',
              Icons.fitness_center,
              Colors.orange,
              280,
            ),
            _buildActivityItem(
              'Evening Yoga',
              'Flexibility • 30 min',
              '2 days ago',
              Icons.self_improvement,
              Colors.green,
              150,
            ),
            _buildActivityItem(
              'Weekend Hike',
              '8.5 km • 2 hours',
              '3 days ago',
              Icons.terrain,
              Colors.brown,
              520,
            ),
            _buildActivityItem(
              'Swimming',
              '1.5 km • 40 min',
              '5 days ago',
              Icons.pool,
              Colors.cyan,
              420,
            ),
            const SizedBox(height: 20),
            
            // Activity Breakdown
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🏆 Activity Breakdown',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActivityType('Running', '12 activities', Icons.directions_run, Colors.blue),
                        _buildActivityType('Strength', '8 activities', Icons.fitness_center, Colors.orange),
                        _buildActivityType('Yoga', '4 activities', Icons.self_improvement, Colors.green),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Progress Bars
                    _buildProgressBar('Running', 75, Colors.blue),
                    _buildProgressBar('Strength', 50, Colors.orange),
                    _buildProgressBar('Yoga', 25, Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Achievements
            const Text(
              '🎯 Achievements',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildAchievementCard('🏃‍♂️', 'First 5K Run', 'Complete a 5km run'),
                  _buildAchievementCard('🔥', '7-Day Streak', 'Workout for 7 days straight'),
                  _buildAchievementCard('🏋️‍♂️', 'Strength Master', 'Complete 50 strength workouts'),
                  _buildAchievementCard('🧘‍♀️', 'Yoga Beginner', 'Complete 10 yoga sessions'),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Log Activity'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final distances = [5, 8, 6, 12, 10, 15, 8];
    final maxDistance = distances.reduce((a, b) => a > b ? a : b);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: days.asMap().entries.map((entry) {
        final index = entry.key;
        final day = entry.value;
        final distance = distances[index];
        final height = (distance / maxDistance) * 80;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 20,
              height: height,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              day,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${distance}km',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildActivityItem(
    String title,
    String details,
    String time,
    IconData icon,
    Color color,
    int calories,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    details,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.local_fire_department, size: 20, color: Colors.orange),
                const SizedBox(height: 4),
                Text(
                  '$calories',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'cal',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityType(String type, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              type,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('$percentage%', style: TextStyle(color: color)),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildAchievementCard(String emoji, String title, String description) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}