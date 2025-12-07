import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all), // FIXED: Changed from Icons.check_all
            onPressed: () async {
              if (mounted) {
                await auth.markAllNotificationsAsRead();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications marked as read'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: auth.notificationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }
          
          final notifications = snapshot.data ?? [];
          
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey.withOpacity(0.4)), // Fixed
                  const SizedBox(height: 16),
                  const Text(
                    'No notifications yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Join clubs, RSVP to events, or join challenges to see notifications here',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          // Group notifications by date
          final today = DateTime.now();
          final yesterday = today.subtract(const Duration(days: 1));
          
          final todayNotifications = notifications.where((n) {
            final date = (n['timestamp'] ?? n['createdAt']) as DateTime?;
            return date != null && date.day == today.day && date.month == today.month && date.year == today.year;
          }).toList();
          
          final yesterdayNotifications = notifications.where((n) {
            final date = (n['timestamp'] ?? n['createdAt']) as DateTime?;
            return date != null && date.day == yesterday.day && date.month == yesterday.month && date.year == yesterday.year;
          }).toList();
          
          final olderNotifications = notifications.where((n) {
            final date = (n['timestamp'] ?? n['createdAt']) as DateTime?;
            if (date == null) return false;
            return date.day != today.day || date.month != today.month || date.year != today.year;
          }).toList();
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (todayNotifications.isNotEmpty)
                _buildNotificationSection('Today', todayNotifications, auth),
              if (yesterdayNotifications.isNotEmpty)
                _buildNotificationSection('Yesterday', yesterdayNotifications, auth),
              if (olderNotifications.isNotEmpty)
                _buildNotificationSection('This Week', olderNotifications, auth),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildNotificationSection(String title, List<Map<String, dynamic>> notifications, AuthViewModel auth) {
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
        ...notifications.map((notification) => _buildNotificationItem(notification, auth)),
      ],
    );
  }
  
  Widget _buildNotificationItem(Map<String, dynamic> notification, AuthViewModel auth) {
    final isRead = notification['read'] == true;
    final type = notification['type'] ?? '';
    final title = notification['title'] ?? 'Notification';
    final message = notification['message'] ?? '';
    final date = (notification['timestamp'] ?? notification['createdAt']) as DateTime?;
    
    // Get icon based on type
    IconData icon;
    Color color;
    
    switch (type) {
      case 'club_join':
        icon = Icons.people;
        color = Colors.blue;
        break;
      case 'event_rsvp':
        icon = Icons.event;
        color = Colors.green;
        break;
      case 'challenge_join':
        icon = Icons.emoji_events;
        color = Colors.orange;
        break;
      case 'workout':
        icon = Icons.fitness_center;
        color = Colors.red;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.purple;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: isRead ? null : Colors.purple.withOpacity(0.05),
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
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message),
            const SizedBox(height: 4),
            Text(
              _formatDate(date ?? DateTime.now()),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: !isRead
            ? Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () async {
          // Mark as read if unread
          if (!isRead) {
            await auth.markNotificationAsRead(notification['id']);
          }
          
          // Handle notification action
          _handleNotificationAction(notification['data']);
        },
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
  
  void _handleNotificationAction(Map<String, dynamic>? data) {
    if (data == null) return;
    
    final action = data['action'];
    // You can add navigation based on action type
    // For example: Navigator.pushNamed(context, '/club/${data['clubName']}');
  }
}