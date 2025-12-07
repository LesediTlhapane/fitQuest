import 'package:flutter/material.dart';
// Remove unused imports
import 'package:syncfusion_flutter_charts/charts.dart';
// Keep only necessary imports

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late TooltipBehavior _tooltipBehavior;
  late TrackballBehavior _trackballBehavior;
  String _selectedFilter = 'Week';
  List<String> filters = ['Week', 'Month', 'Year'];
  
  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity & Stats'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview with animated chart
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
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
                        _buildStatItem('Distance', '32.5 km', Icons.directions_run, Colors.blue),
                        _buildStatItem('Duration', '4h 30m', Icons.timer, Colors.green),
                        _buildStatItem('Calories', '1,850', Icons.local_fire_department, Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 15),
                    
                    // FIXED: Weekly Chart - Proper height constraint
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 120,
                        maxHeight: 150,
                      ),
                      child: _buildWeeklyChart(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Activity History with tabs
            const Text(
              'Activity History',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Runs'),
                        Tab(text: 'Workouts'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      children: [
                        _buildActivityList('all'),
                        _buildActivityList('runs'),
                        _buildActivityList('workouts'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Activity Breakdown with animated pie chart
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
                    SizedBox(
                      height: 200,
                      child: _buildActivityPieChart(),
                    ),
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
            _buildAchievementsGrid(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _logManualActivity,
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

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
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

  Widget _buildWeeklyChart() {
    final List<ChartData> chartData = [
      ChartData('Mon', 5),
      ChartData('Tue', 8),
      ChartData('Wed', 6),
      ChartData('Thu', 12),
      ChartData('Fri', 10),
      ChartData('Sat', 15),
      ChartData('Sun', 8),
    ];

    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      trackballBehavior: _trackballBehavior,
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      primaryYAxis: const NumericAxis(
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      series: <CartesianSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.day,
          yValueMapper: (ChartData data, _) => data.distance,
          color: Colors.purple,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          animationDuration: 1000,
        ),
      ],
    );
  }

  Widget _buildActivityList(String type) {
    // Mock data - replace with actual data from database
    final List<Map<String, dynamic>> activities = [
      {
        'type': 'Running',
        'title': 'Morning Run',
        'details': '5.2 km • 32 min',
        'time': 'Today, 7:30 AM',
        'icon': Icons.directions_run,
        'color': Colors.blue,
        'calories': 320,
      },
      {
        'type': 'Workout',
        'title': 'Gym Session',
        'details': 'Strength Training • 45 min',
        'time': 'Yesterday',
        'icon': Icons.fitness_center,
        'color': Colors.orange,
        'calories': 280,
      },
      {
        'type': 'Workout',
        'title': 'Evening Yoga',
        'details': 'Flexibility • 30 min',
        'time': '2 days ago',
        'icon': Icons.self_improvement,
        'color': Colors.green,
        'calories': 150,
      },
      {
        'type': 'Running',
        'title': 'Weekend Hike',
        'details': '8.5 km • 2 hours',
        'time': '3 days ago',
        'icon': Icons.terrain,
        'color': Colors.brown,
        'calories': 520,
      },
      {
        'type': 'Workout',
        'title': 'Swimming',
        'details': '1.5 km • 40 min',
        'time': '5 days ago',
        'icon': Icons.pool,
        'color': Colors.cyan,
        'calories': 420,
      },
    ];

    final filteredActivities = type == 'all'
        ? activities
        : activities.where((a) => a['type'].toLowerCase() == type.toLowerCase()).toList();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: filteredActivities.length,
      itemBuilder: (context, index) {
        final activity = filteredActivities[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: activity['color']!.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(activity['icon'] as IconData, color: activity['color'] as Color),
            ),
            title: Text(
              activity['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(activity['details'] as String),
                const SizedBox(height: 2),
                Text(
                  activity['time'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_fire_department, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '${activity['calories']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text(
                  'cal',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
            onTap: () {
              _showActivityDetails(activity);
            },
          ),
        );
      },
    );
  }

  Widget _buildActivityPieChart() {
    final List<PieData> pieData = [
      PieData('Running', 45, Colors.blue),
      PieData('Strength', 30, Colors.orange),
      PieData('Yoga', 15, Colors.green),
      PieData('Other', 10, Colors.purple),
    ];

    return SfCircularChart(
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<PieData, String>(
          dataSource: pieData,
          xValueMapper: (PieData data, _) => data.activity,
          yValueMapper: (PieData data, _) => data.percentage,
          pointColorMapper: (PieData data, _) => data.color,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          animationDuration: 1000,
        ),
      ],
    );
  }

  Widget _buildAchievementsGrid() {
    final achievements = [
      {'emoji': '🏃‍♂️', 'title': 'First 5K Run', 'desc': 'Complete a 5km run', 'unlocked': true},
      {'emoji': '🔥', 'title': '7-Day Streak', 'desc': 'Workout for 7 days straight', 'unlocked': true},
      {'emoji': '🏋️‍♂️', 'title': 'Strength Master', 'desc': 'Complete 50 strength workouts', 'unlocked': false},
      {'emoji': '🧘‍♀️', 'title': 'Yoga Beginner', 'desc': 'Complete 10 yoga sessions', 'unlocked': true},
      {'emoji': '🚀', 'title': 'Marathon Ready', 'desc': 'Run 42km in a month', 'unlocked': false},
      {'emoji': '⭐', 'title': 'Consistency King', 'desc': '30 active days', 'unlocked': false},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: achievements.map((achievement) {
        return Card(
          color: achievement['unlocked'] as bool
              ? Colors.purple.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: achievement['unlocked'] as bool
                  ? Colors.purple.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  achievement['emoji'] as String,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 8),
                Text(
                  achievement['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: achievement['unlocked'] as bool ? Colors.purple : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['desc'] as String,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                if (!(achievement['unlocked'] as bool))
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Locked',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Time Period'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: filters.map((filter) {
            return RadioListTile(
              title: Text(filter),
              value: filter,
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value.toString();
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showActivityDetails(Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(activity['title'] as String),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(activity['details'] as String),
            const SizedBox(height: 10),
            Text('Time: ${activity['time']}'),
            Text('Calories burned: ${activity['calories']} cal'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _shareActivity(activity);
            },
            child: const Text('SHARE'),
          ),
        ],
      ),
    );
  }

  void _shareActivity(Map<String, dynamic> activity) async {
    // Remove unused variable warning by using it
    final message = '''
🏃 ${activity['title']}
📊 ${activity['details']}
⏰ ${activity['time']}
🔥 ${activity['calories']} calories burned

Shared via FitQuest App
#FitQuest #Fitness
''';
    
    // Log the message to use the variable
    debugPrint('Sharing message: $message');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing feature would open here'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _logManualActivity() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Manual Activity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Activity Type'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Distance (km)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Activity logged successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('LOG'),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.distance);
  final String day;
  final double distance;
}

class PieData {
  PieData(this.activity, this.percentage, this.color);
  final String activity;
  final double percentage;
  final Color color;
}