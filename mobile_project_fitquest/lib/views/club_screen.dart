import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports Clubs'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.purple,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.sports, size: 40, color: Colors.white),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sports Community',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Connect with fellow athletes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        // Explore all clubs action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Explore All Sports Clubs'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Featured Sports Clubs
            const Text(
              '🏆 Featured Sports Clubs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Join active sports communities',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            
            _buildClubCard(
              'Running Club',
              'For all running enthusiasts',
              Icons.directions_run,
              180,
              12,
              Colors.blue,
              onJoin: () => _showJoinDialog(context, 'Running Club'),
            ),
            _buildClubCard(
              'Basketball Team',
              'Weekly games and training',
              Icons.sports_basketball,
              45,
              8,
              Colors.orange,
              onJoin: () => _showJoinDialog(context, 'Basketball Team'),
            ),
            _buildClubCard(
              'Cycling Crew',
              'Road and mountain biking',
              Icons.pedal_bike,
              90,
              10,
              Colors.green,
              onJoin: () => _showJoinDialog(context, 'Cycling Crew'),
            ),
            _buildClubCard(
              'Swimming Squad',
              'Pool and open water swimming',
              Icons.pool,
              75,
              15,
              Colors.cyan,
              onJoin: () => _showJoinDialog(context, 'Swimming Squad'),
            ),
            _buildClubCard(
              'Yoga & Wellness',
              'Mindfulness and flexibility',
              Icons.self_improvement,
              120,
              20,
              Colors.purple,
              onJoin: () => _showJoinDialog(context, 'Yoga & Wellness'),
            ),
            _buildClubCard(
              'Soccer League',
              'Casual and competitive play',
              Icons.sports_soccer,
              110,
              16,
              Colors.green,
              onJoin: () => _showJoinDialog(context, 'Soccer League'),
            ),
            _buildClubCard(
              'Hiking Group',
              'Weekend mountain adventures',
              Icons.terrain,
              85,
              8,
              Colors.brown,
              onJoin: () => _showJoinDialog(context, 'Hiking Group'),
            ),
            _buildClubCard(
              'Fitness Warriors',
              'Cross-training and strength',
              Icons.fitness_center,
              150,
              18,
              Colors.red,
              onJoin: () => _showJoinDialog(context, 'Fitness Warriors'),
            ),
            const SizedBox(height: 20),
            
            // Active Challenges
            const Text(
              '🔥 Active Sports Challenges',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Participate in community challenges',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            
            _buildChallengeCard(
              '100K Running Challenge',
              'Run 100km in a month',
              95,
              '🏃 Marathon Badge',
              [Colors.blue, Colors.purple],
              onJoin: () => _showChallengeDialog(context, '100K Running Challenge'),
            ),
            _buildChallengeCard(
              '30-Day Fitness Streak',
              'Workout every day for 30 days',
              120,
              '💪 Iron Will Badge',
              [Colors.green, Colors.teal],
              onJoin: () => _showChallengeDialog(context, '30-Day Fitness Streak'),
            ),
            _buildChallengeCard(
              'Mountain Climb',
              'Climb 10,000m in a month',
              65,
              '⛰️ Peak Seeker Badge',
              [Colors.brown, Colors.orange],
              onJoin: () => _showChallengeDialog(context, 'Mountain Climb'),
            ),
            const SizedBox(height: 20),
            
            // Upcoming Sports Events
            const Text(
              '📅 Upcoming Sports Events',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildEventCard(
              'City Marathon',
              'Saturday, 6:00 AM',
              'Central Park',
              Icons.directions_run,
              onRSVP: () => _showRSVPDialog(context, 'City Marathon'),
            ),
            _buildEventCard(
              'Basketball Tournament',
              'Sunday, 2:00 PM',
              'Sports Complex',
              Icons.sports_basketball,
              onRSVP: () => _showRSVPDialog(context, 'Basketball Tournament'),
            ),
            _buildEventCard(
              'Cycling Race',
              'Next Saturday, 8:00 AM',
              'Mountain Trail',
              Icons.pedal_bike,
              onRSVP: () => _showRSVPDialog(context, 'Cycling Race'),
            ),
            _buildEventCard(
              'Swim Meet',
              'Friday, 4:00 PM',
              'Olympic Pool',
              Icons.pool,
              onRSVP: () => _showRSVPDialog(context, 'Swim Meet'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildClubCard(
    String name,
    String description,
    IconData icon,
    int members,
    int events,
    Color color, {
    required VoidCallback onJoin,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
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
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '$members members',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(width: 15),
                      const Icon(Icons.event, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '$events events',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(
    String title,
    String description,
    int participants,
    String reward,
    List<Color> gradient, {
    required VoidCallback onJoin,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      reward,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(Icons.people, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '$participants participants',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: onJoin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: gradient.first,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Join Challenge'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(
    String title,
    String time,
    String location,
    IconData icon, {
    required VoidCallback onRSVP,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.purple),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.schedule, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(time, style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onRSVP,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('RSVP'),
        ),
      ),
    );
  }

  Future<void> _showJoinDialog(BuildContext context, String clubName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Club'),
        content: Text('Are you sure you want to join "$clubName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              final auth = Provider.of<AuthViewModel>(context, listen: false);
              if (auth.user != null) {
                await auth.addUserClub(clubName);
              }
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('JOIN'),
          ),
        ],
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully joined $clubName! Check your notifications.'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _showChallengeDialog(BuildContext context, String challengeName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Challenge'),
        content: Text('Join "$challengeName" challenge?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              final auth = Provider.of<AuthViewModel>(context, listen: false);
              if (auth.user != null) {
                await auth.addUserChallenge(challengeName);
              }
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('JOIN CHALLENGE'),
          ),
        ],
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Joined $challengeName challenge! Check your notifications.'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _showRSVPDialog(BuildContext context, String eventName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('RSVP to Event'),
        content: Text('Confirm your attendance for "$eventName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              final auth = Provider.of<AuthViewModel>(context, listen: false);
              if (auth.user != null) {
                await auth.addUserEvent(eventName);
              }
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('CONFIRM RSVP'),
          ),
        ],
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('RSVP confirmed for $eventName! Check your notifications.'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}