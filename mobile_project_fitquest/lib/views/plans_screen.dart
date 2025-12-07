import 'package:flutter/material.dart';
import '../core/theme.dart';

class PlansScreen extends StatelessWidget {
  final List<WorkoutPlan> workoutPlans = [
    WorkoutPlan(
      title: 'Beginner\'s 30-Day Challenge',
      description: 'Perfect for fitness newcomers',
      duration: '30 days',
      difficulty: 2,
      calories: 1800,
      icon: Icons.emoji_events_rounded,
      gradient: [Color(0xFF667EEA), Color(0xFF764BA2)],
    ),
    WorkoutPlan(
      title: 'Marathon Training',
      description: 'Build endurance for long distances',
      duration: '12 weeks',
      difficulty: 4,
      calories: 3200,
      icon: Icons.flag_rounded,
      gradient: [Color(0xFFf093fb), Color(0xFFf5576c)],
    ),
    WorkoutPlan(
      title: 'Strength & Power',
      description: 'Build muscle and increase strength',
      duration: '8 weeks',
      difficulty: 4,
      calories: 2500,
      icon: Icons.fitness_center_rounded,
      gradient: [Color(0xFF4facfe), Color(0xFF00f2fe)],
    ),
    WorkoutPlan(
      title: 'Yoga & Flexibility',
      description: 'Improve flexibility and reduce stress',
      duration: 'Daily',
      difficulty: 1,
      calories: 800,
      icon: Icons.self_improvement_rounded,
      gradient: [Color(0xFF43e97b), Color(0xFF38f9d7)],
    ),
    WorkoutPlan(
      title: 'HIIT Burn',
      description: 'High intensity fat burning',
      duration: '4 weeks',
      difficulty: 5,
      calories: 2800,
      icon: Icons.local_fire_department_rounded,
      gradient: [Color(0xFFfa709a), Color(0xFFfee140)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Workout Plans',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: primaryGradient,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return _buildHeader();
                  } else if (index == 1) {
                    return _buildQuickWorkouts();
                  } else {
                    return _buildWorkoutPlanCard(index - 2);
                  }
                },
                childCount: workoutPlans.length + 2,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add_rounded),
        label: Text('Custom Plan'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Journey',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Select a plan that matches your fitness goals',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildQuickWorkouts() {
    final quickWorkouts = [
      {'title': 'Morning Energy', 'time': '20 min', 'icon': Icons.wb_sunny_rounded},
      {'title': 'Lunch Break', 'time': '15 min', 'icon': Icons.lunch_dining_rounded},
      {'title': 'Evening Relax', 'time': '30 min', 'icon': Icons.nightlight_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Workouts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: quickWorkouts.length,
            itemBuilder: (context, index) {
              final workout = quickWorkouts[index];
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 12),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          workout['icon'] as IconData,
                          color: primaryPurple,
                          size: 32,
                        ),
                        SizedBox(height: 12),
                        Text(
                          workout['title'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          workout['time'] as String,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildWorkoutPlanCard(int planIndex) {
    final plan = workoutPlans[planIndex];
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // Navigate to plan details
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: plan.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  plan.icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      plan.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.schedule_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          plan.duration,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${plan.calories} cal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Simple difficulty indicator
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < plan.difficulty 
                            ? Icons.star_rounded 
                            : Icons.star_border_rounded,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutPlan {
  final String title;
  final String description;
  final String duration;
  final int difficulty;
  final int calories;
  final IconData icon;
  final List<Color> gradient;

  WorkoutPlan({
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.calories,
    required this.icon,
    required this.gradient,
  });
}