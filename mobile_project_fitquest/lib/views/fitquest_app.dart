import 'package:fitquest/viewmodels/auth_vm.dart';
import 'package:fitquest/views/activity_screen.dart';
import 'package:fitquest/views/club_screen.dart';
import 'package:fitquest/views/home_screen.dart';
import 'package:fitquest/views/login_failed_screen.dart';
import 'package:fitquest/views/plans_screen.dart';
import 'package:fitquest/views/run_screen.dart';
import 'package:fitquest/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FitQuestApp extends StatefulWidget {
  const FitQuestApp({super.key});

  static get fitQuestKey => null;

  @override
  State<FitQuestApp> createState() => _FitQuestAppState();
}

class _FitQuestAppState extends State<FitQuestApp> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() => _currentIndex = index);
  }

  Widget _mainApp() {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreenEnhanced(),
          PlansScreen(),
          const RunScreen(),
          ClubsScreen(),
          ActivityScreen(),
        ],
      ),
      bottomNavigationBar: FitQuestBottomNav(
        index: _currentIndex,
        onTap: setCurrentIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    if (auth.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (auth.isLoggedIn) {
      return _mainApp();
    }

    return const LoginScreen();
  }
}