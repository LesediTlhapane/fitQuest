import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _markAllAsRead(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _clearAllNotifications(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationSection(
            'Today',
            [
              _buildNotificationItem(
                'Club Join Request',
                'Your request to join WTC Running Club has been approved!',
                Icons.people,
                Colors.blue,
                'Just now',
                true,
              ),
              _buildNotificationItem(
                'Challenge Accepted',
                'You joined the 30-Day Code Streak challenge',
                Icons.emoji_events,
                Colors.orange,
                '2 hours ago',
                true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildNotificationSection(
            'Yesterday',
            [
              _buildNotificationItem(
                'Event Reminder',
                'WTC Campus Run starts in 1 hour',
                Icons.event,
                Colors.green,
                'Yesterday',
                false,
              ),
              _buildNotificationItem(
                'Goal Achievement',
                'You reached your weekly running goal!',
                Icons.flag,
                Colors.purple,
                'Yesterday',
                false,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildNotificationSection(
            'This Week',
            [
              _buildNotificationItem(
                'New Club Member',
                'John joined WTC Yoga Coders',
                Icons.person_add,
                Colors.teal,
                '2 days ago',
                false,
              ),
              _buildNotificationItem(
                'Workout Complete',
                'Great job on your morning run!',
                Icons.fitness_center,
                Colors.red,
                '3 days ago',
                false,
              ),
              _buildNotificationItem(
                'RSVP Confirmed',
                'Your RSVP for Coding Workshop is confirmed',
                Icons.check_circle,
                Colors.green,
                '4 days ago',
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection(String title, List<Widget> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 10),
        ...notifications,
      ],
    );
  }

  Widget _buildNotificationItem(
    String title,
    String message,
    IconData icon,
    Color color,
    String time,
    bool unread,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: unread ? Colors.purple.withOpacity(0.05) : null,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: unread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: unread
            ? Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          // Handle notification tap
        },
        onLongPress: () {
          // Show options
        },
      ),
    );
  }

  Future<void> _markAllAsRead(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark All as Read'),
        content: const Text('Mark all notifications as read?'),
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
                  content: Text('All notifications marked as read'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('MARK ALL'),
          ),
        ],
      ),
    );
  }

  Future<void> _clearAllNotifications(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Delete all notifications? This action cannot be undone.'),
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
                  content: Text('All notifications cleared'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('CLEAR ALL'),
          ),
        ],
      ),
    );
  }
}