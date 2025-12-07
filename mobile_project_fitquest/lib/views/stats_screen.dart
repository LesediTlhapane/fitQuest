import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeFrame = 'Week';
  List<String> timeFrames = ['Day', 'Week', 'Month', 'Year'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics & Analytics'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Progress'),
            Tab(text: 'Goals'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildProgressTab(),
          _buildGoalsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Time Frame Selector
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Select Time Frame',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: timeFrames.map((frame) {
                      return ChoiceChip(
                        label: Text(frame),
                        selected: _selectedTimeFrame == frame,
                        onSelected: (selected) {
                          setState(() {
                            _selectedTimeFrame = frame;
                          });
                        },
                        selectedColor: Colors.purple,
                        labelStyle: TextStyle(
                          color: _selectedTimeFrame == frame ? Colors.white : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Activity Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Activity Distribution',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      primaryYAxis: const NumericAxis(),
                      series: <CartesianSeries>[
                        ColumnSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Mon', 45),
                            ChartData('Tue', 60),
                            ChartData('Wed', 35),
                            ChartData('Thu', 75),
                            ChartData('Fri', 50),
                            ChartData('Sat', 85),
                            ChartData('Sun', 40),
                          ],
                          xValueMapper: (ChartData data, _) => data.day,
                          yValueMapper: (ChartData data, _) => data.distance,
                          color: Colors.purple,
                          animationDuration: 1000,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildStatCard('Total Distance', '156.2 km', Icons.directions_run, Colors.blue),
              _buildStatCard('Total Time', '28h 45m', Icons.timer, Colors.green),
              _buildStatCard('Calories Burned', '12,450', Icons.local_fire_department, Colors.orange),
              _buildStatCard('Workouts', '42', Icons.fitness_center, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Progress Line Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Progress Over Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      primaryYAxis: const NumericAxis(),
                      series: <CartesianSeries>[
                        LineSeries<ProgressData, String>(
                          dataSource: [
                            ProgressData('Jan', 30, 45),
                            ProgressData('Feb', 45, 60),
                            ProgressData('Mar', 60, 75),
                            ProgressData('Apr', 75, 90),
                            ProgressData('May', 90, 120),
                            ProgressData('Jun', 120, 150),
                          ],
                          xValueMapper: (ProgressData data, _) => data.month,
                          yValueMapper: (ProgressData data, _) => data.distance,
                          name: 'Distance (km)',
                          color: Colors.blue,
                          animationDuration: 1000,
                        ),
                        LineSeries<ProgressData, String>(
                          dataSource: [
                            ProgressData('Jan', 5, 8),
                            ProgressData('Feb', 8, 12),
                            ProgressData('Mar', 12, 15),
                            ProgressData('Apr', 15, 18),
                            ProgressData('May', 18, 22),
                            ProgressData('Jun', 22, 25),
                          ],
                          xValueMapper: (ProgressData data, _) => data.month,
                          yValueMapper: (ProgressData data, _) => data.workouts,
                          name: 'Workouts',
                          color: Colors.green,
                          animationDuration: 1000,
                        ),
                      ],
                      legend: const Legend(isVisible: true),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Pace Improvement
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pace Improvement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      primaryYAxis: const NumericAxis(isInversed: true),
                      series: <CartesianSeries>[
                        LineSeries<PaceData, String>(
                          dataSource: [
                            PaceData('Week 1', 7.5),
                            PaceData('Week 2', 7.2),
                            PaceData('Week 3', 6.8),
                            PaceData('Week 4', 6.5),
                            PaceData('Week 5', 6.2),
                            PaceData('Week 6', 5.9),
                            PaceData('Week 7', 5.6),
                          ],
                          xValueMapper: (PaceData data, _) => data.week,
                          yValueMapper: (PaceData data, _) => data.pace,
                          markerSettings: const MarkerSettings(isVisible: true),
                          animationDuration: 1000,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Current Goals
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Goals',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildGoalItem('Run 100km this month', 65, Colors.blue),
                  _buildGoalItem('Complete 30 workouts', 80, Colors.green),
                  _buildGoalItem('Lose 5kg weight', 40, Colors.orange),
                  _buildGoalItem('Improve pace to 5:30 min/km', 25, Colors.purple),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Achievements
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Achievements',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildAchievementBadge('🏆', 'Marathon Finisher'),
                      _buildAchievementBadge('🔥', '30-Day Streak'),
                      _buildAchievementBadge('🚀', 'Pace Master'),
                      _buildAchievementBadge('⭐', 'Consistency King'),
                      _buildAchievementBadge('💪', 'Strength Champion'),
                      _buildAchievementBadge('🧘', 'Yoga Master'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalItem(String goal, int progress, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                goal,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('$progress%'),
            ],
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(String emoji, String title) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            textAlign: TextAlign.center,
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

class ProgressData {
  ProgressData(this.month, this.distance, this.workouts);
  final String month;
  final double distance;
  final double workouts;
}

class PaceData {
  PaceData(this.week, this.pace);
  final String week;
  final double pace;
}