import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';

class ProfileScreenEnhanced extends StatefulWidget {
  const ProfileScreenEnhanced({super.key});

  @override
  State<ProfileScreenEnhanced> createState() => _ProfileScreenEnhancedState();
}

class _ProfileScreenEnhancedState extends State<ProfileScreenEnhanced> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _selectedGoal = 'Lose Weight';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editProfile(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade600, Colors.purple.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.user?.displayName ?? 'FitQuest User',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          auth.user?.email ?? 'user@example.com',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _buildProfileStat('Workouts', '12'),
                            const SizedBox(width: 20),
                            _buildProfileStat('Level', '5'),
                            const SizedBox(width: 20),
                            _buildProfileStat('Streak', '7d'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Current Goal
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.flag, color: Colors.purple),
                        SizedBox(width: 10),
                        Text(
                          'Current Goal',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                      value: _selectedGoal,
                      items: const [
                        DropdownMenuItem(value: 'Lose Weight', child: Text('Lose Weight')),
                        DropdownMenuItem(value: 'Build Muscle', child: Text('Build Muscle')),
                        DropdownMenuItem(value: 'Improve Endurance', child: Text('Improve Endurance')),
                        DropdownMenuItem(value: 'General Fitness', child: Text('General Fitness')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGoal = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.65,
                      backgroundColor: Colors.grey[200],
                      color: Colors.purple,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weekly Progress',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          '65%',
                          style: TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Settings
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.purple),
                    title: const Text(
                      'Settings',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showSettings(context),
                  ),
                  SwitchListTile(
                    title: const Text('Notifications'),
                    subtitle: const Text('Receive workout reminders'),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: Colors.purple,
                  ),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Toggle dark theme'),
                    value: _darkMode,
                    onChanged: (value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                    activeColor: Colors.purple,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Help & Support
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.purple),
                    title: const Text(
                      'Help & Support',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showHelpSupport(context),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.contact_support, color: Colors.grey),
                    title: const Text('FAQ'),
                    onTap: () => _showFAQ(context),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.grey),
                    title: const Text('Contact Us'),
                    onTap: () => _contactSupport(context),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip, color: Colors.grey),
                    title: const Text('Privacy Policy'),
                    onTap: () => _showPrivacyPolicy(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Achievements
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.purple),
                        SizedBox(width: 10),
                        Text(
                          'Recent Achievements',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAchievementBadge('🏃‍♂️', 'First 5K'),
                        _buildAchievementBadge('🔥', '7-Day Streak'),
                        _buildAchievementBadge('🏋️‍♂️', 'Strength'),
                        _buildAchievementBadge('🧘‍♀️', 'Yoga'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final confirm = await _showLogoutConfirmation(context);
                  if (confirm) {
                    await auth.logout();
                    // Navigate to welcome screen
                    Navigator.pushReplacementNamed(context, '/');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(String emoji, String title) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.purple, width: 2),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> _editProfile(BuildContext context) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final nameController = TextEditingController(text: auth.user?.displayName);
    final emailController = TextEditingController(text: auth.user?.email);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              enabled: false,
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
              // Update profile logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSettings(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification Settings'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _notificationSettings(context),
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _privacySettings(context),
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Data & Storage'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _dataSettings(context),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CLOSE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _notificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Workout Reminders'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Goal Notifications'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Club Updates'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _privacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Settings'),
        content: const Text('Configure your privacy preferences here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _dataSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data & Storage'),
        content: const Text('Manage your app data and storage settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Future<void> _showHelpSupport(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Help & Support',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.live_help),
              title: const Text('Get Help'),
              subtitle: const Text('Find answers to common questions'),
              onTap: () => _showFAQ(context),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email Support'),
              subtitle: const Text('Contact our support team'),
              onTap: () => _contactSupport(context),
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Live Chat'),
              subtitle: const Text('Chat with support agent'),
              onTap: () => _startLiveChat(context),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CLOSE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFAQ(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Frequently Asked Questions'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: const [
              ExpansionTile(
                title: Text('How do I track my runs?'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Go to the Run screen and press START to begin tracking your run.'),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('How do I join clubs?'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Visit the Clubs screen and press JOIN on any club you want to join.'),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Can I share my progress?'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Yes! Use the Share Progress button on the Home screen.'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _contactSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: support@fitquest.com'),
            SizedBox(height: 10),
            Text('Phone: +27 11 123 4567'),
            SizedBox(height: 10),
            Text('Hours: Mon-Fri 9am-5pm'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _startLiveChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Live Chat'),
        content: const Text('Live chat feature would open here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Your privacy is important to us. This privacy policy explains what personal data we collect and how we use it.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Future<bool> _showLogoutConfirmation(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('LOGOUT'),
          ),
        ],
      ),
    ) ?? false;
  }
}