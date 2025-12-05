import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';
import 'home_screen.dart';
import 'plans_screen.dart';
import 'run_screen.dart';
import 'club_screen.dart';
import 'activity_screen.dart';
import 'login_screen.dart';

class FitQuestApp extends StatefulWidget {
  const FitQuestApp({super.key});

  @override
  State<FitQuestApp> createState() => _FitQuestAppState();
}

class _FitQuestAppState extends State<FitQuestApp> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const PlansScreen(),
    const RunScreen(),
    ClubScreen(),
    ActivityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, auth, _) {
        if (auth.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!auth.isLoggedIn) {
          return const LoginScreen();
        }

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setCurrentIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Plans"),
              BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: "Run"),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "Club"),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Activity"),
            ],
          ),
        );
      },
    );
  }
}
